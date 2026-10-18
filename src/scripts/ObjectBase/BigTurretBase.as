package ObjectBase
{
   import Audio.GameSound;
   import GameScene.GameScene;
   import flash.display.Bitmap;
   
   public class BigTurretBase extends TurretBase
   {
      
      public function BigTurretBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         Bitmap(obj).smoothing = true;
         baseHealth *= 10;
         extraHealth *= 10;
      }
      
      override public function rof() : int
      {
         return 10;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.bigTurretFire;
      }
      
      override public function bulletSpeed() : Number
      {
         return 1.5;
      }
      
      override public function shrapnelCount() : int
      {
         return 4;
      }
      
      override public function _experience() : int
      {
         return 100;
      }
      
      override public function offsetX() : int
      {
         return 8;
      }
      
      override public function slowSpeed() : Number
      {
         return 0.5;
      }
      
      override public function offsetY() : int
      {
         return 24;
      }
   }
}

