package InventoryScreen
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterDraggable;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Weapons.InventoryItem;
   import Weapons.ItemActive;
   import Weapons.ItemBase;
   import Weapons.ItemPassive;
   import Weapons.WeaponBase;
   import flash.geom.Point;
   
   public class InventorySlot extends GameObject
   {
      
      public var isShop:Boolean = false;
      
      public var placeSound:GameSound;
      
      public var dragging:GameObjectFilterDraggable;
      
      public var index:int;
      
      public var item:GameObject;
      
      public var firstSet:Boolean = false;
      
      public var appropriateBase:Class;
      
      public var arr:Array;
      
      public function InventorySlot(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Embeds.weaponslot_png,"TextLayer",param2,param3);
         updateDespitePaused = true;
      }
      
      public function associateWith(param1:InventoryItem, param2:Class) : void
      {
         var _loc3_:GameObject = null;
         appropriateBase = param2;
         if(param1)
         {
            item = param1.getGameObject();
            item.basex = basex;
            item.basey = basey;
            item.updateDespitePaused = true;
            for each(_loc3_ in gs.objects)
            {
               if(_loc3_ is Inventory)
               {
                  Inventory(_loc3_).slide(item);
               }
            }
            dragging = new GameObjectFilterDraggable();
            dragging.finishFunc = finishDrag;
            dragging.startFunc = startDrag;
            item.addFilter(dragging);
         }
      }
      
      public function kill() : void
      {
         if(item)
         {
            item.remove();
         }
         remove();
      }
      
      public function finishDrag() : void
      {
         var _loc3_:GameObject = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:Number = 99999;
         var _loc2_:InventorySlot = null;
         for each(_loc3_ in gs.objects)
         {
            if(_loc3_ is InventorySlot)
            {
               _loc6_ = _loc3_.basex - item.modifiedx;
               _loc7_ = _loc3_.basey - item.modifiedy;
               _loc8_ = Math.sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_);
               if(_loc8_ < _loc1_)
               {
                  _loc1_ = _loc8_;
                  _loc2_ = InventorySlot(_loc3_);
               }
            }
         }
         if(_loc1_ > 52)
         {
            return;
         }
         var _loc4_:Object = _loc2_.arr[_loc2_.index];
         var _loc5_:Object = arr[index];
         if(_loc2_)
         {
            if(_loc4_ == null || _loc4_ is appropriateBase || _loc2_.isShop)
            {
               if(_loc5_ == null || _loc5_ is _loc2_.appropriateBase || _loc2_.isShop)
               {
                  swapWith(_loc2_);
               }
            }
         }
         if(!_loc2_.isShop)
         {
            if(appropriateBase == WeaponBase && _loc4_ is ItemBase || _loc2_.appropriateBase == WeaponBase && _loc5_ is ItemBase)
            {
               if(getInventory())
               {
                  getInventory().doItemInWeapon();
               }
            }
            else if(appropriateBase == ItemBase && _loc4_ is WeaponBase || _loc2_.appropriateBase == ItemBase && _loc5_ is WeaponBase)
            {
               if(getInventory())
               {
                  getInventory().doWeaponInItem();
               }
            }
            if(appropriateBase == ItemActive && _loc4_ is ItemPassive || _loc2_.appropriateBase == ItemActive && _loc5_ is ItemPassive)
            {
               if(getInventory())
               {
                  getInventory().doPassiveInActive();
               }
            }
            if(appropriateBase == ItemPassive && _loc4_ is ItemActive || _loc2_.appropriateBase == ItemPassive && _loc5_ is ItemActive)
            {
               if(getInventory())
               {
                  getInventory().doActiveInPassive();
               }
            }
         }
      }
      
      public function handleShopBuy(param1:InventorySlot) : void
      {
         if(param1.item == null)
         {
            if(getShop().doBuy(arr[index]))
            {
               doSwap(param1);
            }
         }
         else
         {
            getShop().noBuyFull(arr[index]);
         }
      }
      
      public function getShop() : Shop
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is Shop)
            {
               return Shop(_loc1_);
            }
         }
         return null;
      }
      
      public function getInventory() : Inventory
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is Inventory)
            {
               return Inventory(_loc1_);
            }
         }
         return null;
      }
      
      override public function _update() : void
      {
         var _loc1_:Point = null;
         if(dragging)
         {
            if(!dragging.beingDragged)
            {
               item.bringToFront();
            }
         }
         if(dragging)
         {
            if(!dragging.beingDragged)
            {
               if(!firstSet)
               {
                  item.basex = basex;
                  item.basey = basey;
                  firstSet = true;
               }
               _loc1_ = Interpolation.tendTowardsVector(item.basex,item.basey,basex,basey,10);
               item.basex = _loc1_.x;
               item.basey = _loc1_.y;
            }
         }
      }
      
      public function handleShopSell(param1:InventorySlot) : void
      {
         if(isShop)
         {
            return;
         }
         if(arr[index] is InventoryItem)
         {
            getShop().doSell(arr[index]);
            item.remove();
            arr[index] = null;
            item = null;
            dragging = null;
         }
      }
      
      public function startDrag() : void
      {
         Sounds.invPickup.play();
      }
      
      public function swapWith(param1:InventorySlot) : void
      {
         if(param1.arr == MainScene(gs).player.weapons)
         {
            if(arr[index] is WeaponBase)
            {
               if(WeaponBase(arr[index]).playerMinLevel() > MainScene(gs).player.level)
               {
                  handleTooLowLevel();
                  return;
               }
            }
         }
         if(param1.isShop)
         {
            handleShopSell(param1);
            return;
         }
         if(isShop)
         {
            handleShopBuy(param1);
            return;
         }
         doSwap(param1);
      }
      
      public function handleTooLowLevel() : void
      {
         if(getInventory())
         {
            getInventory().doNoEquip();
         }
      }
      
      public function doSwap(param1:InventorySlot) : void
      {
         var _loc2_:Object = param1.arr[param1.index];
         param1.arr[param1.index] = arr[index];
         arr[index] = _loc2_;
         var _loc3_:GameObject = param1.item;
         var _loc4_:GameObjectFilterDraggable = param1.dragging;
         param1.item = item;
         param1.dragging = dragging;
         item = _loc3_;
         dragging = _loc4_;
         if(dragging)
         {
            dragging.finishFunc = finishDrag;
         }
         if(param1.dragging)
         {
            param1.dragging.finishFunc = param1.finishDrag;
         }
         if(param1.placeSound)
         {
            param1.placeSound.play();
         }
      }
   }
}

