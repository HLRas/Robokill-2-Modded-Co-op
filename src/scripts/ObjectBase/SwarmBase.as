package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Scenes.MainScene;
   
   public class SwarmBase extends EnemyBase
   {
      
      public var rotationLock:Number = 0;
      
      public var rotationLockTicks:int = 0;
      
      public var baseSpeed:Number = 1.7;
      
      public function SwarmBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         addFilter(new GameObjectFilterRotateSlowly(3.5));
         extraHealth *= 0.3;
         dist = 8;
      }
      
      override public function itemDropLevel() : int
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
         super._update();
         doMovement();
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         super.hitBy(param1,param2);
         MainScene(gs).currentLevel.enragedBugs = true;
      }
      
      override public function _experience() : int
      {
         return 5;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.alienSmallDie;
      }
      
      public function _moveTowardsPlayer() : void
      {
         moveTowardsPlayer(baseSpeed);
      }
      
      override public function dropsItem() : Boolean
      {
         return false;
      }
      
      public function doMovement() : void
      {
         if(rotationLockTicks > 0)
         {
            --rotationLockTicks;
            baseRotation = rotationLock;
            moveAlongAngle(1,baseRotation);
         }
         else if(!MainScene(gs).currentLevel.enragedBugs)
         {
            moveRandomly(1,200);
         }
         else
         {
            _moveTowardsPlayer();
         }
      }
      
      override public function growlSound() : GameSound
      {
         return Sounds.alienSmallGrowl;
      }
   }
}

