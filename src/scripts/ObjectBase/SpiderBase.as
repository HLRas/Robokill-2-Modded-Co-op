package ObjectBase
{
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.SpiderShot;
   import Objects.Swarm;
   import Scenes.MainScene;
   import Tools.Interpolation;
   
   public class SpiderBase extends EnemyBase
   {
      
      public var runAwaySpeed:Number = 1.5;
      
      public var shot:SpiderShot;
      
      public var aiming:int = 0;
      
      public function SpiderBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         addFilter(new GameObjectFilterRotateSlowly(4));
         shot = new SpiderShot(param1,param4,param5);
         shot.angle = 0;
         shot.changeZOrder("Player");
         baseHealth *= 2;
         extraHealth *= 2;
      }
      
      public function aimSpeed() : int
      {
         if(toughness == 0)
         {
            return 2;
         }
         if(toughness == 1)
         {
            return 5;
         }
         return 10;
      }
      
      override public function _remove() : void
      {
         if(shot)
         {
            if(!shot.released)
            {
               shot.remove();
            }
         }
         super._remove();
      }
      
      override public function _update() : void
      {
         if(shot)
         {
            shot.heavyDamage = true;
            shot.speedMult = 0.5;
            shot.basex = tformedX(0,-28);
            shot.basey = tformedY(0,-28);
            shot.baseRotation = modifiedRotation;
            shot.angle = baseRotation;
            shot.bigFrame = true;
            if(hidden)
            {
               shot.hide();
            }
            else
            {
               shot.show();
            }
         }
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         if(Boolean(MainScene(gs).fading) || isTeleporting())
         {
            aiming = 50;
         }
         if(frozen)
         {
            _doLegsSpeed(this,0);
            return;
         }
         if(runAwaySpeed > 1.5)
         {
            runAwaySpeed -= 0.001;
         }
         aiming = Interpolation.lockValue(aiming + 1,0,50);
         if(Boolean(shot) && distanceToPlayer() < shootingDistance())
         {
            baseRotation = angleToObject(MainScene(gs).player) + 90;
            if(Interpolation.distanceToAngle(baseRotation,modifiedRotation) < 1)
            {
               aiming -= aimSpeed();
               if(aiming < 0)
               {
                  Sounds.rocketShoot.play();
                  shot.released = true;
                  shot = null;
               }
            }
            _doLegsSpeed(this,0);
         }
         else if(shot)
         {
            moveTowardsPlayer(1);
         }
         else
         {
            if(toughness > 0)
            {
               if(ticks % 80 == 0)
               {
                  spawn(Swarm,basex,basey,toughness - 1);
                  MainScene(gs).currentLevel.enragedBugs = true;
               }
            }
            moveRandomly(runAwaySpeed,100);
         }
      }
      
      override public function _experience() : int
      {
         return 50;
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         runAwaySpeed = 2;
         super.hitBy(param1,param2);
      }
      
      public function shootingDistance() : Number
      {
         if(toughness == 0)
         {
            return 200;
         }
         if(toughness == 1)
         {
            return 400;
         }
         return 800;
      }
      
      override public function kill() : void
      {
         if(shot)
         {
            shot.released = true;
            Sounds.rocketShoot.play();
         }
         super.kill();
      }
   }
}

