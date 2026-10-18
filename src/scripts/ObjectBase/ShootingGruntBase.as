package ObjectBase
{
   import Audio.GameSound;
   import GameScene.GameScene;
   
   public class ShootingGruntBase extends GruntBase
   {
      
      public function ShootingGruntBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         baseHealth *= 2.5;
         extraHealth *= 3;
      }
      
      override public function _experience() : int
      {
         return 20;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.shooteyGruntFire;
      }
      
      override public function shoots() : Boolean
      {
         return true;
      }
   }
}

