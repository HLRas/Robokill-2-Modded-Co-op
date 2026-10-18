package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObjectFilterRecoil;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Scenes.MainScene;
   import Tools.Interpolation;
   
   public class TurretBase extends EnemyBase
   {
      
      public var walker:WalkerBase;
      
      public var side:Boolean = false;
      
      public var offset:int = Math.random() * 200;
      
      public function TurretBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         pushable = false;
         addFilter(new GameObjectFilterRotateSlowly(slowSpeed()));
         baseHealth *= 4;
         setsImpassable = true;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.turretFire;
      }
      
      public function bulletSpeed() : Number
      {
         return 1;
      }
      
      override public function _update() : void
      {
         var _loc1_:Boolean = false;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         if(!frozen)
         {
            baseRotation = angleToObject(MainScene(gs).player) + 90;
            if(Interpolation.distanceToAngle(baseRotation,modifiedRotation) < 2)
            {
               if((randTicks + offset) % 200 >= shootingLength())
               {
                  if((randTicks + offset) % rof() == 0)
                  {
                     side = !side;
                     _loc1_ = false;
                     if(side)
                     {
                        _loc1_ = Boolean(shootBullet(offsetX(),-offsetY(),bulletSpeed()));
                     }
                     else
                     {
                        _loc1_ = Boolean(shootBullet(-offsetX(),-offsetY(),bulletSpeed()));
                     }
                     if(_loc1_)
                     {
                        addFilter(new GameObjectFilterRecoil(10,-5));
                     }
                  }
               }
            }
         }
         super._update();
         if(walker)
         {
            if(walker._removed && !_removed)
            {
               remove();
            }
         }
      }
      
      override public function _experience() : int
      {
         return 40;
      }
      
      public function slowSpeed() : Number
      {
         return 2;
      }
      
      public function rof() : int
      {
         return 20;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.explosion;
      }
      
      public function offsetX() : int
      {
         return 4;
      }
      
      public function offsetY() : int
      {
         return 12;
      }
      
      public function shootingLength() : int
      {
         if(walker)
         {
            return 80;
         }
         return 100;
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
      
      override public function kill() : void
      {
         super.kill();
      }
   }
}

