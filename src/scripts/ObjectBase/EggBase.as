package ObjectBase
{
   import Audio.GameSound;
   import GameScene.GameScene;
   
   public class EggBase extends EnemyBase
   {
      
      public function EggBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         setsImpassable = true;
         pushable = false;
      }
      
      override public function killSound() : GameSound
      {
         return null;
      }
      
      override public function _experience() : int
      {
         return 10;
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
   }
}

