package Items
{
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   import Weapons.ItemActive;
   
   public class ItemActiveShield extends ItemActive
   {
      
      public function ItemActiveShield()
      {
         super();
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         param1._inShield = 300;
         rechargeProgress = 0;
      }
      
      override public function attributeCost() : int
      {
         return 60;
      }
      
      override public function priceLow() : int
      {
         return 600;
      }
      
      override public function minimumEpisode() : int
      {
         return 0;
      }
      
      override public function units() : String
      {
         return "RECHARGE TIME:";
      }
      
      override public function name() : String
      {
         return "ACTIVE SHIELD";
      }
      
      override public function description2() : String
      {
         return "SHORT BATTERY LIFE.";
      }
      
      override public function attributeLow() : int
      {
         return 30;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_activeshield_png;
      }
      
      override public function priceHigh() : int
      {
         return 10000;
      }
      
      override public function description() : String
      {
         return "STRONG DEFENSIVE SHIELD.";
      }
      
      override public function attributeHigh() : int
      {
         return 18;
      }
   }
}

