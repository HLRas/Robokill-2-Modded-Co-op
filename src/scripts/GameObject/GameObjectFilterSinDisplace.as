package GameObject
{
   public class GameObjectFilterSinDisplace extends GameObjectFilter
   {
      
      public var speed:Number = 1;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function GameObjectFilterSinDisplace()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         ++ticks;
         param1.modifiedx += x * param1.sind(speed * Number(ticks) * 3.6);
         param1.modifiedy += y * param1.sind(speed * Number(ticks) * 3.6);
      }
   }
}

