package GameObject
{
   public class GameObjectFilterTrigger extends GameObjectFilter
   {
      
      public var cause:Function;
      
      public var result:Function;
      
      public function GameObjectFilterTrigger()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         if(cause())
         {
            removeFilter = true;
            result();
         }
      }
   }
}

