package Weapons
{
   import GlobalSetup.Embeds;
   
   public class ItemMoreGold extends ItemPassive
   {
      
      public function ItemMoreGold()
      {
         super();
      }
      
      override public function modifyAttribute(param1:String) : String
      {
         return param1 + "%";
      }
      
      override public function passive() : Boolean
      {
         return true;
      }
      
      override public function attributeCost() : int
      {
         return 50;
      }
      
      override public function priceHigh() : int
      {
         return 1600;
      }
      
      override public function minimumEpisode() : int
      {
         return 3;
      }
      
      override public function units() : String
      {
         return "EXTRA CASH: ";
      }
      
      override public function name() : String
      {
         return "CASH SENSOR";
      }
      
      override public function description2() : String
      {
         return "DROPS.";
      }
      
      override public function attributeLow() : int
      {
         return 4;
      }
      
      override public function icon() : Class
      {
         return Embeds.itemmoregold_png;
      }
      
      override public function priceLow() : int
      {
         return 200;
      }
      
      override public function description() : String
      {
         return "INCREASES THE SIZE OF ENEMY CASH";
      }
      
      override public function attributeHigh() : int
      {
         return 32;
      }
   }
}

