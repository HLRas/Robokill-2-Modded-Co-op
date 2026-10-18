package ObjectBase
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.RocketGrunt;
   import Objects.SpiderShot;
   import Tools.Interpolation;
   import Tools.Random;
   
   public class GruntBase extends EnemyBase
   {
      
      public var acc:Number = 0;
      
      public var shootoffset:int = Random.randInt(0,1000);
      
      public var accTicks:int = 0;
      
      public var switchRotationCount:int = 0;
      
      public function GruntBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         addFilter(new GameObjectFilterRotateSlowly(3));
         needsToAim = false;
         extraHealth *= 0.55;
         dist *= 0.8;
      }
      
      override public function _update() : void
      {
         var _loc4_:GameObject = null;
         var _loc5_:Class = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:BulletBase = null;
         if(shoots())
         {
            _loc5_ = Embeds.grunt_gun_png;
            if(this is RocketGrunt)
            {
               _loc5_ = Embeds.grunt_rocket_png;
            }
            _loc4_ = helper.conditionallyCreateChild(_loc5_,"Gun",true,1,null,baseAlpha * fallingAlpha());
            if(_loc4_)
            {
               _loc4_.basex = basex;
               _loc4_.basey = basey;
               _loc4_.baseRotation = angleToObject(ms.player) + 90;
            }
         }
         if(blockUpdating())
         {
            super._update();
            return;
         }
         if(frozen == 0)
         {
            --switchRotationCount;
            if(switchRotationCount < 0)
            {
               switchRotationCount = 100 + Math.random() * 200;
               baseRotation = Math.random() * 360;
            }
         }
         super._update();
         var _loc1_:Boolean = false;
         var _loc2_:Number = 1;
         if(shoots())
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc2_ *= 0.6;
            _loc6_ = baseRotation;
            baseRotation = angleToObject(ms.player) + 90;
            _loc7_ = (ticks + shootoffset) % 150;
            if(this is RocketGrunt)
            {
               if(_loc7_ == 60 || _loc7_ == 80)
               {
                  _loc8_ = shoot(SpiderShot,_loc7_ == 60 ? -10 : 10,-12);
                  if(_loc8_)
                  {
                     SpiderShot(_loc8_).damageMult = SpiderShot(_loc8_).damageMult * 3;
                     ++SpiderShot(_loc8_).boxDamage;
                     SpiderShot(_loc8_).released = true;
                  }
               }
            }
            else if(_loc7_ == 60 || _loc7_ == 70 || _loc7_ == 80 || _loc7_ == 90)
            {
               if(_loc7_ / 10 % 2)
               {
                  shootBullet(-6,-6);
               }
               else
               {
                  shootBullet(6,-6);
               }
            }
            baseRotation = _loc6_;
         }
         else if(shoots())
         {
            _loc2_ = 0.6;
         }
         if(distanceToPlayer() < 300 && !shoots())
         {
            accTicks += 1;
            acc += 0.05;
         }
         else
         {
            acc -= 0.1;
            accTicks = 0;
         }
         if(accTicks > 300)
         {
            acc -= 0.1;
         }
         acc = Interpolation.lockValue(acc,0,1);
         var _loc3_:Number = _loc2_ * 1.5 + acc / 3;
         if(_loc3_ > 0)
         {
            moveTowardsPlayer(_loc3_);
         }
         else
         {
            baseRotation = angleToObject(ms.player) + 90;
         }
         for each(_loc4_ in gs.objects)
         {
            if(_loc4_ is HumanBase)
            {
               if(spriteCollidesWith(HumanBase(_loc4_)))
               {
                  _loc4_.remove();
               }
            }
         }
      }
      
      override public function _experience() : int
      {
         return 10;
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() * 0.5;
      }
      
      override public function canHaveTumor() : Boolean
      {
         return !shoots();
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() * 0.5;
      }
      
      public function shoots() : Boolean
      {
         return false;
      }
   }
}

