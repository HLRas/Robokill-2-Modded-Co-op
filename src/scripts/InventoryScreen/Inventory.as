package InventoryScreen
{
   import Audio.GameSound;
   import GameConfig.GameConfig;
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.*;
   import Layout.*;
   import ObjectBase.AlienBase;
   import Objects.Robot;
   import Scenes.*;
   import Tools.HumanReadable;
   import Tools.Interpolation;
   import Weapons.InventoryItem;
   import Weapons.ItemActive;
   import Weapons.ItemPassive;
   import Weapons.WeaponBase;
   import flash.display.*;
   
   public class Inventory extends HUDDisplay
   {
      
      public static var descriptionContainer:GameObject;
      
      public static var descriptionText:Array;
      
      public static var playerIm:GameObject;
      
      public static var finished:Layout;
      
      public static var itemIm:GameObject;
      
      public static var inventoryOpenedCount:int = 0;
      
      public var invTextAlpha:Number = 0;
      
      public var playerInventoryLayout:Array;
      
      public var currentText:Layout;
      
      public var shopkeeperAlien:AlienBase;
      
      public var rightSideLayout:Layout;
      
      public var speakOn:Boolean = true;
      
      public var inventoryLayout:Layout;
      
      public var currentItem:InventoryItem;
      
      public var playerInventory:Array;
      
      public function Inventory(param1:GameScene)
      {
         super(param1,Embeds.inventory_png,"TextLayer",400,300);
         basey += 44;
         ++inventoryOpenedCount;
      }
      
      override public function _kill() : void
      {
         var _loc1_:GameObject = null;
         killText();
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is InventorySlot)
            {
               LayerFilter.reverse(InventorySlot(_loc1_).item);
            }
         }
         LayerFilter.reverse(finished);
      }
      
      public function doPassiveInActive() : void
      {
         setShopkeeperText("THIS IS AN ITEM TYPE A SLOT - YOU CANNOT PLACE AN ITEM TYPE B HERE.");
      }
      
      public function makeCharacterStats() : Layout
      {
         var _loc6_:int = 0;
         var _loc1_:GameObject = new GameObject(gs,Embeds.character_stats_png,"TextLayer",0,0);
         _loc1_.updateDespitePaused = true;
         var _loc2_:Array = LayoutTools.fillWithText(_loc1_,2,6,16,24,8,24,-2);
         var _loc3_:Array = [["NAME:",MainScene(gs).player.name],["",""],["EXP LEVEL: ",MainScene(gs).player.level + 1],["MAX SHIELDS: ",HumanReadable.formatInteger(MainScene(gs).player.getShieldsForLevel())],["DAMAGE: ",HumanReadable.truncateFloat(MainScene(gs).player.getDamageForLevel()) + "x"],["TOTAL KILLS: ",HumanReadable.formatInteger(MainScene(gs).player.totalKills)]];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc2_[_loc4_].length)
            {
               _loc2_[_loc4_][_loc6_].setText(_loc3_[_loc4_][_loc6_],16);
               _loc2_[_loc4_][_loc6_].updateDespitePaused = true;
               _loc6_++;
            }
            _loc4_++;
         }
         return gs.horiz([_loc1_],0);
      }
      
      public function doWeaponInItem() : void
      {
         setShopkeeperText("THIS IS AN ITEM SLOT - YOU CANNOT PLACE A WEAPON HERE. ");
      }
      
      public function doActiveInPassive() : void
      {
         setShopkeeperText("THIS IS AN ITEM TYPE B SLOT - YOU CANNOT PLACE AN ITEM TYPE A HERE.");
      }
      
      public function speak(param1:int) : void
      {
      }
      
      public function getPlayerInventory() : Layout
      {
         playerInventory = new Array();
         inventoryLayout = createSlots(playerInventory,4,7);
         bindInventory(playerInventory,MainScene(gs).player.inventory,Object);
         var _loc1_:GameObject = new GameObject(gs,Embeds.inventory_text_png,"TextLayer",0,0);
         _loc1_.updateDespitePaused = true;
         return gs.vert([_loc1_,inventoryLayout],0);
      }
      
      public function makeQuadInventory(param1:Class, param2:Array, param3:Class) : Layout
      {
         var _loc9_:InventorySlot = null;
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < 4)
         {
            _loc9_ = new InventorySlot(gs,0,0);
            _loc9_.placeSound = Sounds.invPlace;
            _loc4_.push(_loc9_);
            _loc5_++;
         }
         var _loc6_:GameObject = new GameObject(gs,param1,"TextLayer",0,0);
         _loc6_.updateDespitePaused = true;
         if(param1 == Embeds.weapon_slot_png)
         {
            playerIm = _loc6_;
         }
         else
         {
            itemIm = _loc6_;
         }
         var _loc7_:Layout = gs.vert(_loc4_,3);
         var _loc8_:Layout = Layout.Horiz([_loc6_,_loc7_],1);
         bindInventory(_loc4_,param2,param3);
         return _loc8_;
      }
      
      public function createSlots(param1:Array, param2:int, param3:int, param4:GameSound = null) : Layout
      {
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:InventorySlot = null;
         if(!param4)
         {
            param4 = Sounds.invPickup;
         }
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < param2)
         {
            _loc7_ = new Array();
            _loc8_ = 0;
            while(_loc8_ < param3)
            {
               _loc9_ = new InventorySlot(gs,0,0);
               _loc9_.placeSound = param4;
               _loc7_.push(_loc9_);
               param1.push(_loc9_);
               _loc8_++;
            }
            _loc5_.push(Layout.Horiz(_loc7_,2));
            _loc6_++;
         }
         return gs.vert(_loc5_,0);
      }
      
      public function getDescriptionContainer(param1:Boolean = false) : GameObject
      {
         var _loc4_:int = 0;
         var _loc2_:Class = Embeds.item_descript_png;
         if(param1)
         {
            _loc2_ = Embeds.item_description_small_png;
         }
         descriptionContainer = new GameObject(gs,_loc2_,"TextLayer",0,0);
         descriptionContainer.updateDespitePaused = true;
         if(param1)
         {
            descriptionText = LayoutTools.fillWithText(descriptionContainer,2,7,16,24,8,24,4);
         }
         else
         {
            descriptionText = LayoutTools.fillWithText(descriptionContainer,2,7,16,24,8,24,0);
         }
         var _loc3_:int = 0;
         while(_loc3_ < descriptionText.length)
         {
            _loc4_ = 0;
            while(_loc4_ < descriptionText[_loc3_].length)
            {
               descriptionText[_loc3_][_loc4_].setText("YES",16);
               descriptionText[_loc3_][_loc4_].updateDespitePaused = true;
               _loc4_++;
            }
            _loc3_++;
         }
         return descriptionContainer;
      }
      
      public function bindInventory(param1:Array, param2:Array, param3:Class, param4:Boolean = false, param5:int = 0) : void
      {
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            if(_loc6_ < param2.length)
            {
               param1[_loc6_].associateWith(param2[_loc6_ + param5],param3);
               param1[_loc6_].arr = param2;
               param1[_loc6_].index = _loc6_ + param5;
               param1[_loc6_].isShop = param4;
            }
            _loc6_++;
         }
      }
      
      public function finishTalking() : void
      {
         shopkeeperAlien.isTalking = false;
      }
      
      public function doNoEquip() : void
      {
         setShopkeeperText("YOU NEED TO LEVEL UP BEFORE YOU CAN USE THIS ITEM.");
         speak(3);
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:InventorySlot = null;
         super._update();
         var _loc1_:Boolean = false;
         if(currentText)
         {
            LayerFilter.setLayerOrigin(currentText,544 - 50,222 - 23);
         }
         if(!helper.anySlideFilters())
         {
            for each(_loc2_ in gs.objects)
            {
               if(_loc2_.mOverModified())
               {
                  if(_loc2_ is InventorySlot)
                  {
                     _loc3_ = InventorySlot(_loc2_);
                     if(_loc3_.arr[_loc3_.index])
                     {
                        _loc1_ = true;
                        registerMouseOver(_loc3_.arr[_loc3_.index]);
                     }
                  }
               }
            }
         }
         if(!_loc1_)
         {
            registerMouseOver(null);
         }
         if(_loc1_)
         {
            invTextAlpha += 0.1;
         }
         else
         {
            invTextAlpha -= 0.1;
         }
         invTextAlpha = Interpolation.lockValue(invTextAlpha,0,1);
         LayerFilter.setAlpha(descriptionText,invTextAlpha);
      }
      
      override public function _open(param1:GameScene) : void
      {
         makePlayerInventory();
         var _loc2_:Layout = param1.vert([makeCharacterStats(),makeEquippedInventory()],2);
         finished = param1.horiz([_loc2_,rightSideLayout],24,400,300 + 44);
         shopkeeper = new GameObject(param1,Embeds.shop_character_png,"TextLayer",0,67 - 328);
         shopkeeper.updateDespitePaused = true;
         var _loc3_:String = "Click and drag a weapon or upgrade to the appropriate\nslots on the left.              \nSell unwanted weapon and upgrade items in the shop.";
         _loc3_ = _loc3_.toUpperCase();
         shopkeeperText = createText(-(shopkeeper.baseWidth - 314) / 2,-(shopkeeper.baseHeight - 14) / 2,finishTalking,_loc3_);
         shopkeeper.addChild(shopkeeperText);
         addChild(shopkeeper);
         shopkeeperAlien = new Robot(param1,0,0);
         shopkeeper.addChild(shopkeeperAlien);
         shopkeeperAlien.basex = -244;
         shopkeeperAlien.basey = shopkeeper.baseHeight / 2 - shopkeeperAlien.baseHeight / 2 - 8;
         shopkeeperAlien.isTalking = true;
         Robot(shopkeeperAlien).audio = inventoryOpenedCount <= 1;
         slide(finished);
      }
      
      public function killText() : void
      {
         LayerFilter.applyAlphaInOut(currentText,0,0,0,10);
      }
      
      public function makePlayerInventory() : void
      {
         var _loc1_:Object = getPlayerInventory();
         var _loc2_:Object = getDescriptionContainer();
         rightSideLayout = gs.vert([_loc2_,_loc1_],10);
      }
      
      public function makeEquippedInventory() : Layout
      {
         var _loc7_:InventorySlot = null;
         var _loc8_:Layout = null;
         var _loc1_:GameObject = new GameObject(gs,Embeds.weapon_slot_png,"TextLayer",0,0);
         _loc1_.updateDespitePaused = true;
         var _loc2_:Layout = gs.horiz([_loc1_]);
         var _loc3_:Array = [96,152,27,223,27,69,181,223];
         var _loc4_:Array = [40,40,129,129,200,200,200,200];
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < 8)
         {
            _loc7_ = new InventorySlot(gs,0,0);
            _loc7_.placeSound = Sounds.invPlace;
            _loc5_.push(_loc7_);
            _loc8_ = gs.horiz([_loc7_]);
            _loc8_.freePlacement = true;
            _loc8_.freeX = _loc3_[_loc6_] - _loc1_.baseWidth / 2;
            _loc8_.freeY = _loc4_[_loc6_] - _loc1_.baseHeight / 2;
            _loc2_.children.push(_loc8_);
            _loc6_++;
         }
         bindInventory(_loc5_.slice(0,4),MainScene(gs).player.weapons,WeaponBase,false);
         bindInventory(_loc5_.slice(4,6),MainScene(gs).player.items,ItemActive,false);
         bindInventory(_loc5_.slice(6,9),MainScene(gs).player.items,ItemPassive,false,2);
         return _loc2_;
      }
      
      public function setShopkeeperText(param1:String) : void
      {
         gof.txt = param1;
         gof.ticks = gof.offset;
         gof.finishCallbackCalled = false;
         speakOn = true;
      }
      
      public function registerMouseOver(param1:InventoryItem) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(param1 != currentItem)
         {
            currentItem = param1;
            if(param1)
            {
               _loc2_ = param1.getText();
               if(_loc2_)
               {
                  _loc3_ = 0;
                  while(_loc3_ < descriptionText.length)
                  {
                     _loc4_ = 0;
                     while(_loc4_ < descriptionText[_loc3_].length)
                     {
                        if(_loc2_.length > _loc3_)
                        {
                           if(_loc2_[_loc3_].length > _loc4_)
                           {
                              _loc5_ = _loc2_[_loc3_][_loc4_];
                              _loc6_ = GameConfig.fontColor;
                              if(_loc5_.indexOf("<RED>") != -1)
                              {
                                 _loc5_ = _loc5_.replace("<RED>","");
                                 _loc6_ = 16730174;
                              }
                              if(_loc5_.indexOf("<ORANGE>") != -1)
                              {
                                 _loc5_ = _loc5_.replace("<ORANGE>","");
                                 _loc6_ = 16764727;
                              }
                              descriptionText[_loc3_][_loc4_].setText(_loc5_,-1,_loc6_);
                           }
                        }
                        _loc4_++;
                     }
                     _loc3_++;
                  }
               }
            }
         }
      }
      
      public function doItemInWeapon() : void
      {
         setShopkeeperText("THIS IS A WEAPON SLOT - YOU CANNOT PLACE AN ITEM HERE.");
      }
   }
}

