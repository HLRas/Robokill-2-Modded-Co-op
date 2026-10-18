package GameObject
{
   public class GameObjectFilterHeight extends GameObjectFilter
   {
      
      public var height:Number = 0;
      
      public function GameObjectFilterHeight(param1:Number = 0)
      {
         super();
         height = param1;
      }
      
      override public function update(param1:GameObject) : void
      {
         param1.modifiedx -= height;
         param1.modifiedy -= height;
      }
   }
}

