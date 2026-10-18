package GameObject
{
   import Tools.Random;
   
   public class GameObjectFilterPulse extends GameObjectFilter
   {
      
      public var alpha:Number = 1;
      
      public var Speed:Number = 1;
      
      public function GameObjectFilterPulse()
      {
         super();
         ticks = Random.randInt(0,100);
      }
      
      override public function update(param1:GameObject) : void
      {
         ++ticks;
         param1.modifiedAlpha *= alpha * (1 + param1.sind(ticks * 2 * Speed)) / 2;
      }
   }
}

