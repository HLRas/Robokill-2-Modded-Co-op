package GameObject
{
   import Tools.Interpolation;
   
   public class GameObjectFilterFadeInOut extends GameObjectFilter
   {
      
      public var FadeIn:int = 0;
      
      public var FadeOutDuration:Number = 0;
      
      public var FadeInBlur:int = 0;
      
      public var FadeInDelay:Number = 0;
      
      public var FadeOut:int = 0;
      
      public var FadeInDuration:Number = 0;
      
      public var FadeOutKill:int = 1;
      
      public var FadeOutBlur:int = 0;
      
      public var FadeOutTime:Number = 0;
      
      public function GameObjectFilterFadeInOut()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Array = null;
         ticks += 1;
         var _loc2_:Number = 1;
         var _loc3_:Number = 1;
         var _loc4_:Number = 1;
         if(FadeIn)
         {
            _loc3_ = Interpolation.linearInterpolateLock(0,1,Interpolation.fromTo(ticks,FadeInDelay,FadeInDelay + FadeInDuration));
         }
         if(FadeOut)
         {
            _loc4_ = Interpolation.linearInterpolateLock(1,0,Interpolation.fromTo(ticks,FadeOutTime,FadeOutTime + FadeOutDuration));
         }
         _loc2_ = _loc3_ * _loc4_;
         param1.pushAlpha(_loc2_);
         if(Boolean(FadeInBlur) || Boolean(FadeOutBlur))
         {
            _loc5_ = (1 - _loc3_) * FadeInBlur + (1 - _loc4_) * FadeOutBlur;
            _loc6_ = param1.obj.filters;
            param1.obj.filters = _loc6_;
         }
         if(Boolean(FadeOut) && Boolean(FadeOutKill))
         {
            if(ticks > FadeOutTime + FadeOutDuration)
            {
               param1._toRemove = true;
            }
         }
      }
   }
}

