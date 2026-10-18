package GameObject
{
   import Tools.Interpolation;
   
   public class GameObjectFilterShake extends GameObjectFilter
   {
      
      public var lastX:Number = 0;
      
      public var lastY:Number = 0;
      
      public var nextX:Number = 0;
      
      public var timeLow:Number = 1;
      
      public var nextY:Number = 0;
      
      public var timeHigh:Number = 5;
      
      public var extent:Number = 0;
      
      public var mag:Number = 5;
      
      public var t:Number = 1;
      
      public function GameObjectFilterShake()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         t += 1;
         if(t > extent)
         {
            lastX = nextX;
            lastY = nextY;
            nextX = (Math.random() - 0.5) * 2;
            nextY = (Math.random() - 0.5) * 2;
            t = 0;
            extent = timeLow + Math.random() * (timeHigh - timeLow);
         }
         param1.modifiedx += mag * Interpolation.linearInterpolate(lastX,nextX,t / extent);
         param1.modifiedy += mag * Interpolation.linearInterpolate(lastY,nextY,t / extent);
      }
   }
}

