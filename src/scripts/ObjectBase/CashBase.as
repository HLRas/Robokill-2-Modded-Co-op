package ObjectBase
{
   import GameScene.GameScene;
   import Scenes.MainScene;
   import Tools.Random;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class CashBase extends PickupBase
   {
      
      public var CashMedium:BitmapData;
      
      public var CashSmall:BitmapData;
      
      public var amount:int = 0;
      
      public var CashHeavy:BitmapData;
      
      public function CashBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         var _loc6_:int = MainScene(param1).currentEpisode;
         amount = Random.randInt(20 + 10 * _loc6_,60 + 40 * _loc6_) * MainScene(param1).player.cashMult();
      }
      
      override public function playSound() : void
      {
         Sounds.pickup.play();
      }
      
      override public function pickupName() : String
      {
         return "$" + amount;
      }
      
      override public function _update() : void
      {
         super._update();
         setAmount();
      }
      
      override public function _init() : void
      {
         setAmount();
      }
      
      override public function serializeFields() : Array
      {
         return ["basex","basey","amount"];
      }
      
      public function setAmount() : void
      {
         if(amount < 250)
         {
            Bitmap(obj).bitmapData = CashSmall;
         }
         else if(amount < 750)
         {
            Bitmap(obj).bitmapData = CashMedium;
         }
         else
         {
            Bitmap(obj).bitmapData = CashHeavy;
         }
      }
      
      override public function pickup() : Boolean
      {
         MainScene(gs).player.money = MainScene(gs).player.money + amount;
         return true;
      }
   }
}

