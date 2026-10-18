package Levels
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import flash.display.Bitmap;
   import flash.utils.getDefinitionByName;
   
   public class propertiesSet
   {
      
      public static var levels:int = 51;
      
      public function propertiesSet()
      {
         super();
      }
      
      public function init(param1:int, param2:GameScene) : Array
      {
         var _loc4_:GameObject = null;
         return new Array();
      }
      
      public function createObject(param1:Array, param2:GameScene) : GameObject
      {
         var _loc3_:GameObject = null;
         if(param1.length > 0)
         {
            _loc3_ = new param1[0](param2,param1[1],param1[2]);
            if(param1[3] != 0)
            {
               if(_loc3_["images"])
               {
                  Bitmap(_loc3_.obj).bitmapData = _loc3_["images"][param1[3]];
                  _loc3_.baseWidth = _loc3_.obj.width;
                  _loc3_.baseHeight = _loc3_.obj.height;
                  _loc3_.animFrame = param1[3];
               }
            }
            if(param1.length > 4)
            {
               _loc3_.baseAlpha = param1[4];
            }
            if(param1.length > 5)
            {
               _loc3_.baseRotation = param1[5];
            }
            if(param1.length > 7)
            {
               _loc3_.baseScaleX = param1[6];
               _loc3_.baseScaleY = param1[7];
            }
            if(param1.length > 8)
            {
               _loc3_.baseBrightness = param1[8];
            }
            if(param1.length > 9)
            {
               _loc3_.additive = true;
            }
            return _loc3_;
         }
         return null;
      }
      
      public function getClasses(param1:int) : Array
      {
         return new Array();
      }
   }
}

