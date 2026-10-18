package GameScene
{
   import Tools.Interpolation;
   
   public class GameSceneCamera
   {
      
      public var totalTicks:Number = 300;
      
      public var linear:Boolean = false;
      
      public var minX:Number = -9999999;
      
      public var minY:Number = -9999999;
      
      public var maxX:Number = 9999999;
      
      public var maxY:Number = 9999999;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var furtherestRight:Number = 0;
      
      public var frameChange:Number = 1;
      
      public function GameSceneCamera()
      {
         super();
      }
      
      public function position(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
         if(this.x > maxX)
         {
            this.x = maxX;
         }
         if(this.x < minX)
         {
            this.x = minX;
         }
         if(this.y > maxY)
         {
            this.y = maxY;
         }
         if(this.y < minY)
         {
            this.y = minY;
         }
      }
      
      public function interpolateWithWidth(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Number = param1 * 0.7 + param3 * 0.3;
         if(_loc6_ < param3 - param5 / 2 + 128)
         {
            _loc6_ = param3 - param5 / 2 + 128;
         }
         if(_loc6_ > furtherestRight)
         {
            furtherestRight = _loc6_;
         }
         position(_loc6_,(param2 + param4) / 2);
      }
      
      public function positionInterpolate(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         if(param5 > 1200)
         {
            param3 = Interpolation.tendTowardsSmoothed(param3,param1,param5 - 1200);
         }
         var _loc6_:Number = param1 * 0.7 + param3 * 0.3;
         position(_loc6_,(param2 + param4) / 2);
      }
   }
}

