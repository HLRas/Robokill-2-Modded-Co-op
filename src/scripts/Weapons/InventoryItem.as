package Weapons
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Layout.Layout;
   import Layout.LayoutOverhang;
   import Multiplayer.SyncObject;
   import Scenes.MainScene;
   
   public class InventoryItem extends SyncObject
   {
      
      public var gs:GameScene;
      
      public var inShop:Boolean = false;
      
      public function InventoryItem()
      {
         super();
      }
      
      public function getText() : Array
      {
         return null;
      }
      
      public function plural() : Boolean
      {
         return false;
      }
      
      public function getGameObject(param1:String = "AfterTextLayer") : GameObject
      {
         return null;
      }
      
      public function update(param1:MainScene) : void
      {
      }
      
      public function properties() : String
      {
         return "";
      }
      
      public function value() : int
      {
         var _loc1_:int = 1;
         if(inShop)
         {
            _loc1_ *= 7;
         }
         return _loc1_ * _value();
      }
      
      public function name() : String
      {
         return "HURTINATOR 5000";
      }
      
      public function playerMinLevel() : int
      {
         return 0;
      }
      
      public function _value() : int
      {
         return 100;
      }
      
      public function pair(param1:String, param2:String) : Layout
      {
         if(param1 == "")
         {
            param1 = " ";
         }
         if(param2 == "")
         {
            param2 = " ";
         }
         return LayoutOverhang.Horiz([gs.text(param1,20),gs.text(param2,20)],8,120,0);
      }
      
      public function inGameImage() : Class
      {
         return null;
      }
      
      public function transformGameObject(param1:GameObject) : void
      {
      }
   }
}

