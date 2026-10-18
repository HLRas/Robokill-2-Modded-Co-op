package Weapons
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Tools.Random;
   import flash.display.Bitmap;
   
   public class ItemBase extends InventoryItem
   {
      
      public var rechargeTime:Number = 2000;
      
      public var attribute:int;
      
      public var lastUsed:int = 0;
      
      public var rechargeProgress:Number = 0;
      
      public function ItemBase()
      {
         super();
         attribute = Random.randInt(attributeLow(),currentAttributeHigh());
         displayLevel();
      }
      
      public function serializeFields() : Array
      {
         return ["attribute"];
      }
      
      public function modifyAttribute(param1:String) : String
      {
         return param1;
      }
      
      public function useOn(param1:PlayerBase) : void
      {
      }
      
      override public function getGameObject(param1:String = "AfterTextLayer") : GameObject
      {
         var _loc2_:Bitmap = new (icon())();
         var _loc3_:Bitmap = new Bitmap(Embeds.itemLevel[displayLevel()]);
         _loc3_.x = _loc2_.width - _loc3_.width;
         _loc2_.bitmapData.draw(_loc3_,_loc3_.transform.matrix);
         return new GameObject(null,_loc2_,param1,0,0);
      }
      
      public function attributeCost() : int
      {
         return 0;
      }
      
      public function priceLow() : int
      {
         return 0;
      }
      
      public function minimumEpisode() : int
      {
         return 0;
      }
      
      override public function update(param1:MainScene) : void
      {
         super.update(param1);
         rechargeProgress += rechargeSpeed();
      }
      
      public function priceHigh() : int
      {
         return 0;
      }
      
      public function attributeLow() : int
      {
         return 0;
      }
      
      public function attributeHigh() : int
      {
         return 0;
      }
      
      public function rechargeSpeed() : Number
      {
         return 1;
      }
      
      public function displayLevel(param1:Number = -999) : int
      {
         if(param1 < 0)
         {
            param1 = attribute;
         }
         var _loc2_:Number = (param1 - attributeLow()) / (attributeHigh() - attributeLow());
         _loc2_ *= 7;
         var _loc3_:int = int(_loc2_ + 0.5);
         return Interpolation.lockValueInt(_loc3_,0,7);
      }
      
      override public function getText() : Array
      {
         return [["<ORANGE>ITEM: ","<ORANGE>" + name()],["",""],[description(),""],[description2(),""],["",""],["<ORANGE>VALUE: ","<ORANGE>$" + value()],[units(),modifyAttribute(String(attribute))]];
      }
      
      public function currentAttributeHigh() : Number
      {
         var _loc1_:int = minimumEpisode();
         if(GameScene.currentScene is MainScene)
         {
            return Interpolation.linearInterpolateLock(attributeLow() * 1.2,attributeHigh(),Interpolation.fromTo(MainScene(GameScene.currentScene).currentEpisode - _loc1_,0,11 - _loc1_));
         }
         return attributeLow();
      }
      
      public function passive() : Boolean
      {
         return false;
      }
      
      public function maxLevelCurrently() : int
      {
         return displayLevel(currentAttributeHigh());
      }
      
      public function units() : String
      {
         return "";
      }
      
      override public function _value() : int
      {
         return priceLow() * 0.5 + (priceHigh() - priceLow()) * displayLevel() / 7;
      }
      
      public function description2() : String
      {
         return "";
      }
      
      public function icon() : Class
      {
         return null;
      }
      
      public function description() : String
      {
         return "";
      }
   }
}

