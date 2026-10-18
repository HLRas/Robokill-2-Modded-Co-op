package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.Critter;
   import Objects.RunnerGrenade;
   import Objects.SpiderLegs;
   import Scenes.MainScene;
   
   public class SpiderSpitBase extends BigSpiderBase
   {
      
      public var shooting:int = 0;
      
      public var crittersSpawned:Boolean = false;
      
      public var lastShot:int = 0;
      
      public var followers:int = 0;
      
      public var shot:int = 0;
      
      public function SpiderSpitBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         baseHealth *= 8;
         extraHealth *= 9;
         legs = new SpiderLegs(param1,0,0);
         legs.baseHandleY = 0.4;
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(2));
         pushWeight = 1000;
      }
      
      override public function preKill() : void
      {
         var _loc2_:Critter = null;
         super.preKill();
         if(crittersSpawned)
         {
            return;
         }
         crittersSpawned = true;
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = Critter(spawn(Critter,basex + (Math.random() - 0.5) * 10,basey + (Math.random() - 0.5) * 10,toughness));
            if(_loc2_)
            {
               _loc2_.baseRotation = Math.random() * 360;
            }
            _loc1_++;
         }
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:EnemyBulletBase = null;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         followers = 0;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is Critter)
            {
               if(Critter(_loc1_).following == this)
               {
                  ++followers;
               }
            }
         }
         if(shot < 16)
         {
            moveRandomly(1);
            if(shooting > 0)
            {
               if(ticks - lastShot > 25)
               {
                  --shooting;
                  lastShot = ticks;
                  ++shot;
                  _loc2_ = shootBullet(0,-20);
                  if(_loc2_)
                  {
                     RunnerGrenade(_loc2_).difficulty = toughness + 1;
                     if(RunnerGrenade(_loc2_).difficulty > 2)
                     {
                        RunnerGrenade(_loc2_).difficulty = 2;
                     }
                  }
               }
            }
            if(MainScene(gs).countEnemies() < 16)
            {
               if(ticks - lastShot > 50)
               {
                  if(Math.random() < 0.01)
                  {
                     shooting = 3;
                  }
               }
            }
         }
         else
         {
            moveTowardsPlayer(2);
         }
      }
      
      override public function _experience() : int
      {
         return 100;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.grenadeShoot;
      }
   }
}

