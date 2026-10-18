package ObjectBase
{
   import GameScene.GameScene;
   import Scenes.MainScene;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class RespawnPointBase extends GameObjectBase
   {
      
      public var activated:Boolean = false;
      
      public var on:BitmapData;
      
      public function RespawnPointBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function _update() : void
      {
         super._update();
         if(!activated)
         {
            if(MainScene(gs).lazyEnemiesCount == 0)
            {
               activated = true;
               Bitmap(obj).bitmapData = on;
            }
         }
         if(activated)
         {
            helper.showChildren();
         }
         else
         {
            helper.hideChildren();
         }
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey"];
      }
   }
}

