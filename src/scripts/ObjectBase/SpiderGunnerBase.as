package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.SpiderLegs;
   
   public class SpiderGunnerBase extends EnemyBase
   {
      
      public var slowDown:int = 0;
      
      public var nextPeriod:int = Math.random() * 500 + 200;
      
      public var side:Boolean = false;
      
      public var nextSlowDown:int = Math.random() * 300;
      
      public function SpiderGunnerBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         addFilter(new GameObjectFilterRotateSlowly(2));
         legs = new SpiderLegs(param1,0,0);
         addChild(legs);
         baseHealth *= 10;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.spiderGunnerFire;
      }
      
      override public function _experience() : int
      {
         return 60;
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
         }
         if(slowDown > 0)
         {
            slowDown += 1;
            if(slowDown < 50)
            {
               moveRandomly(1 - Number(slowDown) / 50,50);
            }
            else if(slowDown > 150)
            {
               moveRandomly(Number(slowDown - 150) / 50,50);
            }
            else
            {
               moveRandomly(0,50);
            }
            if(slowDown > 50 && slowDown < 150)
            {
               if(ticks % 10 == 0)
               {
                  side = !side;
                  if(side)
                  {
                     shootBullet(-10,-10);
                  }
                  else
                  {
                     shootBullet(10,-10);
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
            moveRandomly(1,50);
         }
      }
   }
}

