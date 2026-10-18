package GameObject
{
   public class GameObjectFilterMoveWith extends GameObjectFilter
   {
      
      public var other:GameObject;
      
      public var dx:Number;
      
      public var dy:Number;
      
      public var setup:Boolean = false;
      
      public function GameObjectFilterMoveWith()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         ++ticks;
         if(!setup)
         {
            setup = true;
            dx = param1.basex - other.basex;
            dy = param1.basey - other.basey;
         }
         param1.basex = other.basex + dx;
         param1.basey = other.basey + dy;
         if(other._removed)
         {
            removeFilter = true;
         }
      }
   }
}

