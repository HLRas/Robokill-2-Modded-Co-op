package Weapons
{
   import Items.ItemKamikaziBot;
   import Items.ItemMinelayer;
   import Items.ItemShootingBot;
   import Scenes.MainScene;
   
   public class ItemActive extends ItemBase
   {
      
      public function ItemActive()
      {
         super();
      }
      
      override public function update(param1:MainScene) : void
      {
         super.update(param1);
         if(!(this is ItemMinelayer || this is ItemKamikaziBot || this is ItemShootingBot))
         {
            rechargeTime = attribute * 100;
         }
      }
   }
}

