package GameObject
{
   import Tools.Interpolation;
   
   public class GameObjectHelperFilter
   {
      
      public var go:GameObject;
      
      public function GameObjectHelperFilter(param1:GameObject)
      {
         super();
         go = param1;
      }
      
      public function isDragging() : Boolean
      {
         var _loc1_:GameObjectFilter = null;
         for each(_loc1_ in go.filters)
         {
            if(_loc1_ is GameObjectFilterDraggable)
            {
               return GameObjectFilterDraggable(_loc1_).beingDragged;
            }
         }
         return false;
      }
      
      public function fadeIn(param1:int, param2:int = 0) : void
      {
         var _loc3_:GameObjectFilterFadeInOut = new GameObjectFilterFadeInOut();
         _loc3_.FadeIn = 1;
         _loc3_.FadeInDuration = param1;
         _loc3_.FadeInDelay = param2;
         go.addFilter(_loc3_);
      }
      
      public function addShift(param1:Number, param2:Number, param3:int = -1) : void
      {
         var _loc4_:GameObjectFilterShift = new GameObjectFilterShift();
         _loc4_.dx = param1;
         _loc4_.dy = param2;
         _loc4_.timeout = param3;
         go.addFilter(_loc4_);
      }
      
      public function stayOnScreen(param1:Number = -1) : void
      {
         var _loc2_:GameObjectFilter = null;
         var _loc3_:GameObjectFilterStayOnScreen = null;
         for each(_loc2_ in go.filters)
         {
            if(_loc2_ is GameObjectFilterStayOnScreen)
            {
               return;
            }
         }
         _loc3_ = new GameObjectFilterStayOnScreen();
         if(param1 > 0)
         {
            _loc3_.overridedx = param1;
         }
         go.addFilter(_loc3_);
      }
      
      public function sqrtInterpolateIn(param1:int = 75, param2:Number = -1000, param3:Number = 0) : void
      {
         var _loc4_:GameObjectFilterSqrtInterpolateIn = new GameObjectFilterSqrtInterpolateIn();
         _loc4_.dx = param2;
         _loc4_.dy = param3;
         _loc4_.FadeTime = param1;
         go.addFilter(_loc4_);
      }
      
      public function rubberPulse(param1:Number = 1) : void
      {
         var _loc3_:GameObjectFilter = null;
         var _loc2_:int = 0;
         for each(_loc3_ in go.filters)
         {
            if(_loc3_ is GameObjectFilterPulseScale)
            {
               if(!GameObjectFilterPulseScale(_loc3_).done)
               {
                  _loc2_++;
               }
            }
         }
         if(_loc2_ >= 4)
         {
            return;
         }
         var _loc4_:GameObjectFilterPulseScale = new GameObjectFilterPulseScale();
         _loc4_.killAfterOne = true;
         _loc4_.scale = 0.075 * param1;
         _loc4_.Speed *= 8;
         go.addFilter(_loc4_);
      }
      
      public function getModifiedRotation() : Number
      {
         var _loc1_:GameObjectFilter = null;
         for each(_loc1_ in go.filters)
         {
            if(_loc1_ is GameObjectFilterRotateSlowly)
            {
               return GameObjectFilterRotateSlowly(_loc1_).internalRotation;
            }
         }
         return go.baseRotation;
      }
      
      public function draggable(param1:Function = null, param2:Function = null, param3:Boolean = false) : GameObjectFilterDraggable
      {
         var _loc4_:GameObjectFilterDraggable = new GameObjectFilterDraggable();
         _loc4_.startFunc = param1;
         _loc4_.finishFunc = param2;
         _loc4_.dormant = param3;
         go.addFilter(_loc4_);
         return _loc4_;
      }
      
      public function addPanelSlide() : void
      {
         go.basey -= 700;
         var _loc1_:GameObjectFilterSqrtInterpolateIn = new GameObjectFilterSqrtInterpolateIn();
         _loc1_.dy = 700;
         _loc1_.FadeTime = 100;
         _loc1_.useSquareSquare = true;
         go.addFilter(_loc1_);
      }
      
      public function scaleIn(param1:int, param2:Number = 0, param3:Number = 0, param4:int = 0) : void
      {
         var _loc5_:GameObjectFilterScaleInOut = new GameObjectFilterScaleInOut();
         _loc5_.ScaleIn = 1;
         _loc5_.ScaleInDelay = param4;
         _loc5_.ScaleInDuration = param1;
         _loc5_.ScaleInStartX = param2;
         _loc5_.ScaleInStartY = param3;
         go.addFilter(_loc5_);
      }
      
      public function sinDisplace(param1:Number, param2:Number, param3:Number = 1) : void
      {
         var _loc4_:GameObjectFilterSinDisplace = new GameObjectFilterSinDisplace();
         _loc4_.x = param1;
         _loc4_.y = param2;
         _loc4_.speed = param3;
         go.addFilter(_loc4_);
      }
      
      public function fadeOffIfFalse(param1:int, param2:Function) : void
      {
         var period:int = param1;
         var func:Function = param2;
         var gof:GameObjectFilterTrigger = new GameObjectFilterTrigger();
         gof.cause = func;
         gof.result = function():void
         {
            go.helperFilter.fadeOff(period);
         };
         go.addFilter(gof);
      }
      
      public function resetRotation() : void
      {
         var _loc1_:GameObjectFilter = null;
         for each(_loc1_ in go.filters)
         {
            if(_loc1_ is GameObjectFilterRotateSlowly)
            {
               GameObjectFilterRotateSlowly(_loc1_).internalRotationSet = false;
            }
         }
      }
      
      public function shake(param1:Number = 1) : void
      {
         var _loc2_:GameObjectFilterShake = new GameObjectFilterShake();
         _loc2_.mag = param1;
         go.addFilter(_loc2_);
      }
      
      public function moveWith(param1:GameObject) : void
      {
         var _loc2_:GameObjectFilterMoveWith = new GameObjectFilterMoveWith();
         _loc2_.other = param1;
         go.addFilter(_loc2_);
      }
      
      public function pulse(param1:Number = 1, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         var _loc5_:GameObjectFilterPulse = new GameObjectFilterPulse();
         if(param2 > 0)
         {
            _loc5_.Speed = 100 / param2;
         }
         if(!param4)
         {
            _loc5_.ticks = 0;
         }
         _loc5_.alpha = param1;
         go.addFilter(_loc5_);
      }
      
      public function fadeOff(param1:int, param2:int = -1, param3:Boolean = true) : void
      {
         if(param2 == -1)
         {
            param2 = param1;
            param1 = 0;
         }
         var _loc4_:GameObjectFilterFadeInOut = new GameObjectFilterFadeInOut();
         _loc4_.FadeOut = 1;
         _loc4_.FadeOutTime = param1;
         _loc4_.FadeOutDuration = param2;
         _loc4_.FadeOutKill = param3 ? 1 : 0;
         go.addFilter(_loc4_);
      }
      
      public function blink(param1:Number = 0, param2:int = 100, param3:int = 0, param4:Boolean = true) : void
      {
         var _loc5_:GameObjectFilterBlink = new GameObjectFilterBlink();
         _loc5_.BlinkAlpha = param1;
         _loc5_.Interval = param2;
         _loc5_.AliveTime = param3;
         if(!param4)
         {
            _loc5_.ticks = 0;
         }
         go.addFilter(_loc5_);
      }
      
      public function dampenInterpolateIn(param1:int, param2:Number, param3:Number, param4:int = 0) : void
      {
         var _loc5_:GameObjectFilterDampenInterpolateIn = new GameObjectFilterDampenInterpolateIn();
         _loc5_.Delay = param4;
         _loc5_.FadeTime = param1;
         _loc5_.dx = param2;
         _loc5_.dy = param3;
         go.addFilter(_loc5_);
      }
      
      public function addRepeats(param1:Array = null) : void
      {
         var _loc2_:GameObjectFilterRepeats = new GameObjectFilterRepeats();
         _loc2_.imageSets = param1;
         go.addFilter(_loc2_);
      }
      
      public function rotationAligned() : Boolean
      {
         var _loc1_:GameObjectFilter = null;
         for each(_loc1_ in go.filters)
         {
            if(_loc1_ is GameObjectFilterRotateSlowly)
            {
               if(Interpolation.distanceToAngle(GameObjectFilterRotateSlowly(_loc1_).internalRotation,go.baseRotation) < 1)
               {
                  return true;
               }
               return false;
            }
         }
         return true;
      }
   }
}

