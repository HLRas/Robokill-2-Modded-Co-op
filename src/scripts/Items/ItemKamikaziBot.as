package Items
{
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   import Objects.KamikazeBot;
   import Weapons.ItemActive;
   
   public class ItemKamikaziBot extends ItemActive
   {
      
      public function ItemKamikaziBot()
      {
         super();
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc2_:KamikazeBot = new KamikazeBot(null,param1.basex,param1.basey);
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
         return 3000;
      }
      
      override public function minimumEpisode() : int
      {
         return 5;
      }
      
      override public function units() : String
      {
         return "DAMAGE:";
      }
      
      override public function name() : String
      {
         return "SEEKER DROID";
      }
      
      override public function description2() : String
      {
         return "A STRONG ENEMY AND REMOVES IT.";
      }
      
      override public function attributeLow() : int
      {
         return 30;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_kamikazebot_png;
      }
      
      override public function priceLow() : int
      {
         return 250;
      }
      
      override public function description() : String
      {
         return "AGGRESSIVE AI DROID CHOOSES";
      }
      
      override public function attributeHigh() : int
      {
         return 15;
      }
   }
}

