package GameScene
{
   import GameObject.GameObject;
   import Serialization.StoreObject;
   import Tools.GraphicsTools;
   import Tools.Input;
   import Tools.Interpolation;
   import flash.display.Bitmap;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class GameSceneStack
   {
      
      public static var focusObj:GameObject;
      
      public static var currentStack:GameSceneStack;
      
      public var lastTicks:int;
      
      public var fadeSprite:Bitmap;
      
      public var stack:Array = new Array();
      
      public var i:Input;
      
      public var extraDelay:int = 0;
      
      public var fading:Boolean = false;
      
      public var fadeTicks:int = 0;
      
      public var killedLife:int = 0;
      
      public var elapsedTicks:int;
      
      public var mainSprite:Sprite;
      
      public function GameSceneStack()
      {
         super();
         currentStack = this;
      }
      
      public function update() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:GameScene = null;
         var _loc7_:int = 0;
         var _loc8_:GameScene = null;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:GameObject = null;
         StoreObject.updateStoreObject();
         if(i == null)
         {
            if(Input.i)
            {
               i = Input.i;
            }
            else
            {
               i = new Input(mainSprite.stage);
            }
         }
         if(GameScene.stealFocus)
         {
            if(focusObj)
            {
               if(focusObj._removed)
               {
                  focusObj = null;
               }
            }
            if(focusObj)
            {
               mainSprite.stage.focus = InteractiveObject(focusObj.obj);
            }
            else
            {
               mainSprite.stage.focus = mainSprite;
            }
            mainSprite.focusRect = null;
            mainSprite.stage.stageFocusRect = false;
         }
         var _loc1_:int = getTimer();
         elapsedTicks += _loc1_ - lastTicks;
         lastTicks = _loc1_;
         var _loc2_:int = (elapsedTicks - elapsedTicks % 10) / 10;
         elapsedTicks %= 10;
         if(_loc2_ > 5)
         {
            _loc2_ = 5;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc3_ == _loc2_ - 1;
            _loc5_ = getTimer();
            _loc6_ = GameScene(stack[stack.length - 1]);
            if(!fading || fadeTicks > 60 + extraDelay)
            {
               _loc6_.update();
            }
            _loc7_ = 0;
            while(_loc7_ < stack.length - 1)
            {
               _loc8_ = GameScene(stack[_loc7_]);
               if(_loc8_.updateWhenRemoving)
               {
                  _loc8_.update();
               }
               _loc7_++;
            }
            if(fading)
            {
               fadeTicks += 1;
               fadeSprite.alpha = Interpolation.linearInterpolateLock(0,1,Interpolation.fromTo(fadeTicks,0,30));
               fadeSprite.alpha *= Interpolation.linearInterpolateLock(1,0,Interpolation.fromTo(fadeTicks,70 + extraDelay,100 + extraDelay));
               if(fadeTicks > 100 + extraDelay && _loc4_)
               {
                  fadeTicks = 0;
                  fading = false;
                  mainSprite.removeChild(fadeSprite);
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         loop1:
         while(_loc3_ < _loc2_)
         {
            _loc9_ = 0;
            while(true)
            {
               if(_loc9_ >= stack.length - 1)
               {
                  _loc3_++;
                  continue loop1;
               }
               _loc6_ = GameScene(stack[_loc9_]);
               _loc10_ = false;
               if(_loc6_.fadeToBlack)
               {
                  _loc6_.fadeToBlackTicks += 1;
                  _loc10_ = _loc6_.fadeToBlackTicks > 50;
               }
               else
               {
                  _loc6_.m.alpha -= 0.02;
                  _loc10_ = _loc6_.m.alpha < 0;
               }
               if(_loc10_ && _loc3_ == _loc2_ - 1)
               {
                  break;
               }
               _loc9_++;
            }
            trace("KILLIN");
            trace(_loc6_);
            _loc6_.flushParticles();
            for each(_loc11_ in _loc6_.objects)
            {
               _loc11_.remove();
               _loc11_.gs = null;
               _loc11_.filters = null;
               _loc11_.parent = null;
               _loc11_.children = null;
               _loc11_._removed = true;
            }
            mainSprite.removeChild(_loc6_.m);
            _loc6_.objects = new Array();
            stack = [stack.pop()];
            return;
         }
      }
      
      public function pushScene(param1:GameScene, param2:Boolean = false, param3:int = 0) : void
      {
         param1.gss = this;
         param1.i = i;
         param1.register(mainSprite);
         param1.init();
         stack.push(param1);
         extraDelay = param3;
         if(param2)
         {
            if(fadeSprite)
            {
               if(mainSprite.contains(fadeSprite))
               {
                  mainSprite.removeChild(fadeSprite);
               }
            }
            fadeSprite = GraphicsTools.createFilledSprite(800,600,0);
            mainSprite.addChild(fadeSprite);
            fadeTicks = 0;
            fading = true;
            param1.fadeToBlack = true;
         }
         else
         {
            fading = false;
         }
      }
   }
}

