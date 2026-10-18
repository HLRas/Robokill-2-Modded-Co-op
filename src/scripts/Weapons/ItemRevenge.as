package Weapons
{
   import GlobalSetup.Embeds;
   
   public class ItemRevenge extends ItemPassive
   {
      
      public function ItemRevenge()
      {
         super();
      }
      
      override public function passive() : Boolean
      {
         return true;
      }
      
      override public function attributeCost() : int
      {
         return 4;
      }
      
      override public function priceHigh() : int
      {
         return 640;
      }
      
      override public function minimumEpisode() : int
      {
         return 2;
      }
      
      override public function units() : String
      {
         return "DAMAGE:";
      }
      
      override public function name() : String
      {
         return "REVENGE DETONATOR";
      }
      
      override public function description2() : String
      {
         return "DESTROYING NEARBY ENEMIES.";
      }
      
      override public function attributeLow() : int
      {
         return 15;
      }
      
      override public function icon() : Class
      {
         return Embeds.itemrevenge_png;
      }
      
      override public function priceLow() : int
      {
         return 60;
      }
      
      override public function description() : String
      {
         return "DETONATES IF YOUR HEALTH IS LOW, ";
      }
      
      override public function attributeHigh() : int
      {
         return 160;
      }
   }
}

