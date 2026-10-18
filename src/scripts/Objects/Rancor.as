package Objects
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Misc.EnemyLeveling;
   import ObjectBase.EnemyBase;
   import ObjectBase.EnemyBulletBase;
   import ObjectConstructors.Rancor_constructor;
   import Particles.Particle;
   import Tools.Random;
   import flash.display.Bitmap;
   
   public class Rancor extends EnemyBase
   {
      
      public var moveAnim:Array;
      
      public var attack:Array;
      
      public var _attackDone:Boolean = false;
      
      public var state:int = 0;
      
      public var stateAttacking:int = 1;
      
      public var stateShouting:int = 2;
      
      public var lastAttacked:int = 0;
      
      public var lastShouting:int = -300;
      
      public var shout:Array;
      
      public var stateTicks:int = 0;
      
      public var fire:Array;
      
      public var stateMoving:int = 0;
      
      public function Rancor(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Rancor_constructor.baseim_embed,Rancor_constructor.LayerName,param2,param3);
         Rancor_constructor.setup(param1,this);
         baseHealth *= 800;
         legs = new RancorLegs();
         legs.animSpeed *= 1;
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(2));
         animSpeed = 5;
         collidesWithPlayer = false;
         pushWeight = 9999;
         changeZOrder("AbovePlayer");
      }
      
      public function changeState(param1:int) : void
      {
         if(state != param1)
         {
            stateTicks = 0;
         }
         state = param1;
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() / 2;
      }
      
      public function attackFrame() : int
      {
         var _loc1_:int = stateTicks / 5;
         if(_loc1_ < 5)
         {
            _attackDone = false;
            return _loc1_;
         }
         var _loc2_:int = _loc1_ - 5;
         if(_loc2_ < 6 * 12)
         {
            _loc2_ %= 6;
            _loc2_ += 5;
            if(_loc2_ >= 8)
            {
               _loc2_ = 7 + 8 - _loc2_;
            }
            return _loc2_;
         }
         var _loc3_:int = 4 - (_loc2_ - 6 * 12);
         if(_loc3_ < 0)
         {
            _attackDone = true;
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public function shoutFrame() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         if(stateTicks < 40)
         {
            return stateTicks / 5;
         }
         if(stateTicks < 80)
         {
            if(stateTicks % 10 < 5)
            {
               return 7;
            }
            return 6;
         }
         return 15 - (stateTicks - 40) / 5;
      }
      
      override public function growlSound() : GameSound
      {
         return Sounds.alienBigGrowl;
      }
      
      override public function kill() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Particle = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         emitConditionalParticles("GasTankDestroy");
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            emitConditionalParticles("EnemyHit");
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            _loc2_ = "EnemyHitBlood";
            if(Math.random() < 0.5)
            {
               _loc2_ += "2";
            }
            _loc3_ = emitConditionalParticles(_loc2_)[0];
            if(_loc3_)
            {
               _loc4_ = Math.random() * 360;
               _loc4_ = _loc4_ + (Math.random() - 0.5) * 20;
               _loc5_ = cosd(_loc4_);
               _loc6_ = sind(_loc4_);
               _loc7_ = 1 + Math.random() * 0.6;
               _loc3_.x += (Math.random() - 0.5) * baseWidth / 2;
               _loc3_.y += (Math.random() - 0.5) * baseHeight / 2;
               _loc3_.dx = _loc5_ * _loc7_;
               _loc3_.dy = _loc6_ * _loc7_;
               _loc3_.Rotation = Math.atan2(_loc3_.dy,_loc3_.dx) * 180 / Math.PI + 90;
            }
            _loc1_++;
         }
         super.kill();
      }
      
      override public function _experience() : int
      {
         return 5000;
      }
      
      public function walkFrame() : int
      {
         return int(stateTicks / 5) % moveAnim.length;
      }
      
      override public function _update() : void
      {
         var _loc1_:* = 0;
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Class = null;
         var _loc6_:EnemyBase = null;
         var _loc7_:int = 0;
         var _loc8_:EnemyLeveling = null;
         var _loc9_:GameObject = null;
         var _loc10_:Number = NaN;
         var _loc11_:EnemyBulletBase = null;
         if(ms.player._removed)
         {
            animFreeze = true;
            legs.animFreeze = true;
         }
         ++stateTicks;
         super._update();
         if(state == stateMoving)
         {
            moveTowardsPlayer(1.5);
            if(ticks - lastAttacked > 600)
            {
               if(walkFrame() == 19)
               {
                  changeState(stateAttacking);
                  lastAttacked = ticks;
               }
            }
            if(ticks - lastShouting > 400)
            {
               if(Math.random() > 0.995 && ms.countEnemies() <= 3)
               {
                  lastShouting = ticks;
                  changeState(stateShouting);
                  Sounds.brutePowerthirst.play();
                  emitConditionalParticles("BruteShock");
                  _loc1_ = 0;
                  while(_loc1_ < 3)
                  {
                     _loc2_ = [Math.random() * 800,Math.random() * 600];
                     _loc3_ = true;
                     if(distanceToPoint(_loc2_[0],_loc2_[1]) < 100)
                     {
                        _loc3_ = false;
                     }
                     if(ms.player.distanceToPoint(_loc2_[0],_loc2_[1]) < 100)
                     {
                        _loc3_ = false;
                     }
                     _loc4_ = -1;
                     while(_loc4_ <= 1)
                     {
                        _loc7_ = -1;
                        while(_loc7_ <= 1)
                        {
                           if(!ms.squareExists(_loc2_[0] + _loc4_ * 20,_loc2_[1] + _loc7_ * 20))
                           {
                              _loc3_ = false;
                           }
                           _loc7_++;
                        }
                        _loc4_++;
                     }
                     if(!_loc3_)
                     {
                        _loc1_--;
                     }
                     else
                     {
                        _loc5_ = [HoverTrooper,BullBat,NestSwarm,MinigunBrute,TrooperCommander,Trooper,RocketBrute][Random.randInt(0,4)];
                        _loc6_ = EnemyBase(spawn(_loc5_,_loc2_[0],_loc2_[1],0));
                        if(_loc6_)
                        {
                           _loc6_.basex = _loc2_[0];
                           _loc6_.basey = _loc2_[1];
                           _loc6_.shouldTeleport = true;
                           _loc6_.teleportOffset = 50 + _loc1_ * 25;
                           _loc8_ = ms.el;
                           _loc8_.levelEnemies([_loc6_],ms.currentEpisode);
                           _loc9_ = _loc6_;
                           EnemyBase(_loc9_).hide();
                           _loc9_.baseAlpha = 0;
                           _loc9_.obj.alpha = 0;
                           _loc9_.obj.visible = false;
                           _loc9_.obj.x = -1000;
                           Bitmap(_loc9_.obj).bitmapData = null;
                           if(EnemyBase(_loc9_).legs)
                           {
                              EnemyBase(_loc9_).legs.hide();
                              EnemyBase(_loc9_).legs.obj.alpha = 0;
                              EnemyBase(_loc9_).legs.obj.visible = false;
                              EnemyBase(_loc9_).legs.syncObj();
                           }
                           EnemyBase(_loc9_).syncObj();
                        }
                     }
                     _loc1_++;
                  }
               }
            }
         }
         else if(state == stateAttacking)
         {
            if(attackFrame() <= 10)
            {
               moveTowardsPlayer(0);
            }
            if(attackFrame() == 7)
            {
               if(ticks % 10 == 0)
               {
                  _loc10_ = 20;
                  if(ticks % 20 == 0)
                  {
                     _loc10_ = 27;
                  }
                  _loc11_ = shoot(BigTurretBullet,_loc10_,-40,true,6);
                  if(_loc11_)
                  {
                     Sounds.laserEnemyFire.play();
                     _loc11_.speedMult *= 1.5;
                  }
               }
            }
            if(attackDone())
            {
               stateTicks = 100;
               changeState(stateMoving);
            }
         }
         else if(state == stateShouting)
         {
            if(stateTicks > 100)
            {
               changeState(stateMoving);
            }
         }
         updateAnimation();
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.alienBigDie;
      }
      
      public function attackDone() : Boolean
      {
         return _attackDone;
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() / 2;
      }
      
      public function updateAnimation() : void
      {
         if(state == stateMoving)
         {
            helperAnimation.setFrame(moveAnim[walkFrame()]);
         }
         else if(state == stateAttacking)
         {
            helperAnimation.setFrame(fire[attackFrame()]);
         }
         else if(state == stateShouting)
         {
            helperAnimation.setFrame(shout[shoutFrame()]);
         }
      }
   }
}

