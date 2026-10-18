package Objects
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.Brute_constructor;
   import Tools.Interpolation;
   import Tools.PathfindToPoint;
   import flash.geom.Point;
   
   public class Brute extends EnemyBase
   {
      
      public var minigunFiringChannel:GameSoundChannel;
      
      public var stateAttacking:int = 1;
      
      public var lift:Array;
      
      public var stateShouting:int = 2;
      
      public var stateStopAndFire:int = 5;
      
      public var shoutLength:int = 400;
      
      public var shadow:Array;
      
      public var statePickingUp:int = 3;
      
      public var stateLifting:int = 4;
      
      public var pickupTarget:GameObject;
      
      public var jump:Array;
      
      public var bombDetonating:int = 0;
      
      public var attack:Array;
      
      public var stateClimbingWait:int = 9;
      
      public var attackLength:int = 120;
      
      public var attackingAngle:Number = 0;
      
      public var hasLauncher:Boolean = false;
      
      public var hasBomb:Boolean = false;
      
      public var stateTicks:int = 0;
      
      public var boxRotation:Number = 0;
      
      public var shoutingSpeed:Number = 0;
      
      public var killed:Boolean = false;
      
      public var runSpeed:Number = 2;
      
      public var attackingDestY:Number = 0;
      
      public var attackingDestX:Number = 0;
      
      public var hasMinigun:Boolean = false;
      
      public var state:int = 0;
      
      public var stateDropping:int = 6;
      
      public var lastAttacked:int;
      
      public var climb:Array;
      
      public var rocketWalk:Array;
      
      public var stateClimbing:int = 7;
      
      public var walk:Array;
      
      public var shout:Array;
      
      public var leadAmount:int = 0;
      
      public var lastShout:int = -1000;
      
      public var stateClimbingAdvance:int = 8;
      
      public var stateRunning:int = 0;
      
      public var minigunWalk:Array;
      
      public var drop:Array;
      
      public var customPathfind:PathfindToPoint;
      
      public function Brute(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Brute_constructor.baseim_embed,Brute_constructor.LayerName,param2,param3);
         Brute_constructor.setup(param1,this);
         legs = new BruteLegs(param1,0,0);
         legs.baseRotation = Math.random() * 360;
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(3));
         pushWeight = 5;
         baseHealth *= 5;
         customPathfind = ms.toPlayer.createChild();
         customPathfind.reconstructGraph(10,10);
         imageSet = walk;
         collidesWithPlayer = false;
         changeZOrder("AbovePlayer");
      }
      
      override public function _experience() : int
      {
         return 80;
      }
      
      public function getJumpingSpeed() : Number
      {
         if(ticks - lastShout < shoutLength)
         {
            return 7;
         }
         return 6;
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         super.hitBy(param1,param2);
         if(state == stateAttacking)
         {
            dx *= 0.5;
            dy *= 0.5;
         }
      }
      
      override public function stunnable() : Boolean
      {
         if(state == stateClimbing || state == stateClimbingWait)
         {
            return false;
         }
         return super.stunnable();
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.alienBigDie;
      }
      
      public function goTowardsBox() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:Number = NaN;
         var _loc3_:GameObject = null;
         for each(_loc3_ in gs.objects)
         {
            if(_loc3_ is FloorProp)
            {
               if(!(_loc3_ is DestructableCover))
               {
                  if(distanceToObject(_loc3_) < 150)
                  {
                     if(FloorProp(_loc3_).canPickUp())
                     {
                        if(!FloorProp(_loc3_).pickedUp)
                        {
                           if(!FloorProp(_loc3_).covering)
                           {
                              if(distanceToObject(_loc3_) < _loc2_ || _loc1_ == null)
                              {
                                 _loc1_ = _loc3_;
                                 _loc2_ = distanceToObject(_loc3_);
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         if(_loc1_)
         {
            pickupTarget = _loc1_;
            FloorProp(_loc1_).covering = this;
            changeState(statePickingUp);
         }
      }
      
      override public function kill() : void
      {
         if(killed)
         {
            return;
         }
         killed = true;
         if(!falling)
         {
            if(hasBomb)
            {
               doSplashDamage(150,1,true,true,true);
            }
         }
         super.kill();
      }
      
      override public function isFlying() : Boolean
      {
         return state == stateAttacking;
      }
      
      override public function canFall() : Boolean
      {
         var _loc1_:Number = Math.sqrt(dx * dx + dy * dy);
         if(!frozen)
         {
            if(state == stateAttacking)
            {
               if(_loc1_ > 0.5)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      override public function hitByShockwave() : void
      {
         super.hitByShockwave();
         if(hasLauncher)
         {
            changeState(stateRunning);
            throwLauncher(180);
         }
         if(state == stateAttacking)
         {
            changeState(stateRunning);
         }
      }
      
      public function pingPong(param1:Number, param2:Number, param3:Number) : Number
      {
         param1 %= param2;
         if(param1 < param2 / 2)
         {
            return param3 * (param1 / (param2 / 2));
         }
         return param3 * (1 - (param1 - param2 / 2) / (param2 / 2));
      }
      
      public function updateRank() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:GameObject = null;
         if(toughness > 0)
         {
            _loc1_ = [Embeds.rank_trooper_1_png,Embeds.rank_trooper_2_png,Embeds.rank_trooper_3_png,Embeds.rank_trooper_4_png,Embeds.rank_trooper_5_png];
            if(this is TrooperCommander)
            {
               _loc1_ = [Embeds.rank_commander_1_png,Embeds.rank_commander_2_png,Embeds.rank_commander_3_png,Embeds.rank_commander_4_png,Embeds.rank_commander_5_png];
            }
            _loc2_ = toughness - 1;
            if(this is TrooperCommander)
            {
               _loc2_ = toughness;
            }
            _loc3_ = helper.conditionallyCreateChild(_loc1_[_loc2_],"Rank",!beforeTeleporting(),1,null,baseAlpha * fallingAlpha());
            if(_loc3_)
            {
               _loc3_.basex = basex + 18;
               _loc3_.basey = basey - 18;
            }
         }
      }
      
      override public function tintRed() : Number
      {
         if(frozen > 0)
         {
            return 0.4;
         }
         return 1;
      }
      
      public function getSpeed() : Number
      {
         if(hasMinigun)
         {
            return runSpeed / 3;
         }
         if(hasLauncher)
         {
            return runSpeed / 2;
         }
         if(ticks - lastShout < shoutLength)
         {
            return runSpeed + 0.5;
         }
         return runSpeed;
      }
      
      override public function _remove() : void
      {
         if(minigunFiringChannel)
         {
            minigunFiringChannel.stop();
            minigunFiringChannel = null;
         }
         if(pickupTarget)
         {
            if(distanceToObject(pickupTarget) < 52)
            {
               FloorProp(pickupTarget).hasBeenHit(pickupTarget);
            }
         }
         super._remove();
      }
      
      public function throwLauncher(param1:Number = 0) : void
      {
         var _loc2_:BruteRocketLauncher = BruteRocketLauncher(spawn(BruteRocketLauncher,basex,basey,0));
         if(_loc2_)
         {
            _loc2_.pushable = false;
            _loc2_.dx = Math.cos((270 + baseRotation + param1) * Math.PI / 180) * 5;
            _loc2_.dy = Math.sin((270 + baseRotation + param1) * Math.PI / 180) * 5;
            _loc2_.baseRotation = baseRotation;
         }
         hasLauncher = false;
      }
      
      override public function collisionWidth() : Number
      {
         if(state == stateClimbingWait)
         {
            return 0;
         }
         return super.collisionWidth() * 0.25;
      }
      
      public function changeState(param1:int) : void
      {
         state = param1;
         stateTicks = 0;
      }
      
      public function updateAnimation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(isTeleporting())
         {
            if(hasLauncher)
            {
               imageSet = rocketWalk;
               setFrame(0);
            }
            else if(hasMinigun)
            {
               imageSet = minigunWalk;
               setFrame(0);
            }
            legs.animFreeze = true;
            animFreeze = true;
            return;
         }
         legs.animFreeze = state == stateShouting;
         legs.hidden = false;
         animFreeze = false;
         if(state == stateClimbingWait)
         {
            legs.hide();
            baseAlpha = 0;
         }
         else if(state == stateClimbing)
         {
            legs.hide();
            animSpeed = 0;
            baseAlpha = 1;
            _loc1_ = stateTicks / 6;
            if(_loc1_ > 6)
            {
               _loc1_--;
               if(_loc1_ < 6)
               {
                  _loc1_ = 6;
               }
            }
            if(_loc1_ > 19)
            {
               _loc1_ = 19;
            }
            helperAnimation.setFrame(climb[_loc1_]);
         }
         else if(state == stateDropping)
         {
            legs.animFreeze = true;
            imageSet = drop;
            animSpeed = 4;
         }
         else if(state == stateStopAndFire)
         {
            legs.animFreeze = true;
            animFreeze = true;
            if(hasMinigun)
            {
               _loc2_ = pingPong(ticks,12,3);
               animSpeed = 0;
               helperAnimation.setFrame(attack[_loc2_]);
            }
         }
         else if(state == stateLifting)
         {
            animSpeed = 0;
            imageSet = lift;
            setFrame(stateTicks / 3);
         }
         else if(state == stateShouting)
         {
            animSpeed = 0;
            imageSet = shout;
            if(stateTicks < 20)
            {
               setFrame(stateTicks / 5);
            }
            else if(stateTicks > 80)
            {
               setFrame(4 - (stateTicks - 80) / 5);
            }
            else
            {
               if(stateTicks == 20)
               {
                  health = totalHealth;
               }
               _loc3_ = stateTicks - 20;
               _loc3_ %= 20;
               _loc3_ = 10 - Math.abs(_loc3_ - 10);
               setFrame(4 + _loc3_ / 2.5);
            }
         }
         else if(state == stateAttacking)
         {
            legs.hidden = true;
            animSpeed = 0;
            imageSet = jump;
            _loc4_ = 6;
            _loc5_ = 20;
            if(stateTicks < _loc4_ * 6)
            {
               setFrame(stateTicks / _loc4_);
            }
            else if(stateTicks < _loc4_ * 6 + _loc5_)
            {
               setFrame(5);
            }
            else if(stateTicks < _loc4_ * 10 + _loc5_)
            {
               setFrame((stateTicks - (_loc4_ * 6 - _loc5_)) / _loc4_);
            }
            else if(stateTicks > attackLength + 30)
            {
               _loc6_ = 2 - (stateTicks - (attackLength + 30)) / 5;
               if(_loc6_ < 0)
               {
                  _loc6_ = 0;
               }
               setFrame(_loc6_);
            }
            else if(stateTicks > attackLength - 20)
            {
               _loc6_ = 10 - (stateTicks - (attackLength - 20)) / 2;
               if(_loc6_ < 2)
               {
                  _loc6_ = 2;
               }
               setFrame(_loc6_);
            }
         }
         else
         {
            animSpeed = 4;
            if(hasLauncher)
            {
               imageSet = rocketWalk;
            }
            else if(hasMinigun)
            {
               imageSet = minigunWalk;
               animSpeed = 7;
            }
            else
            {
               imageSet = walk;
            }
         }
         if(ms.player._removed || stunned > 0)
         {
            animFreeze = true;
            legs.animFreeze = true;
         }
      }
      
      override public function tintGreen() : Number
      {
         if(frozen > 0)
         {
            return 1;
         }
         return 0;
      }
      
      override public function getPathfind() : PathfindToPoint
      {
         if(state == statePickingUp)
         {
            return customPathfind;
         }
         return ms.toPlayer;
      }
      
      override public function growlSound() : GameSound
      {
         return Sounds.alienBigGrowl;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:GameObject = null;
         var _loc4_:GameObject = null;
         var _loc5_:Number = NaN;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Point = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:BulletBase = null;
         var _loc14_:Point = null;
         pushable = !(state == stateClimbing || state == stateClimbingWait);
         updateRank();
         _loc1_ = helper.conditionallyCreateChild(Embeds.Brute_shadow001_png,"shadow",!(state == stateClimbing || state == stateClimbingAdvance || state == stateClimbingWait || beforeTeleporting()),1,null,baseAlpha * fallingAlpha());
         if(_loc1_)
         {
            _loc1_.basex = basex;
            _loc1_.basey = basey;
            _loc1_.imageSet = shadow;
            _loc1_.animSpeed = animSpeed;
            _loc1_.changeZOrder("Floor");
            _loc1_.animFreeze = legs.animFreeze;
         }
         _loc2_ = helper.conditionallyCreateChild(Embeds.aura_large_png,"aura",ticks - lastShout < shoutLength && !beforeTeleporting(),0.05,null,baseAlpha * fallingAlpha());
         if(_loc2_)
         {
            _loc2_.basex = basex;
            _loc2_.basey = basey;
            _loc2_.changeZOrder("Floor");
            _loc2_.additive = true;
         }
         if(ticks == 1)
         {
            if(!ms.logicalSquareExists(logicalSquareX(),logicalSquareY()))
            {
               baseRotation = 0;
               if(ms.logicalSquareExists(logicalSquareX() + 1,logicalSquareY()))
               {
                  baseRotation = 90;
               }
               if(ms.logicalSquareExists(logicalSquareX() - 1,logicalSquareY()))
               {
                  baseRotation = 270;
               }
               if(ms.logicalSquareExists(logicalSquareX(),logicalSquareY() + 1))
               {
                  baseRotation = 180;
               }
               changeState(stateClimbingWait);
               hasBomb = true;
            }
         }
         if(hasBomb)
         {
            _loc4_ = helper.conditionallyCreateChild(Embeds.brute_bomb_png,"Bomb",state != stateClimbingWait && state != stateClimbingAdvance && state != stateClimbing && !falling && state != stateShouting,1);
            if(_loc4_)
            {
               _loc4_.basex = tformedX(0,10);
               _loc4_.basey = tformedY(0,10);
               _loc4_.additive = true;
               if(_loc4_.randTicks % 100 < 50)
               {
                  _loc4_.baseAlpha = 0;
               }
               else
               {
                  _loc4_.baseAlpha = 1;
               }
            }
            if(distanceToPlayer() < 80)
            {
               if(!bombDetonating)
               {
                  bombDetonating = 1;
                  Sounds.grenadeWarning.play();
               }
            }
            if(bombDetonating > 0)
            {
               ++bombDetonating;
               if(bombDetonating > 100)
               {
                  Sounds.gasTankDestroy.play();
                  kill();
               }
            }
         }
         if(state == stateClimbingWait)
         {
            if(distanceToPlayer() < 200)
            {
               changeState(stateClimbing);
               trapEffect();
            }
         }
         if(state == stateClimbing)
         {
            if(stateTicks > 21 * 6)
            {
               changeState(stateClimbingAdvance);
            }
         }
         if(state == stateClimbingAdvance)
         {
            move(0,-1);
            if(stateTicks > 20)
            {
               changeState(stateRunning);
            }
         }
         super._update();
         if(Boolean(stunned) || Boolean(frozen))
         {
            if(state == stateAttacking)
            {
               changeState(stateRunning);
               updateAnimation();
            }
            updateAnimation();
         }
         if(blockUpdating())
         {
            if(minigunFiringChannel)
            {
               minigunFiringChannel.stop();
               minigunFiringChannel = null;
            }
            updateAnimation();
            return;
         }
         if(minigunFiringChannel)
         {
            if(state != stateStopAndFire)
            {
               minigunFiringChannel.stop();
               minigunFiringChannel = null;
            }
         }
         collidesWithWalls = state != stateAttacking;
         var _loc3_:Number = Interpolation.linearInterpolateLock(0,1,lastHit / 20);
         ++stateTicks;
         rotateTowardsPlayer = state != statePickingUp;
         if(falling)
         {
            if(pickupTarget)
            {
               if(distanceToObject(pickupTarget) < 52)
               {
                  FloorProp(pickupTarget).hasBeenHit(pickupTarget);
               }
               pickupTarget = null;
            }
            return;
         }
         if(state == stateLifting)
         {
            if(stateTicks == 1)
            {
               boxRotation = pickupTarget.baseRotation - Interpolation.snapToAngle(baseRotation,90);
               FloorProp(pickupTarget).health = 40;
               leadAmount = Math.random() * 30 + 10;
            }
            _loc5_ = stateTicks / 24;
            if(_loc5_ > 1)
            {
               _loc5_ = 1;
            }
            _loc6_ = tformed(0,-40 + _loc5_ * 24);
            pickupTarget.basex = _loc6_.x;
            pickupTarget.basey = _loc6_.y;
            pickupTarget.baseRotation = boxRotation + modifiedRotation;
            pickupTarget.baseScaleX = 1 + _loc5_ / 5;
            pickupTarget.baseScaleY = 1 + _loc5_ / 5;
            moveTowardsPlayer(getSpeed());
            _loc7_ = ms.player.basex + ms.player.lastdx * leadAmount;
            _loc8_ = ms.player.basey + ms.player.lastdy * leadAmount;
            _loc9_ = helper.angleToPoint(_loc7_,_loc8_);
            baseRotation = _loc9_ + 90;
            if(stateTicks > 100)
            {
               if(Interpolation.distanceToAngle(_loc9_ + 90,modifiedRotation) < 10)
               {
                  if(distanceToPlayer() < 400)
                  {
                     _loc10_ = helper.vectorToPoint(_loc7_,_loc8_);
                     GameObjectBase(pickupTarget).dx = _loc10_.x * 4;
                     GameObjectBase(pickupTarget).dy = _loc10_.y * 4;
                     FloorProp(pickupTarget).throwingProgress = 1;
                     trace(FloorProp(pickupTarget).health);
                     changeState(stateRunning);
                     pickupTarget = null;
                  }
               }
            }
            if(pickupTarget)
            {
               if(pickupTarget._removed || FloorProp(pickupTarget)._hitByShockwave)
               {
                  pickupTarget = null;
                  changeState(stateRunning);
               }
            }
         }
         else if(state == statePickingUp)
         {
            _loc11_ = GameObjectBase(pickupTarget).logicalSquareX();
            _loc12_ = GameObjectBase(pickupTarget).logicalSquareY();
            baseRotation = helper.angleToObject(pickupTarget) + 90;
            customPathfind.reconstructGraph(_loc11_,_loc12_);
            moveTowardsSquare(getSpeed(),_loc11_,_loc12_);
            if(pickupTarget._removed || FloorProp(pickupTarget)._hitByShockwave)
            {
               pickupTarget = null;
               changeState(stateRunning);
            }
            else if(distanceToObject(pickupTarget) < 40)
            {
               changeState(stateLifting);
               FloorProp(pickupTarget).setPassable(true);
               pickupTarget.changeZOrder("Player");
               FloorProp(pickupTarget).pickedUp = 1;
            }
         }
         else if(state == stateRunning)
         {
            moveTowardsPlayer(getSpeed());
            if(!(hasLauncher || hasMinigun))
            {
               if(Math.random() > 0.995)
               {
                  if(ticks - lastShout > 400)
                  {
                     killBoxes(70);
                     changeState(stateShouting);
                     Sounds.brutePowerthirst.play();
                     lastShout = ticks;
                     emitConditionalParticles("BruteShock");
                  }
               }
            }
            if(canShoot())
            {
               if(hasLauncher)
               {
                  if(Math.random() > 0.98)
                  {
                     if(distanceToPlayer() > 150)
                     {
                        changeState(stateStopAndFire);
                     }
                     else
                     {
                        changeState(stateDropping);
                     }
                  }
               }
               if(hasMinigun)
               {
                  if(Math.random() > 0.99)
                  {
                     if(distanceToPlayer() > 150)
                     {
                        changeState(stateStopAndFire);
                     }
                  }
               }
            }
         }
         else if(state == stateShouting)
         {
            if(stateTicks > 100)
            {
               changeState(stateRunning);
               shoutingSpeed = 0.5;
            }
         }
         else if(state == stateStopAndFire)
         {
            moveTowardsPlayer(0);
            _loc7_ = ms.player.basex + ms.player.lastdx * leadAmount;
            _loc8_ = ms.player.basey + ms.player.lastdy * leadAmount;
            _loc9_ = helper.angleToPoint(_loc7_,_loc8_);
            baseRotation = _loc9_ + 90;
            if(hasLauncher)
            {
               if(stateTicks == 50 || stateTicks == 100 || stateTicks == 150)
               {
                  _loc13_ = shoot(SpiderShot,18,-38);
                  if(_loc13_)
                  {
                     Sounds.grenadeShoot.play();
                     SpiderShot(_loc13_).move(0,12);
                     SpiderShot(_loc13_).released = true;
                     SpiderShot(_loc13_).hasTarget = true;
                     SpiderShot(_loc13_).distanceToTravel = distanceToObject(ms.player);
                     SpiderShot(_loc13_).startX = _loc13_.basex;
                     SpiderShot(_loc13_).startY = _loc13_.basey;
                     SpiderShot(_loc13_).speedMult = SpiderShot(_loc13_).speedMult * 0.7;
                     _loc13_.noCollideTicks = 20;
                  }
               }
            }
            else if(hasMinigun)
            {
               if(stateTicks % 10 == 0)
               {
                  if(!minigunFiringChannel)
                  {
                     minigunFiringChannel = Sounds.bruteMinigunFire.play(true);
                  }
                  _loc13_ = shoot(GruntBullet,8,-38);
                  if(_loc13_)
                  {
                     _loc13_.noCollideTicks = 20;
                  }
               }
            }
            if(stateTicks > 200)
            {
               changeState(stateRunning);
            }
         }
         else if(state == stateDropping)
         {
            moveTowardsPlayer(0);
            if(stateTicks == 1)
            {
               throwLauncher();
            }
            if(stateTicks > 32)
            {
               changeState(stateRunning);
            }
         }
         customPathfind.lazyUpdate();
         if(shoutingSpeed > 0)
         {
            shoutingSpeed -= 0.0001;
         }
         if(!(hasLauncher || hasMinigun))
         {
            if(state == stateRunning)
            {
               if(!hasBomb)
               {
                  if(distanceToPlayer() < 250)
                  {
                     if(ticks - lastAttacked > 200)
                     {
                        lastAttacked = ticks;
                        changeState(stateAttacking);
                        Sounds.alienBigGrowl.play();
                     }
                     else
                     {
                        goTowardsBox();
                     }
                  }
               }
            }
         }
         slowAroundCorners = state != stateAttacking;
         if(state == stateAttacking)
         {
            if(stateTicks == 1)
            {
               leadAmount = Math.random() * 30 + 10;
            }
            killBoxes(20);
            if(stateTicks <= attackLength)
            {
               if(stateTicks > 60)
               {
                  moveAlongAngle(getJumpingSpeed(),attackingAngle - 90);
                  baseRotation = attackingAngle;
               }
               else
               {
                  _loc7_ = ms.player.basex + ms.player.lastdx * leadAmount;
                  _loc8_ = ms.player.basey + ms.player.lastdy * leadAmount;
                  attackingDestX = _loc7_;
                  attackingDestY = _loc8_;
                  baseRotation = helper.angleToPoint(_loc7_,_loc8_) + 90;
                  if(!ms.squareExists(_loc7_,_loc8_))
                  {
                     changeState(stateRunning);
                  }
               }
            }
            if(stateTicks == 60)
            {
               attackingAngle = helperFilter.getModifiedRotation();
            }
            if(stateTicks == attackLength + 40)
            {
               changeState(stateRunning);
            }
            if((stateTicks == attackLength || distanceToPoint(attackingDestX,attackingDestY) < 10) && (dx != 0 || dy != 0))
            {
               emitConditionalParticles("BruteShock");
               dx = 0;
               dy = 0;
               killBoxes(70);
               if(distanceToPlayer() < 80)
               {
                  ms.player.handleHit(this);
                  _loc14_ = helper.vectorToObject(ms.player);
                  ms.player.extradx += _loc14_.x * 5;
                  ms.player.extrady += _loc14_.y * 5;
               }
               stateTicks = attackLength;
            }
         }
         updateAnimation();
      }
      
      override public function _init() : void
      {
         super._init();
      }
      
      override public function tintBlue() : Number
      {
         if(frozen > 0)
         {
            return 0.6;
         }
         return 0;
      }
      
      override public function collisionHeight() : Number
      {
         if(state == stateClimbingWait)
         {
            return 0;
         }
         return super.collisionWidth() * 0.25;
      }
      
      public function killBoxes(param1:Number) : void
      {
         var _loc2_:GameObject = null;
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is FloorProp)
            {
               if(!(FloorProp(_loc2_).flying || FloorProp(_loc2_).throwingProgress))
               {
                  if(distanceToObject(_loc2_) < param1)
                  {
                     FloorProp(_loc2_).covering = this;
                     FloorProp(_loc2_).hasBeenHit(_loc2_);
                  }
               }
            }
         }
      }
   }
}

