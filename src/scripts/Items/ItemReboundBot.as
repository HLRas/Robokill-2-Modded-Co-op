package Items
{
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   import Objects.ReboundBot;
   import Weapons.ItemActive;
   
   public class ItemReboundBot extends ItemActive
   {
      
      public function ItemReboundBot()
      {
         super();
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc2_:ReboundBot = new ReboundBot(null,param1.basex,param1.basey);
         _loc2_.basex += _loc2_.spawnX();
         _loc2_.basey += _loc2_.spawnY();
         param1.emitConditionalParticles("Teleport",_loc2_.spawnX(),_loc2_.spawnY());
         rechargeProgress = 0;
      }
      
      override public function attributeCost() : int
      {
         return 60;
      }
      
      override public function priceHigh() : int
      {
         return 6000;
      }
      
      override public function minimumEpisode() : int
      {
         return 7;
      }
      
      override public function units() : String
      {
         return "RECHARGE TIME:";
      }
      
      override public function name() : String
      {
         return "PULSE DROID";
      }
      
      override public function description2() : String
      {
         return "A SONIC PULSE WHEN IN RANGE.";
      }
      
      override public function attributeLow() : int
      {
         return 30;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_reboundbot_png;
      }
      
      override public function priceLow() : int
      {
         return 750;
      }
      
      override public function description() : String
      {
         return "HOMES IN ON ENEMIES AND EMITS";
      }
      
      override public function attributeHigh() : int
      {
         return 20;
      }
   }
}

