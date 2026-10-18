package Objects
{
   import Audio.GameSound;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import ObjectBase.BigSpiderBase;
   import ObjectBase.BulletBase;
   import ObjectConstructors.CritterClusterGrenade_constructor;
   
   public class CritterClusterGrenade extends BigSpiderBase
   {
      
      public var shooting:int = 0;
      
      public var lastShot:int = 0;
      
      public var followers:int = 0;
      
      public var shot:int = 0;
      
      public function CritterClusterGrenade(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,CritterClusterGrenade_constructor.baseim_embed,CritterClusterGrenade_constructor.LayerName,param2,param3);
         CritterClusterGrenade_constructor.setup(param1,this);
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
         var _loc1_:BulletBase = null;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         if(shot < 16)
         {
            moveRandomly(1);
            if(randTicks % 100 == 0)
            {
               --shooting;
               lastShot = ticks;
               ++shot;
               _loc1_ = shoot(RunnerGrenade,0,-20,false);
               if(_loc1_)
               {
                  _loc1_.baseRotation = baseRotation;
                  _loc1_.angle = _loc1_.baseRotation;
                  RunnerGrenade(_loc1_).effect = 1;
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
         return 200;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.grenadeShoot;
      }
   }
}

