package GameObject
{
   import Tools.Interpolation;
   
   public class GameObjectFilterSqrtInterpolateIn extends GameObjectFilter
   {
      
      public var useSquareSquare:Boolean = false;
      
      public var useSquare:Boolean = false;
      
      public var FadeTime:int;
      
      public var removeFilterWhenDoneReposition:Boolean = true;
      
      public var dy:Number = 0;
      
      public var killFunction:Function;
      
      public var useAlpha:Boolean = false;
      
      public var removeFilterWhenDone:Boolean = false;
      
      public var killWhenDone:Boolean = false;
      
      public var dx:Number = 0;
      
      public var Delay:int;
      
      public function GameObjectFilterSqrtInterpolateIn()
      {
         super();
      }
      
      override public function removeWhenDone() : void
      {
         killWhenDone = true;
      }
      
      override public function update(param1:GameObject) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         ticks += 1;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         if(useAlpha)
         {
            _loc4_ = 0;
            _loc5_ = 1;
            if(useSquare)
            {
               _loc4_ = 1;
               _loc5_ = 0;
            }
            param1.modifiedAlpha *= Interpolation.squareInterpolateLock(_loc4_,_loc5_,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
         }
         else if(useSquareSquare)
         {
            _loc6_ = 0;
            _loc7_ = dx;
            _loc8_ = 0;
            _loc9_ = dy;
            if(useSquare)
            {
               _loc6_ = dx;
               _loc8_ = dy;
               _loc7_ = 0;
               _loc9_ = 0;
            }
            _loc2_ = Interpolation.squareSquareInterpolateLock(_loc6_,_loc7_,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
            _loc3_ = Interpolation.squareSquareInterpolateLock(_loc8_,_loc9_,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
         }
         else if(useSquare)
         {
            _loc2_ = Interpolation.squareInterpolateLock(0,dx,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
            _loc3_ = Interpolation.squareInterpolateLock(0,dy,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
         }
         else
         {
            _loc2_ = Interpolation.sqrtInterpolateLock(dx,0,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
            _loc3_ = Interpolation.sqrtInterpolateLock(dy,0,Interpolation.fromTo(ticks,Delay,Delay + FadeTime));
         }
         param1.modifiedx += _loc2_;
         param1.modifiedy += _loc3_;
         if(ticks > Delay + FadeTime)
         {
            if(killWhenDone)
            {
               if(Boolean(killFunction))
               {
                  killFunction(param1);
               }
               param1.remove();
            }
            if(removeFilterWhenDone)
            {
               if(removeFilterWhenDoneReposition)
               {
                  param1.basex += dx;
                  param1.basey += dy;
               }
               removeFilter = true;
            }
         }
      }
      
      public function done() : Boolean
      {
         return ticks > Delay + FadeTime;
      }
      
      override public function reverse() : void
      {
         useSquare = !useSquare;
         ticks = 0;
      }
      
      public function progress() : Number
      {
         var _loc1_:Number = Interpolation.lockValue(Interpolation.fromTo(ticks,Delay,Delay + FadeTime),0,1);
         if(useSquare)
         {
            return 1 - _loc1_;
         }
         return _loc1_;
      }
   }
}

