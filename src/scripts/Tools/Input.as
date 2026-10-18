package Tools
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;

   public class Input
   {

      public static var i:Input;

      public static var verboseInput:Boolean = false;

      // ---- Gamepad config (Xbox-style layout as reported by Flash GameInput on Windows) ----
      public static const PAD_LX:String = "AXIS_0";

      public static const PAD_LY:String = "AXIS_1";

      public static const PAD_RX:String = "AXIS_2";

      public static const PAD_RY:String = "AXIS_3";

      public static const PAD_A:String = "BUTTON_4";

      public static const PAD_B:String = "BUTTON_5";

      public static const PAD_X:String = "BUTTON_6";

      public static const PAD_Y:String = "BUTTON_7";

      public static const PAD_LB:String = "BUTTON_8";

      public static const PAD_RB:String = "BUTTON_9";

      public static const PAD_LT:String = "BUTTON_10";

      public static const PAD_RT:String = "BUTTON_11";

      public static const PAD_BACK:String = "BUTTON_12";

      public static const PAD_START:String = "BUTTON_13";

      public static const PAD_UP:String = "BUTTON_16";

      public static const PAD_DOWN:String = "BUTTON_17";

      public static const PAD_LEFT:String = "BUTTON_18";

      public static const PAD_RIGHT:String = "BUTTON_19";

      public static const PAD_BUTTONS:Array = [PAD_A,PAD_B,PAD_X,PAD_Y,PAD_LB,PAD_RB,PAD_LT,PAD_RT,PAD_BACK,PAD_START,PAD_UP,PAD_DOWN,PAD_LEFT,PAD_RIGHT];

      // Flash reports stick Y as +1 = up; the game wants +1 = down.
      public static var invertStickY:Boolean = true;

      public static var stickDeadzone:Number = 0.25;

      public static var aimDeadzone:Number = 0.35;

      public static var aimRadius:Number = 110;

      public static var cursorSpeed:Number = 12;

      public static const DEBUG_KEY:int = 120;

      public static const P2_COLOR:uint = 0x4CFF4C;

      // Holding START this long starts co-op (or, for player 2, leaves it). A short tap pauses.
      public static var holdMs:int = 3000;

      public var last:FocusEvent;

      public var mouseButtonHit:int = 0;

      public var focusStatus:int = 0;

      public var keyStatus:Array = new Array();

      public var mousex:int;

      public var mousey:int;

      public var mouseStatus:int = 0;

      public var keysHit:Array = new Array();

      // ---- Gamepad state ----
      // Controller assignment:
      //   1 controller, solo:  player 1 = keyboard + mouse and/or the controller.
      //   1 controller, co-op: player 1 = keyboard + mouse, player 2 = the controller.
      //   2 controllers:       player 1 = keyboard + mouse and/or controller 1, player 2 = controller 2.
      // Co-op starts when the joining controller holds START for holdMs. In menus every controller drives the cursor.
      // Each pad is a plain object (see newPad) so no extra class is needed.
      public var p1Pad:Object = newPad();

      public var p2Pad:Object = newPad();

      public var menuPad:Object = newPad();

      // Set by MainScene every frame while player 2 is in the game (alive) / exists at all (alive or waiting to respawn).
      public var p2Active:Boolean = false;

      public var p2Present:Boolean = false;

      // Set by MainScene: with a single controller, co-op hands that controller to player 2.
      public var coopEnabled:Boolean = false;

      public var padMoveX:Number = 0;

      public var padMoveY:Number = 0;

      public var padMode:Boolean = false;

      public var padFire:Boolean = false;

      public var padAimX:Number = 0;

      public var padAimY:Number = -1;

      public var padCursorX:Number = 0;

      public var padCursorY:Number = 0;

      private var stage:Stage;

      private var gameInput:Object;

      private var devices:Array = new Array();

      private var pads:Array = new Array();

      private var padHeldKeys:Object = {};

      private var p2JoinRequest:Boolean = false;

      private var p2LeaveRequest:Boolean = false;

      // START hold tracking per controller (index into pads).
      private var startWasDown:Array = new Array();

      private var startDownAt:Array = new Array();

      private var startTracking:Array = new Array();

      private var startConsumed:Array = new Array();

      private var p1Index:int = -1;

      private var p2Index:int = -1;

      private var joinIndex:int = -1;

      // Last time (ms) gameplay was running. The game logic runs on a timer, not every frame, so the
      // frame-based inGameplay() can flicker; START holds only cancel after a real pause.
      private var lastGameplayMs:int = -100000;

      // A controller "left click" in a menu, waiting for the scene to press the button under the cursor.
      private var padClick:Boolean = false;

      private var frame:int = 0;

      private var aimFrame:int = -100;

      private var p2Frame:int = -100;

      private var aimOriginX:Number = 0;

      private var aimOriginY:Number = 0;

      private var p2AimX:Number = 0;

      private var p2AimY:Number = 0;

      private var lastRealMouseX:Number = 0;

      private var lastRealMouseY:Number = 0;

      private var cursor:Sprite;

      private var p2Cursor:Sprite;

      private var debugText:TextField;

      public function Input(param1:DisplayObject)
      {
         super();
         param1.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
         param1.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
         param1.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
         param1.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
         param1.addEventListener(FocusEvent.FOCUS_IN,focusInHandler);
         param1.addEventListener(FocusEvent.FOCUS_OUT,focusOutHandler);
         param1.addEventListener(FocusEvent.FOCUS_OUT,focusOutHandler2);
         param1.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,focusOutHandler);
         param1.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,focusOutHandler);
         i = this;
         stage = param1 as Stage;
         initGamepad();
         param1.addEventListener(Event.ENTER_FRAME,pollGamepad);
      }

      // Called by player 1 each frame with its position, so the right stick can aim around it.
      public function setAimOrigin(param1:Number, param2:Number) : void
      {
         aimOriginX = param1;
         aimOriginY = param2;
         aimFrame = frame;
      }

      // Called by player 2 each frame with its aim point, for the green reticle.
      public function setP2Aim(param1:Number, param2:Number) : void
      {
         p2AimX = param1;
         p2AimY = param2;
         p2Frame = frame;
      }

      public function inGameplay() : Boolean
      {
         return frame - aimFrame <= 2 || frame - p2Frame <= 2;
      }

      public function hasP2Pad() : Boolean
      {
         return p2Pad.connected;
      }

      // A controller that could start co-op by holding START.
      public function hasJoinPad() : Boolean
      {
         return joinIndex >= 0;
      }

      public function padCount() : int
      {
         return pads.length;
      }

      // True once when the joining controller has held START long enough; stale requests are dropped.
      public function p2JoinHit() : Boolean
      {
         var _loc1_:Boolean = p2JoinRequest;
         p2JoinRequest = false;
         return _loc1_;
      }

      // True once when player 2 has held START long enough to leave co-op.
      public function p2LeaveHit() : Boolean
      {
         var _loc1_:Boolean = p2LeaveRequest;
         p2LeaveRequest = false;
         return _loc1_;
      }

      // 0..1 progress of a START hold that will join or leave co-op ("join" / "leave" in holdAction()).
      public function holdProgress() : Number
      {
         var d:int = holdIndex();
         if(d < 0)
         {
            return 0;
         }
         return Math.min(1,(getTimer() - startDownAt[d]) / holdMs);
      }

      public function holdAction() : String
      {
         var d:int = holdIndex();
         if(d < 0)
         {
            return "";
         }
         return d == p2Index && p2Present ? "leave" : "join";
      }

      private function holdIndex() : int
      {
         var d:int = 0;
         while(d < pads.length)
         {
            if(startTracking[d] && !startConsumed[d] && (d == p2Index && p2Present || d == joinIndex && !p2Present))
            {
               return d;
            }
            d++;
         }
         return -1;
      }

      // True once after RT / A / LT is pressed in a menu (the scene clicks the button under the pad cursor).
      public function takePadClick() : Boolean
      {
         var _loc1_:Boolean = padClick;
         padClick = false;
         return _loc1_;
      }

      public function mouseY() : int
      {
         if(padMode)
         {
            if(inGameplay())
            {
               return int(aimOriginY + padAimY * aimRadius);
            }
            return int(padCursorY);
         }
         return mousey;
      }

      public function mouseUpHandler(param1:MouseEvent) : void
      {
         mouseStatus = 0;
      }

      public function keyUpHandler(param1:KeyboardEvent) : void
      {
         keyStatus[param1.keyCode] = false;
      }

      public function outOfFocus() : Boolean
      {
         return !focusStatus;
      }

      public function mouseMoveHandler(param1:MouseEvent) : void
      {
         mousex = param1.stageX;
         mousey = param1.stageY;
         if(Math.abs(mousex - lastRealMouseX) + Math.abs(mousey - lastRealMouseY) > 3)
         {
            padMode = false;
         }
         lastRealMouseX = mousex;
         lastRealMouseY = mousey;
      }

      public function mouseX() : int
      {
         if(padMode)
         {
            if(inGameplay())
            {
               return int(aimOriginX + padAimX * aimRadius);
            }
            return int(padCursorX);
         }
         return mousex;
      }

      public function focusOutHandler(param1:FocusEvent) : void
      {
         var _loc2_:int = 0;
         if(last)
         {
            if(param1.type == FocusEvent.FOCUS_OUT)
            {
               if(last.type != FocusEvent.MOUSE_FOCUS_CHANGE)
               {
                  _loc2_ = 0;
                  while(_loc2_ < keyStatus.length)
                  {
                     keyStatus[_loc2_] = false;
                     _loc2_++;
                  }
                  mouseStatus = 0;
               }
            }
         }
         last = param1;
      }

      public function focusOutHandler2(param1:FocusEvent) : void
      {
         focusStatus = 0;
      }

      public function keyDown(param1:int) : int
      {
         return keyStatus[param1] || padHeldKeys[param1] ? 1 : 0;
      }

      public function mouseDownHandler(param1:MouseEvent) : void
      {
         mouseStatus = 1;
         mouseButtonHit = 1;
      }

      public function mouseDown() : int
      {
         return mouseStatus || padFire ? 1 : 0;
      }

      public function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(keyStatus[param1.keyCode] != true)
         {
            keysHit[param1.keyCode] = true;
         }
         keyStatus[param1.keyCode] = true;
         if(param1.keyCode == DEBUG_KEY)
         {
            toggleDebug();
         }
         if(verboseInput)
         {
            trace(param1.keyCode);
         }
      }

      public function focusInHandler(param1:FocusEvent) : void
      {
         focusStatus = 1;
      }

      public function mouseHit() : int
      {
         var _loc1_:int = mouseButtonHit;
         mouseButtonHit = 0;
         return _loc1_;
      }

      public function keyHit(param1:int, param2:Boolean = true) : int
      {
         var _loc3_:int = int(keysHit[param1]);
         if(param2)
         {
            keysHit[param1] = false;
         }
         return _loc3_;
      }

      // ================= Gamepad =================

      public static function newPad() : Object
      {
         return {
            connected:false,
            buttons:{},
            prevButtons:{},
            hits:{},
            lsX:0,
            lsY:0,
            lsMag:0,
            rsX:0,
            rsY:0,
            rsMag:0,
            dpx:0,
            dpy:0,
            moveX:0,
            moveY:0,
            aimX:0,
            aimY:-1,
            fire:false,
            active:false
         };
      }

      // Rebuilds a pad's state from one frame of control values (null = no controller).
      public static function updatePad(param1:Object, param2:Object) : void
      {
         var id:String = null;
         var pad:Object = param1;
         pad.prevButtons = pad.buttons;
         pad.buttons = {};
         pad.connected = param2 != null;
         if(!pad.connected)
         {
            pad.lsX = pad.lsY = pad.lsMag = pad.rsX = pad.rsY = pad.rsMag = pad.dpx = pad.dpy = pad.moveX = pad.moveY = 0;
            pad.fire = pad.active = false;
            pad.hits = {};
            return;
         }
         var ys:Number = invertStickY ? -1 : 1;
         for each(id in PAD_BUTTONS)
         {
            pad.buttons[id] = Number(param2[id]) > 0.5;
            if(pad.buttons[id] && !pad.prevButtons[id])
            {
               pad.hits[id] = true;
            }
         }
         var ls:Array = deadzone(Number(param2[PAD_LX]) || 0,(Number(param2[PAD_LY]) || 0) * ys,stickDeadzone);
         var rs:Array = deadzone(Number(param2[PAD_RX]) || 0,(Number(param2[PAD_RY]) || 0) * ys,aimDeadzone);
         pad.lsX = ls[0];
         pad.lsY = ls[1];
         pad.lsMag = ls[2];
         pad.rsX = rs[0];
         pad.rsY = rs[1];
         pad.rsMag = rs[2];
         pad.dpx = (pad.buttons[PAD_RIGHT] ? 1 : 0) - (pad.buttons[PAD_LEFT] ? 1 : 0);
         pad.dpy = (pad.buttons[PAD_DOWN] ? 1 : 0) - (pad.buttons[PAD_UP] ? 1 : 0);
         var mx:Number = pad.lsX + pad.dpx;
         var my:Number = pad.lsY + pad.dpy;
         var m:Number = Math.sqrt(mx * mx + my * my);
         if(m > 1)
         {
            mx /= m;
            my /= m;
         }
         pad.moveX = mx;
         pad.moveY = my;
         if(pad.rsMag > 0)
         {
            pad.aimX = pad.rsX / pad.rsMag;
            pad.aimY = pad.rsY / pad.rsMag;
         }
         pad.fire = Boolean(pad.buttons[PAD_A] || pad.buttons[PAD_RT] || pad.buttons[PAD_LT]);
         var act:Boolean = pad.lsMag > 0 || pad.rsMag > 0 || pad.dpx != 0 || pad.dpy != 0;
         for(id in pad.buttons)
         {
            if(pad.buttons[id])
            {
               act = true;
            }
         }
         pad.active = act;
      }

      public static function padHeld(param1:Object, param2:String) : Boolean
      {
         return Boolean(param1.buttons[param2]);
      }

      public static function padPressed(param1:Object, param2:String) : Boolean
      {
         return Boolean(param1.buttons[param2]) && !param1.prevButtons[param2];
      }

      // Press edge of a pad button, latched until read once.
      public function padHit(param1:Object, param2:String) : Boolean
      {
         var _loc3_:Boolean = Boolean(param1.hits[param2]);
         param1.hits[param2] = false;
         return _loc3_;
      }

      public static function deadzone(param1:Number, param2:Number, param3:Number) : Array
      {
         var mag:Number = Math.sqrt(param1 * param1 + param2 * param2);
         if(mag < param3 || isNaN(mag))
         {
            return [0,0,0];
         }
         var scaled:Number = Math.min(1,(mag - param3) / (1 - param3));
         return [param1 / mag * scaled,param2 / mag * scaled,scaled];
      }

      private function initGamepad() : void
      {
         var GI:Class = null;
         var n:int = 0;
         try
         {
            GI = getDefinitionByName("flash.ui.GameInput") as Class;
            if(!GI || !GI["isSupported"])
            {
               return;
            }
            gameInput = new GI();
            gameInput.addEventListener("deviceAdded",onDeviceAdded);
            gameInput.addEventListener("deviceRemoved",onDeviceRemoved);
            n = 0;
            while(n < int(GI["numDevices"]))
            {
               addDevice(GI["getDeviceAt"](n));
               n++;
            }
         }
         catch(e:Error)
         {
            gameInput = null;
         }
      }

      private function onDeviceAdded(param1:Object) : void
      {
         addDevice(param1.device);
      }

      private function onDeviceRemoved(param1:Object) : void
      {
         var idx:int = devices.indexOf(param1.device);
         if(idx >= 0)
         {
            devices.splice(idx,1);
         }
      }

      private function addDevice(param1:Object) : void
      {
         if(!param1 || devices.indexOf(param1) >= 0)
         {
            return;
         }
         try
         {
            param1.enabled = true;
         }
         catch(e:Error)
         {
         }
         devices.push(param1);
      }

      private function readDevice(param1:Object) : Object
      {
         var c:int = 0;
         var ctl:Object = null;
         var values:Object = {};
         try
         {
            c = 0;
            while(c < int(param1.numControls))
            {
               ctl = param1.getControlAt(c);
               values[ctl.id] = Number(ctl.value);
               c++;
            }
         }
         catch(e:Error)
         {
         }
         return values;
      }

      // Merges several devices, keeping the strongest value of each control.
      private function mergeValues(param1:Array) : Object
      {
         var dv:Object = null;
         var id:String = null;
         var v:Number = NaN;
         var values:Object = {};
         for each(dv in param1)
         {
            for(id in dv)
            {
               v = Number(dv[id]);
               if(values[id] == undefined || Math.abs(v) > Math.abs(values[id]))
               {
                  values[id] = v;
               }
            }
         }
         return values;
      }

      // Skips devices that don't look like a gamepad (needs at least a left stick).
      private function looksLikePad(param1:Object) : Boolean
      {
         return param1[PAD_LX] != undefined && param1[PAD_LY] != undefined;
      }

      // Maps a pad button onto a keyboard key code (held + hit edge).
      private function bindKey(param1:Object, param2:String, param3:int) : void
      {
         if(padPressed(param1,param2))
         {
            keysHit[param3] = true;
         }
         if(padHeld(param1,param2))
         {
            padHeldKeys[param3] = true;
         }
      }

      private function bindKeys(param1:Object, param2:Boolean = true) : void
      {
         bindKey(param1,PAD_LB,32);
         bindKey(param1,PAD_RB,16);
         bindKey(param1,PAD_X,32);
         bindKey(param1,PAD_Y,73);
         bindKey(param1,PAD_BACK,77);
         if(param2)
         {
            bindKey(param1,PAD_START,80);
         }
         bindKey(param1,PAD_B,27);
      }

      // In gameplay START is handled here: a tap pauses (on release), a long hold joins or leaves co-op.
      private function updateStartHolds(param1:Array, param2:Boolean) : void
      {
         var d:int = 0;
         var down:Boolean = false;
         var now:int = getTimer();
         d = 0;
         while(d < param1.length)
         {
            down = Number(param1[d][PAD_START]) > 0.5;
            if(!param2)
            {
               startTracking[d] = false;
            }
            else
            {
               if(down && !startWasDown[d])
               {
                  startTracking[d] = true;
                  startConsumed[d] = false;
                  startDownAt[d] = now;
               }
               if(startTracking[d] && down && !startConsumed[d] && now - startDownAt[d] >= holdMs)
               {
                  if(d == p2Index && p2Present)
                  {
                     startConsumed[d] = true;
                     p2LeaveRequest = true;
                  }
                  else if(d == joinIndex && !p2Present)
                  {
                     startConsumed[d] = true;
                     p2JoinRequest = true;
                  }
               }
               if(!down && startTracking[d])
               {
                  startTracking[d] = false;
                  if(!startConsumed[d] && (d == p1Index || d == p2Index && p2Present))
                  {
                     keysHit[80] = true;
                  }
               }
            }
            startWasDown[d] = down;
            d++;
         }
      }

      private function pollGamepad(param1:Event) : void
      {
         var dev:Object = null;
         var dv:Object = null;
         var all:Array = new Array();
         frame++;
         pads = new Array();
         for each(dev in devices)
         {
            dv = readDevice(dev);
            if(looksLikePad(dv))
            {
               pads.push(dev);
               all.push(dv);
            }
         }
         var n:int = int(all.length);
         if(n >= 2)
         {
            p1Index = 0;
            p2Index = 1;
         }
         else if(n == 1)
         {
            p1Index = coopEnabled ? -1 : 0;
            p2Index = coopEnabled ? 0 : -1;
         }
         else
         {
            p1Index = p2Index = -1;
         }
         joinIndex = n >= 2 ? 1 : (n == 1 && !coopEnabled ? 0 : -1);
         updatePad(p1Pad,p1Index >= 0 ? all[p1Index] : null);
         updatePad(p2Pad,p2Index >= 0 ? all[p2Index] : null);
         updatePad(menuPad,n >= 1 ? mergeValues(all) : null);
         padHeldKeys = {};
         if(inGameplay())
         {
            lastGameplayMs = getTimer();
         }
         updateStartHolds(all,getTimer() - lastGameplayMs < 300);
         if(inGameplay())
         {
            gameplayPads();
         }
         else
         {
            menuPads();
         }
         updateCursor();
         if(debugText && debugText.visible)
         {
            updateDebug(all);
         }
      }

      private function gameplayPads() : void
      {
         if(p1Pad.connected)
         {
            if(p1Pad.active && !padMode)
            {
               padMode = true;
            }
            padMoveX = p1Pad.moveX;
            padMoveY = p1Pad.moveY;
            padAimX = p1Pad.aimX;
            padAimY = p1Pad.aimY;
            padCursorX = aimOriginX + padAimX * aimRadius;
            padCursorY = aimOriginY + padAimY * aimRadius;
            // A / RT / LT act as the mouse button (fire in game, click on HUD buttons).
            padFire = p1Pad.fire;
            if(padPressed(p1Pad,PAD_A) || padPressed(p1Pad,PAD_RT) || padPressed(p1Pad,PAD_LT))
            {
               mouseButtonHit = 1;
            }
            bindKeys(p1Pad,false);
         }
         else
         {
            // Player 1 has no controller: keep aiming with the real mouse.
            padMode = false;
            padMoveX = padMoveY = 0;
            padFire = false;
         }
         if(p2Pad.connected)
         {
            if(p2Active)
            {
               if(padPressed(p2Pad,PAD_BACK))
               {
                  keysHit[77] = true;
               }
               if(padPressed(p2Pad,PAD_Y))
               {
                  keysHit[73] = true;
               }
            }
         }
      }

      private function menuPads() : void
      {
         padMoveX = padMoveY = 0;
         if(!padMode)
         {
            padClick = false;
         }
         p2JoinRequest = false;
         p2LeaveRequest = false;
         p1Pad.hits = {};
         p2Pad.hits = {};
         if(!menuPad.connected)
         {
            padFire = false;
            return;
         }
         if(menuPad.active && !padMode)
         {
            padMode = true;
            padCursorX = mousex;
            padCursorY = mousey;
         }
         padCursorX += (menuPad.lsX * menuPad.lsMag + menuPad.rsX * menuPad.rsMag) * cursorSpeed + menuPad.dpx * cursorSpeed * 0.5;
         padCursorY += (menuPad.lsY * menuPad.lsMag + menuPad.rsY * menuPad.rsMag) * cursorSpeed + menuPad.dpy * cursorSpeed * 0.5;
         if(stage)
         {
            padCursorX = Math.max(0,Math.min(stage.stageWidth,padCursorX));
            padCursorY = Math.max(0,Math.min(stage.stageHeight,padCursorY));
         }
         // A / RT / LT act as the mouse button (click in menus).
         padFire = menuPad.fire;
         if(padPressed(menuPad,PAD_A) || padPressed(menuPad,PAD_RT) || padPressed(menuPad,PAD_LT))
         {
            mouseButtonHit = 1;
            padClick = true;
         }
         bindKeys(menuPad);
      }

      private function makeCursor(param1:uint) : Sprite
      {
         var s:Sprite = new Sprite();
         s.mouseEnabled = false;
         s.mouseChildren = false;
         s.graphics.lineStyle(2,0,0.6);
         s.graphics.drawCircle(0,0,9);
         s.graphics.lineStyle(2,param1,0.9);
         s.graphics.drawCircle(0,0,8);
         s.graphics.moveTo(-13,0);
         s.graphics.lineTo(-4,0);
         s.graphics.moveTo(4,0);
         s.graphics.lineTo(13,0);
         s.graphics.moveTo(0,-13);
         s.graphics.lineTo(0,-4);
         s.graphics.moveTo(0,4);
         s.graphics.lineTo(0,13);
         stage.addChild(s);
         return s;
      }

      private function bringToFront(param1:DisplayObject) : void
      {
         if(stage.getChildIndex(param1) != stage.numChildren - 1)
         {
            stage.setChildIndex(param1,stage.numChildren - 1);
         }
      }

      private function updateCursor() : void
      {
         if(!stage)
         {
            return;
         }
         if(!cursor)
         {
            cursor = makeCursor(0xFFFFFF);
            p2Cursor = makeCursor(P2_COLOR);
         }
         cursor.visible = padMode;
         if(padMode)
         {
            cursor.x = mouseX();
            cursor.y = mouseY();
            bringToFront(cursor);
         }
         p2Cursor.visible = frame - p2Frame <= 2;
         if(p2Cursor.visible)
         {
            p2Cursor.x = p2AimX;
            p2Cursor.y = p2AimY;
            bringToFront(p2Cursor);
         }
      }

      // F9 toggles an overlay of raw controller values (for remapping).
      private function toggleDebug() : void
      {
         if(!stage)
         {
            return;
         }
         if(!debugText)
         {
            debugText = new TextField();
            debugText.defaultTextFormat = new TextFormat("_typewriter",11,0xFFFF00);
            debugText.background = true;
            debugText.backgroundColor = 0;
            debugText.mouseEnabled = false;
            debugText.width = 300;
            debugText.height = 500;
            debugText.visible = false;
            stage.addChild(debugText);
         }
         debugText.visible = !debugText.visible;
         if(debugText.visible)
         {
            stage.setChildIndex(debugText,stage.numChildren - 1);
         }
      }

      private function updateDebug(param1:Array) : void
      {
         var id:String = null;
         var d:int = 0;
         var role:String = null;
         var s:String = "GameInput: " + (gameInput ? "supported" : "NOT supported") + ", devices: " + devices.length + ", pads: " + pads.length + "\n";
         d = 0;
         while(d < pads.length)
         {
            role = d == p1Index ? "P1" : (d == p2Index ? "P2" : (d == joinIndex ? "P2 (hold START to join)" : "unused"));
            s += "\n[" + d + "] " + role + ": " + String(pads[d].name) + "\n";
            for(id in param1[d])
            {
               if(Math.abs(Number(param1[d][id])) > 0.05)
               {
                  s += "  " + id + " = " + Number(param1[d][id]).toFixed(2) + "\n";
               }
            }
            d++;
         }
         debugText.text = s;
      }
   }
}
