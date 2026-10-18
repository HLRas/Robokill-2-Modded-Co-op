package ObjectBase
{
   import GameScene.GameScene;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class WalkerTurretBase extends TurretBase
   {
      
      public var medium:BitmapData;
      
      public var front:Boolean = false;
      
      public function WalkerTurretBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function _experience() : int
      {
         return 0;
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         if(front)
         {
            Bitmap(obj).bitmapData = medium;
            baseWidth = medium.width;
            baseHeight = medium.height;
         }
         super._update();
      }
      
      override public function offsetX() : int
      {
         if(!front)
         {
            return super.offsetX();
         }
         return 9;
      }
   }
}

