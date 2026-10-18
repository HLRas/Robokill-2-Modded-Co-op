package Objects
{
   import GameScene.GameScene;
   import ObjectBase.PickupBase;
   import ObjectConstructors.TimeRechargePickup_constructor;
   import Tools.Random;
   import Weapons.ItemBase;
   import flash.display.Bitmap;
   
   public class TimeRechargePickup extends PickupBase
   {
      
      public var randomSet:Array;
      
      public function TimeRechargePickup(param1:GameScene, param2:int, param3:int)
      {
         super(param1,TimeRechargePickup_constructor.baseim_embed,TimeRechargePickup_constructor.LayerName,param2,param3);
         TimeRechargePickup_constructor.setup(param1,this);
         Bitmap(obj).bitmapData = randomSet[Random.randInt(0,randomSet.length - 1)];
      }
      
      override public function pickupName() : String
      {
         return "RECHARGE";
      }
      
      override public function pickup() : Boolean
      {
         var _loc2_:ItemBase = null;
         var _loc1_:int = 0;
         while(_loc1_ < ms.player.items.length)
         {
            if(ms.player.items[_loc1_])
            {
               _loc2_ = ms.player.items[_loc1_];
               _loc2_.rechargeProgress += _loc2_.rechargeSpeed() * 500;
            }
            _loc1_++;
         }
         Sounds.shieldPickup.play();
         return true;
      }
   }
}

