package Objects
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.EnemyBase;
   import ObjectBase.EnemyBulletBase;
   import ObjectConstructors.GooTurret_constructor;
   import Tools.Interpolation;
   import Tools.Random;
   import flash.display.BitmapData;
   
   public class GooTurret extends EnemyBase
   {
      
      public var forward:int = 30;
      
      public var rotationLock:Number = 0;
      
      public var ticksBeenZero:Boolean = false;
      
      public var idle:int = 0;
      
      public var rotationFixed:Boolean = false;
      
      public var fireValue:int = 0;
      
      public var shootMask:BitmapData;
      
      public var back:int = 30;
      
      public var periodTicks:int = 0;
      
      public var emerge:Array;
      
      public function GooTurret(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,GooTurret_constructor.baseim_embed,GooTurret_constructor.LayerName,param2,param3);
         GooTurret_constructor.setup(param1,this);
         pushable = false;
         baseHealth *= 16;
         baseAlpha = 0;
         periodTicks = 300 + Math.random() * 200;
         collidesWithPlayer = false;
         addFilter(new GameObjectFilterRotateSlowly(2));
      }
      
      internal function fixRotation() : Boolean
      {
         return false;
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
      
      override public function stunnable() : Boolean
      {
         var _loc1_:int = getPeriod();
         if(_loc1_ > 50 && _loc1_ < 150)
         {
            return false;
         }
         return super.stunnable();
      }
      
      override public function _experience() : int
      {
         return 80;
      }
      
      internal function fireFrame() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = getPeriod();
         if(_loc1_ >= 50 && _loc1_ <= 250)
         {
            if(_loc1_ < 50 + back)
            {
               return 17 * (_loc1_ - 50) / back;
            }
            if(_loc1_ > 150 - forward)
            {
               return 17 - 17 * (_loc1_ - (150 - forward)) / forward;
            }
            return 17;
         }
         return 0;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.alienBigDie;
      }
      
      override public function playGrowlAtStart() : Boolean
      {
         return false;
      }
      
      public function updateFiring() : void
      {
         var _loc1_:int = 0;
         var _loc2_:EnemyBulletBase = null;
         if(isFiring())
         {
            _loc1_ = 0;
            while(_loc1_ < 1)
            {
               _loc2_ = shoot(GooBullet,0,10,false);
               if(_loc2_)
               {
                  _loc2_.baseRotation += (Math.random() - 0.5) * 10;
                  _loc2_.move(0,-10);
                  _loc2_.changeZOrder("Player");
               }
               _loc1_++;
            }
         }
      }
      
      override public function growlSound() : GameSound
      {
         return Sounds.alienBigGrowl;
      }
      
      public function anyGooTurretsNearby(param1:GameObject) : Boolean
      {
         var _loc2_:GameObject = null;
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is GooTurret)
            {
               if(_loc2_.distanceToObject(param1) < 10)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function _update() : void
      {
         var _loc3_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Array = null;
         var _loc12_:EnemyCrack = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         _loc3_ = getPeriod();
         if(_loc3_ >= 50 && _loc3_ < 150)
         {
            if(fireFrame() == 17)
            {
               _loc1_ = true;
            }
            if(this is GooTurretSpawn)
            {
               _loc1_ = false;
            }
         }
         if(_loc3_ == 50)
         {
            Sounds.alienBigGrowl.play();
         }
         var _loc4_:GameObject = helper.conditionallyCreateChild(Embeds.snake_rest_mask_png,"Mask",_loc1_,1,null,1);
         if(_loc4_)
         {
            _loc4_.changeZOrder("AbovePlayer");
            _loc4_.basex = basex;
            _loc4_.basey = basey;
            _loc4_.baseRotation = helperFilter.getModifiedRotation();
            _loc5_ = tintRed();
            _loc6_ = tintGreen();
            _loc7_ = tintBlue();
            if(hitTint())
            {
               _loc5_ += 1;
               _loc6_ += 1;
               _loc7_ += 1;
            }
            _loc4_.tint(_loc5_,_loc6_,_loc7_);
         }
         ++periodTicks;
         updateAnimation();
         _loc3_ = getPeriod();
         if(_loc3_ < 50)
         {
            _loc8_ = ms.player.basex + ms.player.lastdx * 10;
            _loc9_ = ms.player.basey + ms.player.lastdy * 10;
            _loc10_ = helper.angleToPoint(_loc8_,_loc9_);
            baseAlpha = Interpolation.linearInterpolateLock(0,1,_loc3_ / 10);
            if(_loc3_ == 1)
            {
               helperFilter.resetRotation();
            }
            if(!rotationFixed)
            {
               baseRotation = _loc10_ + 90 - 40;
               rotationLock = _loc10_ + 90;
            }
            if(_loc3_ == 1)
            {
               if(fixRotation())
               {
                  helperFilter.resetRotation();
                  rotationFixed = true;
               }
            }
         }
         else if(_loc3_ < 150)
         {
            rotationFixed = false;
            baseRotation = rotationLock - 40 + (_loc3_ - 50) * 80 / 100;
         }
         else if(_loc3_ < 200)
         {
            baseRotation = rotationLock + 40;
            baseAlpha = Interpolation.linearInterpolateLock(1,0,(_loc3_ - 170) / 30);
         }
         else if(_loc3_ == 320)
         {
            _loc11_ = getValidMovementTargets();
            if(_loc11_.length)
            {
               _loc12_ = _loc11_[Random.randInt(0,_loc11_.length - 1)];
               basex = _loc12_.basex;
               basey = _loc12_.basey;
               if(!_loc12_.cracked)
               {
                  _loc12_.crack(true);
               }
               periodTicks += Math.random() * 60;
            }
         }
         updateFiring();
         super._update();
      }
      
      public function getValidMovementTargets() : Array
      {
         var _loc2_:GameObject = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is EnemyCrack)
            {
               if(!EnemyCrack(_loc2_).spawnGoo)
               {
                  if(!anyGooTurretsNearby(_loc2_))
                  {
                     _loc1_.push(_loc2_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      override public function collisionWidth() : Number
      {
         var _loc1_:int = getPeriod();
         if(_loc1_ >= 50 && _loc1_ <= 200)
         {
            return super.collisionWidth();
         }
         return 0;
      }
      
      public function getPeriod() : int
      {
         var _loc1_:int = periodTicks % 500;
         if(_loc1_ == 0)
         {
            ticksBeenZero = true;
         }
         if(!ticksBeenZero)
         {
            return 0;
         }
         return _loc1_;
      }
      
      override public function collisionHeight() : Number
      {
         var _loc1_:int = getPeriod();
         if(_loc1_ >= 50 && _loc1_ <= 200)
         {
            return super.collisionHeight();
         }
         return 0;
      }
      
      public function updateAnimation() : void
      {
         var _loc1_:int = getPeriod();
         if(_loc1_ < 50)
         {
            helperAnimation.setFrame(emerge[int(_loc1_ / 6)]);
         }
         else if(_loc1_ < 150)
         {
            helperAnimation.setFrame(imageSet[fireFrame()]);
         }
         else if(_loc1_ < 200)
         {
            helperAnimation.setFrame(emerge[8 - int((_loc1_ - 150) / 6)]);
         }
      }
      
      internal function isFiring() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = getPeriod();
         if(_loc1_ > 50 + back && _loc1_ < 150 - forward)
         {
            _loc2_ = (_loc1_ + 50) % (idle + back + forward);
            if(_loc2_ % 8 == fireValue)
            {
               fireValue = Math.random() * 5;
               return true;
            }
         }
         return false;
      }
   }
}

