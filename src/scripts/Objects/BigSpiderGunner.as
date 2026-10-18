package Objects
{
   import Audio.GameSound;
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import Scenes.MainScene;
   import flash.display.*;
   
   public class BigSpiderGunner extends BigSpiderBase
   {
      
      public var shooting:int = 0;
      
      public var lastShot:int = 0;
      
      public var followers:int = 0;
      
      public var shot:int = 0;
      
      public var killed:Boolean = false;
      
      public function BigSpiderGunner(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BigSpiderGunner_constructor.baseim_embed,BigSpiderGunner_constructor.LayerName,param2,param3);
         BigSpiderGunner_constructor.setup(param1,this);
         baseHealth *= 8;
         extraHealth *= 3;
         legs = new SpiderLegs(param1,0,0);
         legs.baseHandleY = 0.4;
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(2));
         pushWeight = 1000;
      }
      
      override public function _update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:GruntBullet = null;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         if(shot < 99999)
         {
            moveRandomly(1);
            if(shooting > 0)
            {
               if(ticks - lastShot > 25)
               {
                  --shooting;
                  lastShot = ticks;
                  ++shot;
                  _loc1_ = -4;
                  if(shot % 2 == 0)
                  {
                     _loc1_ = 4;
                  }
                  _loc2_ = GruntBullet(shoot(GruntBullet,_loc1_,-10));
                  if(_loc2_)
                  {
                     _loc2_.helperAnimation.setFrame(new Embeds.spider_bullet_1_png().bitmapData);
                     Sounds.enemyShoot.play();
                  }
               }
            }
            if(MainScene(gs).countEnemies() < 16)
            {
               if(ticks - lastShot > 50)
               {
                  if(Math.random() < 0.01)
                  {
                     shooting = 5;
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
         return 40;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.grenadeShoot;
      }
      
      override public function preKill() : void
      {
         var _loc2_:Critter = null;
         if(killed)
         {
            return;
         }
         killed = true;
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
   }
}

