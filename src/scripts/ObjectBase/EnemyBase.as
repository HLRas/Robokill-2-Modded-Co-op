package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilter;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.BFG;
   import Objects.BatNest;
   import Objects.BigTurret;
   import Objects.BigTurretBullet;
   import Objects.DroidBullet;
   import Objects.EnemyCrack;
   import Objects.EnemyCrackFake;
   import Objects.EnemyLaser;
   import Objects.GooTurret;
   import Objects.GruntBullet;
   import Objects.GunFighter;
   import Objects.HoverTrooper;
   import Objects.HulkBullet;
   import Objects.HunterBullet;
   import Objects.Nest;
   import Objects.PickupText;
   import Objects.RunnerGrenade;
   import Objects.ShootingGrunt;
   import Objects.SleeperBullet;
   import Objects.Spawn;
   import Objects.SpiderGunner;
   import Objects.SpiderGunnerShot;
   import Objects.SpiderShot;
   import Objects.SpiderSpit;
   import Objects.Tumor;
   import Objects.WalkerTurret;
   import Particles.Particle;
   import Scenes.MainMenu;
   import Scenes.MainScene;
   import Tools.Input;
   import Tools.Interpolation;
   import Tools.PathfindSquare;
   import Tools.PathfindToPoint;
   import Tools.Random;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class EnemyBase extends ActorBase
   {
      
      public static var levelMult:Array = [1.219,3.674,3.494,4.574,8.114,12.91,9.076,8.399,11.18,10.13,16.65,10.73];
      
      public static var toughnessMult:Array = [1,3,6];
      
      internal var lastDestX:int = -1;
      
      internal var lastDestY:int = -1;
      
      public var legSpeedConst:Number = 1;
      
      public var tumorObject:Tumor;
      
      public var movementLastX:Number = 0;
      
      public var hitSucceeded:Boolean = false;
      
      public var movementLastY:Number = 0;
      
      public var canMoveToPlayer:Boolean = false;
      
      public var determineMoveToPlayer:Boolean = false;
      
      public var legs:LegsBase;
      
      public var hasBeenFrozen:Boolean = false;
      
      public var needsToAim:Boolean = true;
      
      public var hasSetupSlowRotation:Boolean = false;
      
      public var setsImpassable:Boolean = false;
      
      public var rotateTowardsPlayer:Boolean = true;
      
      public var greenColors:Array = [0,-0.54,0.21];
      
      public var collidesWithPlayer:Boolean = true;
      
      public var endTicks:int = 0;
      
      public var redColors:Array = [1,1.18,0];
      
      public var b:Number = 0.61;
      
      public var g:Number = -0.54;
      
      public var blocksNewLevel:Boolean = true;
      
      public var doingLegSpeed:Boolean = true;
      
      public var r:Number = 1.18;
      
      public var hasTumor:Boolean;
      
      public var blueColors:Array = [0,0.61,0.79];
      
      public var save:Boolean = true;
      
      public var lastHitBullet:BulletBase;
      
      public var extraHealth:int = 40;
      
      public var baseHealth:int = 5;
      
      public var forceRandom:int = 0;
      
      public var lastRandomMovementY:int;
      
      public var toughness:int = 0;
      
      public var stunned:int = 0;
      
      public var nextSquarePosX:Number = 0;
      
      public var nextSquarePosY:Number = 0;
      
      public var lastRandomMovementX:int;
      
      public var facePlayer:Boolean = false;
      
      public var frozen:int = 0;
      
      public var _killed:Boolean = false;
      
      public var extradx:Number = 0;
      
      public var extrady:Number = 0;
      
      public var mtpPlayerX:int = -1;
      
      public var mtpPlayerY:int = -1;
      
      public var slowAroundCorners:Boolean = true;
      
      public var legs2:GameObject;
      
      public var inertia:Number = 0.9;
      
      public var totalHealth:int = 0;
      
      public var chooseNewPath:int = 0;
      
      public var mtpX:int = -1;
      
      public var mtpY:int = -1;
      
      public var angle:Number = 0;
      
      public var bouncesOffSides:Boolean = false;
      
      public var firstShotDelay:int = 70 + 30 * Math.random();
      
      public var organic:Boolean = true;
      
      public var nextSquare:PathfindSquare;
      
      public function EnemyBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3,param4,param5);
         ms = MainScene(param1);
         if(ms.currentEpisode > 1)
         {
            if(canHaveTumor())
            {
               if(MainScene(param1).currentLevel.tumorRoom)
               {
                  hasTumor = Math.random() < 0.5 ? true : false;
               }
            }
         }
         if(!(this is EnemyCrack || this is EnemyCrackFake || this is Nest || this is Spawn || this is EggBase || this is BatNest))
         {
            baseRotation = Math.random() * 360;
         }
      }
      
      public function shootBullet(param1:int, param2:int, param3:Number = 1) : EnemyBulletBase
      {
         var _loc5_:EnemyBulletBase = null;
         if(!canShoot())
         {
            return null;
         }
         getFireSound().play();
         var _loc4_:Point = this.tformed(param1,param2);
         var _loc6_:Boolean = false;
         if(this is WalkerTurretBase)
         {
            if(WalkerTurret(this).front)
            {
               _loc6_ = true;
            }
         }
         if(this is SpiderGunner)
         {
            _loc5_ = new SpiderGunnerShot(gs,_loc4_.x,_loc4_.y);
         }
         else if(this is HoverBase)
         {
            _loc5_ = new DroidBullet(gs,_loc4_.x,_loc4_.y);
         }
         else if(this is GunFighter || this is WalkerTurret)
         {
            _loc5_ = new HunterBullet(gs,_loc4_.x,_loc4_.y);
            _loc5_.damageMult *= 1.5;
         }
         else if(_loc6_)
         {
            _loc5_ = new SleeperBullet(gs,_loc4_.x,_loc4_.y);
         }
         else if(this is BigTurret || this is BFG)
         {
            _loc5_ = new BigTurretBullet(gs,_loc4_.x,_loc4_.y);
         }
         else if(this is ShootingGrunt)
         {
            _loc5_ = new GruntBullet(gs,_loc4_.x,_loc4_.y);
         }
         else if(this is SpiderSpitBase)
         {
            _loc5_ = new RunnerGrenade(gs,_loc4_.x,_loc4_.y);
         }
         else if(this is SleeperBase || this is HoverTrooper)
         {
            _loc5_ = new SleeperBullet(gs,_loc4_.x,_loc4_.y);
         }
         else if(this is MineLayerBase)
         {
            _loc5_ = new EnemyLaser(gs,_loc4_.x,_loc4_.y);
            EnemyLaser(_loc5_).startx = _loc4_.x;
            EnemyLaser(_loc5_).starty = _loc4_.y;
            EnemyLaser(_loc5_).endx = MainScene(gs).player.basex;
            EnemyLaser(_loc5_).endy = MainScene(gs).player.basey;
         }
         else
         {
            _loc5_ = new HulkBullet(gs,_loc4_.x,_loc4_.y);
         }
         _loc5_.from = this;
         if(this is BeserkerBase)
         {
            _loc5_.damageMult = 4;
         }
         _loc5_.baseRotation = baseRotation + (Math.random() - 0.5) * 15;
         _loc5_.speedMult = param3;
         _loc5_.angle = _loc5_.baseRotation;
         if(this is WalkerTurretBase)
         {
            _loc5_.speedMult *= 1.4;
         }
         if(!(this is SpiderSpitBase))
         {
            _loc5_.toughness = toughness;
            _loc5_.tint(tintRed(),tintGreen(),tintBlue());
         }
         var _loc7_:String = "Shoot";
         if(this is BigTurret)
         {
            _loc7_ = "ShootBig";
         }
         if(this is MineLayerBase || this is SpiderGunnerBase)
         {
            _loc7_ = "LaserShoot";
         }
         if(!(this is SpiderSpit))
         {
            emitConditionalParticles(_loc7_,param1,param2 - 8,false,baseRotation);
         }
         return _loc5_;
      }
      
      public function moveToDest(param1:Number) : void
      {
         var _loc2_:Number = Math.atan2(nextSquarePosY - basey,nextSquarePosX - basex) * 180 / Math.PI;
         moveAlongAngle(param1,_loc2_);
      }
      
      public function _experience() : int
      {
         trace("NO EXPERIENCE SET!!! " + String(this));
         return 1;
      }
      
      override public function handlePlayerCollision() : void
      {
         if(ms.player.falling)
         {
            return;
         }
         if(!collidesWithPlayer)
         {
            return;
         }
         if(isTeleporting())
         {
            return;
         }
         if(MainScene(gs).player.inShield())
         {
            if(ticks % 10 == 0)
            {
               if(ticks % 40 == 0)
               {
                  hitBy(null,1);
               }
               else
               {
                  hitBy(null,0);
               }
            }
         }
         else
         {
            doExplosion();
            MainScene(gs).player.handleHit(this);
            if(ms.player.shields >= 0)
            {
               kill();
            }
         }
      }
      
      public function itemDropLevel() : int
      {
         return 1;
      }
      
      public function shootMissile(param1:int, param2:int) : SpiderShot
      {
         if(!canShoot())
         {
            return null;
         }
         Sounds.rocketShoot.play();
         var _loc3_:SpiderShot = new SpiderShot(gs,0,0);
         _loc3_.basex = tformedX(param1,param2);
         _loc3_.basey = tformedY(param1,param2);
         _loc3_.dx = 0;
         _loc3_.dy = 0;
         _loc3_.baseRotation = baseRotation + (Math.random() - 0.5) * 20;
         _loc3_.angle = _loc3_.baseRotation;
         _loc3_.released = true;
         if(this is BeserkerBase)
         {
            _loc3_.damageMult = 4;
         }
         return _loc3_;
      }
      
      public function shoot(param1:Class, param2:Number = 0, param3:Number = 0, param4:Boolean = true, param5:Number = 15) : EnemyBulletBase
      {
         if(!canShoot(!(this is GooTurret)))
         {
            return null;
         }
         var _loc6_:EnemyBulletBase = new param1();
         _loc6_.basex = basex;
         _loc6_.basey = basey;
         _loc6_.speedMult = 1;
         _loc6_.angle = baseRotation + (Math.random() - 0.5) * param5;
         _loc6_.baseRotation = _loc6_.angle;
         _loc6_.toughness = toughness;
         if(!_loc6_ is GrenadeBase)
         {
            _loc6_.tint(tintRed(),tintGreen(),tintBlue());
         }
         _loc6_.move(param2,param3);
         _loc6_.source = this;
         var _loc7_:String = "Shoot";
         if(param4)
         {
            emitConditionalParticles(_loc7_,param2,param3 - 8,false,baseRotation);
         }
         return _loc6_;
      }
      
      public function saveBetweenLevels() : Boolean
      {
         return save;
      }
      
      public function setupDifficulty(param1:int) : void
      {
         toughness = param1;
         if(param1 > 0)
         {
            if(blockUpdating())
            {
               super._update();
               return;
            }
         }
         tint(1,0,0);
         health = baseHealth + param1 * extraHealth;
         totalHealth = health;
      }
      
      public function handleSideBounce() : void
      {
         var _loc1_:Number = collisionWidth();
         var _loc2_:Number = collisionHeight();
         if(basex - _loc1_ / 2 < 0)
         {
            basex = 2 * (_loc1_ / 2) - basex;
            dx *= -1;
         }
         if(basex + _loc1_ / 2 > 800)
         {
            basex = 2 * (800 - _loc1_ / 2) - basex;
            dx *= -1;
         }
         if(basey - _loc2_ / 2 < 0)
         {
            basey = 2 * (_loc2_ / 2) - basey;
            dy *= -1;
         }
         if(basey + _loc2_ / 2 > 600)
         {
            basey = 2 * (600 - _loc2_ / 2) - basey;
            dy *= -1;
         }
      }
      
      public function moveTowardsSquare(param1:Number, param2:int, param3:int, param4:Number = -100, param5:Number = -100) : int
      {
         var _loc9_:PathfindSquare = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:PathfindSquare = null;
         var _loc6_:Number = MainScene.getSquareX(param2);
         var _loc7_:Number = MainScene.getSquareY(param3);
         if(param4 > 0 || param5 > 0)
         {
            _loc6_ = param4;
            _loc7_ = param5;
         }
         var _loc8_:Number = distanceToPoint(_loc6_,_loc7_);
         if(_loc8_ < 3)
         {
            return _loc8_;
         }
         if(_loc8_ > 40)
         {
            _loc9_ = getPathfind().getField(logicalSquareX(),logicalSquareY());
            if(_loc9_)
            {
               _loc10_ = logicalSquareX() + _loc9_.dirx;
               _loc11_ = logicalSquareY() + _loc9_.diry;
               if(canMoveToPlayer)
               {
               }
               if(_loc10_ >= 0 && _loc10_ < 800 / 40)
               {
                  if(_loc11_ >= 0 && _loc11_ < 600 / 40)
                  {
                     _loc12_ = getPathfind().field[_loc10_][_loc11_];
                  }
               }
               setNextSquare(_loc9_,_loc12_);
            }
            moveToDest(param1);
         }
         else
         {
            moveAlongAngle(param1,helper.angleToPoint(_loc6_,_loc7_));
         }
         return _loc8_;
      }
      
      public function moveAlongAngle(param1:Number, param2:Number, param3:Boolean = true) : void
      {
         var _loc5_:GameObjectFilter = null;
         if(isTeleporting())
         {
            return;
         }
         var _loc4_:Number = angleToObject(MainScene(gs).player);
         if(rotateTowardsPlayer)
         {
            baseRotation = _loc4_ + 90;
         }
         if(legs)
         {
            legs.baseRotation = param2 + 90;
            if(legs2)
            {
               legs2.baseRotation = param2 + 90;
            }
         }
         else if(!facePlayer)
         {
            baseRotation = param2 + 90;
         }
         if(MainScene(gs).justFinishedFading())
         {
            if(legs)
            {
               for each(_loc5_ in legs.filters)
               {
                  if(_loc5_ is GameObjectFilterRotateSlowly)
                  {
                     GameObjectFilterRotateSlowly(_loc5_).internalRotation = param2 + 90;
                  }
               }
            }
         }
         if(slowAroundCorners)
         {
            if(Interpolation.distanceToAngle(baseRotation,modifiedRotation) > 1)
            {
               param1 /= Math.sqrt(Interpolation.distanceToAngle(baseRotation,modifiedRotation));
            }
         }
         else if(param3)
         {
            param2 = modifiedRotation - 90;
         }
         param1 *= ms.globalSpeed;
         dx += cosd(param2) * param1 * (1 - inertia);
         dy += sind(param2) * param1 * (1 - inertia);
         dx *= inertia;
         dy *= inertia;
         basex += dx;
         basey += dy;
         doLegsSpeed(param1);
      }
      
      public function canShoot(param1:Boolean = true) : Boolean
      {
         if(ticks < firstShotDelay)
         {
            return false;
         }
         if(needsToAim)
         {
            if(param1)
            {
               if(Interpolation.distanceToAngle(modifiedRotation,angleToObject(shootTarget()) + 90) > 30)
               {
                  return false;
               }
            }
         }
         if(MainScene(gs).currentLevel.ambushRoom)
         {
            return false;
         }
         if(MainScene(gs).fading)
         {
            return false;
         }
         if(falling)
         {
            return false;
         }
         if(MainScene(gs).player._removed)
         {
            return false;
         }
         if(frozen > 0)
         {
            return false;
         }
         return true;
      }
      
      public function _doLegsSpeed(param1:GameObject, param2:Number) : void
      {
         if(!doingLegSpeed)
         {
            return;
         }
         if(frozen)
         {
            param1.animFreeze = true;
         }
         else
         {
            param1.animFreeze = false;
         }
         param1.animSpeed = 3 / param2 * legSpeedConst;
         var _loc3_:Number = Interpolation.distanceToAngle(param1.baseRotation,param1.modifiedRotation);
         if(slowAroundCorners)
         {
            if(_loc3_ > 4)
            {
               param1.animSpeed *= Math.sqrt(_loc3_);
            }
         }
      }
      
      public function shrapnelCount() : int
      {
         return 2;
      }
      
      public function stunnable() : Boolean
      {
         return true;
      }
      
      public function moveTowardsPlayerFly(param1:Number = 1) : void
      {
         var _loc2_:PlayerBase = MainScene(gs).player;
         var _loc3_:PathfindSquare = getPathfind().getField(logicalSquareX(),logicalSquareY());
         var _loc4_:PathfindSquare = getPathfind().getField(_loc2_.logicalSquareX(),_loc2_.logicalSquareY());
         setNextSquare(_loc3_,_loc4_);
         moveToPoint(param1);
      }
      
      public function killSound() : GameSound
      {
         return Sounds.alienMediumDie;
      }
      
      public function isFlying() : Boolean
      {
         return false;
      }
      
      public function doPlayerPathfindCheck() : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:PlayerBase = MainScene(gs).player;
         var _loc2_:int = _loc1_.logicalSquareX();
         var _loc3_:int = _loc1_.logicalSquareY();
         var _loc4_:int = logicalSquareX();
         var _loc5_:int = logicalSquareY();
         if(_loc2_ != mtpPlayerX || _loc3_ != mtpPlayerY || _loc4_ != mtpX || _loc5_ != mtpY)
         {
            mtpPlayerX = _loc2_;
            mtpPlayerY = _loc3_;
            mtpX = _loc4_;
            mtpY = _loc5_;
            _loc6_ = Math.abs(_loc2_ - _loc4_) + 1;
            _loc7_ = Math.abs(_loc3_ - _loc5_) + 1;
            if(_loc6_ * _loc7_ <= 1200)
            {
               canMoveToPlayer = isPathOK(_loc2_,_loc3_);
            }
            else
            {
               canMoveToPlayer = false;
            }
         }
      }
      
      public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         var _loc3_:String = null;
         var _loc4_:Particle = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:PickupText = null;
         hitSucceeded = false;
         if(hidden)
         {
            return;
         }
         if(isTeleporting())
         {
            return;
         }
         if(collisionWidth() == 0)
         {
            return;
         }
         if(ticks < 10)
         {
            return;
         }
         if(param1)
         {
            if(param1.hitList[id] == true)
            {
               return;
            }
            param1.hasHit(this);
            param1.hitList[id] = true;
            health -= param1.damage();
         }
         else if(param2 == -1)
         {
            if(toughness == 0)
            {
               health -= 10;
            }
            else
            {
               health -= 30;
            }
         }
         else
         {
            health -= param2;
         }
         if(lastHit > 9)
         {
            lastHit = 0;
         }
         if(param1 is BulletBase)
         {
            lastHitBullet = BulletBase(param1);
         }
         if(MainMenu.levelOfDetail)
         {
            if(organic)
            {
               _loc3_ = "EnemyHitBlood";
               if(Math.random() < 0.5)
               {
                  _loc3_ += "2";
               }
               _loc4_ = emitConditionalParticles(_loc3_)[0];
               if(_loc4_)
               {
                  _loc5_ = Math.random() * 360;
                  if(param1)
                  {
                     _loc5_ = param1.angle - 90;
                  }
                  _loc5_ += (Math.random() - 0.5) * 20;
                  _loc6_ = cosd(_loc5_);
                  _loc7_ = sind(_loc5_);
                  _loc8_ = 1 + Math.random() * 0.6;
                  _loc4_.x += (Math.random() - 0.5) * baseWidth / 2;
                  _loc4_.y += (Math.random() - 0.5) * baseHeight / 2;
                  _loc4_.dx = _loc6_ * _loc8_;
                  _loc4_.dy = _loc7_ * _loc8_;
                  _loc4_.Rotation = Math.atan2(_loc4_.dy,_loc4_.dx) * 180 / Math.PI + 90;
               }
            }
            else
            {
               emitConditionalParticles("EnemyHit");
            }
         }
         if(health < 0)
         {
            _loc9_ = String(this);
            preKill();
            doExplosion(param1);
            if(setsImpassable)
            {
               MainScene(gs).setPassable(logicalSquareX(),logicalSquareY(),true);
            }
            if(_experience() != 0)
            {
               _loc10_ = new PickupText(gs,basex,basey - baseHeight / 2,"+" + int(_experience() * toughnessMult[toughness]) + " XP",16755200);
            }
            MainScene(gs).player.giveExperience(experience());
            kill();
         }
         hitSucceeded = true;
      }
      
      override public function hitByShockwave() : void
      {
         super.hitByShockwave();
         hitBy(null,5);
      }
      
      public function canHaveTumor() : Boolean
      {
         return false;
      }
      
      public function moveToSquare(param1:int, param2:int, param3:Number) : *
      {
         var _loc4_:PathfindSquare = getPathfind().getField(logicalSquareX(),logicalSquareY());
         var _loc5_:PathfindSquare = getPathfind().getField(param1,param2);
         setNextSquare(_loc4_,_loc5_);
         moveToDest(param3);
      }
      
      public function moveRandomly(param1:Number = 1, param2:Number = 150) : void
      {
         var _loc6_:PathfindSquare = null;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(frozen > 0)
         {
            doLegsSpeed(0);
            return;
         }
         if(enemyHitCount > 40 || wallHitCount > 40)
         {
            enemyHitCount = 0;
            wallHitCount = 0;
            lastDestX = -1;
         }
         if(lastX == basex && lastY == basey)
         {
            doLegsSpeed(0);
         }
         var _loc3_:int = logicalSquareX();
         var _loc4_:int = logicalSquareY();
         var _loc5_:PathfindSquare = getPathfind().getField(_loc3_,_loc4_);
         if(_loc3_ == lastDestX && _loc4_ == lastDestY || (lastDestX < 0 || lastDestY < 0))
         {
            _loc7_ = !(_loc3_ == lastDestX && _loc4_ == lastDestY) || lastRandomMovementX == 0 && lastRandomMovementY == 0;
            if(_loc7_)
            {
               lastRandomMovementX = Random.randInt(-3,3);
               lastRandomMovementY = Random.randInt(-3,3);
            }
            else if(Math.random() < 0)
            {
               if(Math.random() < 0.5)
               {
                  lastRandomMovementX = Random.randInt(-3,3);
               }
               else
               {
                  lastRandomMovementY = Random.randInt(-3,3);
               }
            }
            _loc8_ = _loc3_ + lastRandomMovementX;
            _loc9_ = _loc4_ + lastRandomMovementY;
            if(_loc8_ < 0 || _loc8_ > 14 || (_loc9_ < 0 || _loc9_ > 10))
            {
               _loc8_ = -1;
            }
            lastDestX = _loc8_;
            lastDestY = _loc9_;
         }
         if(_loc5_)
         {
            if(_loc8_ != -1)
            {
               if(isPathOK(lastDestX,lastDestY))
               {
                  _loc6_ = getPathfind().getField(lastDestX,lastDestY);
               }
            }
         }
         if(distanceToPlayer(lastDestX * 52,lastDestY * 52) < param2)
         {
            if(distanceToPlayer(lastDestX * 52,lastDestY * 52) < distanceToPlayer())
            {
               _loc6_ = null;
            }
         }
         if(_loc6_)
         {
            setNextSquare(_loc5_,_loc6_);
         }
         else
         {
            lastDestX = -1;
         }
         if(_loc6_)
         {
            moveToDest(param1);
         }
      }
      
      public function experience() : int
      {
         return _experience() * levelMult[MainScene(gs).currentEpisode] * toughnessMult[toughness] * 1.2;
      }
      
      public function playGrowlAtStart() : Boolean
      {
         return true;
      }
      
      public function doFacePlayer() : void
      {
         baseRotation = angleToObject(MainScene(gs).player) + 90;
      }
      
      public function updateStunned() : void
      {
         if(!stunnable())
         {
            stunned = 0;
         }
         if(isFlying())
         {
            stunned = 0;
         }
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.stun001_png,"Stun",stunned > 0,stunned > 0 ? 0.1 : 0.02,null,baseAlpha);
         if(_loc1_)
         {
            if(stunned > 0)
            {
               --stunned;
            }
            _loc1_.imageSet = Embeds.stun;
            _loc1_.animSpeed = 2;
            _loc1_.basex = basex;
            _loc1_.basey = basey;
            _loc1_.additive = true;
         }
      }
      
      public function shootTarget() : GameObject
      {
         return ms.player;
      }
      
      override public function tintRed() : Number
      {
         var _loc1_:Boolean = false;
         if(Input.i.keyDown(84))
         {
            r += 0.01;
            _loc1_ = true;
         }
         if(Input.i.keyDown(89))
         {
            g += 0.01;
            _loc1_ = true;
         }
         if(Input.i.keyDown(85))
         {
            b += 0.01;
            _loc1_ = true;
         }
         if(Input.i.keyDown(71))
         {
            r -= 0.01;
            _loc1_ = true;
         }
         if(Input.i.keyDown(72))
         {
            g -= 0.01;
            _loc1_ = true;
         }
         if(Input.i.keyDown(74))
         {
            b -= 0.01;
            _loc1_ = true;
         }
         if(_loc1_)
         {
            if(ticks % 10 == 0)
            {
               trace(r + "," + g + "," + b);
            }
         }
         if(frozen > 0)
         {
            return 0.4;
         }
         if(tintBasedOnPosition)
         {
            return tintPositionR;
         }
         return redColors[toughness];
      }
      
      public function moveTowardsPlayer(param1:Number = 1) : void
      {
         var _loc2_:PathfindSquare = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PathfindSquare = null;
         if(hasTumor)
         {
            param1 /= 2;
         }
         if(wallHitCount >= 50)
         {
            forceRandom = 100;
         }
         if(forceRandom > 0)
         {
            --forceRandom;
            moveRandomly(param1,0);
            return;
         }
         determineMoveToPlayer = true;
         if(MainScene(gs).player._removed)
         {
            doLegsSpeed(0);
            return;
         }
         if(frozen > 0)
         {
            doLegsSpeed(0);
            return;
         }
         if(distanceToPlayer() > 40)
         {
            _loc2_ = getPathfind().getField(logicalSquareX(),logicalSquareY());
            if(_loc2_)
            {
               if(_loc2_.dirx == 0 && _loc2_.diry == 0)
               {
                  moveRandomly(param1);
                  return;
               }
               _loc3_ = logicalSquareX() + _loc2_.dirx;
               _loc4_ = logicalSquareY() + _loc2_.diry;
               if(canMoveToPlayer)
               {
                  _loc3_ = MainScene(gs).player.logicalSquareX();
                  _loc4_ = MainScene(gs).player.logicalSquareY();
                  moveToPoint(param1);
                  return;
               }
               if(_loc3_ >= 0 && _loc3_ < 800 / 40)
               {
                  if(_loc4_ >= 0 && _loc4_ < 600 / 40)
                  {
                     _loc5_ = getPathfind().field[_loc3_][_loc4_];
                  }
               }
               setNextSquare(_loc2_,_loc5_);
            }
            moveToDest(param1);
         }
         else
         {
            moveToPoint(param1);
         }
      }
      
      public function preKill() : void
      {
         var _loc1_:String = String(this);
         trace("del:" + _loc1_ + "," + toughness);
         if(!_killed)
         {
            _killed = true;
            if(killSound())
            {
               killSound().play();
            }
            if(canFall())
            {
               if(dropsItem())
               {
                  PickupBase.maybeCreatePickup(gs,basex,basey,0,itemDropLevel());
               }
            }
         }
      }
      
      public function updateTumor() : void
      {
         if(!canHaveTumor())
         {
            hasTumor = false;
            return;
         }
         if(!hasTumor)
         {
            return;
         }
         if(!tumorObject)
         {
            tumorObject = new Tumor();
            tumorObject.setupDifficulty(0);
            tumorObject.attachedTo = this;
         }
         else
         {
            tumorObject.basex = basex;
            tumorObject.basey = basey;
            tumorObject.baseRotation = helperFilter.getModifiedRotation();
            tumorObject.imageSet = Embeds.tumor;
            tumorObject.animSpeed = 2;
            tumorObject.baseAlpha = baseAlpha * fallingAlpha();
            if(tumorObject._removed)
            {
               hasTumor = false;
               tumorObject = null;
            }
         }
      }
      
      public function overlapsOtherEnemy() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ != this)
            {
               if(_loc1_ is EnemyBase)
               {
                  if(spriteCollidesWith(EnemyBase(_loc1_)))
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function canBeFrozen() : Boolean
      {
         return true;
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey","health","toughness"];
      }
      
      override public function collisionWidth() : Number
      {
         if(tumorObject)
         {
            return 0;
         }
         return super.collisionWidth();
      }
      
      public function stun() : void
      {
         if(stunnable())
         {
            stunned = 300;
         }
      }
      
      public function getFireSound() : GameSound
      {
         return Sounds.enemyShoot;
      }
      
      override public function tintGreen() : Number
      {
         if(frozen > 0)
         {
            return 1;
         }
         if(tintBasedOnPosition)
         {
            return tintPositionG;
         }
         return greenColors[toughness];
      }
      
      public function doExplosion(param1:BulletBase = null) : void
      {
         var _loc2_:BitmapData = Embeds.explosionScar[Random.randInt(0,Embeds.explosionScar.length - 1)];
         MainScene(gs).markFloor(_loc2_,basex - _loc2_.width / 2,basey - _loc2_.height / 2,Math.random(),1,1);
         doShrapnel(shrapnelCount(),tintRed(),tintGreen(),tintBlue(),param1);
         if(itemDropLevel() > 0)
         {
            if(Math.random() < 0.5)
            {
               emitConditionalParticles("Destroy2");
            }
            else
            {
               emitConditionalParticles("Destroy");
            }
         }
         else
         {
            emitConditionalParticles("DestroySmall");
         }
      }
      
      public function moveToPoint(param1:Number) : void
      {
         moveAlongAngle(param1,angleToObject(MainScene(gs).player));
      }
      
      public function doLegsSpeed(param1:Number) : void
      {
         if(!legs)
         {
            _doLegsSpeed(this,param1);
         }
         else
         {
            _doLegsSpeed(legs,param1);
         }
         if(legs2)
         {
            _doLegsSpeed(legs2,param1);
         }
      }
      
      public function dropsItem() : Boolean
      {
         return true;
      }
      
      public function legOffsetMultiplier() : Number
      {
         return 1;
      }
      
      public function getPathfind() : PathfindToPoint
      {
         return ms.toPlayer;
      }
      
      public function growlSound() : GameSound
      {
         return Sounds.alienMediumGrowl;
      }
      
      override public function _update() : void
      {
         var _loc6_:GameObjectFilter = null;
         var _loc7_:GameObjectFilter = null;
         var _loc1_:Boolean = distanceToPoint(movementLastX,movementLastY) < 0.05;
         animFreeze2 = _loc1_;
         if(legs)
         {
            legs.animFreeze2 = _loc1_;
         }
         movementLastX = basex;
         movementLastY = basey;
         basex += extradx;
         basey += extrady;
         extradx *= 0.96;
         extrady *= 0.96;
         updateStunned();
         updateTumor();
         if(isTeleporting() || Boolean(frozen))
         {
            animFreeze = true;
            if(legs)
            {
               legs.animFreeze = true;
            }
            if(legs2)
            {
               legs2.animFreeze = true;
            }
         }
         if(isTeleporting())
         {
            if(distanceToPlayer() < 200)
            {
               MainScene(gs).currentLevel.expediateAmbush();
            }
         }
         if(beforeTeleporting())
         {
            hide();
            baseAlpha = 0;
            if(legs)
            {
               legs.hide();
               legs.baseAlpha = 0;
            }
         }
         if(MainScene(gs).currentLevel.ambushRoom && !(this is EnemyCrack || this is EggBase || this is TerranTurretBase))
         {
            shouldTeleport = true;
            hide();
         }
         else
         {
            show();
         }
         if(legs)
         {
            legs.basex = -(basex - 400) / 100;
            legs.basey = -(basey - 300) / 80;
            legs.tformFromParent = false;
         }
         if(determineMoveToPlayer)
         {
            doPlayerPathfindCheck();
         }
         if(legs)
         {
            for each(_loc6_ in legs.filters)
            {
               if(_loc6_ is GameObjectFilterRotateSlowly)
               {
                  GameObjectFilterRotateSlowly(_loc6_).paused = frozen > 0;
               }
            }
         }
         if(frozen > 0)
         {
            --frozen;
         }
         if(legs)
         {
            legs.baseScaleX = baseScaleX;
            legs.baseScaleY = baseScaleY;
         }
         var _loc2_:MainScene = MainScene(gs);
         var _loc3_:int = 16;
         var _loc4_:Number = collisionWidth();
         var _loc5_:Number = collisionHeight();
         if(!bouncesOffSides)
         {
            basex = Interpolation.lockValue(basex,_loc2_.wallstartx + _loc4_ / 2,_loc2_.wallendx - _loc4_ / 2);
            basey = Interpolation.lockValue(basey,_loc2_.wallstarty + _loc5_ / 2,_loc2_.wallendy - _loc5_ / 2);
         }
         else
         {
            if(basex < _loc2_.wallstartx + _loc4_ / 2)
            {
               basex = _loc2_.wallstartx + _loc4_ / 2;
               dx *= -1;
            }
            if(basex > _loc2_.wallendx - _loc4_ / 2)
            {
               basex = _loc2_.wallendx - _loc4_ / 2;
               dx *= -1;
            }
            if(basey < _loc2_.wallstarty + _loc5_ / 2)
            {
               basey = _loc2_.wallstarty + _loc5_ / 2;
               dy *= -1;
            }
            if(basey > _loc2_.wallendy - _loc5_ / 2)
            {
               basey = _loc2_.wallendy - _loc5_ / 2;
               dy *= -1;
            }
         }
         if(ticks == 20)
         {
            if(setsImpassable)
            {
               if(MainScene(gs).getPassable(logicalSquareX(),logicalSquareY()))
               {
                  MainScene(gs).setPassable(logicalSquareX(),logicalSquareY(),false,this);
               }
               else
               {
                  setsImpassable = false;
               }
            }
         }
         if(!hasSetupSlowRotation)
         {
            hasSetupSlowRotation = true;
            for each(_loc7_ in filters)
            {
               if(_loc7_ is GameObjectFilterRotateSlowly)
               {
                  GameObjectFilterRotateSlowly(_loc7_).internalRotationSet = false;
               }
            }
         }
         super._update();
      }
      
      public function nextSquareInvalid() : Boolean
      {
         var _loc1_:Boolean = !canFall();
         var _loc2_:Boolean = canMoveOnLand();
         if(!nextSquare)
         {
            return true;
         }
         if(_loc1_)
         {
            if(nextSquare.exists)
            {
               if(!_loc2_)
               {
                  return true;
               }
               if(!nextSquare.passable)
               {
                  return true;
               }
            }
         }
         else if(nextSquare.passable == false)
         {
            return true;
         }
         if(nextSquare.y >= 11 || nextSquare.x >= 15)
         {
            return true;
         }
         return false;
      }
      
      public function moveAwayFromPlayer(param1:Number = 1) : void
      {
         var _loc5_:PathfindSquare = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:PathfindSquare = null;
         if(frozen > 0)
         {
            doLegsSpeed(0);
            return;
         }
         var _loc2_:int = logicalSquareX();
         var _loc3_:int = logicalSquareY();
         var _loc4_:PathfindSquare = getPathfind().field[_loc2_][_loc3_];
         if(_loc4_)
         {
            _loc6_ = -1;
            while(_loc6_ <= 1)
            {
               _loc7_ = -1;
               while(_loc7_ <= 1)
               {
                  if(_loc6_ != 0 || _loc7_ != 0)
                  {
                     _loc8_ = getPathfind().getField(_loc2_ + _loc6_,_loc3_ + _loc7_);
                     if(_loc8_)
                     {
                        if(_loc8_.dirx == -_loc6_ && _loc8_.diry == -_loc7_)
                        {
                           _loc5_ = _loc8_;
                        }
                     }
                  }
                  _loc7_++;
               }
               _loc6_++;
            }
            if(_loc5_)
            {
               setNextSquare(_loc4_,_loc5_);
            }
         }
         if(_loc5_)
         {
            moveToDest(param1);
         }
      }
      
      public function setNextSquare(param1:PathfindSquare, param2:PathfindSquare) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(distanceToPoint(nextSquarePosX,nextSquarePosY) < 1 || nextSquare != param2)
         {
            nextSquare = param2;
            nextSquarePosX = (param2.x + 0.5 + Math.random() * (20 - dist) / 20) * 52 + 10;
            nextSquarePosY = (param2.y + 0.5 + Math.random() * (20 - dist) / 20) * 52 + 14;
            _loc3_ = param2.x * 52 + 10;
            _loc4_ = (param2.x + 1) * 52 + 10;
            _loc5_ = param2.y * 52 + 14;
            _loc6_ = (param2.y + 1) * 52 + 14;
            _loc3_ += baseWidth / 2 + 4;
            _loc4_ -= baseWidth / 2 + 4;
            _loc5_ += baseHeight / 2 + 4;
            _loc6_ -= baseHeight / 2 + 4;
            nextSquarePosX = Random.randInt(_loc3_,_loc4_);
            nextSquarePosY = Random.randInt(_loc5_,_loc6_);
         }
      }
      
      public function blockUpdating() : Boolean
      {
         return beforeTeleporting() || frozen || stunned > 0 || ms.currentLevel.ambushRoom;
      }
      
      override public function tintBlue() : Number
      {
         if(frozen > 0)
         {
            return 0.6;
         }
         if(tintBasedOnPosition)
         {
            return tintPositionB;
         }
         return blueColors[toughness];
      }
      
      override public function collisionHeight() : Number
      {
         if(tumorObject)
         {
            return 0;
         }
         return super.collisionHeight();
      }
      
      public function collidesWithAnything() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is GameObjectBase)
            {
               if(_loc1_ != this)
               {
                  if(GameObjectBase(_loc1_).spriteCollidesWith(this))
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
   }
}

