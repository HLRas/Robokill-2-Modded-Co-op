package Tools
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import Scenes.MainMenu;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.JPEGEncoderOptions;
   import flash.display.Loader;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
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

      private static const D_IMAGE:int = 1;

      private static const D_FREE:int = 2;

      private static const D_FILTERS:int = 3;

      private static const D_SOUND:int = 4;

      private static const D_FRAME:int = 5;

      private static const D_PAD:int = 6;

      private static const D_IMAGEREF:int = 7;

      private static const D_TEXT:int = 8;

      private static const D_JPEG:int = 9;

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

      // The game's shared pictures (Embeds' static BitmapData) by name, and each embedded picture class's original
      // pixels: pictures the guest's copy of the game already has are sent by name instead of pixels.
      private static var staticNames:Dictionary;

      private static var classOriginals:Object = {};

      // Text pictures: their text and layout, sent instead of pixels.
      private static var textDescs:Dictionary = new Dictionary(true);

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

      private static var tmpMatrix:Matrix = new Matrix();

      private static var lastPadBytes:String = "";

      private static var lastPadSent:int = 0;

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
         if(s.bytesAvailable > 0)
         {
            bytesIn += s.bytesAvailable;
            s.readBytes(inBuf,inBuf.length,s.bytesAvailable);
         }
         var pos:int = 0;
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
         rest = new ByteArray();
         if(pos < inBuf.length)
         {
            inBuf.position = pos;
            inBuf.readBytes(rest,0,inBuf.length - pos);
         }
         inBuf = rest;
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
      }

      private static function onExitFrame(param1:Event) : void
      {
         ++frameNo;
         if(sock && sock.connected && getTimer() - lastPing > 20000)
         {
            lastPing = getTimer();
            sendRelay(R_PING);
         }
         if(mode == 1 && peer && frameNo % 2 == 0)
         {
            // Skip frames while the upload is backed up, so lag doesn't build up.
            if(sock && sock.bytesPending < 150000)
            {
               try
               {
                  captureFrame();
               }
               catch(e:Error)
               {
               }
            }
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
         if(!staticNames)
         {
            buildStaticNames();
         }
      }

      private static function buildStaticNames() : void
      {
         var v:XML = null;
         var bd:BitmapData = null;
         staticNames = new Dictionary();
         try
         {
            var E:Class = getDefinitionByName("GlobalSetup.Embeds") as Class;
            var x:XML = describeType(E);
            for each(v in x.variable)
            {
               if(String(v.@type) == "flash.display::BitmapData")
               {
                  bd = E[String(v.@name)] as BitmapData;
                  if(bd)
                  {
                     staticNames[bd] = String(v.@name);
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
      }

      private static function captureFrame() : void
      {
         var t0:int = getTimer();
         ++frameSeq;
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
         walk(stage,null,BlendMode.NORMAL);
         var out:ByteArray = new ByteArray();
         out.writeUnsignedInt(t0);
         writeVar(out,frameCount);
         out.writeBytes(frameBody);
         writeChannels(out);
         out.compress();
         sendData(D_FRAME,out);
         if(frameNo % 600 == 0)
         {
            sweep();
         }
         captureMs += (getTimer() - t0 - captureMs) * 0.1;
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
         var col:String = ct.redMultiplier != 1 || ct.greenMultiplier != 1 || ct.blueMultiplier != 1 || ct.redOffset != 0 || ct.greenOffset != 0 || ct.blueOffset != 0 ? [clampShort(ct.redMultiplier * 256),clampShort(ct.greenMultiplier * 256),clampShort(ct.blueMultiplier * 256),clampShort(ct.redOffset),clampShort(ct.greenOffset),clampShort(ct.blueOffset)].join(",") : "";
         var fl:int = Math.max(0,BLENDS.indexOf(param6)) | (param7 ? 128 : 0);
         var oid:int = objIds[param1];
         if(!oid)
         {
            oid = nextObj++;
            objIds[param1] = oid;
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
            if(last.col != col)
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
            if(col.length > 0)
            {
               b.writeByte(1);
               b.writeShort(clampShort(ct.redMultiplier * 256));
               b.writeShort(clampShort(ct.greenMultiplier * 256));
               b.writeShort(clampShort(ct.blueMultiplier * 256));
               b.writeShort(clampShort(ct.redOffset));
               b.writeShort(clampShort(ct.greenOffset));
               b.writeShort(clampShort(ct.blueOffset));
            }
            else
            {
               b.writeByte(0);
            }
            last.col = col;
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
         var name:String = staticNames ? staticNames[param2] : null;
         if(name)
         {
            sendRef(param1.id,1,name);
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
                  var r:Rectangle = BitmapData(diff).getColorBoundsRect(4294967295,0,false);
                  BitmapData(diff).dispose();
                  if(r.width > 0 && r.height > 0)
                  {
                     sendImage(param1.id,param2,r,false);
                  }
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
         sendImage(param1.id,param2,param2.rect,true);
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
            var r:Rectangle = BitmapData(diff).getColorBoundsRect(4294967295,0,false);
            BitmapData(diff).dispose();
            if(r.width > 0 && r.height > 0)
            {
               sendImage(param1.id,param2,r,false);
               param1.copy.copyPixels(param2,r,r.topLeft);
            }
         }
      }

      private static function sendImage(param1:int, param2:BitmapData, param3:Rectangle, param4:Boolean) : void
      {
         // Big opaque areas (screen-fade snapshots, room floors) go as JPEG: a tenth of the size, so they don't
         // hold up the frames behind them.
         if(param3.width * param3.height >= 40000)
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
               sendData(D_JPEG,jb);
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
         sendData(D_IMAGE,b);
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
            sendData(D_FREE,b);
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

      private static function filterSetId(param1:Array) : int
      {
         var f:BitmapFilter = null;
         var b:ByteArray = new ByteArray();
         var key:String = "";
         var n:int = 0;
         var cm:ColorMatrixFilter = null;
         var g:GlowFilter = null;
         var d:DropShadowFilter = null;
         var bf:BlurFilter = null;
         var m:Array = null;
         var i:int = 0;
         b.writeByte(0);
         for each(f in param1)
         {
            if(f is ColorMatrixFilter)
            {
               cm = ColorMatrixFilter(f);
               m = cm.matrix;
               b.writeByte(1);
               key += "c";
               i = 0;
               while(i < 20)
               {
                  b.writeFloat(m[i]);
                  key += "," + m[i];
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
               key += "g" + [g.color,g.alpha,g.blurX,g.blurY,g.strength,g.quality,g.inner,g.knockout].join(",");
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
               key += "d" + [d.distance,d.angle,d.color,d.alpha,d.blurX,d.blurY,d.strength,d.quality,d.inner,d.knockout,d.hideObject].join(",");
            }
            else
            {
               if(!(f is BlurFilter))
               {
                  continue;
               }
               bf = BlurFilter(f);
               b.writeByte(4);
               b.writeFloat(bf.blurX);
               b.writeFloat(bf.blurY);
               b.writeByte(bf.quality);
               key += "b" + [bf.blurX,bf.blurY,bf.quality].join(",");
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
         b.position = 0;
         b.writeByte(n);
         var out:ByteArray = new ByteArray();
         out.writeShort(id);
         out.writeBytes(b);
         sendData(D_FILTERS,out);
         return id;
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
         while(i < n && i < PAD_CONTROLS.length)
         {
            values[PAD_CONTROLS[i]] = param1.readByte() / 127;
            i++;
         }
         remotePad = values;
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
         var b:ByteArray = new ByteArray();
         b.writeByte(PAD_CONTROLS.length);
         var id:String = null;
         var v:Number = NaN;
         var q:Array = [];
         for each(id in PAD_CONTROLS)
         {
            v = Number(values[id]) || 0;
            if(kb[id] && Math.abs(kb[id]) > Math.abs(v))
            {
               v = kb[id];
            }
            q.push(Math.round(Math.max(-1,Math.min(1,v)) * 127));
            b.writeByte(q[q.length - 1]);
         }
         // Sent the moment it changes, plus a refresh every 100 ms.
         var bytesKey:String = q.join(",");
         if(bytesKey != lastPadBytes || getTimer() - lastPadSent > 100)
         {
            lastPadBytes = bytesKey;
            lastPadSent = getTimer();
            sendData(D_PAD,b);
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
      // uneven network arrival doesn't show as stutter. The delay follows the measured jitter.
      private static function renderGuest() : void
      {
         if(snaps.length == 0)
         {
            return;
         }
         var target:Number = Math.max(45,Math.min(400,jitter + 40));
         if(target > bufferMs)
         {
            bufferMs = target;
         }
         else
         {
            bufferMs += (target - bufferMs) * 0.01;
         }
         var rt:Number = getTimer() - clockBase - bufferMs;
         // Way behind (e.g. after a hitch): skip ahead rather than playing old frames.
         while(snaps.length > 2 && rt - snaps[0].t > 600)
         {
            snaps.shift();
         }
         while(snaps.length >= 2 && snaps[1].t <= rt)
         {
            snaps.shift();
         }
         var s0:Object = snaps[0];
         var s1:Object = snaps.length > 1 ? snaps[1] : null;
         var f:Number = s1 && rt > s0.t && s1.t > s0.t ? Math.min(1,(rt - s0.t) / (s1.t - s0.t)) : 0;
         if(!s0.done)
         {
            s0.done = true;
            applyChannels(s0.chans);
         }
         drawSnapshot(s0,s1,f);
      }

      private static function drawSnapshot(param1:Object, param2:Object, param3:Number) : void
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
         var g:Number = NaN;
         while(k < n)
         {
            e = list[k];
            bmp = pool[k];
            if(!bmp)
            {
               bmp = new Bitmap();
               pool[k] = bmp;
               poolFilter[k] = 0;
               layer.addChild(bmp);
            }
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
            }
            m.a = e.a;
            m.b = e.b;
            m.c = e.c;
            m.d = e.d;
            m.tx = e.tx;
            m.ty = e.ty;
            g = 1;
            e1 = param2 && param3 > 0 ? param2.byId[e.oid] : null;
            // Blend toward the next frame, unless the object jumped (teleport, new room) or changed picture.
            if(e1 && e1.img == e.img && Math.abs(e1.tx - e.tx) + Math.abs(e1.ty - e.ty) < 80 && Math.abs(e1.a - e.a) + Math.abs(e1.b - e.b) + Math.abs(e1.c - e.c) + Math.abs(e1.d - e.d) < 0.8)
            {
               m.a += (e1.a - e.a) * param3;
               m.b += (e1.b - e.b) * param3;
               m.c += (e1.c - e.c) * param3;
               m.d += (e1.d - e.d) * param3;
               m.tx += (e1.tx - e.tx) * param3;
               m.ty += (e1.ty - e.ty) * param3;
            }
            bmp.smoothing = (e.fl & 128) != 0;
            bmp.transform.matrix = m;
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
            bmp.blendMode = BLENDS[e.fl & 127] || BlendMode.NORMAL;
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
            bytesOut = bytesIn = framesIn = 0;
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
            statsText.height = 18;
            statsText.y = 560;
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
            line = "HOST  capture " + captureMs.toFixed(1) + " ms   upload " + Math.round(bytesOut / 1024 / secs) + " KB/s   backlog " + Math.round((sock ? sock.bytesPending : 0) / 1024) + " KB   objects " + frameCount + "   " + (peer ? "friend connected" : "waiting");
         }
         else if(mode == 2)
         {
            line = "GUEST  download " + Math.round(bytesIn / 1024 / secs) + " KB/s   frames " + Math.round(framesIn / secs) + "/s   jitter " + Math.round(jitter) + " ms   delay " + Math.round(bufferMs) + " ms   queued " + snaps.length;
         }
         bytesOut = bytesIn = framesIn = 0;
         statsText.text = " " + line + "   (F8)";
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
         else if(kind == D_IMAGEREF)
         {
            readImageRef(param1);
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
         var count:int = readVar(bytes);
         var list:Array = new Array(count);
         var byId:Object = {};
         var k:int = 0;
         var oid:int = 0;
         var mask:int = 0;
         var st:Object = null;
         var e:Object = null;
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
                  fl:0
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
            st.seen = getTimer();
            e = {
               oid:oid,
               img:st.img,
               tx:st.tx,
               ty:st.ty,
               a:st.a,
               b:st.b,
               c:st.c,
               d:st.d,
               al:st.al,
               col:st.col,
               fid:st.fid,
               fl:st.fl
            };
            list[k] = e;
            byId[oid] = e;
            k++;
         }
         snaps.push({
            t:t,
            list:list,
            byId:byId,
            chans:readChannels(bytes),
            done:false
         });
         trackArrival(t);
         // Object states the host has long forgotten (it resends them in full) can go.
         if(frameNo % 300 == 0)
         {
            var now:int = getTimer();
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

      // Jitter = how much later than the earliest-arriving frame of the last 10 s frames arrive: the 95th
      // percentile over the last 3 s, so one stray late packet doesn't add delay for everything after it.
      private static function trackArrival(param1:Number) : void
      {
         var now:int = getTimer();
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
         jitter = recent.length > 0 ? Number(recent[Math.min(recent.length - 1,int(recent.length * 0.95))]) : 0;
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
