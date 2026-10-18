package Objects
{
   import Audio.GameSound;
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import Scenes.MainScene;
   import Templates.RewardText;
   import Tools.*;
   import flash.display.*;
   import flash.geom.Point;
   
   public class Trooper extends EnemyBase
   {
      
      public var stateHeadingForWeapon:int = 10;
      
      public var landing:int;
      
      public var _destSquareY:int = 0;
      
      public var weapon:int = 1;
      
      public var square:GameObjectBase;
      
      public var shadow:Array;
      
      public var lastInCover:int = -500;
      
      public var weaponSniper:int = 2;
      
      public var inShieldTicks:int = 0;
      
      public var _destSquareX:int = 0;
      
      public var fire:Array;
      
      public var aim:Array;
      
      public var shieldHits:Number = 0;
      
      public var weaponShotgun:int = 1;
      
      public var grenade:Array;
      
      public var chargeRotation:Number = 0;
      
      public var coverRotation:Number = 0;
      
      public var switchRotationCount:int = 0;
      
      public var lastHitPlayer:int = -1000;
      
      public var flyAdditive:Array;
      
      public var stateJetpack:int = 6;
      
      public var shooting:int = 0;
      
      public var stateTicks:int = 0;
      
      public var stateRandomOffset:Number = 0;
      
      public var stateGettingOnWeapon:int = 11;
      
      public var disableShield:Boolean = false;
      
      public var shootoffset:int = Random.randInt(0,1000);
      
      public var fly:Array;
      
      public var chargingSlowingDown:int = 0;
      
      public var accTicks:int = 0;
      
      public var throwingGrenade:Boolean = true;
      
      public var stateJetpackCharge:int = 13;
      
      public var acc:Number = 0;
      
      public var nextCharge:int = 400 + Math.random() * 600;
      
      public var stateOnWeapon:int = 12;
      
      public var coverFire:Array;
      
      public var stopAndFireEnd:int = 125;
      
      public var state:int = 0;
      
      public var charging:int = 0;
      
      public var lastJetpackCharge:int = -1000;
      
      public var weaponSMG:int = 0;
      
      public var stateThrowingGrenade:int = 2;
      
      public var stateRiding:int = 5;
      
      public var followAngle:Number = 90 + Math.random() * 10;
      
      public var rotateFilter:GameObjectFilterRotateSlowly;
      
      public var riding:EnemyBase;
      
      public var _commanderInRoom:int = -1;
      
      public var stateRunningForPlayer:int = 4;
      
      public var stateHeadingForCover:int = 3;
      
      public var stateInCover:int = 1;
      
      public var riderLegs:Array;
      
      public var lastCover:GameObjectBase;
      
      public var walk:Array;
      
      public var takeoffTicks:int = Math.random() * 300;
      
      public var chargingDist:Number = 0;
      
      public var weaponMortar:int = 3;
      
      public var stateCallingForReinforcements:int = 9;
      
      public var stateJetpackOutOfControl:int = 14;
      
      public var lastGrenade:int = 0;
      
      public var aimingProgress:Number = 0;
      
      public var stateJetpackLand:int = 7;
      
      public var stateRunning:int = 0;
      
      public var customPathfind:PathfindToPoint;
      
      public var chargingSlowDownStraffe:int = 0;
      
      public var jetpackShadow:BitmapData;
      
      public var destX:Number = 100 + Math.random() * 600;
      
      public var blah:Object = new Object();
      
      public var stateStopAndFire:int = 8;
      
      public var hasBeenInShield:Boolean = false;
      
      public var destY:Number = 100 + Math.random() * 400;
      
      public function Trooper(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         var _loc4_:Boolean = false;
         var _loc5_:GameObject = null;
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Trooper_constructor.baseim_embed,Trooper_constructor.LayerName,param2,param3);
         Trooper_constructor.setup(param1,this);
         legs = new TrooperLegs(param1,0,0);
         legs.baseRotation = Math.random() * 360;
         addChild(legs);
         rotateFilter = new GameObjectFilterRotateSlowly(2);
         addFilter(rotateFilter);
         baseHealth *= 2;
         extraHealth *= 1;
         customPathfind = ms.toPlayer.createChild();
         customPathfind.reconstructGraph(10,10);
         imageSet = walk;
         if(this is TrooperCommander || this is TrooperJet)
         {
            weapon = weaponSMG;
         }
         else
         {
            _loc4_ = false;
            for each(_loc5_ in param1.objects)
            {
               if(_loc5_ is Trooper)
               {
                  if(_loc5_ != this)
                  {
                     _loc4_ = true;
                  }
               }
            }
            for each(_loc5_ in param1.objects)
            {
               if(_loc5_ is Trooper)
               {
                  if(Trooper(_loc5_).weapon == weaponSniper)
                  {
                     _loc4_ = false;
                  }
               }
            }
            if(Math.random() < 0.2 && ms.currentEpisode >= 4)
            {
               weapon = weaponMortar;
            }
            else if(Math.random() < 0.2 && _loc4_ && ms.currentEpisode >= 2)
            {
               weapon = weaponSniper;
            }
            else if(Math.random() < 0.2 && ms.currentEpisode >= 1)
            {
               weapon = weaponShotgun;
            }
            else
            {
               weapon = weaponSMG;
            }
         }
      }
      
      public function closeToScreen() : Boolean
      {
         var _loc1_:Number = basex + dx * 70;
         var _loc2_:Number = basey + dy * 70;
         if(_loc1_ < 0 || _loc1_ > 800)
         {
            return true;
         }
         if(_loc2_ < 0 || _loc2_ > 600)
         {
            return true;
         }
         return false;
      }
      
      public function shootingFrame(param1:int = 0) : int
      {
         var _loc2_:int = randTicks % 150;
         if(state == stateStopAndFire)
         {
            if(stateTicks < 25 || stateTicks > stopAndFireEnd)
            {
               return 0;
            }
            _loc2_ = stateTicks;
            param1 = 0;
         }
         if(param1 == 1)
         {
            if(weapon == weaponSniper)
            {
               return 5 + [0,1,2,3,3,2,1,0,0,0,0][shooting];
            }
            if(_loc2_ < 20)
            {
               return _loc2_ / 4;
            }
            if(_loc2_ < 70)
            {
               return 5 + [0,1,2,3,3,2,1,0,0,0,0][shooting];
            }
            if(_loc2_ < 90)
            {
               return 5 - (_loc2_ - 70) / 4;
            }
            return 0;
         }
         if(param1 == 0)
         {
            return 4 + [0,1,2,3,2,1,0,0,0,0][shooting];
         }
         return 0;
      }
      
      public function determineRidingAnimal() : void
      {
         var _loc1_:GameObject = null;
         if(ticks == 5)
         {
            for each(_loc1_ in gs.objects)
            {
               if(_loc1_ is GruntRider)
               {
                  if(distanceToObject(_loc1_) < 40)
                  {
                     riding = GruntRider(_loc1_);
                  }
               }
            }
         }
         if(riding)
         {
            if(riding._removed)
            {
               riding = null;
            }
         }
         if(riding)
         {
            basex = riding.basex;
            basey = riding.basey;
            pushable = false;
         }
         else
         {
            pushable = true;
         }
         if(riding)
         {
            state = stateRiding;
         }
         else if(state == stateRiding)
         {
            changeState(stateRunning);
         }
      }
      
      public function shootOffsetX() : Number
      {
         if(inJetpack())
         {
            return 18;
         }
         if(state != stateInCover)
         {
            return 4;
         }
         return 6;
      }
      
      public function shootOffsetY() : Number
      {
         if(inJetpack())
         {
            return -30;
         }
         if(state != stateInCover)
         {
            return -28;
         }
         return -28;
      }
      
      override public function handlePlayerCollision() : void
      {
         if(this is TrooperJet)
         {
            if(ticks - lastHitPlayer > 200)
            {
               lastHitPlayer = ticks;
               ms.player.handleHit(this);
            }
         }
      }
      
      override public function tintBlue() : Number
      {
         if(frozen > 0)
         {
            return 0.6;
         }
         return 0;
      }
      
      override public function _experience() : int
      {
         return 50;
      }
      
      override public function _remove() : void
      {
         if(square)
         {
            square.covering = null;
            if(square is MountableTurret)
            {
               square.kill();
            }
         }
      }
      
      public function updateSniper() : void
      {
         var _loc2_:GameObject = null;
         var _loc5_:Number = NaN;
         if(weapon != weaponSniper)
         {
            return;
         }
         var _loc1_:Boolean = state == stateInCover || state == stateStopAndFire;
         if(getCoverPeriod() != 1)
         {
            _loc1_ = false;
         }
         if(!_loc1_)
         {
            aimingProgress = 0;
         }
         else
         {
            aimingProgress += 1 / 150;
         }
         if(aimingProgress > 1)
         {
            doShooting(2);
            aimingProgress = 0;
         }
         _loc2_ = helper.conditionallyCreateChild(Embeds.Sniper_line_png,"sline",_loc1_,0.05);
         var _loc3_:GameObject = helper.conditionallyCreateChild(Embeds.Sniper_dot_png,"sdot",_loc1_,0.05);
         var _loc4_:Point = tformed(10,-18);
         if(_loc2_)
         {
            _loc2_.basex = _loc4_.x;
            _loc2_.basey = _loc4_.y;
            _loc2_.baseRotation = modifiedRotation - 90;
            _loc2_.baseHandleX = 0;
            _loc2_.additive = true;
            _loc2_.baseScaleX = 1 + aimingProgress;
            Bitmap(_loc2_.obj).smoothing = true;
         }
         if(_loc3_)
         {
            _loc5_ = stateTicks / 30;
            _loc3_.basex = ms.player.basex + Math.sin(_loc5_ + Math.cos(_loc5_ / 2 + 50) / 8) * 50 * (1 - aimingProgress);
            _loc3_.basey = ms.player.basey + Math.sin(1 + _loc5_ + Math.cos(_loc5_ / 4) / 4) * 40 * (1 - aimingProgress);
            _loc3_.additive = true;
            _loc3_.changeZOrder("AfterAbovePlayer");
         }
      }
      
      public function pushBack(param1:Number, param2:Number) : void
      {
         basex += cosd(param1 + 90) * param2;
         basey += sind(param1 + 90) * param2;
      }
      
      public function doShooting(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!canShoot())
         {
            return;
         }
         if(state == stateJetpack)
         {
            _loc2_ = randTicks % 150;
            _loc3_ = 30 - toughness * 5;
            if(inShield())
            {
               _loc3_ = 50;
            }
            if(_loc2_ > 11 && _loc2_ < 69)
            {
               if(randTicks % _loc3_ == 0)
               {
                  shooting = 1;
               }
            }
         }
         else if(state == stateOnWeapon)
         {
            _loc2_ = randTicks % 150;
            _loc3_ = 15 - toughness * 2;
            if(param1 == 0 || _loc2_ > 11 && _loc2_ < 69)
            {
               if(randTicks % _loc3_ == 0)
               {
                  shooting = 1;
               }
            }
         }
         else if(weapon == weaponSMG)
         {
            _loc2_ = randTicks % 150;
            _loc3_ = 30 - toughness * 5;
            if(inShield())
            {
               _loc3_ = 50;
            }
            if(param1 == 0 || _loc2_ > 11 && _loc2_ < 69)
            {
               if(randTicks % _loc3_ == 0)
               {
                  shooting = 1;
               }
            }
         }
         else if(weapon == weaponShotgun)
         {
            _loc2_ = randTicks % 200;
            if(_loc2_ == 0 || _loc2_ == 50 && toughness >= 2 || _loc2_ == 100 && toughness >= 3)
            {
               shooting = 1;
            }
         }
         else if(weapon == weaponSniper)
         {
            if(param1 == 2)
            {
               shooting = 1;
            }
         }
         else if(weapon == weaponMortar)
         {
            _loc2_ = randTicks % 150;
            _loc3_ = 30 - toughness * 5;
            if(inShield())
            {
               _loc3_ = 50;
            }
            if(param1 == 0 || _loc2_ > 11 && _loc2_ < 69)
            {
               if(randTicks % _loc3_ == 0)
               {
                  shooting = 1;
               }
            }
         }
      }
      
      public function getCoverPeriod() : Number
      {
         if(state == stateCallingForReinforcements)
         {
            return 0;
         }
         if(weapon == weaponSniper)
         {
            return Period.getPeriod(stateTicks,800,0,25,575,600);
         }
         return Period.getPeriod(stateTicks,300,0,25,175,200);
      }
      
      public function shoots() : Boolean
      {
         return false;
      }
      
      public function coverInvalid() : Boolean
      {
         if(lastHit < 5)
         {
            return true;
         }
         var _loc1_:int = logicalSquareX() - square.logicalSquareX();
         var _loc2_:int = logicalSquareY() - square.logicalSquareY();
         if(_loc1_ != 0)
         {
            if(_loc1_ < 0)
            {
               return ms.player.logicalSquareX() <= logicalSquareX();
            }
            return ms.player.logicalSquareX() >= logicalSquareX();
         }
         if(_loc2_ < 0)
         {
            return ms.player.logicalSquareY() <= logicalSquareY();
         }
         return ms.player.logicalSquareY() >= logicalSquareY();
      }
      
      override public function hitBy(param1:BulletBase, param2:int = 0) : void
      {
         if(inShield())
         {
            if(param1)
            {
               if(blah[param1.id] != "asdf")
               {
                  blah[param1.id] = "asdf";
                  param1.hitByShield();
                  if(param1.wep)
                  {
                     shieldHits += param1.wep.boxDamage() / 25;
                  }
                  if(shieldHits > 1)
                  {
                     inShieldTicks = 0;
                     shieldHits = 0;
                  }
               }
            }
            else
            {
               super.hitBy(param1,param2 / 2);
            }
         }
         else
         {
            super.hitBy(param1,param2);
         }
      }
      
      public function updateShooting() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:BulletBase = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         if(!canShoot())
         {
            shooting = 0;
         }
         if(state == stateRiding)
         {
            shooting = 0;
         }
         if(shooting > 0)
         {
            ++shooting;
         }
         if(shooting >= 10)
         {
            shooting = 0;
         }
         if(shooting == 3)
         {
            if(weapon == weaponSMG || weapon == weaponMortar && Math.random() > 0.1 || weapon == weaponMortar && state != stateInCover || state == stateOnWeapon)
            {
               _loc1_ = (Math.random() - 0.5) * 5;
               _loc2_ = _loc2_ = Math.random() * 30 + 10;
               _loc3_ = shootBullet(shootOffsetX(),shootOffsetY());
               _loc4_ = helper.angleToPoint(ms.player.basex,ms.player.basey);
               _loc5_ = ms.player.basex + ms.player.lastdx * _loc2_;
               _loc6_ = ms.player.basey + ms.player.lastdy * _loc2_;
               _loc7_ = helper.angleToPoint(_loc5_,_loc6_) + _loc1_;
               if(Interpolation.distanceToAngle(_loc4_,_loc7_) > 10)
               {
                  _loc7_ = Interpolation.tendTowardsAngle(_loc4_,_loc7_,10);
               }
               if(_loc3_)
               {
                  _loc3_.angle = _loc7_ + 90;
               }
               if(_loc3_)
               {
                  if(this is TrooperJet)
                  {
                     EnemyBulletBase(_loc3_).damageMult = EnemyBulletBase(_loc3_).damageMult * 2;
                  }
                  if(this is TrooperCommander)
                  {
                     EnemyBulletBase(_loc3_).damageMult = EnemyBulletBase(_loc3_).damageMult * 3;
                  }
                  _loc3_.helperAnimation.setFrame(Embeds.trooperBullet[this is TrooperCommander ? 2 : 0]);
                  if(state == stateOnWeapon)
                  {
                     _loc3_.helperAnimation.setFrame(Embeds.trooperBullet[2]);
                  }
                  if(square)
                  {
                     if(distanceToObject(square) < 80)
                     {
                        _loc3_.collisionIgnoreObject = square;
                     }
                  }
               }
            }
            else if(weapon == weaponShotgun)
            {
               _loc2_ = _loc2_ = Math.random() * 30 + 10;
               _loc1_ = (Math.random() - 0.5) * 5;
               _loc8_ = 0;
               while(_loc8_ < 4)
               {
                  _loc3_ = shootBullet(shootOffsetX(),shootOffsetY());
                  _loc5_ = ms.player.basex + ms.player.lastdx * _loc2_;
                  _loc6_ = ms.player.basey + ms.player.lastdy * _loc2_;
                  _loc7_ = helper.angleToPoint(_loc5_,_loc6_) + _loc1_;
                  _loc4_ = helper.angleToPoint(ms.player.basex,ms.player.basey);
                  if(Interpolation.distanceToAngle(_loc4_,_loc7_) > 10)
                  {
                     _loc7_ = Interpolation.tendTowardsAngle(_loc4_,_loc7_,10);
                  }
                  if(_loc3_)
                  {
                     EnemyBulletBase(_loc3_).damageMult = EnemyBulletBase(_loc3_).damageMult * 1.25;
                     _loc3_.baseRotation = _loc7_ + 90 + (_loc8_ - 1.5) * 5;
                     _loc3_.angle = _loc3_.baseRotation;
                     _loc3_.helperAnimation.setFrame(Embeds.trooperBullet[1]);
                     if(square)
                     {
                        if(distanceToObject(square) < 80)
                        {
                           _loc3_.collisionIgnoreObject = square;
                        }
                     }
                  }
                  _loc8_++;
               }
            }
            else if(weapon == weaponSniper)
            {
               _loc3_ = shootBullet(shootOffsetX(),shootOffsetY() - 24);
               if(_loc3_)
               {
                  _loc3_.baseRotation = baseRotation;
                  _loc3_.angle = _loc3_.baseRotation;
                  EnemyBulletBase(_loc3_).damageMult = 5;
                  _loc3_.helperAnimation.setFrame(Embeds.trooperBullet[3]);
                  EnemyBulletBase(_loc3_).speedMult = 2;
                  EnemyBulletBase(_loc3_).boxDamage = 10;
                  if(square)
                  {
                     if(distanceToObject(square) < 80)
                     {
                        _loc3_.collisionIgnoreObject = square;
                     }
                  }
               }
            }
            else if(weapon == weaponMortar)
            {
               _loc3_ = shoot(RunnerGrenade);
               if(_loc3_)
               {
                  _loc3_.baseRotation = baseRotation;
                  _loc3_.angle = _loc3_.baseRotation;
                  RunnerGrenade(_loc3_).effect = 1;
               }
            }
         }
      }
      
      public function inJetpack() : Boolean
      {
         return state == stateJetpack || state == stateJetpackCharge || state == stateJetpackOutOfControl;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.trooperDie;
      }
      
      override public function isFlying() : Boolean
      {
         if(state == stateJetpack)
         {
            return true;
         }
         if(state == stateJetpackCharge)
         {
            return true;
         }
         if(state == stateJetpackLand)
         {
            return true;
         }
         if(state == stateJetpackOutOfControl)
         {
            return true;
         }
         return false;
      }
      
      public function getDestSquare(param1:GameObjectBase = null) : Array
      {
         if(!param1)
         {
            param1 = square;
         }
         var _loc2_:int = param1.logicalSquareX();
         var _loc3_:int = param1.logicalSquareY();
         var _loc4_:int = ms.player.logicalSquareX();
         var _loc5_:int = ms.player.logicalSquareY();
         var _loc6_:int = _loc2_ - _loc4_;
         var _loc7_:int = _loc3_ - _loc5_;
         if(Math.abs(_loc6_) > Math.abs(_loc7_))
         {
            _destSquareX = _loc6_ < 0 ? -1 : 1;
            _destSquareY = 0;
         }
         else
         {
            _destSquareX = 0;
            _destSquareY = _loc7_ < 0 ? -1 : 1;
         }
         return [_destSquareX,_destSquareY];
      }
      
      public function commanderNear() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is TrooperCommander)
            {
               if(distanceToObject(_loc1_) < 350)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function setCover(param1:GameObject) : void
      {
         var _loc2_:GameObjectBase = GameObjectBase(param1);
         square = _loc2_;
         _loc2_.covering = this;
         lastCover = _loc2_;
         changeState(stateHeadingForCover);
      }
      
      public function updateReinforcements() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GameObject = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.radio001_png,"Radio",state == stateCallingForReinforcements,0.05);
         if(_loc1_)
         {
            _loc1_.additive = true;
            _loc1_.imageSet = Embeds.radio;
            _loc1_.animSpeed = 2;
            _loc1_.basex = basex + baseWidth / 2 - 8;
            _loc1_.basey = basey - baseHeight / 2 - 8;
         }
         if(state == stateCallingForReinforcements)
         {
            if(ms.currentLevel.calledForReinforcements)
            {
               changeState(stateInCover);
            }
            if(lastHit < 8)
            {
               changeState(stateInCover);
            }
            if(stateTicks > 300)
            {
               changeState(stateInCover);
               ms.currentLevel.calledForReinforcements = true;
               RewardText.createRewardText(gs,400,300,"ENEMY REINFORCEMENTS!","TextLayer",16730174);
               _loc2_ = 0;
               while(_loc2_ < 3)
               {
                  _loc3_ = new Trooper();
                  EnemyBase(_loc3_).baseAlpha = 0;
                  ms.el.levelEnemies([_loc3_],ms.currentEpisode);
                  while(true)
                  {
                     _loc3_.basex = Math.random() * 700 + 50;
                     _loc3_.basey = Math.random() * 500 + 50;
                     if(_loc3_.distanceToObject(MainScene(gs).player) >= 100)
                     {
                        _loc4_ = false;
                        _loc5_ = -1;
                        while(_loc5_ <= 1)
                        {
                           _loc6_ = -1;
                           while(_loc6_ <= 1)
                           {
                              if(!MainScene(gs).squareExists(_loc3_.basex + _loc5_ * 26,_loc3_.basey + _loc6_ * 26))
                              {
                                 _loc4_ = true;
                              }
                              _loc6_ += 2;
                           }
                           _loc5_ += 2;
                        }
                        EnemyBase(_loc3_).shouldTeleport = true;
                        EnemyBase(_loc3_).teleportOffset = 50 + Math.random() * 100;
                        if(!_loc4_)
                        {
                           break;
                        }
                     }
                  }
                  _loc2_++;
               }
            }
         }
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
      
      public function findCover() : GameObjectBase
      {
         var _loc1_:GameObject = null;
         var _loc2_:GameObjectBase = null;
         var _loc3_:Number = NaN;
         var _loc4_:GameObjectBase = null;
         var _loc5_:Array = null;
         var _loc6_:PathfindSquare = null;
         var _loc7_:Number = NaN;
         var _loc8_:Array = null;
         for each(_loc1_ in ms.objects)
         {
            if(_loc1_ is GameObjectBase)
            {
               _loc4_ = GameObjectBase(_loc1_);
               if(_loc4_.covering)
               {
                  if(_loc4_.covering is Trooper)
                  {
                     if(Trooper(_loc4_.covering).square != _loc4_)
                     {
                        _loc4_.covering = null;
                     }
                  }
               }
            }
         }
         _loc3_ = 0;
         for each(_loc1_ in ms.objects)
         {
            if(_loc1_ != lastCover)
            {
               if(_loc1_ is FloorProp)
               {
                  if(!GameObjectBase(_loc1_).covering)
                  {
                     _loc4_ = GameObjectBase(_loc1_);
                     if(_loc4_ is FloorProp)
                     {
                        if(FloorProp(_loc4_).temporary)
                        {
                           continue;
                        }
                     }
                     if(_loc4_ is FloorProp)
                     {
                        if(_loc4_.animFrame == 23)
                        {
                           continue;
                        }
                     }
                     if(_loc4_ is FloorProp)
                     {
                        if(_loc4_.animFrame == 5)
                        {
                           continue;
                        }
                     }
                     if(_loc4_ is DestructableCover)
                     {
                        if(DestructableCover(_loc4_).destroyed)
                        {
                           continue;
                        }
                     }
                     _loc5_ = getDestSquare(GameObjectBase(_loc1_));
                     _loc6_ = ms.toPlayer.getField(_loc4_.logicalSquareX() + _loc5_[0],_loc4_.logicalSquareY() + _loc5_[1]);
                     if(_loc6_)
                     {
                        if(_loc6_.passable)
                        {
                           _loc7_ = 100 / distanceToObject(_loc1_);
                           _loc7_ = _loc7_ + _loc1_.distanceToObject(ms.player);
                           _loc8_ = getDestSquare(_loc4_);
                           _loc8_[0] = _loc8_[0] + _loc4_.logicalSquareX();
                           _loc8_[1] += _loc4_.logicalSquareY();
                           if(logicalSquareX() == _loc8_[0] && logicalSquareY() == _loc8_[1])
                           {
                              _loc7_ = 100000;
                           }
                           if(_loc7_ > _loc3_)
                           {
                              _loc2_ = GameObjectBase(_loc1_);
                              _loc3_ = _loc7_;
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      override public function tintRed() : Number
      {
         if(frozen > 0)
         {
            return 0.4;
         }
         return 1;
      }
      
      public function updateInJetpack() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:Number = distanceToObject(ms.player);
         facePlayer = false;
         rotateTowardsPlayer = false;
         var _loc2_:Number = followAngle;
         baseRotation = angleToObject(ms.player) + _loc2_;
         if(state == stateJetpackCharge)
         {
            ++charging;
         }
         else
         {
            charging = 0;
         }
         if(state != stateJetpackCharge)
         {
            if(chargingSlowDownStraffe < 100)
            {
               ++chargingSlowDownStraffe;
            }
         }
         if(charging == 0)
         {
            moveAlongAngle(chargingSlowDownStraffe / 100 * 1.7 * sind(randTicks) * (1 - chargingProgress()),baseRotation,false);
         }
         baseRotation = angleToObject(ms.player) + 90;
         if(state == stateJetpackCharge)
         {
            if(!chargingSlowingDown)
            {
               baseRotation = chargeRotation + 90;
            }
            _loc3_ = basex;
            _loc4_ = basey;
            if(closeToScreen())
            {
               if(!chargingSlowingDown)
               {
                  chargingSlowingDown = 1;
               }
            }
            _loc5_ = 3 * chargingProgress();
            if(chargingSlowingDown)
            {
               ++chargingSlowingDown;
               _loc8_ = 1 - chargingSlowingDown / 75;
               if(_loc8_ < 0.2)
               {
                  _loc8_ = 0.2;
               }
               _loc5_ *= _loc8_;
            }
            moveAlongAngle(_loc5_,chargeRotation,false);
            _loc6_ = basex - _loc3_;
            _loc7_ = basey - _loc4_;
            if(chargingSlowingDown > 75)
            {
               state = stateJetpack;
            }
            chargingSlowDownStraffe = 0;
         }
         else
         {
            doShooting();
            if(ticks - lastJetpackCharge > nextCharge)
            {
               if(helperFilter.rotationAligned())
               {
                  if(1.7 * sind(randTicks) < 0.05)
                  {
                     state = stateJetpackCharge;
                     chargeRotation = baseRotation - 90;
                     chargingDist = distanceToPlayer() + 150;
                     chargingSlowingDown = 0;
                     nextCharge = 400 + Math.random() * 600;
                     lastJetpackCharge = ticks;
                  }
               }
            }
         }
      }
      
      override public function collisionWidth() : Number
      {
         if(riding)
         {
            return 1;
         }
         return super.collisionWidth() * 0.25;
      }
      
      public function updateAnimation() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         rotateFilter.rotSpeed = 2;
         legs.hidden = false;
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.trooper_jet_fly_thrust001_png,"jetAdditive",inJetpack(),1);
         if(inJetpack())
         {
            rotateFilter.rotSpeed = 1.6;
            legs.hidden = true;
            imageSet = fly;
            animSpeed = 0;
            _loc2_ = stateTicks / 5;
            if(_loc2_ > 6)
            {
               _loc2_ = 7 + [0,1,2,1][(_loc2_ - 7) % 4];
            }
            setFrame(_loc2_ % imageSet.length);
            _loc1_.helperAnimation.setFrame(flyAdditive[_loc2_ % imageSet.length]);
            _loc1_.baseRotation = modifiedRotation;
            _loc1_.basex = basex;
            _loc1_.basey = basey;
            _loc1_.additive = true;
         }
         else if(state == stateJetpackLand)
         {
            if(stateTicks < 50)
            {
               setFrame(5 - stateTicks / 10);
            }
            else
            {
               legs.animSpeed = 0;
               imageSet = walk;
               animSpeed = 3;
            }
         }
         else if(state == stateOnWeapon)
         {
            imageSet = aim;
            animSpeed = 0;
         }
         else if(state == stateInCover || state == stateCallingForReinforcements)
         {
            legs.hidden = true;
            imageSet = aim;
            animSpeed = 0;
            _loc3_ = getCoverPeriod();
            _loc4_ = 12 - 6 * _loc3_;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            if(_loc4_ > 12)
            {
               _loc4_ = 12;
            }
            setFrame(_loc4_);
            _loc5_ = shootingFrame();
            if(getCoverPeriod() > 0.9)
            {
               if(_loc5_ > 0)
               {
                  _loc5_ -= 5;
                  helperAnimation.setFrame(coverFire[_loc5_]);
               }
            }
         }
         else if(state == stateThrowingGrenade)
         {
            legs.hidden = true;
            imageSet = grenade;
            animSpeed = 0;
            setFrame(stateTicks / 5);
         }
         else if(state == stateStopAndFire)
         {
            legs.animFreeze = true;
            imageSet = fire;
            animSpeed = 0;
            if(stateTicks < 25)
            {
               setFrame(stateTicks / 5);
            }
            else if(stateTicks > stopAndFireEnd)
            {
               setFrame(5 - (stateTicks - stopAndFireEnd) / 5);
            }
            else
            {
               setFrame(shootingFrame(0));
            }
         }
         else if(state == stateHeadingForCover || state == stateRunning || state == stateRunningForPlayer)
         {
            imageSet = fire;
            animSpeed = 0;
            if(state == stateRunningForPlayer || state == stateRunning)
            {
               setFrame(shootingFrame(0));
            }
            else
            {
               setFrame(shootingFrame(1));
            }
         }
         else
         {
            animSpeed = 3;
            imageSet = walk;
         }
         if(legs)
         {
            if(state == stateRiding && Boolean(riding))
            {
               legs.imageSet = riderLegs;
               legs.animSpeed = 0;
               legs.setFrame(int(riding.animFrame) % 5);
               legs.baseRotation = riding.baseRotation;
               legs.changeZOrder(zOrderString,true);
               riding.changeZOrder(zOrderString,true);
               animSpeed = 0;
            }
            else
            {
               legs.imageSet = TrooperLegs_constructor.imageSet;
               legs.animSpeed = 3;
            }
         }
      }
      
      public function chargingProgress() : Number
      {
         return charging / 100;
      }
      
      public function changeState(param1:int) : void
      {
         if(state == param1)
         {
            return;
         }
         state = param1;
         stateTicks = 0;
         stateRandomOffset = Math.random();
         if(state == stateThrowingGrenade)
         {
            lastGrenade = 0;
         }
         if(state == stateRunningForPlayer)
         {
            square = null;
         }
         if(state == stateStopAndFire)
         {
            stopAndFireEnd = 125;
         }
      }
      
      override public function getPathfind() : PathfindToPoint
      {
         if(Boolean(square) || state == stateHeadingForWeapon)
         {
            return customPathfind;
         }
         return ms.toPlayer;
      }
      
      override public function growlSound() : GameSound
      {
         return Sounds.trooperGrowl;
      }
      
      override public function tintGreen() : Number
      {
         if(frozen > 0)
         {
            return 1;
         }
         return 0;
      }
      
      public function destSquareX() : int
      {
         return _destSquareX;
      }
      
      public function inShield() : Boolean
      {
         if(state == stateOnWeapon)
         {
            return false;
         }
         if(commanderInRoom())
         {
            return false;
         }
         if(isTeleporting())
         {
            return false;
         }
         if(this is TrooperJet)
         {
            return false;
         }
         if(disableShield)
         {
            return false;
         }
         return inShieldTicks > 0;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         var _loc3_:GameObject = null;
         var _loc4_:GameObject = null;
         var _loc6_:Number = NaN;
         var _loc7_:BitmapData = null;
         var _loc8_:GameObjectBase = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:TrooperGrenade = null;
         var _loc15_:Array = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:int = 0;
         var _loc23_:Number = NaN;
         collidesWithWalls = state != stateJetpack;
         pushWeight = state == stateInCover ? 1000 : 1;
         updateRank();
         updateShooting();
         updateSniper();
         updateReinforcements();
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is ShieldPickup || _loc1_ is ShieldLargePickup || _loc1_ is TimeRechargePickup)
            {
               if(distanceToObject(_loc1_) < 20)
               {
                  _loc1_.remove();
                  inShieldTicks = 1000;
               }
            }
         }
         if(inShieldTicks > 0)
         {
            --inShieldTicks;
         }
         var _loc2_:GameObject = helper.conditionallyCreateChild(Embeds.trooper_shadow001_png,"shadow",!beforeTeleporting(),1,null,baseAlpha * fallingAlpha());
         if(_loc2_)
         {
            _loc2_.basex = basex;
            _loc2_.basey = basey;
            _loc2_.imageSet = shadow;
            _loc2_.animSpeed = animSpeed;
            _loc2_.changeZOrder("Floor");
            if(inJetpack())
            {
               if(!jetpackShadow)
               {
                  jetpackShadow = new Embeds.trooper_jet_fly_shadow_png().bitmapData;
               }
               _loc6_ = stateTicks / 50;
               if(_loc6_ > 1)
               {
                  _loc6_ = 1;
               }
               _loc2_.basex = basex + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1) * _loc6_;
               _loc2_.basey = basey + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1) * _loc6_;
               _loc2_.helperAnimation.setFrame(jetpackShadow);
               _loc2_.baseRotation = helper.getModifiedRotation();
            }
         }
         slowAroundCorners = !inJetpack();
         if(state == stateJetpackLand)
         {
            if(stateTicks < 100)
            {
               slowAroundCorners = false;
            }
         }
         _loc3_ = helper.conditionallyCreateChild(Embeds.trooper_shield001_png,"shield",inShield(),0.05,null,baseAlpha * fallingAlpha());
         if(_loc3_)
         {
            _loc3_.basex = basex;
            _loc3_.basey = basey;
            _loc3_.additive = true;
            if(inShield())
            {
               _loc3_.baseScaleX = 1 - shieldHits * 0.3;
               _loc3_.baseScaleY = 1 - shieldHits * 0.3;
               Bitmap(_loc3_.obj).smoothing = true;
            }
            _loc7_ = Embeds.enemyShield[ticks / 8 % 16];
            if(_loc7_)
            {
               _loc3_.helperAnimation.setFrame(_loc7_);
            }
         }
         if(this is TrooperCommander)
         {
            _loc4_ = helper.conditionallyCreateChild(Embeds.aura_large_png,"aura",!beforeTeleporting(),0.05,null,baseAlpha);
         }
         else
         {
            _loc4_ = helper.conditionallyCreateChild(Embeds.aura_small_png,"aura",commanderNear() && !beforeTeleporting(),0.05,null,baseAlpha);
            _loc4_ = helper.conditionallyCreateChild(Embeds.aura_small_png,"aura",commanderNear() && !beforeTeleporting(),0.05,null,baseAlpha);
         }
         if(_loc4_)
         {
            _loc4_.additive = true;
            _loc4_.changeZOrder("Floor",true);
            _loc4_.basex = basex;
            _loc4_.basey = basey;
         }
         determineRidingAnimal();
         if(isTeleporting())
         {
            super._update();
            return;
         }
         ++lastGrenade;
         ++stateTicks;
         if(square)
         {
            if(square._removed || (square is DestructableCover ? Boolean(DestructableCover(square).destroyed) : Boolean(false)))
            {
               changeState(stateRunning);
               square = null;
            }
         }
         if(state != stateRunningForPlayer && !(this is TrooperJet))
         {
            if(ticks - lastInCover > 50 || lastHit < 2)
            {
               if(!square)
               {
                  _loc8_ = findCover();
                  if(_loc8_)
                  {
                     if(!_loc8_.covering)
                     {
                        setCover(_loc8_);
                     }
                  }
               }
            }
         }
         if(ticks == 100)
         {
            customPathfind.reconstructGraph(0,0);
         }
         if(square)
         {
            getDestSquare();
            _loc9_ = destSquareX();
            _loc10_ = destSquareY();
            if(state == stateGettingOnWeapon)
            {
               _loc9_ = 0;
               _loc10_ = 0;
            }
            customPathfind.reconstructGraph(square.logicalSquareX() + _loc9_,square.logicalSquareY() + _loc10_);
            if(state == stateInCover)
            {
               if(coverInvalid())
               {
                  square.covering = null;
                  square = null;
                  state = stateRunning;
                  lastInCover = ticks;
               }
            }
         }
         customPathfind.lazyUpdate();
         if(blockUpdating())
         {
            super._update();
            return;
         }
         if(state == stateThrowingGrenade)
         {
            if(stateTicks > 400)
            {
               changeState(stateInCover);
            }
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
         var _loc5_:Number = 1.5;
         if(distanceToPlayer() < 120)
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
         if(square)
         {
            if(state == stateInCover)
            {
               if(distanceToPlayer() < 250)
               {
                  changeState(stateRunningForPlayer);
               }
            }
         }
         if(square)
         {
            if(state == stateInCover || state == stateThrowingGrenade || state == stateCallingForReinforcements || state == stateOnWeapon)
            {
               moveTowardsPlayer(0);
               if(state == stateOnWeapon)
               {
                  square.baseRotation = helper.getModifiedRotation();
               }
               _loc11_ = angleToObject(ms.player) + 90;
               _loc12_ = Interpolation.distanceToAngle(coverRotation,_loc11_);
               _loc13_ = Interpolation.directionToAngle(coverRotation,_loc11_);
               baseRotation = coverRotation + _loc13_ * _loc12_ * getCoverPeriod();
               if(state == stateOnWeapon)
               {
                  baseRotation = _loc11_;
               }
               if(state != stateOnWeapon)
               {
                  if(getCoverPeriod() < 0.1)
                  {
                     if(lastGrenade > 500 || this is TrooperCommander)
                     {
                        if(randTicks % 100 == 0)
                        {
                           if(!(this is TrooperCommander))
                           {
                              if(distanceToPlayer() < 400 && canShoot())
                              {
                                 changeState(stateThrowingGrenade);
                              }
                           }
                           else if(!ms.currentLevel.calledForReinforcements)
                           {
                              changeState(stateCallingForReinforcements);
                              Sounds.radio.play();
                           }
                        }
                     }
                  }
               }
               if(state == stateThrowingGrenade)
               {
                  if(stateTicks == 50)
                  {
                     _loc14_ = TrooperGrenade(shoot(TrooperGrenade,-15,-12,false));
                     if(_loc14_)
                     {
                        _loc14_.setSpeedBasedOnDistance(distanceToPlayer() + (Math.random() - 0.5) * 100);
                        _loc14_.source = this;
                        Sounds.grenadeWarning.play();
                     }
                  }
                  if(stateTicks > 150)
                  {
                     changeState(stateInCover);
                  }
               }
               if(getCoverPeriod() > 0.9)
               {
                  if(state != stateThrowingGrenade)
                  {
                     if(weapon != weaponSniper)
                     {
                        doShooting();
                     }
                  }
               }
            }
            else
            {
               _loc15_ = getDestSquare(square);
               if(!ms.toPlayer.getField(customPathfind.lastMarkX,customPathfind.lastMarkY).passable)
               {
                  if(square.covering == this)
                  {
                     square.covering = null;
                  }
                  square = null;
                  changeState(stateRunningForPlayer);
               }
               else
               {
                  _loc16_ = customPathfind.lastMarkX;
                  _loc17_ = customPathfind.lastMarkY;
                  if(state == stateGettingOnWeapon)
                  {
                     _loc16_ = square.logicalSquareX();
                     _loc17_ = square.logicalSquareY();
                  }
                  _loc18_ = MainScene.getSquareX(_loc16_);
                  _loc19_ = MainScene.getSquareY(_loc17_);
                  if(state == stateGettingOnWeapon)
                  {
                     _loc15_[0] *= -1;
                     _loc15_[1] *= -1;
                  }
                  _loc20_ = _loc18_ - 13 * _loc15_[0];
                  _loc21_ = _loc19_ - 13 * _loc15_[1];
                  _loc22_ = moveTowardsSquare(_loc5_,_loc16_,_loc17_,_loc20_,_loc21_);
                  doShooting(1);
               }
               if(_loc22_ < 5)
               {
                  if(square is MountableTurret)
                  {
                     if(state == stateGettingOnWeapon)
                     {
                        changeState(stateOnWeapon);
                     }
                     else
                     {
                        changeState(stateGettingOnWeapon);
                     }
                  }
                  else
                  {
                     coverRotation = Math.atan2(_loc15_[1],_loc15_[0]) * 180 / Math.PI - 90;
                     changeState(stateInCover);
                  }
               }
            }
         }
         else if(state == stateStopAndFire)
         {
            moveTowardsPlayer(0);
            doShooting();
            if(stateTicks > 150)
            {
               if(this is TrooperJet)
               {
                  if(ticks > takeoffTicks)
                  {
                     changeState(stateJetpack);
                  }
               }
               else
               {
                  changeState(stateRunningForPlayer);
                  stateTicks = 100;
               }
            }
         }
         else if(this is TrooperJet)
         {
            if(ticks > takeoffTicks)
            {
               if(!inJetpack())
               {
                  changeState(stateJetpack);
               }
            }
            else if(state == stateRunning)
            {
               changeState(stateStopAndFire);
               stopAndFireEnd = 9999;
            }
            if(inJetpack())
            {
               updateInJetpack();
            }
            else if(state == stateJetpackLand)
            {
               _loc23_ = Interpolation.linearInterpolateLock(_loc5_ * 2,_loc5_,stateTicks / 100);
               moveTowardsPlayer(_loc23_);
               if(distanceToPlayer() > 200)
               {
                  if(stateTicks > 500)
                  {
                     changeState(stateJetpack);
                  }
               }
            }
         }
         else
         {
            moveTowardsPlayer(_loc5_);
            if(randTicks % 400 == 0 || distanceToPlayer() < 200)
            {
               changeState(stateStopAndFire);
            }
            if(state == stateInCover)
            {
               changeState(stateRunning);
            }
         }
         updateAnimation();
      }
      
      override public function collisionHeight() : Number
      {
         if(riding)
         {
            return 1;
         }
         return super.collisionHeight() * 0.25;
      }
      
      public function destSquareY() : int
      {
         return _destSquareY;
      }
      
      public function commanderInRoom() : int
      {
         var _loc1_:GameObject = null;
         if(_commanderInRoom == -1)
         {
            _commanderInRoom = 0;
            for each(_loc1_ in gs.objects)
            {
               if(_loc1_ is TrooperCommander)
               {
                  _commanderInRoom = 1;
               }
            }
         }
         return _commanderInRoom;
      }
   }
}

