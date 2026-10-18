package GameObject
{
   import Tools.Random;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class GameObjectHelperAnimation
   {
      
      public var go:GameObject;
      
      public function GameObjectHelperAnimation(param1:GameObject)
      {
         super();
         go = param1;
      }
      
      public function update() : void
      {
      }
      
      public function setFrame(param1:BitmapData) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 == go.vars["lastFrame"])
         {
            return;
         }
         go.vars["lastFrame"] = param1;
         Bitmap(go.obj).bitmapData = param1;
         go.baseWidth = param1.width;
         go.baseHeight = param1.height;
      }
      
      public function setFrameRandomly(param1:Array) : void
      {
         setFrame(param1[Random.randInt(0,param1.length - 1)]);
      }
   }
}

