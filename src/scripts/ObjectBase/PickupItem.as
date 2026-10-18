package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.PickupText;
   import Scenes.MainScene;
   import Weapons.ItemBase;
   import Weapons.WeaponGenerator;
   
   public class PickupItem extends PickupBase
   {
      
      public var created:int = -1000;
      
      public var glow:GameObject;
      
      public var graphicsSet:Boolean = false;
      
      public var item:ItemBase = WeaponGenerator.generateItem();
      
      public function PickupItem(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Embeds.item_png,"Floor",param2,param3);
      }
      
      override public function pickupName() : String
      {
         return item.name();
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
         super._update();
      }
      
      override public function serializeFields() : Array
      {
         return ["basex","basey","wep"];
      }
      
      override public function playSound() : void
      {
         Sounds.pickupItem.play();
      }
      
      override public function pickup() : Boolean
      {
         MainScene(gs).player.addToInventory(item);
         return true;
      }
   }
}

