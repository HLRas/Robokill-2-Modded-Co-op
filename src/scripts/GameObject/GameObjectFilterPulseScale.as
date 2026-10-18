package GameObject
{
   import Tools.Random;
   
   public class GameObjectFilterPulseScale extends GameObjectFilter
   {
      
      public var randTicks:int = 0;
      
      public var Speed:Number = 1;
      
      public var killAfterOne:Boolean = false;
      
      public var done:Boolean = false;
      
      public var scale:Number = 0.2;
      
      public function GameObjectFilterPulseScale()
      {
         super();
         randTicks = Random.randInt(0,100);
      }
      
      override public function update(param1:GameObject) : void
      {
         ++ticks;
         if(!killAfterOne)
         {
            ticks += randTicks;
            ticks = 0;
         }
         var _loc2_:Number = 1 + param1.sind(ticks * 2 * Speed) * scale;
         param1.modifiedScaleX *= _loc2_;
         param1.modifiedScaleY *= _loc2_;
         if(killAfterOne)
         {
            if(ticks * 2 * Speed > 160)
            {
               ticks = 80 / Speed;
               done = true;
            }
         }
      }
   }
}

