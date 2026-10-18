package ObjectBase
{
   import GameObject.*;
   import GameScene.GameScene;
   import Objects.*;
   import Particles.*;
   import Scenes.*;
   import Tools.*;
   import flash.geom.Point;
   
   public class GameObjectBase extends GameObject
   {
      
      public var collisionFudge:Number = 0.5;
      
      public var collisionIgnoreObject:GameObjectBase;
      
      public var falling:Boolean = false;
      
      public var tintPositionG:Number = 0;
      
      public var fallingStartDx:Number = 0;
      
      public var fallingStartDy:Number = 0;
      
      public var dx:Number = 0;
      
      public var dy:Number = 0;
      
      public var fallingStartX:Number = 0;
      
      public var fallingStartY:Number = 0;
      
      public var shouldTeleportParticle:Boolean = true;
      
      public var wallHitCount:int = 0;
      
      public var shouldTeleport:Boolean = false;
      
      public var ms:MainScene;
      
      public var tintPositionR:Number = 1;
      
      public var pushWeight:Number = 1;
      
      public var dist:Number = 20;
      
      public var teleportOffset:int = 0;
      
      public var fallingLastX:Number = 0;
      
      public var tintBasedOnPosition:Boolean = false;
      
      public var fallingLastY:Number = 0;
      
      public var _canFall:Boolean = true;
      
      public var covering:EnemyBase;
      
      public var collidesWithWalls:Boolean = true;
      
      public var fallingProgress:int = 0;
      
      public var alphaVariation:Number = 0;
      
      public var collidesWithBullets:Boolean = true;
      
      public var teleporting:int = 0;
      
      public var pushedByWalls:Boolean = true;
      
      public var enemyHitCount:int = 0;
      
      public var doCollisions:Boolean = true;
      
      public var preventMissionComplete:int = 0;
      
      public var pushable:Boolean = true;
      
      public var tintPositionB:Number = 0;
      
      public function GameObjectBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         ms = MainScene(param1);
      }
      
      public function tooManyToSpawn(param1:Class, param2:int = 0) : Boolean
      {
         var _loc4_:GameObject = null;
         var _loc3_:int = 0;
         for each(_loc4_ in gs.objects)
         {
            if(_loc4_ is param1)
            {
               _loc3_++;
            }
         }
         if(_loc3_ >= 15 - param2)
         {
            return true;
         }
         return false;
      }
      
      public function pushing(param1:GameObjectBase) : void
      {
      }
      
      public function handlePlayerCollision() : void
      {
      }
      
      public function trapEffect() : void
      {
         if(ms.currentLevel.lastTrapTicks != 0)
         {
            if(ms.currentLevel.ticks - ms.currentLevel.lastTrapTicks < 200)
            {
               return;
            }
         }
         ms.currentLevel.lastTrapTicks = ms.currentLevel.ticks;
         new PickupText(gs,basex,basey - 32,"TRAP!",16730174);
         Sounds.trap.play();
         emitConditionalParticles("fall");
         ms.currentLevel.hasHadTrapText = true;
      }
      
      public function logicalSquareX(param1:Number = -9999999) : int
      {
         if(param1 < -999999)
         {
            param1 = basex;
         }
         var _loc2_:Number = param1 - 10;
         var _loc3_:int = int(Math.floor(_loc2_ / 52));
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 800 / 52 - 1)
         {
            _loc3_ = 800 / 52 - 1;
         }
         return _loc3_;
      }
      
      public function logicalSquareY(param1:Number = -9999999) : int
      {
         if(param1 < -999999)
         {
            param1 = basey;
         }
         var _loc2_:Number = param1 - 14;
         var _loc3_:int = int(Math.floor(_loc2_ / 52));
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 800 / 52 - 1)
         {
            _loc3_ = 800 / 52 - 1;
         }
         return _loc3_;
      }
      
      public function fallingAlpha() : Number
      {
         return Interpolation.lockValue(fallingProgress / 100,1,0);
      }
      
      public function isPathOK(param1:int, param2:int) : *
      {
         var _loc9_:int = 0;
         var _loc3_:int = logicalSquareX();
         var _loc4_:int = logicalSquareY();
         var _loc5_:int = 0;
         if(_loc3_ > param1)
         {
            _loc5_ = param1;
            param1 = _loc3_;
            _loc3_ = _loc5_;
         }
         if(_loc4_ > param2)
         {
            _loc5_ = param2;
            param2 = _loc4_;
            _loc4_ = _loc5_;
         }
         var _loc6_:Boolean = !canFall();
         var _loc7_:Boolean = canMoveOnLand();
         var _loc8_:int = _loc3_;
         while(_loc8_ <= param1)
         {
            _loc9_ = _loc4_;
            while(_loc9_ <= param2)
            {
               if(_loc8_ != _loc3_ || _loc9_ != _loc4_)
               {
                  if(_loc6_)
                  {
                     if(MainScene(gs).toPlayer.field[_loc8_][_loc9_].exists)
                     {
                        if(!_loc7_)
                        {
                           return false;
                        }
                        if(MainScene(gs).toPlayer.field[_loc8_][_loc9_].passable == false)
                        {
                           return false;
                        }
                     }
                  }
                  else if(MainScene(gs).toPlayer.field[_loc8_][_loc9_].passable == false)
                  {
                     return false;
                  }
               }
               _loc9_++;
            }
            _loc8_++;
         }
         return true;
      }
      
      public function doShrapnel(param1:int, param2:Number, param3:Number, param4:Number, param5:BulletBase = null) : void
      {
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Particle = null;
         var _loc6_:int = 0;
         while(_loc6_ < param1)
         {
            _loc7_ = "Shrapnel";
            if(Math.random() < 0.3)
            {
               _loc7_ = "Shrapnel2";
            }
            else if(Math.random() < 0.3)
            {
               _loc7_ = "Shrapnel3";
            }
            _loc8_ = emitConditionalParticles(_loc7_);
            if(_loc8_)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc10_ = Math.random() * 360;
                  if(param5)
                  {
                     _loc10_ = param5.angle + (Math.random() - 0.5) * 180;
                  }
                  _loc11_ = 1 + Math.random() * 4;
                  _loc8_[_loc9_].dx = cosd(_loc10_) * _loc11_;
                  _loc8_[_loc9_].dy = sind(_loc10_) * _loc11_;
                  _loc12_ = _loc8_[_loc9_];
                  _loc12_.tint(param2,param3,param4);
                  _loc9_++;
               }
            }
            _loc6_++;
         }
      }
      
      public function anyImpassable(param1:Number = 1) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         loop0:
         while(_loc2_ <= 1)
         {
            _loc3_ = 0;
            while(true)
            {
               if(_loc3_ > 1)
               {
                  _loc2_++;
                  continue loop0;
               }
               if(!MainScene(gs).toPlayer.field[logicalSquareX(basex - param1 * baseWidth / 2 + param1 * baseWidth * _loc2_)][logicalSquareY(basey - param1 * baseHeight / 2 + param1 * baseHeight * _loc3_)].passable)
               {
                  break;
               }
               _loc3_++;
            }
            return true;
         }
         return false;
      }
      
      public function impassable() : Boolean
      {
         return !MainScene(gs).toPlayer.field[logicalSquareX()][logicalSquareY()].passable;
      }
      
      public function splashFalloff(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = (1 - param1 / param2) * 2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      public function canMoveOnLand() : Boolean
      {
         return false;
      }
      
      public function teleportInstant() : Boolean
      {
         if(shouldTeleport)
         {
            return teleporting - teleportOffset == 0;
         }
         return false;
      }
      
      public function spriteCollidesWith(param1:GameObject, param2:Number = 1) : Boolean
      {
         if(Math.abs(param1.basex - basex) < param2 * (param1.baseWidth + baseWidth) / 2)
         {
            if(Math.abs(param1.basey - basey) < param2 * (param1.baseHeight + baseHeight) / 2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
      }
      
      public function isTeleporting() : Boolean
      {
         if(shouldTeleport)
         {
            return teleporting - teleportOffset < 50;
         }
         return false;
      }
      
      public function expediateTeleport() : void
      {
         if(teleporting < teleportOffset)
         {
            teleporting = teleportOffset;
         }
      }
      
      public function distanceToPlayer(param1:Number = -9999999, param2:Number = -9999999) : Number
      {
         if(param1 < -999999)
         {
            param1 = basex;
            param2 = basey;
         }
         var _loc3_:PlayerBase = PlayerBase(MainScene(gs).player);
         var _loc4_:Number = param1 - _loc3_.basex;
         var _loc5_:Number = param2 - _loc3_.basey;
         return Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_);
      }
      
      public function floorPropOn() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is FloorProp)
            {
               if(_loc1_ != this)
               {
                  if(distanceToObject(_loc1_) < 26)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function doSplashDamage(param1:int, param2:Number = 1, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false) : void
      {
         var _loc6_:GameObject = null;
         var _loc7_:Number = NaN;
         var _loc8_:Point = null;
         if(Math.random() < 0.5)
         {
            emitConditionalParticles("Destroy");
         }
         else
         {
            emitConditionalParticles("Destroy2");
         }
         emitConditionalParticles("BruteShock");
         Sounds.explosion.play();
         for each(_loc6_ in gs.objects)
         {
            if(param3)
            {
               if(_loc6_ is EnemyBase)
               {
                  if(_loc6_.distanceToPoint(basex,basey) < param1)
                  {
                     _loc7_ = splashFalloff(_loc6_.distanceToPoint(basex,basey),param1);
                     EnemyBase(_loc6_).stunned = 100;
                     EnemyBase(_loc6_).hitBy(null,15 * (ms.currentEpisode + 1) * _loc7_ * param2);
                     if(EnemyBase(_loc6_).pushable)
                     {
                        _loc8_ = helper.vectorToObject(_loc6_);
                        EnemyBase(_loc6_).extradx = EnemyBase(_loc6_).extradx + _loc8_.x * 3 * _loc7_;
                        EnemyBase(_loc6_).extrady = EnemyBase(_loc6_).extrady + _loc8_.y * 3 * _loc7_;
                     }
                  }
               }
            }
            if(param4)
            {
               if(_loc6_ is FloorProp)
               {
                  if(_loc6_.distanceToPoint(basex,basey) < param1)
                  {
                     FloorProp(_loc6_).hasBeenHit(this,param2 * (1 + ms.currentEpisode / 6));
                  }
               }
            }
            if(param5)
            {
               if(_loc6_ is PlayerBase)
               {
                  if(_loc6_.distanceToPoint(basex,basey) < param1)
                  {
                     _loc7_ = splashFalloff(_loc6_.distanceToPoint(basex,basey),param1);
                     PlayerBase(_loc6_).handleHit(this,param2 * (1 + ms.currentEpisode / 6));
                     _loc8_ = helper.vectorToObject(_loc6_);
                     PlayerBase(_loc6_).extradx = PlayerBase(_loc6_).extradx + _loc8_.x * 3 * _loc7_;
                     PlayerBase(_loc6_).extrady = PlayerBase(_loc6_).extrady + _loc8_.y * 3 * _loc7_;
                  }
               }
            }
         }
      }
      
      public function impassableGreedy(param1:Number = 1) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         loop0:
         while(_loc2_ <= 1)
         {
            _loc3_ = 0;
            while(true)
            {
               if(_loc3_ > 1)
               {
                  _loc2_++;
                  continue loop0;
               }
               if(MainScene(gs).toPlayer.field[logicalSquareX(basex - param1 * baseWidth / 2 + param1 * baseWidth * _loc2_)][logicalSquareY(basey - param1 * baseHeight / 2 + param1 * baseHeight * _loc3_)].passable)
               {
                  break;
               }
               _loc3_++;
            }
            return false;
         }
         return true;
      }
      
      public function kill() : void
      {
         remove();
      }
      
      public function beforeTeleporting() : Boolean
      {
         if(shouldTeleport)
         {
            return teleporting - teleportOffset < 0;
         }
         return false;
      }
      
      override public function _update() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(preventMissionComplete > 0)
         {
            --preventMissionComplete;
         }
         if(ticks > 3)
         {
            if(tintBasedOnPosition)
            {
               _loc1_ = ms.currentLevel.floorBitmapData.getPixel32(400,300);
               _loc2_ = ms.currentLevel.floorBitmapData.getPixel32(basex,basey);
               _loc3_ = Math.pow(Number(_loc2_ & 0xFF) / Number(_loc1_ & 0xFF),0.15);
               tint(_loc3_,_loc3_ - 1,_loc3_ - 1);
               tintBasedOnPosition = false;
               tintPositionR = _loc3_;
               tintPositionG = _loc3_ - 1;
               tintPositionB = _loc3_ - 1;
            }
         }
         if(shouldTeleport)
         {
            if(teleporting - teleportOffset < 50)
            {
               if(!(this is EnemyBase && MainScene(gs).currentLevel.ambushRoom))
               {
                  if(MainScene(gs).fading == 0)
                  {
                     ++teleporting;
                  }
               }
               _loc4_ = teleporting - teleportOffset;
               if(shouldTeleportParticle)
               {
                  if(_loc4_ == 1)
                  {
                     Sounds.teleport.play();
                     emitConditionalParticles("Teleport");
                     if(this is PlayerBase)
                     {
                        emitConditionalParticles("TeleportRing");
                     }
                  }
               }
               baseAlpha = _loc4_ / 50 + alphaVariation;
               if(baseAlpha < 0)
               {
                  baseAlpha = 0;
               }
               if(_loc4_ == 49)
               {
                  baseAlpha = 1;
               }
            }
         }
         --wallHitCount;
         --enemyHitCount;
         if(enemyHitCount < 0)
         {
            enemyHitCount = 0;
         }
         if(wallHitCount < 0)
         {
            wallHitCount = 0;
         }
         if(canFall())
         {
            if(noExistGreedy(0.75))
            {
               if(!falling)
               {
                  falling = true;
                  fallingStartX = basex;
                  fallingStartY = basey;
                  fallingStartDx = basex - fallingLastX;
                  fallingStartDy = basey - fallingLastY;
               }
            }
         }
         if(falling)
         {
            ++fallingProgress;
            baseScaleX -= 0.005;
            baseScaleY -= 0.005;
            baseAlpha -= 0.01;
            if(fallingProgress > 1)
            {
               fallingStartX += fallingStartDx;
               fallingStartY += fallingStartDy;
               fallingStartDx *= 0.9;
               fallingStartDy *= 0.9;
            }
            basex = fallingStartX;
            Interpolation.linearInterpolate(fallingStartX,400,fallingProgress / 500);
            basey = fallingStartY;
            Interpolation.linearInterpolate(fallingStartY,300,fallingProgress / 500);
            if(fallingProgress > 100)
            {
               kill();
            }
            if(!(this is EnemyBase))
            {
               tint(1 - fallingProgress / 100,0,0);
            }
         }
         fallingLastX = basex;
         fallingLastY = basey;
      }
      
      public function hitByShockwave() : void
      {
         var _loc1_:Point = ms.player.helper.vectorToObject(this);
         var _loc2_:Number = 3 + 4 * (1 - distanceToObject(ms.player) / 200);
         if(this is EnemyBase)
         {
            EnemyBase(this).extradx = EnemyBase(this).extradx + _loc1_.x * _loc2_ * shockwaveWeight();
            EnemyBase(this).extrady = EnemyBase(this).extrady + _loc1_.y * _loc2_ * shockwaveWeight();
         }
         else
         {
            dx += _loc1_.x * _loc2_ * shockwaveWeight();
            dy += _loc1_.y * _loc2_ * shockwaveWeight();
         }
      }
      
      public function canFall() : Boolean
      {
         return _canFall;
      }
      
      public function shockwaveWeight() : Number
      {
         return 1;
      }
      
      public function collisionHeight() : Number
      {
         return baseHeight;
      }
      
      public function collisionWidth() : Number
      {
         return baseWidth;
      }
      
      public function spawn(param1:Class, param2:int, param3:int, param4:int, param5:Boolean = false) : EnemyBase
      {
         var _loc7_:GameObject = null;
         var _loc8_:EnemyBase = null;
         if(isTeleporting())
         {
            return null;
         }
         if(falling)
         {
            return null;
         }
         if(MainScene(gs).player._removed)
         {
            return null;
         }
         param4 = Interpolation.lockValueInt(param4,0,2);
         var _loc6_:* = 15;
         for each(_loc7_ in gs.objects)
         {
            if(_loc7_ is param1)
            {
               _loc6_--;
            }
         }
         if(_loc6_ > 0 || param5)
         {
            _loc8_ = new param1(gs,param2,param3);
            _loc8_.setupDifficulty(param4);
            return _loc8_;
         }
         return null;
      }
      
      public function noExistGreedy(param1:Number = 1) : Boolean
      {
         var _loc3_:int = 0;
         if(MainScene(gs).squareExists(basex,basey))
         {
            return false;
         }
         var _loc2_:int = 0;
         loop0:
         while(_loc2_ <= 1)
         {
            _loc3_ = 0;
            while(true)
            {
               if(_loc3_ > 1)
               {
                  _loc2_++;
                  continue loop0;
               }
               if(MainScene(gs).toPlayer.field[logicalSquareX(basex - param1 * baseWidth / 2 + param1 * baseWidth * _loc2_)][logicalSquareY(basey - param1 * baseHeight / 2 + param1 * baseHeight * _loc3_)].exists)
               {
                  break;
               }
               _loc3_++;
            }
            return false;
         }
         return true;
      }
   }
}

