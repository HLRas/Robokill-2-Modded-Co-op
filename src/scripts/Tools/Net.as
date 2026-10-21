package Tools
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import ObjectBase.PlayerBase;
   import Scenes.MainMenu;
   import Scenes.MainScene;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.JPEGEncoderOptions;
   import flash.display.Loader;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.IBitmapDrawable;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.Socket;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.system.ApplicationDomain;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;

   public class Net
   {

      // ================= Online co-op =================
      // The host runs the real game. The guest's copy runs no game logic: it shows a copy of the host's screen and
      // sends its controller back, which the host treats as controller 2 (player 2). Every frame the host walks its
      // display list and sends each picture's id, transform, colour and filters. A picture's pixels are sent the
      // first time it appears (and again, as a changed rectangle, if it is drawn into). Sounds are mirrored by
      // channel. Both sides connect out to relay/relay.py, which pairs them by a join code, because Flash cannot
      // accept incoming connections.

      // The relay only pairs players with the same value, i.e. the same mod version.
      public static const VERSION:String = "rk2-online-" + MainMenu.MOD_VERSION;

      // The relay (Oracle Cloud, Johannesburg). A line "relay=host:port" in online.txt next to the exe overrides it.
      public static var relayHost:String = "84.12.82.74";

      public static var relayPort:int = 7777;

      // 0 = offline, 1 = hosting, 2 = guest.
      public static var mode:int = 0;

      // Shown in the pause menu (host) and on the join screen (guest).
      public static var status:String = "";

      public static var code:String = "";

      // The other player is connected.
      public static var peer:Boolean = false;

      // Host: the guest's latest controller values (same keys as a GameInput device), or null.
      public static var remotePad:Object = null;

      // Host: the guest disconnected, so player 2 should leave.
      public static var guestLeft:Boolean = false;

      private static const R_HOST:int = 1;

      private static const R_JOIN:int = 2;

      private static const R_DATA:int = 3;

      private static const R_PING:int = 4;

      private static const R_CODE:int = 10;

      private static const R_PEER_JOINED:int = 11;

      private static const R_PEER_LEFT:int = 12;

      private static const R_ERROR:int = 13;

      private static const R_PONG:int = 14;

      private static const D_IMAGE:int = 1;

      private static const D_FREE:int = 2;

      private static const D_FILTERS:int = 3;

      private static const D_SOUND:int = 4;

      private static const D_FRAME:int = 5;

      private static const D_PAD:int = 6;

      private static const D_IMAGEREF:int = 7;

      private static const D_TEXT:int = 8;

      private static const D_JPEG:int = 9;

      // A piece of a big message (pictures): u8 last, bytes. Pieces of one message arrive in order.
      private static const D_CHUNK:int = 10;

      private static const CHUNK_SIZE:int = 4096;

      // A picture built by draw calls (a room's floor): its size, fill colour, the names of the pictures it draws
      // from, and the calls. The guest replays them instead of getting the pixels.
      private static const D_RECIPE:int = 11;

      // One more draw call (a floor mark) on a picture made from a recipe.
      private static const D_FLOOROP:int = 12;

      // A picture of a single colour (screen-fade and menu backings): size and colour.
      private static const D_FILL:int = 13;

      private static const SNAPS:Array = ["auto","never","always"];

      private static const BLENDS:Array = [BlendMode.NORMAL,BlendMode.ADD,BlendMode.MULTIPLY,BlendMode.SCREEN,BlendMode.LIGHTEN,BlendMode.DARKEN,BlendMode.OVERLAY,BlendMode.HARDLIGHT,BlendMode.DIFFERENCE,BlendMode.SUBTRACT,BlendMode.INVERT,BlendMode.ALPHA,BlendMode.ERASE];

      // Controller values the guest sends, in order (each as a signed byte).
      private static const PAD_CONTROLS:Array = [Input.PAD_LX,Input.PAD_LY,Input.PAD_RX,Input.PAD_RY].concat(Input.PAD_BUTTONS);

      public static var config:Object = {};

      private static var stage:Stage;

      private static var sock:Socket;

      private static var inBuf:ByteArray = new ByteArray();

      private static var frameNo:int = 0;

      private static var lastPing:int = 0;

      // ---- host state ----
      private static var imgInfo:Dictionary = new Dictionary(true);

      private static var idInfo:Object = {};

      private static var nextImg:int = 1;

      private static var vecCache:Dictionary = new Dictionary(true);

      private static var textCache:Dictionary = new Dictionary(true);

      private static var filterIds:Object = {};

      private static var nextFilter:int = 1;

      private static var soundIds:Dictionary = new Dictionary(true);

      private static var nextSound:int = 1;

      private static var chanIds:Dictionary = new Dictionary(true);

      private static var nextChan:int = 1;

      private static var frameBody:ByteArray;

      private static var frameCount:int = 0;

      private static var rootFix:Matrix;

      // Each display object gets an id, and frames only send what changed since the last frame.
      private static var objIds:Dictionary = new Dictionary(true);

      private static var nextObj:int = 1;

      private static var lastSent:Object = {};

      private static var frameSeq:int = 0;

      // Flow control. The guest acknowledges each frame; frames are only captured while the oldest unacknowledged
      // one is younger than the base round trip plus a margin, so a slow link drops frames instead of queueing
      // them (queued frames are lag). Round trips are measured from the acks.
      private static var ackSeq:int = 0;

      private static var sentAt:Array = new Array(256);

      private static var bulkAt:Array = new Array(256);

      private static var rtt:Number = 0;

      private static var rttMin:Number = -1;

      private static var rttMinAt:int = 0;

      private static var rttNextMin:Number = -1;

      // Pictures and other big messages wait here and go out in pieces between frames, as fast as the link
      // allows without delaying the frames (the window shrinks when round trips grow).
      private static var bulk:Array = [];

      private static var bulkPos:int = 0;

      private static var bulkSent:Number = 0;

      private static var bulkAcked:Number = 0;

      private static var bulkWindow:Number = 16384;

      private static var bulkCutAt:int = 0;

      private static var framesSkipped:int = 0;

      // Host: buttons seen pressed in a guest message, kept pressed until the game has read them once, so a quick
      // tap that's released before the next frame still counts.
      private static var latched:Object = {};

      // Round trip to the relay (PING / PONG), shown in the F8 stats. -1 = unknown (an older relay doesn't echo).
      private static var serverPing:Number = -1;

      // ---- player 2 prediction ----
      // The guest's own robot would only move a round trip after its input. So each frame also describes player 2
      // (position, speed, the last guest input applied, which pictures are its body, legs, shadows and guns, and
      // the aim reticle), and the guest draws those pictures where its own input will have taken player 2 by
      // replaying that input from the host's state (the same movement maths as PlayerBase). predict=0 in
      // online.txt turns it off.
      private static var player2:PlayerBase;

      private static var player2At:int = 0;

      private static var p2Objects:Dictionary;

      private static var p2Oids:Array = [];

      private static var p2CursorOid:int = 0;

      // Host: newest guest input number received, and the one the game last read.
      private static var remoteSeq:int = 0;

      private static var appliedSeq:int = 0;

      // Host: game ticks (10 ms each) run since the game first read that input. Counted in ticks rather than
      // milliseconds: the game runs at most 5 ticks per timer event and none while paused, so its time can fall
      // behind the clock.
      private static var p2Ticks:int = 0;

      private static var appliedTick:int = 0;

      private static var p2TickAt:int = 0;

      // Guest: the inputs sent ({seq, t, mx, my}: move values as the host's PlayerBase will see them), and the
      // aim direction.
      private static var inputSeq:int = 0;

      private static var inputs:Array = [];

      private static var predPad:Object;

      private static var padValues:Object = {};

      // Guest: the drawn offset of player 2 from where the host frame shows it, and a correction that fades out
      // when a new frame moves the prediction (so it doesn't jump).
      private static var p2OffX:Number = 0;

      private static var p2OffY:Number = 0;

      private static var p2ErrX:Number = 0;

      private static var p2ErrY:Number = 0;

      private static var p2CurX:Number = 0;

      private static var p2CurY:Number = 0;

      private static var p2PredSn:int = -1;

      private static var p2PredFrom:Object = null;

      private static var p2LastAt:int = 0;

      private static var lastP2:Object = null;

      // Guest stats: how far the drawn player 2 was from where the host later had it, with and without prediction.
      private static var predLog:Array = [];

      private static var predErr:Number = 0;

      private static var lagErr:Number = 0;

      // Guest stats: average jump of the prediction when a new host frame arrives (what shows as rubber banding).
      private static var predCorr:Number = 0;

      // The game's shared pictures (Embeds' static BitmapData) by name, and each embedded picture class's original
      // pixels: pictures the guest's copy of the game already has are sent by name instead of pixels.
      private static var staticNames:Dictionary;

      private static var classOriginals:Object = {};

      // Text pictures: their text and layout, sent instead of pixels.
      private static var textDescs:Dictionary = new Dictionary(true);

      // Host: draw calls recorded for pictures the game builds (room floors), by BitmapData.
      private static var recipes:Dictionary = new Dictionary(true);

      // ---- stats (F8) ----
      private static var statsOn:Boolean = false;

      private static var statsText:TextField;

      private static var statsAt:int = 0;

      private static var bytesOut:int = 0;

      private static var bytesIn:int = 0;

      private static var framesIn:int = 0;

      private static var captureMs:Number = 0;

      // ---- guest state ----
      private static var view:Sprite;

      private static var layer:Sprite;

      private static var hint:TextField;

      private static var hintUntil:int = 0;

      private static var images:Object = {};

      private static var filterSets:Object = {};

      private static var sounds:Object = {};

      private static var channels:Object = {};

      private static var pool:Array = [];

      private static var poolFilter:Array = [];

      private static var keys:Object = {};

      private static var backHeldSince:int = -1;

      private static var savedMute:Array;

      // Decoded object states, and buffered frames waiting to be shown.
      private static var gstate:Object = {};

      private static var snaps:Array = [];

      private static var sharedIds:Object = {};

      private static var pendingJpeg:Object = {};

      private static var guestClassCache:Object = {};

      // Frame pacing: arrival samples [guest time, guest time - host time], and the playback delay behind the host.
      private static var arrivals:Array = [];

      private static var clockBase:Number = 0;

      private static var jitter:Number = 0;

      private static var bufferMs:Number = 60;

      // Playback runs at host time (now - playOffset). playOffset eases toward clockBase + bufferMs, so changes
      // in delay show as a slight speed-up or slow-down rather than a jump.
      private static var playOffset:Number = NaN;

      private static var lastRenderAt:int = 0;

      // Average time between host frames.
      private static var frameGap:Number = 33;

      private static var lastFrameT:Number = -1;

      private static var underruns:int = 0;

      // The snapshot before snaps[0], for extrapolating when the next one is late.
      private static var prevSnap:Object = null;

      private static var snapSerial:int = 0;

      // Recycled per-object frame entries.
      private static var entryPool:Array = [];

      private static var chunkBuf:ByteArray = null;

      private static var lastFrameSeq:int = -1;

      private static var ackedSeq:int = -1;

      private static var hostRtt:Number = 0;

      private static var tmpMatrix:Matrix = new Matrix();

      private static var padBytes:ByteArray = new ByteArray();

      private static var lastPad:Array = [];

      private static var lastPadSent:int = 0;

      // Guest: per pool slot, what was last applied to its Bitmap, so unchanged pictures aren't touched.
      private static var poolState:Array = [];

      public function Net()
      {
         super();
      }

      public static function init(param1:Stage) : void
      {
         if(stage || !param1)
         {
            return;
         }
         stage = param1;
         stage.addEventListener(Event.EXIT_FRAME,onExitFrame);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            keys[param1.keyCode] = true;
            if(param1.keyCode == 119)
            {
               statsOn = !statsOn;
            }
            if(param1.keyCode == 27 && isMirroring())
            {
               disconnect();
               status = "LEFT THE GAME";
            }
         });
         stage.addEventListener(KeyboardEvent.KEY_UP,function(param1:KeyboardEvent):void
         {
            keys[param1.keyCode] = false;
         });
         loadConfig();
      }

      private static function loadConfig() : void
      {
         var loader:URLLoader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            parseConfig(String(loader.data));
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
         });
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:Event):void
         {
         });
         try
         {
            loader.load(new URLRequest("online.txt"));
         }
         catch(e:Error)
         {
         }
      }

      private static function parseConfig(param1:String) : void
      {
         var line:String = null;
         var eq:int = 0;
         var parts:Array = null;
         for each(line in param1.split(/\r?\n/))
         {
            line = line.replace(/^\s+|\s+$/g,"");
            eq = line.indexOf("=");
            if(line.length == 0 || line.charAt(0) == "#" || eq < 0)
            {
               continue;
            }
            config[line.substr(0,eq).replace(/\s+$/,"").toLowerCase()] = line.substr(eq + 1).replace(/^\s+/,"");
         }
         if(config["relay"])
         {
            parts = String(config["relay"]).split(":");
            relayHost = parts[0];
            if(parts.length > 1)
            {
               relayPort = int(parts[1]);
            }
         }
         // Testing aids: stats=1 shows the F8 stats from the start; testpad=1 makes a guest walk in circles and
         // shoot, so online play can be watched without a second person.
         if(config["stats"] == "1")
         {
            statsOn = true;
         }
         if(config["autohost"])
         {
            startHosting();
         }
         if(config["autojoin"])
         {
            join(config["autojoin"]);
         }
      }

      public static function isHosting() : Boolean
      {
         return mode == 1;
      }

      public static function isMirroring() : Boolean
      {
         return view != null;
      }

      // Host: the guest is connected and should be (re)spawned as player 2 when possible.
      public static function guestWaiting() : Boolean
      {
         return mode == 1 && peer && remotePad != null;
      }

      // Called by MainScene each update with its player 2 (or null).
      public static function watchPlayer2(param1:PlayerBase) : void
      {
         player2 = param1;
         player2At = getTimer();
      }

      // Called by player 2's PlayerBase._update, once per game tick it moves.
      public static function player2Tick() : void
      {
         ++p2Ticks;
         p2TickAt = getTimer();
      }

      public static function takeGuestLeft() : Boolean
      {
         var _loc1_:Boolean = guestLeft;
         guestLeft = false;
         return _loc1_;
      }

      // ---------------- connection ----------------

      public static function startHosting() : void
      {
         if(mode == 1)
         {
            return;
         }
         if(!staticNames)
         {
            buildStaticNames();
         }
         mode = 1;
         status = "CONNECTING...";
         code = "";
         connect(function():void
         {
            var b:ByteArray = new ByteArray();
            b.writeUTF(VERSION);
            sendRelay(R_HOST,b);
         });
      }

      public static function join(param1:String) : void
      {
         code = param1.replace(/\s+/g,"").toUpperCase();
         if(code.length == 0)
         {
            status = "ENTER A CODE";
            return;
         }
         mode = 2;
         status = "CONNECTING...";
         connect(function():void
         {
            var b:ByteArray = new ByteArray();
            b.writeUTF(code);
            b.writeUTF(VERSION);
            sendRelay(R_JOIN,b);
         });
      }

      public static function disconnect() : void
      {
         closeSocket();
         if(mode == 1 && peer)
         {
            guestLeft = true;
         }
         mode = 0;
         peer = false;
         remotePad = null;
         status = "";
         stopMirror();
      }

      private static function lost(param1:String) : void
      {
         disconnect();
         status = param1;
      }

      private static function closeSocket() : void
      {
         var s:Socket = sock;
         sock = null;
         if(s)
         {
            try
            {
               s.close();
            }
            catch(e:Error)
            {
            }
         }
      }

      private static function connect(param1:Function) : void
      {
         var onReady:Function = param1;
         if(relayHost.length == 0)
         {
            lost("NO SERVER SET IN ONLINE.TXT");
            return;
         }
         closeSocket();
         peer = false;
         remotePad = null;
         inBuf = new ByteArray();
         var s:Socket = new Socket();
         sock = s;
         s.timeout = 10000;
         s.addEventListener(Event.CONNECT,function(param1:Event):void
         {
            if(s == sock)
            {
               onReady();
               flush();
            }
         });
         s.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:Event):void
         {
            if(s == sock)
            {
               onData();
            }
         });
         s.addEventListener(Event.CLOSE,function(param1:Event):void
         {
            if(s == sock)
            {
               lost(mode == 2 && peer ? "THE HOST LEFT THE GAME" : "CONNECTION LOST");
            }
         });
         s.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
            if(s == sock)
            {
               lost("CAN'T REACH THE ONLINE SERVER");
            }
         });
         s.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:Event):void
         {
            if(s == sock)
            {
               lost("CAN'T REACH THE ONLINE SERVER");
            }
         });
         try
         {
            s.connect(relayHost,relayPort);
         }
         catch(e:Error)
         {
            lost("CAN'T REACH THE ONLINE SERVER");
         }
      }

      private static function sendRelay(param1:int, param2:ByteArray = null) : void
      {
         if(!sock || !sock.connected)
         {
            return;
         }
         try
         {
            sock.writeUnsignedInt(1 + (param2 ? param2.length : 0));
            bytesOut += 5 + (param2 ? param2.length : 0);
            sock.writeByte(param1);
            if(param2 && param2.length > 0)
            {
               sock.writeBytes(param2);
            }
         }
         catch(e:Error)
         {
         }
      }

      private static function sendData(param1:int, param2:ByteArray) : void
      {
         var b:ByteArray = new ByteArray();
         b.writeByte(param1);
         if(param2.length > 0)
         {
            b.writeBytes(param2);
         }
         sendRelay(R_DATA,b);
      }

      // Big messages go through the bulk queue (see sendBulk), in order among themselves.
      private static function queueBulk(param1:int, param2:ByteArray) : void
      {
         var b:ByteArray = new ByteArray();
         b.writeByte(param1);
         b.writeBytes(param2);
         bulk.push(b);
      }

      private static function flush() : void
      {
         if(sock && sock.connected)
         {
            try
            {
               sock.flush();
            }
            catch(e:Error)
            {
            }
         }
      }

      private static function onData() : void
      {
         var s:Socket = sock;
         var len:uint = 0;
         var type:int = 0;
         var body:ByteArray = null;
         var rest:ByteArray = null;
         // inBuf.position is where the next message starts.
         var pos:int = inBuf.position;
         if(s.bytesAvailable > 0)
         {
            bytesIn += s.bytesAvailable;
            s.readBytes(inBuf,inBuf.length,s.bytesAvailable);
         }
         while(inBuf.length - pos >= 4)
         {
            inBuf.position = pos;
            len = inBuf.readUnsignedInt();
            if(inBuf.length - pos - 4 < len)
            {
               break;
            }
            type = inBuf.readUnsignedByte();
            body = new ByteArray();
            if(len > 1)
            {
               inBuf.readBytes(body,0,len - 1);
            }
            pos += 4 + len;
            try
            {
               onRelayMessage(type,body);
            }
            catch(e:Error)
            {
            }
            if(s != sock)
            {
               return;
            }
         }
         // Only move leftover bytes down when everything was used or a lot of the buffer is spent; copying the
         // unfinished rest after every read made big pictures cost quadratic time.
         if(pos >= inBuf.length)
         {
            inBuf.length = 0;
            inBuf.position = 0;
         }
         else if(pos > 262144)
         {
            rest = new ByteArray();
            inBuf.position = pos;
            inBuf.readBytes(rest,0,inBuf.length - pos);
            inBuf = rest;
            inBuf.position = 0;
         }
         else
         {
            inBuf.position = pos;
         }
      }

      private static function onRelayMessage(param1:int, param2:ByteArray) : void
      {
         if(param1 == R_DATA)
         {
            if(mode == 1)
            {
               onGuestData(param2);
            }
            else if(mode == 2)
            {
               onHostData(param2);
            }
         }
         else if(param1 == R_CODE)
         {
            code = param2.readUTF();
            status = "JOIN CODE: " + code;
         }
         else if(param1 == R_PEER_JOINED)
         {
            peer = true;
            if(mode == 1)
            {
               status = "FRIEND CONNECTED   (CODE " + code + ")";
               resetHost();
            }
            else
            {
               status = "CONNECTED";
               // Warm-up: load every picture the host may refer to by name.
               if(!staticNames)
               {
                  buildStaticNames();
               }
               startMirror();
            }
         }
         else if(param1 == R_PEER_LEFT)
         {
            if(mode == 1)
            {
               peer = false;
               remotePad = null;
               guestLeft = true;
               status = "FRIEND LEFT.   JOIN CODE: " + code;
            }
            else
            {
               lost("THE HOST LEFT THE GAME");
            }
         }
         else if(param1 == R_ERROR)
         {
            lost(param2.readUTF());
         }
         else if(param1 == R_PONG && param2.length >= 4)
         {
            serverPing = getTimer() - param2.readUnsignedInt();
         }
      }

      private static function sendPing() : void
      {
         lastPing = getTimer();
         var b:ByteArray = new ByteArray();
         b.writeUnsignedInt(lastPing);
         sendRelay(R_PING,b);
      }

      private static function onExitFrame(param1:Event) : void
      {
         ++frameNo;
         if(sock && sock.connected && getTimer() - lastPing > 2000)
         {
            sendPing();
         }
         if(mode == 1 && peer && frameNo % 2 == 0)
         {
            // Skip frames while the link is backed up, so lag doesn't build up.
            if(canSendFrame())
            {
               try
               {
                  captureFrame();
               }
               catch(e:Error)
               {
               }
            }
            else
            {
               ++framesSkipped;
            }
         }
         if(mode == 1 && peer)
         {
            sendBulk();
         }
         if(mode == 2 && peer)
         {
            sendPad();
            updateGuestView();
         }
         updateStats();
         flush();
      }

      // ---------------- host: capture ----------------

      private static function resetHost() : void
      {
         imgInfo = new Dictionary(true);
         idInfo = {};
         nextImg = 1;
         vecCache = new Dictionary(true);
         textCache = new Dictionary(true);
         filterIds = {};
         nextFilter = 1;
         soundIds = new Dictionary(true);
         nextSound = 1;
         chanIds = new Dictionary(true);
         nextChan = 1;
         objIds = new Dictionary(true);
         nextObj = 1;
         lastSent = {};
         ackSeq = frameSeq;
         rtt = 0;
         rttMin = rttNextMin = -1;
         rttMinAt = getTimer();
         bulk = [];
         bulkPos = 0;
         bulkSent = bulkAcked = 0;
         bulkWindow = 16384;
         latched = {};
         if(!staticNames)
         {
            buildStaticNames();
         }
      }

      // Every static picture in the game's classes (Embeds and the ObjectConstructors' animation frames), named
      // "class#variable", so a picture the guest's copy of the game also has is sent by name. Touching them all
      // also loads them, so on both sides this is the warm-up when online play starts.
      private static function buildStaticNames() : void
      {
         var v:XML = null;
         var bd:BitmapData = null;
         var n:String = null;
         var cls:Class = null;
         staticNames = new Dictionary();
         var names:Object = null;
         try
         {
            names = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
         }
         catch(e:Error)
         {
            names = ["GlobalSetup::Embeds"];
         }
         for each(n in names)
         {
            if(n != "GlobalSetup::Embeds" && n.indexOf("ObjectConstructors::") != 0)
            {
               continue;
            }
            try
            {
               cls = getDefinitionByName(n) as Class;
               if(!cls)
               {
                  continue;
               }
               for each(v in describeType(cls).variable)
               {
                  if(String(v.@type) == "flash.display::BitmapData")
                  {
                     bd = cls[String(v.@name)] as BitmapData;
                     if(bd && !staticNames[bd])
                     {
                        staticNames[bd] = n + "#" + String(v.@name);
                     }
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
      }

      // A static picture by its "class#variable" name.
      private static function resolveStatic(param1:String) : BitmapData
      {
         var i:int = param1.indexOf("#");
         try
         {
            return (getDefinitionByName(param1.substr(0,i)) as Class)[param1.substr(i + 1)] as BitmapData;
         }
         catch(e:Error)
         {
         }
         return null;
      }

      private static function canSendFrame() : Boolean
      {
         if(!sock || sock.bytesPending > 32768)
         {
            return false;
         }
         var unacked:int = frameSeq - ackSeq;
         if(unacked < 2)
         {
            return true;
         }
         if(rttMin < 0)
         {
            return unacked < 8;
         }
         return getTimer() - sentAt[ackSeq + 1 & 255] < rttMin + 100;
      }

      // The guest has everything up to frame `param1` (16 bits).
      private static function onAck(param1:int) : void
      {
         var seq:int = frameSeq - (frameSeq - param1 & 65535);
         if(seq <= ackSeq)
         {
            return;
         }
         var now:int = getTimer();
         var sample:Number = now - sentAt[seq & 255];
         ackSeq = seq;
         bulkAcked = bulkAt[seq & 255];
         rtt = rtt > 0 ? rtt + (sample - rtt) * 0.1 : sample;
         if(rttMin < 0 || sample < rttMin)
         {
            rttMin = sample;
         }
         if(rttNextMin < 0 || sample < rttNextMin)
         {
            rttNextMin = sample;
         }
         // The base round trip is the lowest of the last 10-20 s, so it follows route changes.
         if(now - rttMinAt > 10000)
         {
            rttMin = rttNextMin;
            rttNextMin = -1;
            rttMinAt = now;
         }
         // Pictures: send less at once when round trips grow (a queue is building), more while they stay low.
         if(sample > rttMin + 50)
         {
            if(now - bulkCutAt > rttMin + 50)
            {
               bulkCutAt = now;
               bulkWindow = Math.max(4096,bulkWindow * 0.5);
            }
         }
         else if(sample < rttMin + 25 && bulkSent - bulkAcked > bulkWindow * 0.5)
         {
            // Only grows while it's being used, so it still fits the link when the next pictures come.
            bulkWindow = Math.min(262144,bulkWindow + 1024);
         }
      }

      // Big messages, in pieces, while the amount not yet acknowledged is within the window and the frames
      // aren't queueing (the oldest unacknowledged frame is barely older than the base round trip).
      private static function sendBulk() : void
      {
         var n:int = 0;
         var msg:ByteArray = null;
         var size:int = 0;
         var b:ByteArray = null;
         if(bulk.length == 0 || frameSeq - ackSeq >= 2 && (rttMin < 0 || getTimer() - sentAt[ackSeq + 1 & 255] > rttMin + 40))
         {
            return;
         }
         while(bulk.length > 0 && bulkSent - bulkAcked < bulkWindow && n < 4 && sock && sock.bytesPending < 65536)
         {
            msg = bulk[0];
            // Smaller pieces on slow links (small window), so a frame never waits long behind one.
            size = Math.min(Math.max(1024,Math.min(CHUNK_SIZE,bulkWindow / 4)),msg.length - bulkPos);
            if(bulkPos == 0 && size == msg.length)
            {
               sendRelay(R_DATA,msg);
            }
            else
            {
               b = new ByteArray();
               b.writeByte(D_CHUNK);
               b.writeByte(bulkPos + size >= msg.length ? 1 : 0);
               b.writeBytes(msg,bulkPos,size);
               sendRelay(R_DATA,b);
            }
            bulkPos += size;
            bulkSent += size;
            if(bulkPos >= msg.length)
            {
               bulk.shift();
               bulkPos = 0;
            }
            n++;
         }
      }

      private static function captureFrame() : void
      {
         var t0:int = getTimer();
         ++frameSeq;
         sentAt[frameSeq & 255] = t0;
         bulkAt[frameSeq & 255] = bulkSent;
         frameBody = new ByteArray();
         frameCount = 0;
         rootFix = null;
         if(stage.numChildren > 0)
         {
            // In a scaled window concatenatedMatrix includes the stage scale; take it back out.
            var top:DisplayObject = stage.getChildAt(0);
            var m:Matrix = top.transform.matrix.clone();
            m.invert();
            var full:Matrix = top.transform.concatenatedMatrix;
            m.concat(full);
            if(Math.abs(m.a - 1) > 0.001 || Math.abs(m.d - 1) > 0.001 || Math.abs(m.tx) > 0.01 || Math.abs(m.ty) > 0.01)
            {
               m.invert();
               rootFix = m;
            }
         }
         collectPlayer2();
         walk(stage,null,BlendMode.NORMAL);
         var out:ByteArray = new ByteArray();
         out.writeUnsignedInt(t0);
         out.writeShort(frameSeq);
         out.writeShort(Math.min(65535,Math.round(rtt)));
         writeVar(out,frameCount);
         out.writeBytes(frameBody);
         writeChannels(out);
         writePlayer2(out);
         out.compress();
         sendData(D_FRAME,out);
         if(frameNo % 600 == 0)
         {
            sweep();
         }
         captureMs += (getTimer() - t0 - captureMs) * 0.1;
      }

      // Host: the display objects that make up player 2 (1) and its aim reticle (2), when it can be predicted:
      // alive, not falling, not teleporting.
      private static function collectPlayer2() : void
      {
         p2Objects = null;
         p2Oids.length = 0;
         p2CursorOid = 0;
         var p:PlayerBase = player2;
         // Also not while player 2 isn't being updated (a comms message or the game is paused): it can't move.
         if(!p || getTimer() - player2At > 250 || getTimer() - p2TickAt > 60 || p._removed || p.falling || p.beforeTeleporting() || config["predict"] == "0")
         {
            return;
         }
         p2Objects = new Dictionary();
         markObjects(p,1);
         var i:int = 0;
         while(i < 4)
         {
            if(p.weaponIcons[i])
            {
               markObjects(p.weaponIcons[i],1);
            }
            i++;
         }
         if(p.riotShield)
         {
            markObjects(p.riotShield,1);
         }
         var cur:Sprite = Input.i ? Input.i.p2CursorSprite() : null;
         if(cur && cur.visible)
         {
            markDisplay(cur,2);
         }
      }

      private static function markObjects(param1:GameObject, param2:int) : void
      {
         var c:GameObject = null;
         if(param1.obj)
         {
            markDisplay(param1.obj,param2);
         }
         for each(c in param1.children)
         {
            markObjects(c,param2);
         }
         // Shadows and other helper-made children live here, not in children.
         var cc:Object = param1.vars ? param1.vars["conditionalChildren"] : null;
         var k:String = null;
         for(k in cc)
         {
            if(cc[k] is GameObject)
            {
               markObjects(GameObject(cc[k]),param2);
            }
         }
      }

      private static function markDisplay(param1:DisplayObject, param2:int) : void
      {
         p2Objects[param1] = param2;
         var dc:DisplayObjectContainer = param1 as DisplayObjectContainer;
         var i:int = 0;
         if(dc)
         {
            while(i < dc.numChildren)
            {
               markDisplay(dc.getChildAt(i),param2);
               i++;
            }
         }
      }

      // u8 present; then x, y (1/4 px), dx, dy, last guest input applied, can-move flags, room bounds, half size,
      // aim point, player 2's object ids, the reticle's id.
      private static function writePlayer2(param1:ByteArray) : void
      {
         var p:PlayerBase = player2;
         if(!p2Objects || p2Oids.length == 0)
         {
            param1.writeByte(0);
            return;
         }
         var ms:MainScene = p.gs as MainScene;
         param1.writeByte(1);
         param1.writeShort(clampShort(p.basex * 4));
         param1.writeShort(clampShort(p.basey * 4));
         param1.writeFloat(p.dx);
         param1.writeFloat(p.dy);
         param1.writeShort(appliedSeq);
         param1.writeShort(Math.min(65535,(p2Ticks - appliedTick) * 10));
         param1.writeByte((p.canMoveX() ? 1 : 0) | (p.canMoveY() ? 2 : 0));
         param1.writeShort(ms ? ms.startx : 0);
         param1.writeShort(ms ? ms.endx : 800);
         param1.writeShort(ms ? ms.starty : 0);
         param1.writeShort(ms ? ms.endy : 600);
         param1.writeByte(Math.min(255,p.baseWidth / 2));
         param1.writeByte(Math.min(255,p.baseHeight / 2));
         param1.writeShort(clampShort(p.aimPointX() * 4));
         param1.writeShort(clampShort(p.aimPointY() * 4));
         writeVar(param1,p2Oids.length);
         var oid:int = 0;
         for each(oid in p2Oids)
         {
            writeVar(param1,oid);
         }
         writeVar(param1,p2CursorOid);
      }

      private static function writeVar(param1:ByteArray, param2:uint) : void
      {
         while(param2 >= 128)
         {
            param1.writeByte(param2 & 127 | 128);
            param2 >>>= 7;
         }
         param1.writeByte(param2);
      }

      private static function readVar(param1:ByteArray) : uint
      {
         var v:uint = 0;
         var s:int = 0;
         var x:int = 0;
         do
         {
            x = param1.readUnsignedByte();
            v |= (x & 127) << s;
            s += 7;
         }
         while((x & 128) != 0);

         return v;
      }

      private static function walk(param1:DisplayObjectContainer, param2:Array, param3:String) : void
      {
         var c:DisplayObject = null;
         var f:Array = null;
         var fl:Array = null;
         var bl:String = null;
         var n:int = param1.numChildren;
         var i:int = 0;
         while(i < n)
         {
            c = param1.getChildAt(i);
            i++;
            if(!c.visible || c.alpha <= 0 || c == statsText)
            {
               continue;
            }
            f = c.filters;
            fl = param2;
            if(f.length > 0)
            {
               fl = param2 ? f.concat(param2) : f;
            }
            bl = c.blendMode != BlendMode.NORMAL && c.blendMode != BlendMode.LAYER ? c.blendMode : param3;
            if(c is Bitmap)
            {
               if(Bitmap(c).bitmapData)
               {
                  emit(c,Bitmap(c).bitmapData,0,0,fl,bl,Bitmap(c).smoothing);
               }
            }
            else if(c is TextField)
            {
               emitText(TextField(c),fl,bl);
            }
            else if(c is SimpleButton)
            {
               // HUD buttons: draw the button's normal state.
               var st:DisplayObject = SimpleButton(c).upState;
               if(st is Bitmap && Bitmap(st).bitmapData)
               {
                  var sm:Matrix = st.transform.matrix.clone();
                  sm.concat(c.transform.concatenatedMatrix);
                  emit(c,Bitmap(st).bitmapData,0,0,fl,bl,Bitmap(st).smoothing,sm,st);
               }
            }
            else if(c is Shape)
            {
               emitVector(c,Shape(c).graphics,fl,bl);
            }
            else if(c is DisplayObjectContainer)
            {
               if(c is Sprite)
               {
                  emitVector(c,Sprite(c).graphics,fl,bl);
               }
               try
               {
                  walk(DisplayObjectContainer(c),fl,bl);
               }
               catch(e:Error)
               {
               }
            }
         }
      }

      // One picture on screen. Per object, only the fields that changed since the last frame are written:
      // object id, change mask, then image / position / rotation+scale / alpha / colour / filters / blend+smoothing.
      private static function emit(param1:DisplayObject, param2:BitmapData, param3:Number, param4:Number, param5:Array, param6:String, param7:Boolean, param8:Matrix = null, param9:DisplayObject = null) : void
      {
         var ct:ColorTransform = param1.transform.concatenatedColorTransform;
         if(ct.alphaMultiplier <= 0.004)
         {
            return;
         }
         var info:Object = imageInfo(param2,param9 ? param9 : param1);
         if(!info)
         {
            return;
         }
         var m:Matrix = param8 ? param8 : param1.transform.concatenatedMatrix;
         if(param3 != 0 || param4 != 0)
         {
            var t:Matrix = new Matrix(1,0,0,1,param3,param4);
            t.concat(m);
            m = t;
         }
         if(rootFix)
         {
            m.concat(rootFix);
         }
         var fid:int = param5 ? filterSetId(param5) : 0;
         var tx:int = clampShort(m.tx * 4);
         var ty:int = clampShort(m.ty * 4);
         var al:int = Math.round(Math.min(1,ct.alphaMultiplier) * 255);
         var tinted:Boolean = ct.redMultiplier != 1 || ct.greenMultiplier != 1 || ct.blueMultiplier != 1 || ct.redOffset != 0 || ct.greenOffset != 0 || ct.blueOffset != 0;
         var cr:int = tinted ? clampShort(ct.redMultiplier * 256) : 256;
         var cg:int = tinted ? clampShort(ct.greenMultiplier * 256) : 256;
         var cb:int = tinted ? clampShort(ct.blueMultiplier * 256) : 256;
         var cro:int = tinted ? clampShort(ct.redOffset) : 0;
         var cgo:int = tinted ? clampShort(ct.greenOffset) : 0;
         var cbo:int = tinted ? clampShort(ct.blueOffset) : 0;
         var fl:int = Math.max(0,BLENDS.indexOf(param6)) | (param7 ? 128 : 0);
         var oid:int = objIds[param1];
         if(!oid)
         {
            oid = nextObj++;
            objIds[param1] = oid;
         }
         if(p2Objects && p2Objects[param1])
         {
            if(p2Objects[param1] == 2)
            {
               p2CursorOid = oid;
            }
            else
            {
               p2Oids.push(oid);
            }
         }
         var last:Object = lastSent[oid];
         var mask:int = 0;
         if(!last)
         {
            last = {};
            lastSent[oid] = last;
            mask = 127;
         }
         else
         {
            if(last.img != info.id)
            {
               mask |= 1;
            }
            if(last.tx != tx || last.ty != ty)
            {
               mask |= 2;
            }
            if(Math.abs(last.a - m.a) > 0.0005 || Math.abs(last.b - m.b) > 0.0005 || Math.abs(last.c - m.c) > 0.0005 || Math.abs(last.d - m.d) > 0.0005)
            {
               mask |= 4;
            }
            if(last.al != al)
            {
               mask |= 8;
            }
            if(last.cr != cr || last.cg != cg || last.cb != cb || last.cro != cro || last.cgo != cgo || last.cbo != cbo)
            {
               mask |= 16;
            }
            if(last.fid != fid)
            {
               mask |= 32;
            }
            if(last.fl != fl)
            {
               mask |= 64;
            }
         }
         last.seen = frameSeq;
         var b:ByteArray = frameBody;
         writeVar(b,oid);
         b.writeByte(mask);
         if(mask & 1)
         {
            writeVar(b,info.id);
            last.img = info.id;
         }
         if(mask & 2)
         {
            b.writeShort(tx);
            b.writeShort(ty);
            last.tx = tx;
            last.ty = ty;
         }
         if(mask & 4)
         {
            b.writeFloat(m.a);
            b.writeFloat(m.b);
            b.writeFloat(m.c);
            b.writeFloat(m.d);
            last.a = m.a;
            last.b = m.b;
            last.c = m.c;
            last.d = m.d;
         }
         if(mask & 8)
         {
            b.writeByte(al);
            last.al = al;
         }
         if(mask & 16)
         {
            if(tinted)
            {
               b.writeByte(1);
               b.writeShort(cr);
               b.writeShort(cg);
               b.writeShort(cb);
               b.writeShort(cro);
               b.writeShort(cgo);
               b.writeShort(cbo);
            }
            else
            {
               b.writeByte(0);
            }
            last.cr = cr;
            last.cg = cg;
            last.cb = cb;
            last.cro = cro;
            last.cgo = cgo;
            last.cbo = cbo;
         }
         if(mask & 32)
         {
            writeVar(b,fid);
            last.fid = fid;
         }
         if(mask & 64)
         {
            b.writeByte(fl);
            last.fl = fl;
         }
         ++frameCount;
      }

      private static function clampShort(param1:Number) : int
      {
         return Math.max(-32768,Math.min(32767,Math.round(param1)));
      }

      // Pixels are sent the first time a picture is used. Pictures are checked now and then for changes (the
      // floor's blood decals, bars, HUD timers, vector graphics), and only the changed rectangle is resent.
      private static function imageInfo(param1:BitmapData, param2:DisplayObject) : Object
      {
         var info:Object = imgInfo[param1];
         if(!info)
         {
            try
            {
               info = {
                  id:nextImg++,
                  seen:frameNo,
                  checked:frameNo,
                  interval:2,
                  sig:signature(param1),
                  copy:null,
                  base:null
               };
               imgInfo[param1] = info;
               idInfo[info.id] = info;
               registerImage(info,param1,param2);
            }
            catch(e:Error)
            {
               return null;
            }
            return info;
         }
         info.seen = frameNo;
         if(frameNo - info.checked >= info.interval)
         {
            info.checked = frameNo;
            var sig:Number = signature(param1);
            if(sig != info.sig)
            {
               info.sig = sig;
               info.interval = param1.width * param1.height > 100000 ? 12 : 2;
               sendChange(info,param1);
            }
            else
            {
               info.interval = Math.min(param1.width * param1.height > 100000 ? 24 : 30,info.interval * 2);
            }
         }
         return info;
      }

      private static function signature(param1:BitmapData) : Number
      {
         var h:Object = param1.histogram();
         var s:Number = param1.width * 7919 + param1.height;
         var ch:int = 0;
         var i:int = 0;
         var v:Object = null;
         while(ch < 4)
         {
            v = h[ch];
            i = 0;
            while(i < 256)
            {
               s += v[i] * (i + 1) * (ch * 263 + 1);
               i++;
            }
            ch++;
         }
         return s;
      }

      // A new picture: by name if the guest's copy of the game already has it (plus any pixels that differ from
      // the original), otherwise its pixels.
      private static function registerImage(param1:Object, param2:BitmapData, param3:DisplayObject) : void
      {
         var rec:Object = recipes[param2];
         if(rec)
         {
            sendRecipe(param1,param2,rec);
            return;
         }
         var name:String = staticNames ? staticNames[param2] : null;
         if(name)
         {
            sendRef(param1.id,3,name);
            param1.copy = param2.clone();
            return;
         }
         var cls:String = param3 is Bitmap ? getQualifiedClassName(param3) : null;
         if(cls && cls.indexOf("::Embeds_") > 0)
         {
            var orig:BitmapData = classOriginal(cls);
            if(orig && orig.width == param2.width && orig.height == param2.height)
            {
               sendRef(param1.id,2,cls);
               var diff:Object = param2.compare(orig);
               if(diff is BitmapData)
               {
                  var r:Rectangle = null;
                  for each(r in changedRects(BitmapData(diff)))
                  {
                     sendImage(param1.id,param2,r,false);
                  }
                  BitmapData(diff).dispose();
                  param1.copy = param2.clone();
               }
               else
               {
                  param1.base = orig;
               }
               return;
            }
         }
         var text:ByteArray = textDescs[param2];
         if(text)
         {
            var tb:ByteArray = new ByteArray();
            writeVar(tb,param1.id);
            tb.writeShort(param2.width);
            tb.writeShort(param2.height);
            tb.writeBytes(text);
            sendData(D_TEXT,tb);
            return;
         }
         // One colour all over (fade and menu backings): just the colour.
         if(param2.width * param2.height >= 4096)
         {
            var c:uint = param2.getPixel32(0,0);
            var other:Rectangle = param2.getColorBoundsRect(4294967295,c,false);
            if(other.width == 0 || other.height == 0)
            {
               var fb:ByteArray = new ByteArray();
               writeVar(fb,param1.id);
               fb.writeShort(param2.width);
               fb.writeShort(param2.height);
               fb.writeByte(param2.transparent ? 1 : 0);
               fb.writeUnsignedInt(c);
               queueBulk(D_FILL,fb);
               param1.copy = param2.clone();
               return;
            }
         }
         sendImage(param1.id,param2,param2.rect,true);
      }

      // ---------------- recorded pictures (room floors) ----------------

      // Called by GameLevel.getFloor when it creates a room's floor picture.
      public static function recordStart(param1:BitmapData, param2:uint) : void
      {
         if(mode != 1)
         {
            return;
         }
         recipes[param1] = {
            w:param1.width,
            h:param1.height,
            tr:param1.transparent,
            fill:param2,
            ops:[]
         };
      }

      // GameLevel.getFloor's draw calls go through here: the draw, plus a record of it when hosting. param8 is the
      // display object a BitmapData source belongs to, to name it by its embedded class.
      public static function recordDraw(param1:BitmapData, param2:IBitmapDrawable, param3:Matrix = null, param4:ColorTransform = null, param5:String = null, param6:Rectangle = null, param7:Boolean = false, param8:DisplayObject = null) : void
      {
         param1.draw(param2,param3,param4,param5,param6,param7);
         var rec:Object = recipes[param1];
         if(!rec)
         {
            return;
         }
         // A source that can't be named is left out: the host's check after replaying sends that area as pixels.
         var name:String = sourceName(param2,param8);
         if(!name)
         {
            return;
         }
         var bmp:Bitmap = param2 as Bitmap;
         rec.ops.push({
            t:1,
            name:name,
            bmp:bmp != null,
            snap:bmp ? bmp.pixelSnapping : "auto",
            bsmooth:bmp ? bmp.smoothing : false,
            m:param3 ? param3.clone() : null,
            ct:param4 ? new ColorTransform(param4.redMultiplier,param4.greenMultiplier,param4.blueMultiplier,param4.alphaMultiplier,param4.redOffset,param4.greenOffset,param4.blueOffset,param4.alphaOffset) : null,
            blend:param5,
            clip:param6 ? param6.clone() : null,
            smooth:param7
         });
      }

      // Called by MainScene after a floor mark (floor.drawToImage): recorded, and sent at once if the guest has
      // the floor already.
      public static function recordMark(param1:GameObject, param2:BitmapData, param3:Number, param4:Number, param5:int, param6:Number, param7:Number, param8:String, param9:Rectangle, param10:Array) : void
      {
         var target:BitmapData = param1 && param1.obj is Bitmap ? Bitmap(param1.obj).bitmapData : null;
         var rec:Object = target ? recipes[target] : null;
         if(!rec)
         {
            return;
         }
         var name:String = sourceName(param2,null);
         if(!name)
         {
            return;
         }
         var op:Object = {
            t:2,
            name:name,
            x:param3,
            y:param4,
            rot:param5,
            sx:param6,
            sy:param7,
            blend:param8,
            clip:param9 ? param9.clone() : null,
            tint:param10 ? param10.concat() : null,
            bx:param1.basex,
            by:param1.basey
         };
         rec.ops.push(op);
         var info:Object = imgInfo[target];
         if(mode == 1 && peer && info && info.copy)
         {
            var b:ByteArray = new ByteArray();
            writeVar(b,info.id);
            writeOps(b,[op]);
            queueBulk(D_FLOOROP,b);
            // Keep the host's copy of what the guest has in step, so the change check finds nothing to resend.
            b.position = 0;
            readVar(b);
            replayOps(info.copy,b);
         }
      }

      // The name of a picture the guest's copy also has: a static picture, or an embedded class's untouched
      // picture.
      private static function sourceName(param1:Object, param2:DisplayObject) : String
      {
         var bd:BitmapData = param1 is Bitmap ? Bitmap(param1).bitmapData : param1 as BitmapData;
         if(!bd)
         {
            return null;
         }
         if(!staticNames)
         {
            buildStaticNames();
         }
         if(staticNames[bd])
         {
            return "S" + staticNames[bd];
         }
         var disp:DisplayObject = param1 is Bitmap ? DisplayObject(param1) : param2;
         var cls:String = disp is Bitmap ? getQualifiedClassName(disp) : null;
         if(cls && cls.indexOf("::Embeds_") > 0)
         {
            var orig:BitmapData = classOriginal(cls);
            if(orig && orig.width == bd.width && orig.height == bd.height && (orig == bd || orig.compare(bd) === 0))
            {
               return "K" + cls;
            }
         }
         return null;
      }

      private static function resolveSource(param1:String) : BitmapData
      {
         if(param1.charAt(0) == "S")
         {
            return resolveStatic(param1.substr(1));
         }
         return classOriginal(param1.substr(1));
      }

      // Names table, then the calls.
      private static function writeOps(param1:ByteArray, param2:Array) : void
      {
         var names:Array = [];
         var index:Object = {};
         var op:Object = null;
         for each(op in param2)
         {
            if(index[op.name] === undefined)
            {
               index[op.name] = names.length;
               names.push(op.name);
            }
         }
         writeVar(param1,names.length);
         var n:String = null;
         for each(n in names)
         {
            param1.writeUTF(n);
         }
         writeVar(param1,param2.length);
         var fl:int = 0;
         for each(op in param2)
         {
            param1.writeByte(op.t);
            writeVar(param1,index[op.name]);
            if(op.t == 1)
            {
               fl = (op.bmp ? 1 : 0) | (op.bsmooth ? 2 : 0) | (op.m ? 4 : 0) | (op.ct ? 8 : 0) | (op.clip ? 16 : 0) | (op.smooth ? 32 : 0);
               param1.writeByte(fl);
               param1.writeByte(Math.max(0,SNAPS.indexOf(op.snap)));
               param1.writeByte(op.blend ? Math.max(0,BLENDS.indexOf(op.blend)) : 255);
               if(op.m)
               {
                  param1.writeDouble(op.m.a);
                  param1.writeDouble(op.m.b);
                  param1.writeDouble(op.m.c);
                  param1.writeDouble(op.m.d);
                  param1.writeDouble(op.m.tx);
                  param1.writeDouble(op.m.ty);
               }
               if(op.ct)
               {
                  param1.writeDouble(op.ct.redMultiplier);
                  param1.writeDouble(op.ct.greenMultiplier);
                  param1.writeDouble(op.ct.blueMultiplier);
                  param1.writeDouble(op.ct.alphaMultiplier);
                  param1.writeDouble(op.ct.redOffset);
                  param1.writeDouble(op.ct.greenOffset);
                  param1.writeDouble(op.ct.blueOffset);
                  param1.writeDouble(op.ct.alphaOffset);
               }
            }
            else
            {
               fl = (op.clip ? 16 : 0) | (op.tint ? 64 : 0);
               param1.writeByte(fl);
               param1.writeDouble(op.x);
               param1.writeDouble(op.y);
               param1.writeInt(op.rot);
               param1.writeDouble(op.sx);
               param1.writeDouble(op.sy);
               param1.writeByte(op.blend ? Math.max(0,BLENDS.indexOf(op.blend)) : 255);
               param1.writeDouble(op.bx);
               param1.writeDouble(op.by);
               if(op.tint)
               {
                  param1.writeByte(op.tint.length);
                  var tv:Number = NaN;
                  for each(tv in op.tint)
                  {
                     param1.writeDouble(tv);
                  }
               }
            }
            if(op.clip)
            {
               param1.writeDouble(op.clip.x);
               param1.writeDouble(op.clip.y);
               param1.writeDouble(op.clip.width);
               param1.writeDouble(op.clip.height);
            }
         }
      }

      // Reads a names table and calls (as written by writeOps) and draws them onto param1. Used by the guest, and
      // by the host for its copy, so both run exactly the same code on exactly the same numbers.
      private static function replayOps(param1:BitmapData, param2:ByteArray) : void
      {
         var names:Array = [];
         var n:int = readVar(param2);
         while(n-- > 0)
         {
            names.push(param2.readUTF());
         }
         var sources:Array = [];
         n = readVar(param2);
         var t:int = 0;
         var src:BitmapData = null;
         var fl:int = 0;
         var snap:String = null;
         var bl:int = 0;
         var m:Matrix = null;
         var ct:ColorTransform = null;
         var clip:Rectangle = null;
         var idx:int = 0;
         while(n-- > 0)
         {
            t = param2.readUnsignedByte();
            idx = readVar(param2);
            if(sources[idx] === undefined)
            {
               sources[idx] = resolveSource(names[idx]);
            }
            src = sources[idx];
            fl = param2.readUnsignedByte();
            m = null;
            ct = null;
            clip = null;
            if(t == 1)
            {
               snap = SNAPS[param2.readUnsignedByte()];
               bl = param2.readUnsignedByte();
               if(fl & 4)
               {
                  m = new Matrix(param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble());
               }
               if(fl & 8)
               {
                  ct = new ColorTransform(param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble());
               }
               if(fl & 16)
               {
                  clip = new Rectangle(param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble());
               }
               if(src)
               {
                  param1.draw((fl & 1) != 0 ? new Bitmap(src,snap,(fl & 2) != 0) : src,m,ct,bl == 255 ? null : BLENDS[bl],clip,(fl & 32) != 0);
               }
            }
            else
            {
               var mx:Number = param2.readDouble();
               var my:Number = param2.readDouble();
               var rot:int = param2.readInt();
               var sx:Number = param2.readDouble();
               var sy:Number = param2.readDouble();
               bl = param2.readUnsignedByte();
               var bx:Number = param2.readDouble();
               var by:Number = param2.readDouble();
               var tint:Array = null;
               if(fl & 64)
               {
                  tint = [];
                  var k:int = param2.readUnsignedByte();
                  while(k-- > 0)
                  {
                     tint.push(param2.readDouble());
                  }
               }
               if(fl & 16)
               {
                  clip = new Rectangle(param2.readDouble(),param2.readDouble(),param2.readDouble(),param2.readDouble());
               }
               if(src)
               {
                  // Made and removed around each use, like GameLevel.getFloor does, so it never shows on screen.
                  var mo:GameObject = new GameObject(null,Bitmap,"BelowPlayer",0,0);
                  mo.obj.visible = false;
                  Bitmap(mo.obj).bitmapData = param1;
                  mo.basex = bx;
                  mo.basey = by;
                  mo.drawToImage(src,mx,my,rot,sx,sy,bl == 255 ? "normal" : BLENDS[bl],clip,tint);
                  Bitmap(mo.obj).bitmapData = null;
                  mo.remove();
               }
            }
         }
      }

      // Host: a recorded picture. The guest gets the calls; the host replays the same bytes for its copy and sends
      // whatever still differs (normally nothing) as pixels.
      private static function sendRecipe(param1:Object, param2:BitmapData, param3:Object) : void
      {
         var b:ByteArray = new ByteArray();
         writeVar(b,param1.id);
         b.writeShort(param3.w);
         b.writeShort(param3.h);
         b.writeByte(param3.tr ? 1 : 0);
         b.writeUnsignedInt(param3.fill);
         var ops:ByteArray = new ByteArray();
         writeOps(ops,param3.ops);
         b.writeBytes(ops);
         b.compress();
         queueBulk(D_RECIPE,b);
         var copy:BitmapData = new BitmapData(param3.w,param3.h,param3.tr,param3.fill);
         ops.position = 0;
         replayOps(copy,ops);
         param1.copy = copy;
         var diff:Object = param2.compare(copy);
         if(diff is BitmapData)
         {
            var r:Rectangle = null;
            for each(r in changedRects(BitmapData(diff)))
            {
               sendImage(param1.id,param2,r,false);
               copy.copyPixels(param2,r,r.topLeft);
            }
            BitmapData(diff).dispose();
         }
      }

      private static function classOriginal(param1:String) : BitmapData
      {
         if(classOriginals[param1] === undefined)
         {
            classOriginals[param1] = null;
            try
            {
               var obj:Object = new (getDefinitionByName(param1) as Class)();
               if(obj is Bitmap)
               {
                  classOriginals[param1] = Bitmap(obj).bitmapData;
               }
            }
            catch(e:Error)
            {
            }
         }
         return classOriginals[param1];
      }

      private static function sendRef(param1:int, param2:int, param3:String) : void
      {
         var b:ByteArray = new ByteArray();
         writeVar(b,param1);
         b.writeByte(param2);
         b.writeUTF(param3);
         sendData(D_IMAGEREF,b);
      }

      private static function sendChange(param1:Object, param2:BitmapData) : void
      {
         if(!param1.copy && param1.base)
         {
            param1.copy = BitmapData(param1.base).clone();
         }
         if(!param1.copy)
         {
            sendImage(param1.id,param2,param2.rect,false);
            param1.copy = param2.clone();
            return;
         }
         var diff:Object = param2.compare(param1.copy);
         if(diff is BitmapData)
         {
            var r:Rectangle = null;
            for each(r in changedRects(BitmapData(diff)))
            {
               sendImage(param1.id,param2,r,false);
               param1.copy.copyPixels(param2,r,r.topLeft);
            }
            BitmapData(diff).dispose();
         }
      }

      private static var cellScratch:BitmapData;

      // The changed parts of a picture (non-zero pixels of a compare() result). A big change area is split into
      // 128 px cells and each cell's own changed rectangle is used, so two blood splats in opposite corners of
      // the floor don't resend the whole floor.
      private static function changedRects(param1:BitmapData) : Array
      {
         var out:Array = [];
         var all:Rectangle = param1.getColorBoundsRect(4294967295,0,false);
         if(all.width <= 0 || all.height <= 0)
         {
            return out;
         }
         if(all.width * all.height <= 32768)
         {
            out.push(all);
            return out;
         }
         if(!cellScratch)
         {
            cellScratch = new BitmapData(128,128,true,0);
         }
         var cy:int = all.y;
         var cx:int = 0;
         var cell:Rectangle = new Rectangle();
         var r:Rectangle = null;
         var origin:Point = new Point();
         while(cy < all.bottom)
         {
            cx = all.x;
            while(cx < all.right)
            {
               cell.x = cx;
               cell.y = cy;
               cell.width = Math.min(128,all.right - cx);
               cell.height = Math.min(128,all.bottom - cy);
               cellScratch.fillRect(cellScratch.rect,0);
               cellScratch.copyPixels(param1,cell,origin);
               r = cellScratch.getColorBoundsRect(4294967295,0,false);
               if(r.width > 0 && r.height > 0)
               {
                  r.x += cx;
                  r.y += cy;
                  out.push(r);
               }
               cx += 128;
            }
            cy += 128;
         }
         return out;
      }

      private static function sendImage(param1:int, param2:BitmapData, param3:Rectangle, param4:Boolean) : void
      {
         // Opaque areas that aren't tiny (screen-fade snapshots, room floors, floor decals) go as JPEG: a tenth of
         // the size.
         if(param3.width * param3.height >= 4096)
         {
            var opaque:Boolean = !param2.transparent || !param2.getColorBoundsRect(4278190080,4278190080,false).intersects(param3);
            if(opaque)
            {
               var jb:ByteArray = new ByteArray();
               writeVar(jb,param1);
               jb.writeByte(param4 ? 1 : 0);
               jb.writeShort(param2.width);
               jb.writeShort(param2.height);
               jb.writeShort(param3.x);
               jb.writeShort(param3.y);
               jb.writeBytes(param2.encode(param3,new JPEGEncoderOptions(85)));
               queueBulk(D_JPEG,jb);
               return;
            }
         }
         var b:ByteArray = new ByteArray();
         b.writeUnsignedInt(param1);
         b.writeByte(param4 ? 1 : 0);
         b.writeShort(param2.width);
         b.writeShort(param2.height);
         b.writeShort(param3.x);
         b.writeShort(param3.y);
         b.writeShort(param3.width);
         b.writeShort(param3.height);
         var px:ByteArray = param2.getPixels(param3);
         px.compress();
         b.writeBytes(px);
         queueBulk(D_IMAGE,b);
      }

      // Tells the guest to drop pictures the host hasn't shown for a while (or no longer has).
      private static function sweep() : void
      {
         var bd:Object = null;
         var id:String = null;
         var live:Object = {};
         var info:Object = null;
         var stale:Array = [];
         for(bd in imgInfo)
         {
            info = imgInfo[bd];
            if(frameNo - info.seen > 1800)
            {
               stale.push(bd);
            }
            else
            {
               live[info.id] = true;
            }
         }
         for each(bd in stale)
         {
            delete imgInfo[bd];
         }
         var b:ByteArray = new ByteArray();
         var n:int = 0;
         for(id in idInfo)
         {
            if(!live[id])
            {
               b.writeUnsignedInt(int(id));
               delete idInfo[id];
               n++;
            }
         }
         if(n > 0)
         {
            // After any pictures still queued, which may be the ones being freed.
            queueBulk(D_FREE,b);
         }
         // Objects not shown for ~10 s are forgotten (sent in full if they come back). The guest keeps its copy
         // longer, so it never lacks the state a change is relative to.
         for(id in lastSent)
         {
            if(frameSeq - lastSent[id].seen > 300)
            {
               delete lastSent[id];
            }
         }
      }

      // Text and vector graphics are drawn into a picture on the host, and redrawn when they change.
      private static function emitText(param1:TextField, param2:Array, param3:String) : void
      {
         var key:String = param1.text + "|" + param1.textColor + "|" + int(param1.width) + "|" + int(param1.height) + "|" + param1.scrollV;
         var c:Object = textCache[param1];
         if(!c || c.key != key)
         {
            var r:Rectangle = param1.getBounds(param1);
            if(r.width < 1 || r.height < 1 || r.width * r.height > 1000000)
            {
               textCache[param1] = {
                  key:key,
                  bd:null
               };
               return;
            }
            var ox:int = Math.floor(r.x);
            var oy:int = Math.floor(r.y);
            // The guest has the same fonts, so it gets the text and draws it itself; this empty picture only
            // stands for it on the host.
            var bd:BitmapData = new BitmapData(Math.ceil(r.right) - ox + 1,Math.ceil(r.bottom) - oy + 1,true,0);
            var tb:ByteArray = new ByteArray();
            tb.writeShort(ox);
            tb.writeShort(oy);
            tb.writeFloat(param1.width);
            tb.writeFloat(param1.height);
            tb.writeByte((param1.embedFonts ? 1 : 0) | (param1.multiline ? 2 : 0) | (param1.wordWrap ? 4 : 0) | (param1.background ? 8 : 0) | (param1.border ? 16 : 0));
            tb.writeUnsignedInt(param1.backgroundColor);
            tb.writeUnsignedInt(param1.borderColor);
            tb.writeUTF(param1.autoSize);
            tb.writeUTF(param1.antiAliasType);
            tb.writeUTF(param1.gridFitType);
            tb.writeFloat(param1.sharpness);
            tb.writeFloat(param1.thickness);
            tb.writeShort(param1.scrollV);
            tb.writeUTF(param1.htmlText);
            textDescs[bd] = tb;
            c = {
               key:key,
               bd:bd,
               ox:ox,
               oy:oy
            };
            textCache[param1] = c;
         }
         if(c.bd)
         {
            emit(param1,c.bd,c.ox,c.oy,param2,param3,true);
         }
      }

      private static function emitVector(param1:DisplayObject, param2:Graphics, param3:Array, param4:String) : void
      {
         var c:Object = vecCache[param1];
         if(!c || frameNo - c.at >= 30)
         {
            var data:Object = null;
            try
            {
               data = param2.readGraphicsData(false);
            }
            catch(e:Error)
            {
            }
            if(!data || data.length == 0)
            {
               vecCache[param1] = {
                  at:frameNo,
                  bd:null
               };
               return;
            }
            var sh:Shape = new Shape();
            sh.graphics.drawGraphicsData(data as Vector.<IGraphicsData>);
            var r:Rectangle = sh.getBounds(sh);
            if(r.width < 1 || r.height < 1 || r.width * r.height > 1000000)
            {
               vecCache[param1] = {
                  at:frameNo,
                  bd:null
               };
               return;
            }
            var ox:int = Math.floor(r.x);
            var oy:int = Math.floor(r.y);
            var w:int = Math.ceil(r.right) - ox + 1;
            var h:int = Math.ceil(r.bottom) - oy + 1;
            var bd:BitmapData = c && c.bd && c.bd.width == w && c.bd.height == h && c.ox == ox && c.oy == oy ? c.bd : new BitmapData(w,h,true,0);
            bd.fillRect(bd.rect,0);
            bd.draw(sh,new Matrix(1,0,0,1,-ox,-oy),null,null,null,true);
            c = {
               at:frameNo,
               bd:bd,
               ox:ox,
               oy:oy
            };
            vecCache[param1] = c;
         }
         if(c.bd)
         {
            emit(param1,c.bd,c.ox,c.oy,param3,param4,true);
         }
      }

      // A filter list's id. The key is built first; the filters are only encoded (and sent) the first time.
      private static function filterSetId(param1:Array) : int
      {
         var f:BitmapFilter = null;
         var key:String = "";
         var n:int = 0;
         var g:GlowFilter = null;
         var d:DropShadowFilter = null;
         var bf:BlurFilter = null;
         for each(f in param1)
         {
            if(f is ColorMatrixFilter)
            {
               key += "c" + ColorMatrixFilter(f).matrix.join(",");
            }
            else if(f is GlowFilter)
            {
               g = GlowFilter(f);
               key += "g" + g.color + "," + g.alpha + "," + g.blurX + "," + g.blurY + "," + g.strength + "," + g.quality + "," + g.inner + "," + g.knockout;
            }
            else if(f is DropShadowFilter)
            {
               d = DropShadowFilter(f);
               key += "d" + d.distance + "," + d.angle + "," + d.color + "," + d.alpha + "," + d.blurX + "," + d.blurY + "," + d.strength + "," + d.quality + "," + d.inner + "," + d.knockout + "," + d.hideObject;
            }
            else
            {
               if(!(f is BlurFilter))
               {
                  continue;
               }
               bf = BlurFilter(f);
               key += "b" + bf.blurX + "," + bf.blurY + "," + bf.quality;
            }
            n++;
         }
         if(n == 0)
         {
            return 0;
         }
         if(filterIds[key])
         {
            return filterIds[key];
         }
         var id:int = nextFilter++;
         filterIds[key] = id;
         var out:ByteArray = new ByteArray();
         out.writeShort(id);
         out.writeByte(n);
         writeFilters(out,param1);
         sendData(D_FILTERS,out);
         return id;
      }

      private static function writeFilters(param1:ByteArray, param2:Array) : void
      {
         var f:BitmapFilter = null;
         var m:Array = null;
         var i:int = 0;
         var g:GlowFilter = null;
         var d:DropShadowFilter = null;
         var bf:BlurFilter = null;
         var b:ByteArray = param1;
         for each(f in param2)
         {
            if(f is ColorMatrixFilter)
            {
               m = ColorMatrixFilter(f).matrix;
               b.writeByte(1);
               i = 0;
               while(i < 20)
               {
                  b.writeFloat(m[i]);
                  i++;
               }
            }
            else if(f is GlowFilter)
            {
               g = GlowFilter(f);
               b.writeByte(2);
               b.writeUnsignedInt(g.color);
               b.writeFloat(g.alpha);
               b.writeFloat(g.blurX);
               b.writeFloat(g.blurY);
               b.writeFloat(g.strength);
               b.writeByte(g.quality);
               b.writeByte((g.inner ? 1 : 0) | (g.knockout ? 2 : 0));
            }
            else if(f is DropShadowFilter)
            {
               d = DropShadowFilter(f);
               b.writeByte(3);
               b.writeFloat(d.distance);
               b.writeFloat(d.angle);
               b.writeUnsignedInt(d.color);
               b.writeFloat(d.alpha);
               b.writeFloat(d.blurX);
               b.writeFloat(d.blurY);
               b.writeFloat(d.strength);
               b.writeByte(d.quality);
               b.writeByte((d.inner ? 1 : 0) | (d.knockout ? 2 : 0) | (d.hideObject ? 4 : 0));
            }
            else if(f is BlurFilter)
            {
               bf = BlurFilter(f);
               b.writeByte(4);
               b.writeFloat(bf.blurX);
               b.writeFloat(bf.blurY);
               b.writeByte(bf.quality);
            }
         }
      }

      // Every playing sound channel: id, sound, volume, pan, position. The guest starts, adjusts and stops its
      // own channels to match, which covers music, loops and fades without hooking the sound code.
      private static function writeChannels(param1:ByteArray) : void
      {
         var gsc:GameSoundChannel = null;
         var st:SoundTransform = null;
         var list:Array = [];
         for each(gsc in GameSoundChannel.allChannels)
         {
            if(gsc._playing && gsc.chan && gsc.gs && !gsc._remove)
            {
               list.push(gsc);
            }
         }
         param1.writeShort(list.length);
         for each(gsc in list)
         {
            if(!chanIds[gsc])
            {
               chanIds[gsc] = nextChan++;
            }
            st = gsc.chan.soundTransform;
            param1.writeUnsignedInt(chanIds[gsc]);
            param1.writeShort(soundId(gsc.gs));
            param1.writeShort(Math.round(Math.min(4,st.volume) * 1000));
            param1.writeByte(Math.round(Math.max(-1,Math.min(1,st.pan)) * 100));
            param1.writeByte(gsc.looping ? 1 : 0);
            param1.writeUnsignedInt(Math.max(0,gsc.chan.position));
         }
      }

      private static function soundId(param1:GameSound) : int
      {
         if(!soundIds[param1])
         {
            soundIds[param1] = nextSound++;
            var b:ByteArray = new ByteArray();
            b.writeShort(soundIds[param1]);
            b.writeUTF(getQualifiedClassName(param1.embed));
            sendData(D_SOUND,b);
         }
         return soundIds[param1];
      }

      private static function onGuestData(param1:ByteArray) : void
      {
         var kind:int = param1.readUnsignedByte();
         if(kind != D_PAD)
         {
            return;
         }
         var values:Object = {};
         var n:int = param1.readUnsignedByte();
         var i:int = 0;
         var v:Number = NaN;
         while(i < n)
         {
            v = param1.readByte() / 127;
            if(i < PAD_CONTROLS.length)
            {
               values[PAD_CONTROLS[i]] = v;
               if(i >= 4 && v > 0.5)
               {
                  latched[PAD_CONTROLS[i]] = true;
               }
            }
            i++;
         }
         remotePad = values;
         if(param1.bytesAvailable >= 2)
         {
            onAck(param1.readUnsignedShort());
         }
         if(param1.bytesAvailable >= 2)
         {
            remoteSeq = param1.readUnsignedShort();
         }
      }

      // Host, once per game frame: the guest's controller, with any button pressed since the last call still
      // down (a tap shorter than a frame would otherwise be missed).
      public static function takeRemotePad() : Object
      {
         var id:String = null;
         var out:Object = remotePad;
         for(id in latched)
         {
            if(out == remotePad)
            {
               out = {};
               var k:String = null;
               for(k in remotePad)
               {
                  out[k] = remotePad[k];
               }
            }
            out[id] = 1;
         }
         latched = {};
         if(appliedSeq != remoteSeq)
         {
            appliedSeq = remoteSeq;
            appliedTick = p2Ticks;
         }
         return out;
      }

      // ---------------- guest ----------------

      // The guest's controller (all local pads merged), plus a keyboard layout for guests without one.
      private static function sendPad() : void
      {
         var values:Object = Input.i ? Input.i.localPadValues() : null;
         if(!values)
         {
            values = {};
         }
         var kb:Object = {};
         kb[Input.PAD_LX] = (keys[68] ? 1 : 0) - (keys[65] ? 1 : 0);
         kb[Input.PAD_LY] = Input.invertStickY ? (keys[87] ? 1 : 0) - (keys[83] ? 1 : 0) : (keys[83] ? 1 : 0) - (keys[87] ? 1 : 0);
         kb[Input.PAD_RX] = (keys[39] ? 1 : 0) - (keys[37] ? 1 : 0);
         kb[Input.PAD_RY] = Input.invertStickY ? (keys[38] ? 1 : 0) - (keys[40] ? 1 : 0) : (keys[40] ? 1 : 0) - (keys[38] ? 1 : 0);
         kb[Input.PAD_RT] = keys[37] || keys[38] || keys[39] || keys[40] || keys[17] ? 1 : 0;
         kb[Input.PAD_A] = keys[13] ? 1 : 0;
         kb[Input.PAD_LB] = keys[32] ? 1 : 0;
         kb[Input.PAD_RB] = keys[16] ? 1 : 0;
         kb[Input.PAD_Y] = keys[73] ? 1 : 0;
         kb[Input.PAD_BACK] = keys[77] ? 1 : 0;
         kb[Input.PAD_START] = keys[80] ? 1 : 0;
         kb[Input.PAD_B] = keys[8] ? 1 : 0;
         if(config["testpad"] == "1" || config["testpad"] == "2")
         {
            // Walk, stop, half-pushed stick, stop, circle: starts, stops and turns like real play.
            var tt:Number = getTimer() / 1000;
            var ph:Number = tt % 5;
            var mv:Number = ph < 0.6 ? 1 : (ph < 1.1 ? 0 : (ph < 2.3 ? 0.5 : (ph < 2.8 ? 0 : (ph < 4 ? 0.3 : 0))));
            var ang:Number = ph < 1.1 ? -Math.PI / 2 : (ph < 2.8 ? Math.PI / 2 : tt * 4);
            kb[Input.PAD_LX] = Math.cos(ang) * mv;
            kb[Input.PAD_LY] = Math.sin(ang) * mv;
            kb[Input.PAD_RX] = Math.cos(tt * 0.7);
            kb[Input.PAD_RY] = Math.sin(tt * 0.7);
            // testpad=2 only moves (firing also clicks menus).
            kb[Input.PAD_RT] = config["testpad"] == "1" ? int(tt * 2) % 2 : 0;
         }
         var b:ByteArray = padBytes;
         b.length = 0;
         b.writeByte(PAD_CONTROLS.length);
         var id:String = null;
         var v:Number = NaN;
         var q:int = 0;
         var i:int = 0;
         var changed:Boolean = false;
         for each(id in PAD_CONTROLS)
         {
            v = Number(values[id]) || 0;
            if(kb[id] && Math.abs(kb[id]) > Math.abs(v))
            {
               v = kb[id];
            }
            q = Math.round(Math.max(-1,Math.min(1,v)) * 127);
            if(lastPad[i] !== q)
            {
               lastPad[i] = q;
               changed = true;
            }
            b.writeByte(q);
            i++;
         }
         // Then the newest frame received, which acknowledges it (the host paces itself by these), and this
         // input's number.
         b.writeShort(lastFrameSeq & 65535);
         // Sent the moment it changes or a frame arrives, plus a refresh every 100 ms.
         if(changed || lastFrameSeq != ackedSeq || getTimer() - lastPadSent > 100)
         {
            ackedSeq = lastFrameSeq;
            lastPadSent = getTimer();
            inputSeq = inputSeq + 1 & 65535;
            b.writeShort(inputSeq);
            sendData(D_PAD,b);
            recordInput(b);
         }
         // Holding BACK for 3 seconds leaves (ESC also works).
         if(Number(values[Input.PAD_BACK]) > 0.5)
         {
            if(backHeldSince < 0)
            {
               backHeldSince = getTimer();
            }
            else if(getTimer() - backHeldSince > 3000)
            {
               backHeldSince = -1;
               disconnect();
               status = "LEFT THE GAME";
            }
         }
         else
         {
            backHeldSince = -1;
         }
      }

      // The move and aim values the host will get from this input (same dead zones as Input.updatePad).
      private static function recordInput(param1:ByteArray) : void
      {
         var i:int = 0;
         if(!predPad)
         {
            predPad = Input.newPad();
         }
         while(i < PAD_CONTROLS.length)
         {
            padValues[PAD_CONTROLS[i]] = (param1[1 + i] << 24 >> 24) / 127;
            i++;
         }
         Input.updatePad(predPad,padValues);
         var now:int = getTimer();
         inputs.push({
            seq:inputSeq,
            t:now,
            mx:predPad.moveX,
            my:predPad.moveY
         });
         while(inputs.length > 2 && now - inputs[1].t > 1500)
         {
            inputs.shift();
         }
      }

      private static function startMirror() : void
      {
         stopMirror();
         images = {};
         filterSets = {};
         sounds = {};
         channels = {};
         pool = [];
         poolFilter = [];
         gstate = {};
         snaps = [];
         sharedIds = {};
         pendingJpeg = {};
         arrivals = [];
         jitter = 0;
         bufferMs = 60;
         playOffset = NaN;
         lastRenderAt = 0;
         frameGap = 33;
         lastFrameT = -1;
         underruns = 0;
         prevSnap = null;
         entryPool = [];
         chunkBuf = null;
         lastFrameSeq = ackedSeq = -1;
         lastPad = [];
         poolState = [];
         inputs = [];
         predPad = null;
         p2OffX = p2OffY = p2ErrX = p2ErrY = p2CurX = p2CurY = 0;
         p2PredSn = -1;
         p2PredFrom = null;
         lastP2 = null;
         predLog = [];
         predErr = lagErr = predCorr = 0;
         view = new Sprite();
         view.mouseEnabled = false;
         view.mouseChildren = false;
         var bg:Shape = new Shape();
         bg.graphics.beginFill(0);
         bg.graphics.drawRect(0,0,800,600);
         view.addChild(bg);
         layer = new Sprite();
         view.addChild(layer);
         hint = new TextField();
         hint.defaultTextFormat = new TextFormat("_sans",13,16777215,true);
         hint.background = true;
         hint.backgroundColor = 0;
         hint.selectable = false;
         hint.width = 800;
         hint.height = 20;
         hint.y = 580;
         hint.text = "  ONLINE: you are player 2.   ESC or hold BACK for 3 s to leave.";
         view.addChild(hint);
         hintUntil = getTimer() + 8000;
         stage.addChild(view);
         stage.focus = null;
         // Silence this copy of the game; only the host's sounds play.
         SoundMixer.stopAll();
         savedMute = [GameSound.globalSoundMute,GameSound.globalMusicMute];
         GameSound.globalSoundMute = true;
         GameSound.globalMusicMute = true;
      }

      private static function stopMirror() : void
      {
         var id:String = null;
         var bd:BitmapData = null;
         if(!view)
         {
            return;
         }
         for(id in channels)
         {
            try
            {
               channels[id].sc.stop();
            }
            catch(e:Error)
            {
            }
         }
         channels = {};
         if(view.parent)
         {
            view.parent.removeChild(view);
         }
         view = null;
         layer = null;
         for(id in images)
         {
            if(!sharedIds[id])
            {
               BitmapData(images[id]).dispose();
            }
         }
         images = {};
         sharedIds = {};
         snaps = [];
         gstate = {};
         pool = [];
         poolFilter = [];
         poolState = [];
         prevSnap = null;
         entryPool = [];
         chunkBuf = null;
         if(savedMute)
         {
            GameSound.globalSoundMute = savedMute[0];
            GameSound.globalMusicMute = savedMute[1];
            savedMute = null;
         }
      }

      private static function updateGuestView() : void
      {
         if(!view)
         {
            return;
         }
         if(stage.getChildIndex(view) != stage.numChildren - 1)
         {
            stage.setChildIndex(view,stage.numChildren - 1);
         }
         hint.visible = getTimer() < hintUntil;
         renderGuest();
      }

      // Frames are shown a little behind the host, at a steady pace, with movement blended between frames, so
      // uneven network arrival doesn't show as stutter. The delay follows the measured jitter; when it changes,
      // playback runs slightly slower or faster until it matches instead of jumping. If the next frame is late,
      // moving pictures carry on along their last motion for up to 100 ms.
      private static function renderGuest() : void
      {
         if(snaps.length == 0)
         {
            return;
         }
         var now:int = getTimer();
         var dt:Number = lastRenderAt > 0 ? Math.min(100,now - lastRenderAt) : 16;
         lastRenderAt = now;
         bufferMs = Math.max(35,Math.min(300,jitter + frameGap * 1.2 + 5));
         var want:Number = clockBase + bufferMs;
         if(isNaN(playOffset) || want - playOffset > 150 || playOffset - want > 250)
         {
            playOffset = want;
         }
         else if(want > playOffset)
         {
            playOffset += Math.min(want - playOffset,dt * 0.15);
         }
         else
         {
            playOffset -= Math.min(playOffset - want,dt * 0.06);
         }
         var rt:Number = now - playOffset;
         // Way behind (e.g. after a hitch): skip ahead rather than playing old frames.
         while(snaps.length > 2 && rt - snaps[0].t > 600)
         {
            retire(snaps.shift());
         }
         while(snaps.length >= 2 && snaps[1].t <= rt)
         {
            retire(snaps.shift());
         }
         var s0:Object = snaps[0];
         var s1:Object = snaps.length > 1 ? snaps[1] : null;
         var f:Number = 0;
         var ex:Number = 0;
         if(s1)
         {
            f = rt > s0.t && s1.t > s0.t ? Math.min(1,(rt - s0.t) / (s1.t - s0.t)) : 0;
            s0.late = false;
         }
         else if(rt > s0.t && prevSnap && s0.t > prevSnap.t)
         {
            ex = Math.min(rt - s0.t,100) / (s0.t - prevSnap.t);
            if(!s0.late)
            {
               s0.late = true;
               ++underruns;
            }
         }
         if(!s0.done)
         {
            s0.done = true;
            applyChannels(s0.chans);
         }
         updatePrediction(s0,s1,f,now);
         drawSnapshot(s0,s1,f,prevSnap,ex);
      }

      private static function retire(param1:Object) : void
      {
         if(prevSnap)
         {
            releaseSnap(prevSnap);
         }
         prevSnap = param1;
      }

      private static function drawSnapshot(param1:Object, param2:Object, param3:Number, param4:Object, param5:Number) : void
      {
         var list:Array = param1.list;
         var n:int = int(list.length);
         var k:int = 0;
         var e:Object = null;
         var e1:Object = null;
         var bmp:Bitmap = null;
         var bd:BitmapData = null;
         var m:Matrix = tmpMatrix;
         var ct:ColorTransform = null;
         var ps:Object = null;
         var smooth:Boolean = false;
         var p2set:Object = param1.p2 && (p2OffX != 0 || p2OffY != 0 || p2CurX != 0 || p2CurY != 0) ? param1.p2.set : null;
         var p2cur:int = param1.p2 ? int(param1.p2.cursor) : -1;
         while(k < n)
         {
            e = list[k];
            bmp = pool[k];
            if(!bmp)
            {
               bmp = new Bitmap();
               pool[k] = bmp;
               poolFilter[k] = 0;
               poolState[k] = {
                  a:NaN,
                  al:NaN,
                  col:null,
                  fl:-1,
                  smooth:false
               };
               layer.addChild(bmp);
            }
            ps = poolState[k];
            bd = images[e.img];
            if(!bd)
            {
               bmp.visible = false;
               k++;
               continue;
            }
            if(bmp.bitmapData != bd)
            {
               bmp.bitmapData = bd;
               // Assigning bitmapData resets smoothing.
               ps.smooth = false;
            }
            m.a = e.a;
            m.b = e.b;
            m.c = e.c;
            m.d = e.d;
            m.tx = e.tx;
            m.ty = e.ty;
            // Blend toward the next frame, unless the object jumped (teleport, new room) or changed picture.
            if(param3 > 0)
            {
               e1 = e.next;
               if(e1 && e1.sn == param2.sn && e1.oid == e.oid && e1.img == e.img && Math.abs(e1.tx - e.tx) + Math.abs(e1.ty - e.ty) < 80 && Math.abs(e1.a - e.a) + Math.abs(e1.b - e.b) + Math.abs(e1.c - e.c) + Math.abs(e1.d - e.d) < 0.8)
               {
                  m.a += (e1.a - e.a) * param3;
                  m.b += (e1.b - e.b) * param3;
                  m.c += (e1.c - e.c) * param3;
                  m.d += (e1.d - e.d) * param3;
                  m.tx += (e1.tx - e.tx) * param3;
                  m.ty += (e1.ty - e.ty) * param3;
               }
            }
            else if(param5 > 0)
            {
               // The next frame is late: keep moving along the last step (position only).
               e1 = e.prev;
               if(e1 && e1.sn == param4.sn && e1.oid == e.oid && !(p2set && (p2set[e.oid] || e.oid == p2cur)) && e1.img == e.img && Math.abs(e1.tx - e.tx) + Math.abs(e1.ty - e.ty) < 40)
               {
                  m.tx += (e.tx - e1.tx) * param5;
                  m.ty += (e.ty - e1.ty) * param5;
               }
            }
            if(p2set)
            {
               if(p2set[e.oid])
               {
                  m.tx += p2OffX;
                  m.ty += p2OffY;
               }
               else if(e.oid == p2cur)
               {
                  m.tx += p2CurX;
                  m.ty += p2CurY;
               }
            }
            smooth = (e.fl & 128) != 0;
            if(ps.smooth != smooth)
            {
               ps.smooth = smooth;
               bmp.smoothing = smooth;
            }
            if(ps.a != m.a || ps.b != m.b || ps.c != m.c || ps.d != m.d || ps.tx != m.tx || ps.ty != m.ty)
            {
               ps.a = m.a;
               ps.b = m.b;
               ps.c = m.c;
               ps.d = m.d;
               ps.tx = m.tx;
               ps.ty = m.ty;
               bmp.transform.matrix = m;
            }
            if(ps.al != e.al || ps.col != e.col)
            {
               ps.al = e.al;
               ps.col = e.col;
               ct = new ColorTransform(1,1,1,e.al);
               if(e.col)
               {
                  ct.redMultiplier = e.col[0] / 256;
                  ct.greenMultiplier = e.col[1] / 256;
                  ct.blueMultiplier = e.col[2] / 256;
                  ct.redOffset = e.col[3];
                  ct.greenOffset = e.col[4];
                  ct.blueOffset = e.col[5];
               }
               bmp.transform.colorTransform = ct;
            }
            if(ps.fl != (e.fl & 127))
            {
               ps.fl = e.fl & 127;
               bmp.blendMode = BLENDS[e.fl & 127] || BlendMode.NORMAL;
            }
            if(poolFilter[k] != e.fid)
            {
               poolFilter[k] = e.fid;
               bmp.filters = e.fid > 0 && filterSets[e.fid] ? filterSets[e.fid] : [];
            }
            bmp.visible = true;
            k++;
         }
         while(k < pool.length)
         {
            Bitmap(pool[k]).visible = false;
            k++;
         }
      }

      private static function updateStats() : void
      {
         if(!statsOn)
         {
            if(statsText && statsText.parent)
            {
               statsText.parent.removeChild(statsText);
            }
            bytesOut = bytesIn = framesIn = framesSkipped = 0;
            statsAt = getTimer();
            return;
         }
         if(!statsText)
         {
            statsText = new TextField();
            statsText.defaultTextFormat = new TextFormat("_typewriter",12,16776960,true);
            statsText.background = true;
            statsText.backgroundColor = 0;
            statsText.selectable = false;
            statsText.mouseEnabled = false;
            statsText.width = 800;
            // Long lines wrap onto a second line; the box grows to fit.
            statsText.wordWrap = true;
            statsText.autoSize = "left";
         }
         if(!statsText.parent || stage.getChildIndex(statsText) != stage.numChildren - 1)
         {
            stage.addChild(statsText);
         }
         var now:int = getTimer();
         if(now - statsAt < 500)
         {
            return;
         }
         var secs:Number = (now - statsAt) / 1000;
         statsAt = now;
         var line:String = "ONLINE OFF";
         if(mode == 1)
         {
            line = "HOST  rtt " + Math.round(rtt) + " (min " + Math.round(rttMin) + ") ms  server " + pingText() + "  up " + Math.round(bytesOut / 1024 / secs) + " KB/s  capture " + captureMs.toFixed(1) + " ms  skipped " + framesSkipped + "  pics " + bulk.length + "/" + Math.round(bulkWindow / 1024) + "K  obj " + frameCount + (peer ? "" : "  waiting");
         }
         else if(mode == 2)
         {
            line = "GUEST  rtt " + Math.round(hostRtt) + " ms  server " + pingText() + "  down " + Math.round(bytesIn / 1024 / secs) + " KB/s  frames " + Math.round(framesIn / secs) + "/s  jitter " + Math.round(jitter) + "  delay " + Math.round(isNaN(playOffset) ? 0 : playOffset - clockBase) + " ms  late " + underruns + "  queued " + snaps.length + "   player 2 off " + Math.round(lagErr) + ">" + Math.round(predErr) + " fix " + predCorr.toFixed(1) + " px";
         }
         bytesOut = bytesIn = framesIn = framesSkipped = 0;
         statsText.text = " " + line + "   (F8)";
         statsText.y = 578 - statsText.height;
      }

      private static function pingText() : String
      {
         return serverPing < 0 ? "?" : Math.round(serverPing) + " ms";
      }

      private static function onHostData(param1:ByteArray) : void
      {
         var kind:int = param1.readUnsignedByte();
         if(kind == D_IMAGE)
         {
            readImage(param1);
         }
         else if(kind == D_FRAME)
         {
            readFrame(param1);
         }
         else if(kind == D_CHUNK)
         {
            // Pieces of one big message, in order; the last one completes it.
            var last:Boolean = param1.readUnsignedByte() == 1;
            if(!chunkBuf)
            {
               chunkBuf = new ByteArray();
            }
            param1.readBytes(chunkBuf,chunkBuf.length,param1.bytesAvailable);
            if(last)
            {
               var whole:ByteArray = chunkBuf;
               chunkBuf = null;
               whole.position = 0;
               onHostData(whole);
            }
         }
         else if(kind == D_IMAGEREF)
         {
            readImageRef(param1);
         }
         else if(kind == D_RECIPE)
         {
            var rb:ByteArray = new ByteArray();
            param1.readBytes(rb,0,param1.bytesAvailable);
            rb.uncompress();
            rb.position = 0;
            var rid:int = readVar(rb);
            var rbd:BitmapData = new BitmapData(Math.max(1,rb.readUnsignedShort()),Math.max(1,rb.readUnsignedShort()),rb.readUnsignedByte() == 1,rb.readUnsignedInt());
            replayOps(rbd,rb);
            if(images[rid] && !sharedIds[rid])
            {
               BitmapData(images[rid]).dispose();
            }
            images[rid] = rbd;
            delete sharedIds[rid];
         }
         else if(kind == D_FLOOROP)
         {
            var oid:int = readVar(param1);
            if(pendingJpeg[oid])
            {
               pendingJpeg[oid].push(param1);
            }
            else if(images[oid])
            {
               if(sharedIds[oid])
               {
                  images[oid] = BitmapData(images[oid]).clone();
                  delete sharedIds[oid];
               }
               replayOps(images[oid],param1);
            }
         }
         else if(kind == D_FILL)
         {
            var fid2:int = readVar(param1);
            var fw:int = param1.readUnsignedShort();
            var fh:int = param1.readUnsignedShort();
            var ftr:Boolean = param1.readUnsignedByte() == 1;
            if(images[fid2] && !sharedIds[fid2])
            {
               BitmapData(images[fid2]).dispose();
            }
            images[fid2] = new BitmapData(Math.max(1,fw),Math.max(1,fh),ftr,param1.readUnsignedInt());
            delete sharedIds[fid2];
         }
         else if(kind == D_TEXT)
         {
            readText(param1);
         }
         else if(kind == D_JPEG)
         {
            readJpeg(param1);
         }
         else if(kind == D_FILTERS)
         {
            readFilters(param1);
         }
         else if(kind == D_SOUND)
         {
            var sid:int = param1.readUnsignedShort();
            var name:String = param1.readUTF();
            try
            {
               sounds[sid] = new (getDefinitionByName(name) as Class)() as Sound;
            }
            catch(e:Error)
            {
            }
         }
         else if(kind == D_FREE)
         {
            while(param1.bytesAvailable >= 4)
            {
               var fid:int = param1.readUnsignedInt();
               if(images[fid])
               {
                  if(!sharedIds[fid])
                  {
                     BitmapData(images[fid]).dispose();
                  }
                  delete images[fid];
                  delete sharedIds[fid];
               }
            }
         }
      }

      // JPEG decoding is asynchronous; later updates to the same picture wait for it (pendingJpeg).
      private static function readJpeg(param1:ByteArray) : void
      {
         var id:int = readVar(param1);
         if(pendingJpeg[id])
         {
            pendingJpeg[id].push(param1);
            return;
         }
         var isNew:Boolean = param1.readUnsignedByte() == 1;
         var w:int = param1.readUnsignedShort();
         var h:int = param1.readUnsignedShort();
         var x:int = param1.readUnsignedShort();
         var y:int = param1.readUnsignedShort();
         var jpeg:ByteArray = new ByteArray();
         param1.readBytes(jpeg,0,param1.bytesAvailable);
         if(!pendingJpeg[id])
         {
            pendingJpeg[id] = [];
         }
         var loader:Loader = new Loader();
         var started:Sprite = view;
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            if(view != started)
            {
               return;
            }
            var bd:BitmapData = images[id];
            if(isNew || !bd || bd.width != w || bd.height != h)
            {
               if(bd && !sharedIds[id])
               {
                  bd.dispose();
               }
               bd = new BitmapData(w,h,true,0);
               images[id] = bd;
               delete sharedIds[id];
            }
            else if(sharedIds[id])
            {
               bd = bd.clone();
               images[id] = bd;
               delete sharedIds[id];
            }
            var pic:BitmapData = Bitmap(loader.content).bitmapData;
            bd.copyPixels(pic,pic.rect,new Point(x,y));
            pic.dispose();
            var waiting:Array = pendingJpeg[id];
            delete pendingJpeg[id];
            var msg:ByteArray = null;
            for each(msg in waiting)
            {
               msg.position = 0;
               onHostData(msg);
            }
         });
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
            delete pendingJpeg[id];
         });
         loader.loadBytes(jpeg);
      }

      private static function readImage(param1:ByteArray) : void
      {
         param1.position = 1;
         var id:int = param1.readUnsignedInt();
         if(pendingJpeg[id])
         {
            pendingJpeg[id].push(param1);
            return;
         }
         var isNew:Boolean = param1.readUnsignedByte() == 1;
         var w:int = param1.readUnsignedShort();
         var h:int = param1.readUnsignedShort();
         var r:Rectangle = new Rectangle(param1.readUnsignedShort(),param1.readUnsignedShort(),param1.readUnsignedShort(),param1.readUnsignedShort());
         var px:ByteArray = new ByteArray();
         if(param1.bytesAvailable > 0)
         {
            param1.readBytes(px,0,param1.bytesAvailable);
         }
         px.uncompress();
         var bd:BitmapData = images[id];
         if(isNew || !bd || bd.width != w || bd.height != h)
         {
            if(bd && !sharedIds[id])
            {
               bd.dispose();
            }
            bd = new BitmapData(w,h,true,0);
            images[id] = bd;
            delete sharedIds[id];
         }
         else if(sharedIds[id])
         {
            // A shared game picture is about to be drawn into: give this id its own copy first.
            bd = bd.clone();
            images[id] = bd;
            delete sharedIds[id];
         }
         px.position = 0;
         bd.setPixels(r,px);
      }

      // Text from the host, drawn here with this copy's (identical) fonts.
      private static function readText(param1:ByteArray) : void
      {
         var id:int = readVar(param1);
         var w:int = param1.readUnsignedShort();
         var h:int = param1.readUnsignedShort();
         var ox:int = param1.readShort();
         var oy:int = param1.readShort();
         var tf:TextField = new TextField();
         tf.width = param1.readFloat();
         tf.height = param1.readFloat();
         var fl:int = param1.readUnsignedByte();
         tf.embedFonts = (fl & 1) != 0;
         // Always multiline: the game puts line breaks in single-line fields, which htmlText would drop.
         tf.multiline = true;
         tf.wordWrap = (fl & 4) != 0;
         tf.background = (fl & 8) != 0;
         tf.border = (fl & 16) != 0;
         tf.backgroundColor = param1.readUnsignedInt();
         tf.borderColor = param1.readUnsignedInt();
         var autoSize:String = param1.readUTF();
         tf.antiAliasType = param1.readUTF();
         tf.gridFitType = param1.readUTF();
         tf.sharpness = param1.readFloat();
         tf.thickness = param1.readFloat();
         var scroll:int = param1.readShort();
         tf.htmlText = param1.readUTF();
         tf.autoSize = autoSize;
         tf.scrollV = scroll;
         var bd:BitmapData = new BitmapData(Math.max(1,w),Math.max(1,h),true,0);
         try
         {
            bd.draw(tf,new Matrix(1,0,0,1,-ox,-oy),null,null,null,true);
         }
         catch(e:Error)
         {
         }
         if(images[id] && !sharedIds[id])
         {
            BitmapData(images[id]).dispose();
         }
         images[id] = bd;
         delete sharedIds[id];
      }

      // A picture this copy of the game already has: Embeds' shared BitmapData by name, or an embedded class.
      private static function readImageRef(param1:ByteArray) : void
      {
         var id:int = readVar(param1);
         var kind:int = param1.readUnsignedByte();
         var name:String = param1.readUTF();
         var bd:BitmapData = null;
         try
         {
            if(kind == 1)
            {
               bd = (getDefinitionByName("GlobalSetup.Embeds") as Class)[name] as BitmapData;
            }
            else if(kind == 3)
            {
               bd = resolveStatic(name);
            }
            else
            {
               bd = guestClassCache[name];
               if(!bd)
               {
                  bd = Bitmap(new (getDefinitionByName(name) as Class)()).bitmapData;
                  guestClassCache[name] = bd;
               }
            }
         }
         catch(e:Error)
         {
         }
         if(bd)
         {
            images[id] = bd;
            sharedIds[id] = true;
         }
      }

      private static function readFilters(param1:ByteArray) : void
      {
         var id:int = param1.readUnsignedShort();
         var n:int = param1.readUnsignedByte();
         var list:Array = [];
         var t:int = 0;
         var m:Array = null;
         var i:int = 0;
         var fl:int = 0;
         while(n-- > 0)
         {
            t = param1.readUnsignedByte();
            if(t == 1)
            {
               m = [];
               i = 0;
               while(i < 20)
               {
                  m.push(param1.readFloat());
                  i++;
               }
               list.push(new ColorMatrixFilter(m));
            }
            else if(t == 2)
            {
               var gc:uint = param1.readUnsignedInt();
               var ga:Number = param1.readFloat();
               var gx:Number = param1.readFloat();
               var gy:Number = param1.readFloat();
               var gs:Number = param1.readFloat();
               var gq:int = param1.readUnsignedByte();
               fl = param1.readUnsignedByte();
               list.push(new GlowFilter(gc,ga,gx,gy,gs,gq,(fl & 1) != 0,(fl & 2) != 0));
            }
            else if(t == 3)
            {
               var dd:Number = param1.readFloat();
               var dan:Number = param1.readFloat();
               var dc:uint = param1.readUnsignedInt();
               var da:Number = param1.readFloat();
               var dx:Number = param1.readFloat();
               var dy:Number = param1.readFloat();
               var ds:Number = param1.readFloat();
               var dq:int = param1.readUnsignedByte();
               fl = param1.readUnsignedByte();
               list.push(new DropShadowFilter(dd,dan,dc,da,dx,dy,ds,dq,(fl & 1) != 0,(fl & 2) != 0,(fl & 4) != 0));
            }
            else if(t == 4)
            {
               var bx:Number = param1.readFloat();
               var by:Number = param1.readFloat();
               list.push(new BlurFilter(bx,by,param1.readUnsignedByte()));
            }
         }
         filterSets[id] = list;
      }

      private static function readFrame(param1:ByteArray) : void
      {
         var bytes:ByteArray = new ByteArray();
         param1.readBytes(bytes,0,param1.bytesAvailable);
         bytes.uncompress();
         bytes.position = 0;
         var t:Number = bytes.readUnsignedInt();
         lastFrameSeq = bytes.readUnsignedShort();
         hostRtt = bytes.readUnsignedShort();
         var count:int = readVar(bytes);
         var list:Array = new Array(count);
         var sn:int = ++snapSerial;
         var k:int = 0;
         var oid:int = 0;
         var mask:int = 0;
         var st:Object = null;
         var e:Object = null;
         var now:int = getTimer();
         ++framesIn;
         while(k < count)
         {
            oid = readVar(bytes);
            mask = bytes.readUnsignedByte();
            st = gstate[oid];
            if(!st)
            {
               st = {
                  img:0,
                  tx:0,
                  ty:0,
                  a:1,
                  b:0,
                  c:0,
                  d:1,
                  al:1,
                  col:null,
                  fid:0,
                  fl:0,
                  last:null
               };
               gstate[oid] = st;
            }
            if(mask & 1)
            {
               st.img = readVar(bytes);
            }
            if(mask & 2)
            {
               st.tx = bytes.readShort() / 4;
               st.ty = bytes.readShort() / 4;
            }
            if(mask & 4)
            {
               st.a = bytes.readFloat();
               st.b = bytes.readFloat();
               st.c = bytes.readFloat();
               st.d = bytes.readFloat();
            }
            if(mask & 8)
            {
               st.al = bytes.readUnsignedByte() / 255;
            }
            if(mask & 16)
            {
               st.col = bytes.readUnsignedByte() == 1 ? [bytes.readShort(),bytes.readShort(),bytes.readShort(),bytes.readShort(),bytes.readShort(),bytes.readShort()] : null;
            }
            if(mask & 32)
            {
               st.fid = readVar(bytes);
            }
            if(mask & 64)
            {
               st.fl = bytes.readUnsignedByte();
            }
            st.seen = now;
            e = entryPool.length > 0 ? entryPool.pop() : {};
            e.sn = sn;
            e.img = st.img;
            e.tx = st.tx;
            e.ty = st.ty;
            e.a = st.a;
            e.b = st.b;
            e.c = st.c;
            e.d = st.d;
            e.al = st.al;
            e.col = st.col;
            e.fid = st.fid;
            e.fl = st.fl;
            e.oid = oid;
            e.next = null;
            e.prev = null;
            // Link to this object's entry in the previous frame, both ways. Entries are recycled, so a link
            // counts only while the entry still has this object and the expected frame serial.
            if(st.last && st.last.sn == sn - 1 && st.last.oid == oid)
            {
               st.last.next = e;
               e.prev = st.last;
            }
            st.last = e;
            list[k] = e;
            k++;
         }
         var chans:Array = readChannels(bytes);
         var p2:Object = bytes.bytesAvailable > 0 ? readPlayer2(bytes,now,t) : null;
         snaps.push({
            t:t,
            sn:sn,
            arr:now,
            list:list,
            chans:chans,
            p2:p2,
            done:false
         });
         trackArrival(t);
         // Object states the host has long forgotten (it resends them in full) can go.
         if(frameNo % 300 == 0)
         {
            var key:String = null;
            for(key in gstate)
            {
               if(now - gstate[key].seen > 30000)
               {
                  delete gstate[key];
               }
            }
         }
      }

      private static function readPlayer2(param1:ByteArray, param2:int, param3:Number) : Object
      {
         if(param1.readUnsignedByte() != 1)
         {
            lastP2 = null;
            return null;
         }
         var p:Object = {
            t:param3,
            x:param1.readShort() / 4,
            y:param1.readShort() / 4,
            dx:param1.readFloat(),
            dy:param1.readFloat(),
            seq:param1.readUnsignedShort(),
            age:param1.readUnsignedShort(),
            flags:param1.readUnsignedByte(),
            sx:param1.readShort(),
            ex:param1.readShort(),
            sy:param1.readShort(),
            ey:param1.readShort(),
            hw:param1.readUnsignedByte(),
            hh:param1.readUnsignedByte(),
            ax:param1.readShort() / 4,
            ay:param1.readShort() / 4,
            set:{},
            cursor:0,
            blockX:0,
            blockY:0
         };
         var n:int = readVar(param1);
         while(n-- > 0)
         {
            p.set[readVar(param1)] = true;
         }
         p.cursor = readVar(param1);
         // Pushing against something (a crate, a closed door): the stick says go, but the host's player 2 has
         // almost no speed (colliding zeroes it) and has barely moved since the last frame. Free movement gets
         // well above that within a few game ticks, even from standing or with the stick half pushed. Don't
         // predict movement that way.
         var inp:Object = inputAt(p.seq);
         if(lastP2 && inp && param3 > lastP2.t)
         {
            var ticks:Number = (param3 - lastP2.t) / 10;
            if(Math.abs(inp.mx) > 0.3 && Math.abs(p.dx) < 0.35 * Math.abs(inp.mx) && Math.abs(p.x - lastP2.x) / ticks < 0.7 * Math.abs(inp.mx))
            {
               p.blockX = inp.mx > 0 ? 1 : -1;
            }
            if(Math.abs(inp.my) > 0.3 && Math.abs(p.dy) < 0.35 * Math.abs(inp.my) && Math.abs(p.y - lastP2.y) / ticks < 0.7 * Math.abs(inp.my))
            {
               p.blockY = inp.my > 0 ? 1 : -1;
            }
         }
         lastP2 = p;
         // Stats: what the guest drew for "now" at the time this state corresponds to, vs. this state.
         var tau:Number = inputTime(p,param2);
         var e:Object = null;
         for each(e in predLog)
         {
            if(e.t >= tau)
            {
               predErr += (Math.sqrt((e.px - p.x) * (e.px - p.x) + (e.py - p.y) * (e.py - p.y)) - predErr) * 0.05;
               lagErr += (Math.sqrt((e.hx - p.x) * (e.hx - p.x) + (e.hy - p.y) * (e.hy - p.y)) - lagErr) * 0.05;
               break;
            }
         }
         return p;
      }

      // The input with this number (or the newest before it).
      private static function inputAt(param1:int) : Object
      {
         var i:int = inputs.length - 1;
         while(i >= 0)
         {
            if((param1 - inputs[i].seq & 65535) < 32768)
            {
               return inputs[i];
            }
            i--;
         }
         return null;
      }

      // The guest time this state corresponds to: the host had been applying input `seq` for `age` ms, so it's
      // that long after the input was sent (but not past the next input, which the host didn't have yet). Measured
      // this way, network jitter doesn't move the prediction. Without a matching input: a round trip before the
      // frame arrived.
      private static function inputTime(param1:Object, param2:int) : Number
      {
         var i:int = inputs.length - 1;
         var tau:Number = NaN;
         while(i >= 0)
         {
            if((param1.seq - inputs[i].seq & 65535) < 32768)
            {
               tau = inputs[i].t + param1.age;
               if(i + 1 < inputs.length)
               {
                  tau = Math.min(tau,inputs[i + 1].t);
               }
               return Math.min(tau,param2);
            }
            i--;
         }
         return param2 - hostRtt;
      }

      // Where player 2 will be once the host has applied every input sent so far: the newest host state, moved
      // on by the inputs since, 10 ms at a time like the game.
      private static function predictPlayer2(param1:Object, param2:int, param3:int) : Point
      {
         var tau:Number = inputTime(param1,param2);
         var end:Number = param3;
         if(end - tau > 400)
         {
            tau = end - 400;
         }
         var x:Number = param1.x;
         var y:Number = param1.y;
         var dx:Number = param1.dx;
         var dy:Number = param1.dy;
         var i:int = 0;
         var inp:Object = null;
         var mx:Number = 0;
         var my:Number = 0;
         var step:Number = 0;
         while(tau < end)
         {
            while(i < inputs.length && inputs[i].t <= tau)
            {
               inp = inputs[i];
               i++;
            }
            mx = inp ? Number(inp.mx) : 0;
            my = inp ? Number(inp.my) : 0;
            dx = (dx + mx * 0.2) * 0.85;
            dy = (dy + my * 0.2) * 0.85;
            // The last step is partial, so the drawn position moves smoothly between game ticks.
            step = Math.min(1,(end - tau) / 10);
            if(!(param1.blockX != 0 && (dx > 0 ? 1 : -1) == param1.blockX))
            {
               x += dx * 2 * step;
            }
            if(!(param1.blockY != 0 && (dy > 0 ? 1 : -1) == param1.blockY))
            {
               y += dy * 2 * step;
            }
            tau += 10;
         }
         // Room edges, as in PlayerBase._update (doorways are open when the host says player 2 can move rooms).
         if(Math.abs(y - 300) > 18 || (param1.flags & 1) == 0)
         {
            x = Math.max(param1.sx + param1.hw + 5,Math.min(param1.ex - param1.hw - 5,x));
         }
         else if(x - param1.hw < param1.sx || x + param1.hw > param1.ex)
         {
            y = Math.max(300 - 18,Math.min(300 + 18,y));
         }
         if(Math.abs(x - 400) > 18 || (param1.flags & 2) == 0)
         {
            y = Math.max(param1.sy + param1.hh + 5,Math.min(param1.ey - param1.hh - 5,y));
         }
         else if(y - param1.hh < param1.sy || y + param1.hh > param1.ey)
         {
            x = Math.max(400 - 18,Math.min(400 + 18,x));
         }
         return new Point(x,y);
      }

      // Guest, each frame: how far to move player 2's pictures (and where to put the reticle) from where the shown
      // host frame has them.
      private static function updatePrediction(param1:Object, param2:Object, param3:Number, param4:int) : void
      {
         var latest:Object = snaps[snaps.length - 1];
         var S:Object = latest.p2;
         var d0:Object = param1.p2;
         if(!d0 || !S || config["predict"] == "0")
         {
            // Nothing to predict (falling, teleporting, down): ease back to the host's picture.
            p2OffX *= 0.8;
            p2OffY *= 0.8;
            p2ErrX = p2ErrY = 0;
            p2CurX = p2CurY = 0;
            p2PredSn = -1;
            p2PredFrom = null;
            return;
         }
         var d1:Object = param2 && param2.p2 ? param2.p2 : d0;
         var hx:Number = d0.x + (d1.x - d0.x) * param3;
         var hy:Number = d0.y + (d1.y - d0.y) * param3;
         var pred:Point = predictPlayer2(S,latest.arr,param4);
         var rawX:Number = pred.x - hx;
         var rawY:Number = pred.y - hy;
         if(latest.sn != p2PredSn)
         {
            // A new host state moved the prediction: keep the drawn position where it was (the old prediction
            // for the same moment) and fade the difference out, unless it's far off (a teleport, or a hit pushed
            // player 2).
            if(p2PredSn >= 0 && p2PredFrom)
            {
               var old:Point = predictPlayer2(p2PredFrom.p2,p2PredFrom.arr,param4);
               p2ErrX += old.x - pred.x;
               p2ErrY += old.y - pred.y;
               predCorr += (Math.sqrt((old.x - pred.x) * (old.x - pred.x) + (old.y - pred.y) * (old.y - pred.y)) - predCorr) * 0.05;
               if(p2ErrX * p2ErrX + p2ErrY * p2ErrY > 48 * 48)
               {
                  p2ErrX = p2ErrY = 0;
               }
            }
            p2PredSn = latest.sn;
            p2PredFrom = latest;
         }
         // Corrections fade out over about 100 ms, so they show as a short slide rather than a snap.
         var fade:Number = Math.exp(-Math.min(100,param4 - p2LastAt) / 100);
         p2LastAt = param4;
         p2ErrX *= fade;
         p2ErrY *= fade;
         p2OffX = rawX + p2ErrX;
         p2OffY = rawY + p2ErrY;
         // The reticle: at the predicted position plus this player's own aim.
         var aimX:Number = predPad ? Number(predPad.aimX) : 0;
         var aimY:Number = predPad ? Number(predPad.aimY) : -1;
         var hax:Number = d0.ax + (d1.ax - d0.ax) * param3;
         var hay:Number = d0.ay + (d1.ay - d0.ay) * param3;
         p2CurX = hx + p2OffX + aimX * Input.aimRadius - hax;
         p2CurY = hy + p2OffY + aimY * Input.aimRadius - hay;
         predLog.push({
            t:param4,
            px:hx + p2OffX,
            py:hy + p2OffY,
            hx:hx,
            hy:hy
         });
         while(predLog.length > 0 && param4 - predLog[0].t > 1000)
         {
            predLog.shift();
         }
      }

      // A snapshot that's no longer needed: its entries go back to the pool.
      private static function releaseSnap(param1:Object) : void
      {
         var e:Object = null;
         for each(e in param1.list)
         {
            e.sn = -1;
            e.prev = e.next = null;
            entryPool.push(e);
         }
         param1.list = null;
      }

      // Jitter = how much later than the earliest-arriving frame of the last 10 s frames arrive: the 90th
      // percentile over the last 3 s, so a stray late packet doesn't add delay for everything after it (late
      // frames are covered by extrapolation instead).
      private static function trackArrival(param1:Number) : void
      {
         var now:int = getTimer();
         if(lastFrameT >= 0 && param1 > lastFrameT && param1 - lastFrameT < 500)
         {
            frameGap += (param1 - lastFrameT - frameGap) * 0.05;
         }
         lastFrameT = param1;
         var d:Number = now - param1;
         arrivals.push([now,d]);
         while(arrivals.length > 0 && now - arrivals[0][0] > 10000)
         {
            arrivals.shift();
         }
         var base:Number = d;
         var recent:Array = [];
         var a:Array = null;
         for each(a in arrivals)
         {
            if(a[1] < base)
            {
               base = a[1];
            }
         }
         for each(a in arrivals)
         {
            if(now - a[0] < 3000)
            {
               recent.push(a[1] - base);
            }
         }
         recent.sort(Array.NUMERIC);
         clockBase = base;
         jitter = recent.length > 0 ? Number(recent[Math.min(recent.length - 1,int(recent.length * 0.9))]) : 0;
      }

      private static function readChannels(param1:ByteArray) : Array
      {
         var n:int = param1.readUnsignedShort();
         var list:Array = [];
         while(n-- > 0)
         {
            list.push([param1.readUnsignedInt(),param1.readUnsignedShort(),param1.readUnsignedShort() / 1000,param1.readByte() / 100,param1.readUnsignedByte() == 1,param1.readUnsignedInt()]);
         }
         return list;
      }

      private static function applyChannels(param1:Array) : void
      {
         var id:String = null;
         var seen:Object = {};
         var cid:int = 0;
         var sid:int = 0;
         var vol:Number = NaN;
         var pan:Number = NaN;
         var loop:Boolean = false;
         var pos:Number = NaN;
         var c:Object = null;
         var s:Sound = null;
         var ch:Array = null;
         for each(ch in param1)
         {
            cid = ch[0];
            sid = ch[1];
            vol = ch[2];
            pan = ch[3];
            loop = ch[4];
            pos = ch[5];
            seen[cid] = true;
            c = channels[cid];
            if(!c)
            {
               s = sounds[sid];
               if(!s)
               {
                  continue;
               }
               var sc:SoundChannel = null;
               try
               {
                  sc = s.play(s.length > 0 ? pos % s.length : 0,loop ? 9999 : 0,new SoundTransform(vol,pan));
               }
               catch(e:Error)
               {
               }
               if(!sc)
               {
                  continue;
               }
               c = {
                  sc:sc,
                  vol:vol,
                  pan:pan
               };
               channels[cid] = c;
            }
            else if(c.vol != vol || c.pan != pan)
            {
               c.vol = vol;
               c.pan = pan;
               c.sc.soundTransform = new SoundTransform(vol,pan);
            }
         }
         for(id in channels)
         {
            if(!seen[id])
            {
               channels[id].sc.stop();
               delete channels[id];
            }
         }
      }

      // ================= Original helpers =================

      public static function completeHandler(param1:Event) : void
      {
      }

      public static function openURL(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:URLRequestHeader = new URLRequestHeader("pragma","no-cache");
         _loc2_.requestHeaders.push(_loc3_);
         navigateToURL(_loc2_);
      }

      public static function postURL(param1:String, param2:Array, param3:Function = null) : void
      {
         var variables:URLVariables;
         var loader:URLLoader;
         var p:Array = null;
         var url:String = param1;
         var args:Array = param2;
         var finishFunc:Function = param3;
         var req:URLRequest = new URLRequest(url);
         req.method = URLRequestMethod.POST;
         variables = new URLVariables();
         for each(p in args)
         {
            variables[p[0]] = p[1];
         }
         req.data = variables;
         if(finishFunc == null)
         {
            finishFunc = completeHandler;
         }
         loader = new URLLoader(req);
         try
         {
            loader.load(req);
            loader.addEventListener(Event.COMPLETE,function(param1:Event):*
            {
               finishFunc();
            });
         }
         catch(error:Error)
         {
         }
      }
   }
}
