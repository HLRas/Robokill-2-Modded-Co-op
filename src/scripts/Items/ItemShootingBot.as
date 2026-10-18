package Items
{
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   import Objects.ShootingBot;
   import Weapons.ItemActive;
   
   public class ItemShootingBot extends ItemActive
   {
      
      public function ItemShootingBot()
      {
         super();
      }
      
      override public function priceLow() : int
      {
         return 250;
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc2_:ShootingBot = new ShootingBot(null,param1.basex,param1.basey);
         _loc2_.basex += _loc2_.spawnX();
         _loc2_.basey += _loc2_.spawnY();
         _loc2_.damage = attribute;
         param1.emitConditionalParticles("Teleport",_loc2_.spawnX(),_loc2_.spawnY());
         trace("USING!");
         rechargeProgress = 0;
      }
      
      override public function attributeCost() : int
      {
         return 60;
      }
      
      override public function priceHigh() : int
      {
         return 5000;
      }
      
      override public function minimumEpisode() : int
      {
         return 3;
      }
      
      override public function units() : String
      {
         return "DAMAGE:";
      }
      
      override public function name() : String
      {
         return "ATTACK DROID";
      }
      
      override public function description2() : String
      {
         return "LIMITED FIREFIGHT ASSISTANCE";
      }
      
      override public function attributeLow() : int
      {
         return 1;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_shootingbot_png;
      }
      
      public function ItemRecharge() : *
      {
      }
      
      override public function description() : String
      {
         return "INDEPENDENT AI DROID OFFERS";
      }
      
      override public function attributeHigh() : int
      {
         return 10;
      }
   }
}

