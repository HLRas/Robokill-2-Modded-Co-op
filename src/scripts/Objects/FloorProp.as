package Objects
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterPulse;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import ObjectBase.EnemyBulletBase;
   import ObjectBase.FloorDecalBase;
   import ObjectBase.GameObjectBase;
   import ObjectBase.PickupBase;
   import ObjectBase.PickupWeapon;
   import ObjectConstructors.FloorProp_constructor;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Tools.Random;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class FloorProp extends GameObjectBase
   {
      
      public var throwingProgress:int = 0;
      
      public var flying:int = 0;
      
      public var useAnimFrame:Boolean = true;
      
      public var _hitByShockwave:Boolean = false;
      
      public var flyingCause:GameObject = null;
      
      public var lastHit:int = 100;
      
      public var rollingFrame:Number = 0;
      
      public var blowingUp:int = 0;
      
      public var pickedUp:Boolean = false;
      
      public var blowingUpObject:GameObject;
      
      public var temporary:Boolean = false;
      
      public var blowUpTime:int = 40 + Math.random() * 20;
      
      public var propGroup:int = 0;
      
      public var flyingdx:Number = 0;
      
      public var flyingdy:Number = 0;
      
      public var throwLength:Number = 80 + Math.random() * 40;
      
      public var health:int = 6;
      
      public var images:Array;
      
      public var soundChannel:GameSoundChannel;
      
      public function FloorProp(param1:GameScene, param2:int, param3:int)
      {
         super(param1,FloorProp_constructor.baseim_embed,FloorProp_constructor.LayerName,param2,param3);
         FloorProp_constructor.setup(param1,this);
      }
      
      override public function remove() : void
      {
         if(soundChannel)
         {
            soundChannel.stop();
            soundChannel = null;
         }
         super.remove();
      }
      
      public function validForFlyingCollision(param1:GameObject) : Boolean
      {
         if(param1 is FloorDecalBase)
         {
            return true;
         }
         if(param1 is FloorProp)
         {
            return true;
         }
         if(param1 is EnemyBase)
         {
            return true;
         }
         if(param1 is Player)
         {
            return true;
         }
         return false;
      }
      
      public function canPickUp() : Boolean
      {
         if(_hitByShockwave)
         {
            return false;
         }
         return int(animFrame) <= 3 || int(animFrame) == 6 || int(animFrame) == 7 || int(animFrame) == 18;
      }
      
      override public function handlePlayerCollision() : void
      {
         if(throwingProgress)
         {
            ms.player.handleHit(this);
            hasBeenHit(this);
         }
      }
      
      public function validBullet(param1:GameObject) : Boolean
      {
         return true;
      }
      
      public function setPassable(param1:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = logicalSquareX();
         var _loc3_:int = logicalSquareX();
         var _loc4_:int = logicalSquareY();
         var _loc5_:int = logicalSquareY();
         if(baseWidth >= 104)
         {
            _loc2_--;
            _loc3_ += 1;
         }
         if(baseHeight >= 104)
         {
            _loc4_--;
            _loc5_ += 1;
         }
         var _loc6_:int = _loc2_;
         while(_loc6_ <= _loc3_)
         {
            _loc7_ = _loc4_;
            while(_loc7_ <= _loc5_)
            {
               MainScene(gs).setPassable(_loc6_,_loc7_,param1);
               _loc7_++;
            }
            _loc6_++;
         }
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey","animFrame","baseRotation","baseScaleX","baseScaleY","baseWidth","baseHeight","baseAlpha","health"];
      }
      
      public function updateFlying() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         ++flying;
         useAnimFrame = false;
         if(int(animFrame) == 29)
         {
            _loc2_ = Math.sqrt(dx * dx + dy * dy);
            if(_loc2_ < 0.001)
            {
               _loc2_ = 0.001;
            }
            if(dy > 0.01 || dx > 0.01)
            {
               _loc2_ *= -1;
            }
            rollingFrame += _loc2_ / 5;
            _loc3_ = int(rollingFrame) + 100000;
            _loc3_ %= Embeds.barrelRoll.length;
            helperAnimation.setFrame(Embeds.barrelRoll[_loc3_]);
         }
         else if(int(animFrame) == 30)
         {
            _loc2_ = Math.sqrt(dx * dx + dy * dy);
            dx = (dx + dx / _loc2_ * 0.12) * 0.99;
            dy = (dy + dy / _loc2_ * 0.12) * 0.99;
         }
         if(flying > 200)
         {
            blowUp(null,true);
            return;
         }
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ != this)
            {
               if(_loc1_ != flyingCause)
               {
                  if(_loc1_ is GameObjectBase || _loc1_ is FloorDecal)
                  {
                     if(validForFlyingCollision(_loc1_))
                     {
                        if(spriteCollidesWith(_loc1_,0.5))
                        {
                           if(_loc1_ is FloorDecal)
                           {
                              blowUp(null,true);
                           }
                           else
                           {
                              blowUp(_loc1_,true);
                           }
                           return;
                        }
                     }
                  }
               }
            }
         }
         if(basex - baseWidth / 2 < ms.wallstartx || basex + baseWidth / 2 > ms.wallendx || basey - baseHeight / 2 < ms.wallstartx || basey + baseHeight / 2 > ms.wallendy)
         {
            blowUp(null,true);
            return;
         }
      }
      
      public function canCreateTrap() : Boolean
      {
         var _loc1_:GameObject = null;
         if(MainScene(gs).hasCommWindow())
         {
            return false;
         }
         if(distanceToPlayer() < 100)
         {
            return false;
         }
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is EnemyCrack)
            {
               if(distanceToObject(_loc1_) < 52)
               {
                  return false;
               }
            }
         }
         if(!MainScene(gs).currentLevel.hasHadTrap && MainScene(gs).player.canCreateTrap())
         {
            if(!(flying || throwingProgress))
            {
               return true;
            }
         }
         return false;
      }
      
      public function createTrap(param1:int) : void
      {
         var _loc2_:Class = null;
         if(param1 == 0)
         {
            create(Swarm,1,0);
         }
         else if(param1 == 1)
         {
            create(Critter,4,0);
         }
         else if(param1 == 2)
         {
            if(Math.random() < 0.5)
            {
               create(Swarm);
            }
            else
            {
               create(Critter,4);
            }
         }
         else if(param1 == 3)
         {
            create(Swarm);
            create(Critter,4,0);
         }
         else if(param1 == 4)
         {
            create(HoverSwarm);
         }
         else if(param1 == 5)
         {
            _loc2_ = [HoverSwarm,Swarm,Critter][Random.randInt(0,2)];
            if(_loc2_ == HoverSwarm)
            {
               create(HoverSwarm,2);
            }
            else if(_loc2_ == Swarm)
            {
               create(Swarm,4);
            }
            else if(_loc2_ == Critter)
            {
               create(Critter,4);
            }
         }
         else if(param1 == 6)
         {
            create(Wasp,8,0);
         }
         else if(param1 == 7)
         {
            _loc2_ = [HoverSwarm,Swarm,Critter,Wasp][Random.randInt(0,3)];
            if(_loc2_ == HoverSwarm)
            {
               create(HoverSwarm,2);
            }
            else if(_loc2_ == Swarm)
            {
               create(Swarm,4);
            }
            else if(_loc2_ == Critter)
            {
               create(Critter,4);
            }
            else if(Wasp)
            {
               create(Wasp,8,0);
            }
         }
         else if(param1 == 8)
         {
            create(CritterJump,4,0);
         }
         else if(param1 == 9)
         {
            _loc2_ = [HoverSwarm,Swarm,Critter,Wasp,CritterJump][Random.randInt(0,4)];
            if(_loc2_ == HoverSwarm)
            {
               create(HoverSwarm,4);
            }
            else if(_loc2_ == Swarm)
            {
               create(Swarm,3,1);
            }
            else if(_loc2_ == Critter)
            {
               create(Critter,3,1);
            }
            else if(Wasp)
            {
               create(Wasp,8,0);
            }
            else if(CritterJump)
            {
               create(CritterJump,4,0);
            }
         }
         else if(param1 == 10)
         {
            create(NestSwarm,1);
         }
         else if(param1 == 11)
         {
            _loc2_ = [HoverSwarm,Swarm,Critter,Wasp,CritterJump,NestSwarm][Random.randInt(0,5)];
            if(_loc2_ == HoverSwarm)
            {
               create(HoverSwarm,4,1);
            }
            else if(_loc2_ == Swarm)
            {
               create(Swarm,4,2);
            }
            else if(_loc2_ == Critter)
            {
               create(Critter,4,2);
            }
            else if(_loc2_ == Wasp)
            {
               create(Wasp,8,1);
            }
            else if(_loc2_ == CritterJump)
            {
               create(CritterJump,4,1);
            }
            else if(_loc2_ == NestSwarm)
            {
               create(NestSwarm,1);
            }
         }
      }
      
      public function hasBeenHit(param1:GameObject, param2:Number = 1) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(_removed)
         {
            return;
         }
         if(!throwingProgress)
         {
            if(param1 is BulletBase || param1 is FloorProp)
            {
               if(int(animFrame) == 29 || Boolean(int(animFrame == 30)))
               {
                  if(validBullet(param1))
                  {
                     lastHit = 0;
                     _loc3_ = param1 ? param1.baseRotation - 90 : -90;
                     _loc4_ = 0.5;
                     if(!(param1 is BulletBase))
                     {
                        _loc3_ = param1.helper.angleToObject(this);
                        _loc4_ = 2;
                     }
                     _loc5_ = true;
                     if(!flying)
                     {
                        if(int(animFrame) == 29)
                        {
                           if(Interpolation.snapToAngle(_loc3_ - baseRotation - 90,90) != Interpolation.snapToAngle(_loc3_ - baseRotation - 90,180))
                           {
                              _loc5_ = false;
                           }
                           else
                           {
                              _loc3_ = Interpolation.snapToAngle(_loc3_ - baseRotation - 90,180) + baseRotation + 90;
                              dx = cosd(_loc3_) * _loc4_;
                              dy = sind(_loc3_) * _loc4_;
                           }
                        }
                        if(int(animFrame == 30))
                        {
                           dx = cosd(baseRotation + 90) * 0.1;
                           dy = sind(baseRotation + 90) * 0.1;
                        }
                     }
                     else if(int(animFrame) == 29)
                     {
                        if(param1 is BulletBase)
                        {
                           _loc6_ = Math.sqrt(dx * dx + dy * dy);
                           if(Interpolation.snapToAngle(_loc3_ - baseRotation - 90,90) != Interpolation.snapToAngle(_loc3_ - baseRotation - 90,180))
                           {
                              _loc5_ = false;
                           }
                           else
                           {
                              _loc3_ = Interpolation.snapToAngle(_loc3_ - baseRotation - 90,180) + baseRotation + 90;
                              _loc7_ = cosd(_loc3_);
                              _loc8_ = sind(_loc3_);
                              dx = (dx + _loc7_ * 0.35) * 0.95;
                              dy = (dy + _loc8_ * 0.35) * 0.95;
                           }
                        }
                     }
                     if(_loc5_)
                     {
                        setPassable(true);
                        if(!flying)
                        {
                           flying = 1;
                        }
                        flyingCause = param1;
                        return;
                     }
                  }
               }
            }
         }
         if(param1 is FloorProp)
         {
            health = -1;
         }
         else if(param1 is BulletBase)
         {
            if(BulletBase(param1).wep)
            {
               health -= BulletBase(param1).wep.boxDamage() * param2;
            }
            else if(param1 is EnemyBulletBase)
            {
               health -= EnemyBulletBase(param1).boxDamage * EnemyBulletBase(param1).damageMult * param2;
            }
            else
            {
               health -= 1 * param2;
            }
         }
         else if(param1 is EnemyBulletBase)
         {
            health -= EnemyBulletBase(param1).boxDamage * param2;
         }
         else
         {
            if(!(param1 is BomberBomb))
            {
               return;
            }
            health -= 4 * param2;
         }
         if(destructable(int(animFrame)))
         {
            if(lastHit > 9)
            {
               lastHit = 0;
            }
         }
         if(health < 0)
         {
            if(blowingUp == 0)
            {
               blowingUpObject = param1;
               blowingUp = 1;
            }
         }
      }
      
      public function setupPropGroup(param1:*) : void
      {
         var _loc4_:GameObject = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         propGroup = param1;
         var _loc2_:int = logicalSquareX();
         var _loc3_:int = logicalSquareY();
         for each(_loc4_ in gs.objects)
         {
            if(_loc4_ is FloorProp)
            {
               if(!FloorProp(_loc4_).propGroup)
               {
                  _loc5_ = FloorProp(_loc4_).logicalSquareX();
                  _loc6_ = FloorProp(_loc4_).logicalSquareY();
                  if(_loc5_ == _loc2_ && (_loc6_ == _loc3_ - 1 || _loc6_ == _loc3_ + 1))
                  {
                     FloorProp(_loc4_).setupPropGroup(param1);
                  }
                  else if(_loc6_ == _loc3_ && (_loc5_ == _loc2_ - 1 || _loc5_ == _loc2_ + 1))
                  {
                     FloorProp(_loc4_).setupPropGroup(param1);
                  }
               }
            }
         }
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:GameObject = null;
         var _loc4_:GameObjectFilterPulse = null;
         var _loc5_:GameSound = null;
         var _loc6_:Boolean = false;
         if(animFrame == 37 || animFrame == 38)
         {
            _loc2_ = helper.conditionallyCreateChild(Embeds.top_decal_06_png,"topd",true);
            if(_loc2_)
            {
               _loc2_.basex = basex;
               _loc2_.basey = basey - baseHeight / 2;
               _loc2_.baseHandleX = 0;
               _loc2_.baseHandleY = 1;
               _loc2_.changeZOrder("TextLayer");
            }
         }
         if(animFrame == 38)
         {
            _loc3_ = helper.conditionallyCreateChild(Embeds.pulse_01_png,"Pulse",ms.countEnemies() == 0,0.01);
            if(_loc3_)
            {
               if(_loc3_.filters.length == 0)
               {
                  _loc4_ = new GameObjectFilterPulse();
                  _loc4_.alpha = 0.8;
                  _loc3_.addFilter(_loc4_);
               }
               _loc3_.baseScaleX = 2;
               _loc3_.baseScaleY = 2;
               _loc3_.basex = basex;
               _loc3_.basey = basey;
               _loc3_.additive = true;
            }
         }
         if(propGroup == 0)
         {
            setupPropGroup(id);
         }
         if(flying)
         {
            updateFlying();
         }
         else if(int(animFrame) == 29)
         {
            useAnimFrame = false;
            helperAnimation.setFrame(Embeds.barrelRoll[0]);
         }
         basex += dx;
         basey += dy;
         if(throwingProgress)
         {
            ++throwingProgress;
            baseScaleX = 1.2 + Math.sin(90 / throwLength * 3 * throwingProgress * Math.PI / 180) * 0.2;
            baseScaleY = baseScaleX;
            if(_hitByShockwave)
            {
               dx *= 0.985;
               dy *= 0.985;
               if(Math.sqrt(dx * dx + dy * dy) < 0.5)
               {
                  hasBeenHit(this);
               }
            }
            if(throwingProgress > throwLength)
            {
               hasBeenHit(this);
            }
         }
         if(basex < ms.startx || basex > ms.endx || basey < ms.starty || basey > ms.endy)
         {
            hasBeenHit(this);
         }
         if(covering)
         {
            if(covering is Trooper)
            {
               if(Trooper(covering).square != this)
               {
                  covering = null;
               }
            }
            else if(covering is Brute)
            {
               if(Brute(covering).pickupTarget != this)
               {
                  covering = null;
               }
            }
         }
         if(!soundChannel)
         {
            _loc5_ = Sounds.propSounds_sparse[int(animFrame)];
            if(_loc5_)
            {
               soundChannel = _loc5_.play(true);
            }
         }
         if(!(pickedUp || flying))
         {
            setPassable(false);
         }
         if(lastHit < 6)
         {
            tint(tintPositionR + 1,tintPositionG + 1,tintPositionB + 1);
         }
         else
         {
            tint(tintPositionR,tintPositionG,tintPositionB);
         }
         ++lastHit;
         if(useAnimFrame)
         {
            Bitmap(obj).bitmapData = images[animFrame];
            if(obj.width > 52 && obj.width < 104)
            {
               baseWidth = 52;
            }
            if(obj.height > 52 && obj.height < 104)
            {
               baseHeight = 52;
            }
         }
         var _loc1_:String = zOrderString;
         if(Boolean(flying) || Boolean(throwingProgress))
         {
            _loc1_ = "AbovePlayer";
         }
         changeZOrder(_loc1_,true);
         Bitmap(obj).smoothing = true;
         Bitmap(obj).cacheAsBitmap = true;
         super._update();
         if(blowingUp > 0)
         {
            if(ticks % 10 == 0)
            {
               if(int(animFrame) == 6 || int(animFrame) == 7 || int(animFrame) == 18 || int(animFrame) == 31 || int(animFrame) == 29 || int(animFrame) == 30)
               {
                  emitConditionalParticles("DestroySmallOnly",(Math.random() - 0.5) * 14,(Math.random() - 0.5) * 14);
               }
            }
            ++blowingUp;
            _loc6_ = blowingUp > blowUpTime;
            if(!(int(animFrame) == 6 || int(animFrame) == 7 || int(animFrame) == 18 || int(animFrame) == 31 || int(animFrame) == 29 || int(animFrame) == 30))
            {
               _loc6_ = true;
            }
            if(_loc6_ || throwingProgress > 0)
            {
               blowUp(blowingUpObject);
            }
         }
      }
      
      override public function canFall() : Boolean
      {
         if(Boolean(flying) && int(animFrame) == 29)
         {
            return true;
         }
         return false;
      }
      
      public function blowUp(param1:GameObject, param2:Boolean = false) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:GameObject = null;
         var _loc5_:PickupBase = null;
         if(int(animFrame) == 6 || int(animFrame) == 7 || int(animFrame) == 18 || int(animFrame) == 31 || int(animFrame) == 29 || int(animFrame) == 30)
         {
            _loc3_ = Embeds.explosionScar[Random.randInt(0,Embeds.explosionScar.length - 1)];
            MainScene(gs).markFloor(_loc3_,obj.x,obj.y,Math.random(),1,1);
            doSplashDamage(130,1,true,true,true);
            Sounds.gasTankDestroy.play();
         }
         if(int(animFrame) <= 3)
         {
            _loc3_ = Embeds.explosionScar[Random.randInt(0,Embeds.explosionScar.length - 1)];
            MainScene(gs).markFloor(_loc3_,obj.x,obj.y,Math.random(),1,1);
            if(int(animFrame) <= 3)
            {
               doShrapnel(6,0.5,0,0.5);
            }
         }
         if(destructable(int(animFrame)))
         {
            if(int(animFrame) <= 3)
            {
               if(Math.random() < 0.1)
               {
                  if(canCreateTrap())
                  {
                     if(distanceToPlayer() > 120)
                     {
                        createTrap(MainScene(gs).currentEpisode);
                        trapEffect();
                        MainScene(gs).currentLevel.enragedBugs = true;
                        MainScene(gs).currentLevel.hasHadTrap = true;
                     }
                  }
               }
               else
               {
                  _loc5_ = PickupBase.maybeCreatePickup(gs,basex,basey,true);
                  if(_loc5_)
                  {
                     if(_loc5_ is PickupWeapon)
                     {
                        new PickupText(gs,basex - 5,basey - 32,"HIDDEN ITEM!",16764727);
                     }
                  }
               }
               Sounds.explosion.play();
            }
            if(!(flying || throwingProgress))
            {
               setPassable(true);
            }
            for each(_loc4_ in gs.objects)
            {
               if(_loc4_ is EnemyCrack)
               {
                  if(distanceToObject(_loc4_) < 12)
                  {
                     EnemyCrack(_loc4_).crack();
                  }
               }
            }
            remove();
         }
      }
      
      override public function hitByShockwave() : void
      {
         super.hitByShockwave();
         if(throwingProgress == 0)
         {
            _hitByShockwave = true;
            setPassable(true);
            pickedUp = true;
            throwingProgress = 1;
            dx *= 0.75;
            dy *= 0.75;
         }
      }
      
      override public function _init() : void
      {
         super._init();
         tintBasedOnPosition = true;
         if(!(this is DestructableCover))
         {
            if(animFrame == 5 || animFrame == 13 || animFrame == 12)
            {
               tintBasedOnPosition = true;
            }
         }
         if(!(this is DestructableCover))
         {
            if(animFrame == 23)
            {
               collidesWithBullets = false;
               hide();
            }
         }
         if(!(this is DestructableCover))
         {
            if(animFrame == 12 || animFrame == 13)
            {
               collidesWithBullets = false;
            }
         }
      }
      
      public function destructable(param1:int) : Boolean
      {
         return param1 <= 3 || param1 == 6 || param1 == 7 || param1 == 18 || param1 >= 29 && param1 <= 31;
      }
      
      public function create(param1:Class, param2:int = 1, param3:int = 1, param4:Boolean = true) : void
      {
         var _loc6_:EnemyBase = null;
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = EnemyBase(new param1(gs,basex + (Math.random() - 0.5) * 8,basey + (Math.random() - 0.5) * 8));
            _loc6_.shouldTeleport = param4;
            _loc6_.shouldTeleportParticle = _loc5_ == 0;
            _loc6_.setupDifficulty(param3);
            _loc5_++;
         }
      }
   }
}

