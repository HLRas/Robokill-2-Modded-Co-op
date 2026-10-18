package ObjectBase
{
   import Audio.GameSound;
   import GameScene.GameScene;
   
   public class BigFlyBotBase extends EnemyBase
   {
      
      public var slowDown:int = 0;
      
      public var doSpiderShot:Boolean = false;
      
      public var nextSlowDown:int = Math.random() * 300;
      
      public var side:Boolean = false;
      
      public function BigFlyBotBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         baseHealth *= 8;
         extraHealth *= 8;
         inertia = 0.95;
         facePlayer = true;
      }
      
      override public function shrapnelCount() : int
      {
         return 3;
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         nextSlowDown = nextSlowDown - 1;
         if(nextSlowDown < 0)
         {
            nextSlowDown = 400 + Math.random() * 300;
            slowDown = 1;
            doSpiderShot = Math.random() < 0.5 ? true : false;
         }
         if(slowDown > 0)
         {
            slowDown += 1;
            if(slowDown < 50)
            {
               moveRandomly(0.2 + 2 - 2 * Number(slowDown) / 50,50);
            }
            else if(slowDown > 150)
            {
               moveRandomly(0.2 + 2 * Number(150 - slowDown) / 50,50);
            }
            else
            {
               moveRandomly(0.2,50);
            }
            if(slowDown > 50 && slowDown < 150)
            {
               if(ticks % 10 == 0)
               {
                  side = !side;
                  if(doSpiderShot)
                  {
                     if(ticks % 30 == 0)
                     {
                        if(side)
                        {
                           shootMissile(-10,5);
                        }
                        else
                        {
                           shootMissile(10,5);
                        }
                     }
                  }
                  else if(side)
                  {
                     shootBullet(-10,-13);
                  }
                  else
                  {
                     shootBullet(10,-13);
                  }
               }
            }
            if(slowDown > 200)
            {
               slowDown = 0;
            }
         }
         else
         {
            moveRandomly(2,50);
         }
      }
      
      override public function _experience() : int
      {
         return 120;
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.bigHoverFire;
      }
   }
}

