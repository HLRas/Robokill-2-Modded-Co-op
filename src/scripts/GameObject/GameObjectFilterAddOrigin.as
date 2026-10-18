package GameObject
{
   public class GameObjectFilterAddOrigin extends GameObjectFilter
   {
      
      public var dx:Number = 0;
      
      public var dy:Number = 0;
      
      public function GameObjectFilterAddOrigin()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         param1.modifiedx += dx;
         param1.modifiedy += dy;
      }
   }
}

