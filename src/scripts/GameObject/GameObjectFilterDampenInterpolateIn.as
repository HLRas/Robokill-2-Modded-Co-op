package GameObject
{
   import Tools.Interpolation;
   
   public class GameObjectFilterDampenInterpolateIn extends GameObjectFilter
   {
      
      public var Delay:int;
      
      public var dx:Number = 0;
      
      public var dy:Number = 0;
      
      public var FadeTime:int;
      
      public function GameObjectFilterDampenInterpolateIn()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         ticks += 1;
         var _loc2_:Number = Interpolation.dampenInterpolateLock(dx,0,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
         var _loc3_:Number = Interpolation.dampenInterpolateLock(dy,0,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
         param1.modifiedx += _loc2_;
         param1.modifiedy += _loc3_;
      }
   }
}

