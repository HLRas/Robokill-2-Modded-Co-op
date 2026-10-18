package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Tools.Interpolation;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BarBase extends GameObject
   {
      
      public var min:Number = 0;
      
      public var barFull:Number = 0;
      
      public var barInterpolatedFull:Number = 0;
      
      public var backup:BitmapData;
      
      public var max:Number = 1;
      
      public var lastScale:Number;
      
      public var barFallSpeed:Number = 0.02;
      
      public var barRiseSpeed:Number = 0.05;
      
      public var setup:Boolean = false;
      
      public function BarBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function setFull(param1:Number) : void
      {
         barFull = Math.min(max,Math.max(min,param1));
         sync();
      }
      
      override public function _update() : void
      {
         if(barFull > barInterpolatedFull)
         {
            barInterpolatedFull = Interpolation.tendTowards(barInterpolatedFull,barFull,barRiseSpeed);
         }
         else
         {
            barInterpolatedFull = Interpolation.tendTowards(barInterpolatedFull,barFull,barFallSpeed);
         }
         sync();
      }
      
      public function sync() : void
      {
         var _loc1_:GameObject = findChildrenByName("border")[0];
         if(_loc1_)
         {
            _loc1_.baseHandleX = baseHandleX;
            _loc1_.baseHandleY = baseHandleY;
         }
         var _loc2_:GameObject = findChildrenByName("full")[0];
         _loc2_.baseHandleX = baseHandleX;
         _loc2_.baseHandleY = baseHandleY;
         var _loc3_:BitmapData = Bitmap(_loc2_.obj).bitmapData;
         if(!backup)
         {
            backup = new BitmapData(_loc3_.width,_loc3_.height,true);
            backup.copyPixels(_loc3_,new Rectangle(0,0,_loc3_.width,_loc3_.height),new Point());
         }
         if(lastScale != barInterpolatedFull)
         {
            lastScale = barInterpolatedFull;
            Bitmap(_loc2_.obj).bitmapData.copyPixels(backup,new Rectangle(0,0,backup.width,backup.height),new Point());
            Bitmap(_loc2_.obj).bitmapData.fillRect(new Rectangle(backup.width * barInterpolatedFull,0,backup.width * (1 - barInterpolatedFull),backup.height),0);
         }
      }
   }
}

