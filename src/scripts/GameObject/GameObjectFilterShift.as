package GameObject
{
   public class GameObjectFilterShift extends GameObjectFilter
   {
      
      public var timeout:int = -1;
      
      public var dx:Number = 0;
      
      public var dy:Number = 0;
      
      public function GameObjectFilterShift()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         ++ticks;
         param1.basex += dx;
         param1.basey += dy;
         if(ticks > timeout && timeout != -1)
         {
            removeFilter = true;
         }
      }
   }
}

