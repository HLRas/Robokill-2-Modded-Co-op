package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Tools.Random;
   
   public class MineLayerBase extends EnemyBase
   {
      
      public var glow:GameObject;
      
      public var aiming:int = 0;
      
      public var aimingPeriod:int = Random.randInt(200,260);
      
      public function MineLayerBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         baseHealth *= 20;
         extraHealth *= 10;
         addFilter(new GameObjectFilterRotateSlowly(2));
         glow = new GameObject(param1,Embeds.minelayerglow_png,"Player",0,0);
         glow.baseAlpha = 0;
         glow.additive = true;
         addChild(glow);
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.laserEnemyFire;
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         if(MainScene(gs).player._removed)
         {
            aiming = 0;
         }
         ++aiming;
         aiming = Interpolation.lockValueInt(aiming,0,aimingPeriod);
         super._update();
         glow.baseAlpha = Interpolation.linearInterpolateLock(1,0,Interpolation.fromTo(aiming,40,200));
         var _loc1_:Boolean = distanceToPlayer() > 200;
         if(aiming > aimingPeriod - 40 || _loc1_)
         {
            moveTowardsPlayer(1.25);
         }
         else
         {
            baseRotation = angleToObject(MainScene(gs).player) + 90;
         }
         if(aiming < aimingPeriod - 20)
         {
            if(distanceToPlayer() > 220)
            {
               aiming = aimingPeriod;
            }
         }
         if(canMoveToPlayer)
         {
            if(aiming < aimingPeriod - 20 || !_loc1_)
            {
               aiming -= 2;
               if(aiming == 10 || aiming == 50 || aiming == 90)
               {
                  shootBullet(12,-12);
               }
               if(aiming == 30 || aiming == 70 || aiming == 110)
               {
                  shootBullet(-12,-12);
               }
               if(aiming < 0)
               {
                  aiming = aimingPeriod;
               }
            }
         }
         else
         {
            aiming = aimingPeriod;
         }
      }
      
      override public function _experience() : int
      {
         return 100;
      }
   }
}

