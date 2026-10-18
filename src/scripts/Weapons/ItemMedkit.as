package Weapons
{
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   
   public class ItemMedkit extends ItemPassive
   {
      
      public function ItemMedkit()
      {
         super();
      }
      
      override public function plural() : Boolean
      {
         return true;
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         param1.shields += attribute / param1.getShieldsForLevel();
         if(param1.shields > 1)
         {
            param1.shields = 1;
         }
         param1.medKitParticles();
      }
      
      override public function passive() : Boolean
      {
         return true;
      }
      
      override public function attributeCost() : int
      {
         return 2;
      }
      
      override public function priceHigh() : int
      {
         return 960;
      }
      
      override public function units() : String
      {
         return "SHIELD BOOST:";
      }
      
      override public function name() : String
      {
         return "EMERGENCY REPAIR";
      }
      
      override public function description2() : String
      {
         return "ARE LOW. ONE USE ONLY.";
      }
      
      override public function attributeLow() : int
      {
         return 20;
      }
      
      override public function icon() : Class
      {
         return Embeds.itemmedkit_png;
      }
      
      override public function priceLow() : int
      {
         return 40;
      }
      
      override public function description() : String
      {
         return "GIVES A BOOST WHEN YOUR SHIELDS";
      }
      
      override public function attributeHigh() : int
      {
         return 480;
      }
   }
}

