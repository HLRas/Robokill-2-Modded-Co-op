package Weapons
{
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   
   public class ItemRecharge extends ItemPassive
   {
      
      public function ItemRecharge()
      {
         super();
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         param1.shields += attribute / param1.getShieldsForLevel();
         if(param1.shields > 1)
         {
            param1.shields = 1;
         }
         param1.medKitParticles();
         lastUsed = param1.ticks;
      }
      
      override public function passive() : Boolean
      {
         return true;
      }
      
      override public function attributeCost() : int
      {
         return 60;
      }
      
      override public function priceHigh() : int
      {
         return 5760;
      }
      
      override public function units() : String
      {
         return "BOOST:";
      }
      
      override public function name() : String
      {
         return "SHIELD CHARGER";
      }
      
      override public function description2() : String
      {
         return "EACH ROOM. REUSABLE.";
      }
      
      override public function attributeLow() : int
      {
         return 10;
      }
      
      override public function icon() : Class
      {
         return Embeds.itemrecharge_png;
      }
      
      override public function priceLow() : int
      {
         return 600;
      }
      
      override public function description() : String
      {
         return "BOOSTS YOUR SHIELDS AFTER YOU CLEAR";
      }
      
      override public function attributeHigh() : int
      {
         return 96;
      }
   }
}

