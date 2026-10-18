package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.GruntLegs;
   import Tools.Interpolation;
   
   public class GunFighterBase extends EnemyBase
   {
      
      public var holdFire:Boolean = false;
      
      public var side:Boolean = false;
      
      public function GunFighterBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         baseHealth *= 30;
         extraHealth *= 14;
         addFilter(new GameObjectFilterRotateSlowly(2));
         legs = new GruntLegs(param1,0,0);
         addChild(legs);
      }
      
      public function fireticks() : int
      {
         return 200;
      }
      
      public function canMove() : Boolean
      {
         return true;
      }
      
      override public function itemDropLevel() : int
      {
         return 2;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.hunterFire;
      }
      
      override public function shrapnelCount() : int
      {
         return 4;
      }
      
      public function speed() : Number
      {
         return 2;
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         if(canMove())
         {
            moveRandomly(speed(),0);
            if(rotatedToShoot())
            {
               if(!holdFire)
               {
                  if(randTicks % 300 > fireticks())
                  {
                     if(randTicks % 10 == 0)
                     {
                        side = !side;
                        if(side)
                        {
                           shootBullet(-10,-10,2);
                        }
                        else
                        {
                           shootBullet(10,-10,2);
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function _experience() : int
      {
         return 200;
      }
      
      override public function canBeFrozen() : Boolean
      {
         return false;
      }
      
      public function rotatedToShoot() : Boolean
      {
         return Math.abs(Interpolation.distanceToAngle(baseRotation,modifiedRotation)) < 1;
      }
   }
}

