package ObjectBase
{
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.*;
   import InventoryScreen.HUDDisplay;
   import InventoryScreen.Inventory;
   import Objects.PickupText;
   import Scenes.*;
   import Weapons.WeaponBase;
   import Weapons.WeaponGenerator;
   import flash.display.Bitmap;
   
   public class PickupWeapon extends PickupBase
   {
      
      public var wep:WeaponBase;
      
      public var created:int = -1000;
      
      public var glow:GameObject;
      
      public var graphicsSet:Boolean = false;
      
      public function PickupWeapon(param1:GameScene, param2:int, param3:int)
      {
         wep = WeaponGenerator.generateWeapon(40,MainScene(param1).player.level);
         super(param1,wep.pickupImage(),"Floor",param2,param3);
      }
      
      override public function pickupName() : String
      {
         return wep.name();
      }
      
      override public function handlePlayerCollision() : void
      {
         if(MainScene(gs).player.inventoryFull())
         {
            if(ticks - created > 150)
            {
               new PickupText(gs,basex,basey - 28,"INVENTORY FULL!");
               created = ticks;
            }
            return;
         }
         super.handlePlayerCollision();
      }
      
      override public function _update() : void
      {
         if(!graphicsSet)
         {
            graphicsSet = true;
            Bitmap(obj).bitmapData = new (wep.pickupImage())().bitmapData;
            if(wep.properPluginCount() == 1)
            {
               glow = new GameObject(gs,Embeds.uncommon_glow_png,"Floor",0,0);
            }
            else if(wep.properPluginCount() > 1)
            {
               glow = new GameObject(gs,Embeds.rare_glow_png,"Floor",0,0);
            }
            if(glow)
            {
               glow.additive = true;
               glow.basex -= 7;
               glow.basey -= 7;
               addChild(glow);
            }
         }
         super._update();
      }
      
      override public function serializeFields() : Array
      {
         return ["basex","basey","wep"];
      }
      
      override public function playSound() : void
      {
         Sounds.pickupWeapon.play();
      }
      
      override public function pickup() : Boolean
      {
         MainScene(gs).player.addToInventory(wep);
         if(pickMeUp)
         {
            HUDDisplay.open(gs,Inventory);
         }
         return true;
      }
   }
}

