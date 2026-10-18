package GlobalSetup
{
   import GameScene.GameScene;
   
   public class ZOrder
   {
      
      public function ZOrder()
      {
         super();
      }
      
      public function SetupZOrder(param1:GameScene) : void
      {
         param1.addZOrder("");
         param1.addZOrder("Background");
         param1.addZOrder("BelowFloor");
         param1.addZOrder("Floor");
         param1.addZOrder("BelowPlayer");
         param1.addZOrder("Player");
         param1.addZOrder("PlayerHead");
         param1.addZOrder("AbovePlayer");
         param1.addZOrder("AfterAbovePlayer");
         param1.addZOrder("BeforeTextLayer");
         param1.addZOrder("TextLayer");
         param1.addZOrder("AfterTextLayer");
         param1.addZOrder("AfterAfterTextLayer");
      }
   }
}

