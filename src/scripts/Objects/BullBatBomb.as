package Objects
{
   import GameScene.GameScene;
   
   public class BullBatBomb extends BullBat
   {
      
      public function BullBatBomb(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         hasBomb = true;
      }
      
      override public function _experience() : int
      {
         return 250;
      }
   }
}

