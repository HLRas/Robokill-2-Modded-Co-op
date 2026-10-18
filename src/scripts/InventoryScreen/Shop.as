package InventoryScreen
{
   import Audio.GameSoundChannel;
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.*;
   import Layout.*;
   import ObjectBase.PlayerBase;
   import Objects.Alien;
   import Scenes.*;
   import Templates.RandomSpeak;
   import Weapons.InventoryItem;
   import Weapons.WeaponGenerator;
   
   public class Shop extends Inventory
   {
      
      public static var speaking:GameSoundChannel;
      
      public static var lastObjectsScene:GameScene;
      
      public static var lastObjects:Array;
      
      public static var lastObjectsTime:int = 0;
      
      public var leftSideLayout:Layout;
      
      public var randomSpeak:RandomSpeak;
      
      public function Shop(param1:GameScene)
      {
         super(param1);
      }
      
      public function noBuyFull(param1:InventoryItem) : void
      {
         setShopkeeperText("DRAG AN ITEM TO AN EMPTY SLOT TO BUY.");
      }
      
      override public function _open(param1:GameScene) : void
      {
         makePlayerInventory();
         makeLeftShop();
         finished = param1.horiz([leftSideLayout,rightSideLayout],24,400,300 + 44);
         shopkeeper = new GameObject(param1,Embeds.shop_character_png,"TextLayer",0,67 - 328);
         shopkeeper.updateDespitePaused = true;
         shopkeeperText = createText(-(shopkeeper.baseWidth - 314) / 2,-(shopkeeper.baseHeight - 14) / 2,turnSpeakOff,"WELCOME TO MY SHOP PITIFUL HUMAN.                    \n(DRAG AN ITEM TO YOUR INVENTORY TO BUY,  \nOR TO THE SHOP TO SELL.)");
         shopkeeper.addChild(shopkeeperText);
         shopkeeperAlien = new Alien(param1,0,0);
         shopkeeper.addChild(shopkeeperAlien);
         shopkeeperAlien.basex = -244;
         shopkeeperAlien.basey = shopkeeper.baseHeight / 2 - shopkeeperAlien.baseHeight / 2 - 8;
         randomSpeak = new RandomSpeak();
         randomSpeak.sound = Sounds.alienTalk;
         speak(0);
         addChild(shopkeeper);
         slide(finished);
      }
      
      public function makeLeftShop() : void
      {
         var _loc1_:Object = getDescriptionContainer(true);
         var _loc2_:Object = makeEquippedInventory();
         leftSideLayout = gs.vert([_loc1_,_loc2_],2);
      }
      
      override public function makePlayerInventory() : void
      {
         var _loc1_:Object = getPlayerInventory();
         var _loc2_:Object = getShopInventory();
         rightSideLayout = gs.vert([_loc2_,_loc1_],26);
      }
      
      override public function speak(param1:int) : void
      {
         if(speaking)
         {
            if(speaking.playing())
            {
               speaking.stop();
            }
         }
         speaking = Sounds.alienTalk.playSpecific(param1);
      }
      
      public function turnSpeakOn() : void
      {
         speakOn = true;
      }
      
      public function getShopInventory() : Layout
      {
         var _loc1_:Array = null;
         var _loc5_:int = 0;
         if(lastObjects)
         {
            if(gs.Ticks - lastObjectsTime < 100 * 60 && lastObjectsScene == gs)
            {
               _loc1_ = lastObjects;
            }
         }
         if(!_loc1_)
         {
            _loc1_ = new Array(4 * 7);
            _loc5_ = 0;
            while(_loc5_ < 3 * 7)
            {
               if(Math.random() < 0.6)
               {
                  _loc1_[_loc5_] = WeaponGenerator.generateWeapon(40,MainScene(gs).player.level,false,true);
               }
               else
               {
                  _loc1_[_loc5_] = WeaponGenerator.generateItem(40,true);
               }
               if(_loc1_[_loc5_])
               {
                  _loc1_[_loc5_].inShop = true;
               }
               _loc5_++;
            }
            lastObjectsTime = gs.Ticks;
            lastObjects = _loc1_;
            lastObjectsScene = gs;
         }
         var _loc2_:Array = new Array();
         var _loc3_:Layout = createSlots(_loc2_,4,7);
         bindInventory(_loc2_,_loc1_,Object,true);
         var _loc4_:GameObject = new GameObject(gs,Embeds.item_sale_png,"TextLayer",0,0);
         _loc4_.updateDespitePaused = true;
         return gs.vert([_loc4_,_loc3_],0);
      }
      
      override public function _update() : void
      {
         shopkeeperAlien.isTalking = false;
         if(speaking)
         {
            if(speaking.playing())
            {
               shopkeeperAlien.isTalking = true;
            }
         }
         super._update();
      }
      
      public function makeShopInventory() : void
      {
      }
      
      public function turnSpeakOff() : void
      {
         speakOn = false;
      }
      
      public function doBuy(param1:InventoryItem) : Boolean
      {
         var _loc2_:PlayerBase = MainScene(gs).player;
         if(param1.value() > _loc2_.money)
         {
            setShopkeeperText("YOU CANNOT AFFORD THIS " + param1.name() + ".");
            speak(3);
            return false;
         }
         speak(1);
         setShopkeeperText("YOU BOUGHT " + pluralize(param1.plural()) + " " + param1.name() + " FOR $" + param1.value() + ".");
         _loc2_.money -= param1.value();
         param1.inShop = false;
         return true;
      }
      
      public function doSell(param1:InventoryItem) : void
      {
         speak(2);
         setShopkeeperText("YOU SOLD " + pluralize(param1.plural()) + " " + param1.name() + " FOR $" + param1.value() + ".");
         MainScene(gs).player.money = MainScene(gs).player.money + param1.value();
      }
      
      public function pluralize(param1:Boolean) : String
      {
         if(param1)
         {
            return "AN";
         }
         return "A";
      }
   }
}

