package GameObject
{
   public class GameObjectFilterStayOnScreen extends GameObjectFilter
   {
      
      public var overridedx:Number = 0;
      
      public var multiplier:int = 0;
      
      public function GameObjectFilterStayOnScreen()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         var _loc2_:Number = 0;
         if(multiplier == 0)
         {
            _loc2_ = 880 + param1.baseWidth * param1.modifiedScaleX;
         }
         else
         {
            _loc2_ = multiplier * param1.baseWidth * param1.modifiedScaleX;
         }
         if(overridedx > 10)
         {
            _loc2_ = overridedx;
         }
         while(param1.modifiedx - param1.gs.camX * param1.dampenOrigin + param1.baseWidth * param1.modifiedScaleX / 2 < 0)
         {
            param1.modifiedx += _loc2_;
         }
         while(param1.modifiedx - param1.gs.camX * param1.dampenOrigin - param1.baseWidth * param1.modifiedScaleX / 2 > 800)
         {
            param1.modifiedx -= _loc2_;
         }
      }
   }
}

