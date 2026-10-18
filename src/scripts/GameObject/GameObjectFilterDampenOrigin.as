package GameObject
{
   public class GameObjectFilterDampenOrigin extends GameObjectFilter
   {
      
      public var StickToBottom:int = 0;
      
      public var StickToTop:int = 0;
      
      public var factor:Number = 0;
      
      public function GameObjectFilterDampenOrigin()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         param1.dampenOrigin = factor;
         param1.dampenOriginStickToBottom = StickToBottom;
         param1.dampenOriginStickToTop = StickToTop;
      }
   }
}

