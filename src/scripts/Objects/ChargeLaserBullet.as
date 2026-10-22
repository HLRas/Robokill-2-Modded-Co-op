package Objects
{
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.ChargeLaserBulletBase;
   import ObjectBase.EnemyBase;
   import ObjectBase.PlayerBase;
   import ObjectConstructors.ChargeLaserBullet_constructor;
   import Tools.CollisionMath;
   import Tools.Input;
   import Tools.Interpolation;
   import flash.geom.Point;
   
   public class ChargeLaserBullet extends ChargeLaserBulletBase
   {
      
      public var channel:GameSoundChannel;
      
      public var startx:Number = 0;
      
      public var starty:Number = 0;
      
      public var endDestX:Number = 0;
      
      public var endDestY:Number = 0;
      
      public var offsetX:Number = 0;
      
      public var offsetY:Number = 0;
      
      public var charge:Number = 0;
      
      public var endx:Number = 0;
      
      public var endy:Number = 0;
      
      public function ChargeLaserBullet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ChargeLaserBullet_constructor.baseim_embed,ChargeLaserBullet_constructor.LayerName,param2,param3);
         ChargeLaserBullet_constructor.setup(param1,this);
         additive = true;
         collidesWithWalls = false;
         changeZOrder("AfterAbovePlayer");
         channel = Sounds.chargeLaser.play();
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
      }
      
      override public function hitByShield() : void
      {
      }
      
      override public function hasHit(param1:EnemyBase) : void
      {
      }
      
      override public function _remove() : void
      {
         channel.stop(50);
         super._remove();
      }
      
      public var owner:PlayerBase;

      override public function _update() : void
      {
         var _loc7_:GameObject = null;
         var _loc8_:GameObject = null;
         var _loc9_:EnemyBase = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:FloorProp = null;
         collidesWithWalls = false;
         imageSet = Embeds.chargeBeam;
         animSpeed = 1;
         var _loc14_:PlayerBase = owner ? owner : ms.player;
         var _loc1_:Point = _loc14_.tformed(offsetX,offsetY);
         startx = _loc1_.x;
         starty = _loc1_.y;
         if(_loc14_.usesPad())
         {
            endx = _loc14_.lockTargetX;
            endy = _loc14_.lockTargetY;
         }
         else
         {
            endx = _loc14_.aimPointX() + (_loc1_.x - _loc14_.basex);
            endy = _loc14_.aimPointY() + (_loc1_.y - _loc14_.basey);
         }
         if(ticks < 15)
         {
            endx = Interpolation.linearInterpolateLock(startx,endx,ticks / 15);
            endy = Interpolation.linearInterpolateLock(starty,endy,ticks / 15);
         }
         setAngle(Math.atan2(endy - starty,endx - startx) * 180 / Math.PI + 90);
         var _loc2_:Number = endx - startx;
         var _loc3_:Number = endy - starty;
         var _loc4_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
         basex = (startx + endx) / 2;
         basey = (starty + endy) / 2;
         baseScaleY = _loc4_ / baseHeight;
         speed = 0;
         baseAlpha = 0.5 + Math.random() * 0.5;
         if(ticks > 15)
         {
            _loc7_ = helper.conditionallyCreateChild(Embeds.chargelaserhitground_png,"LaserHit",true,1);
            if(_loc7_)
            {
               _loc7_.basex = endx;
               _loc7_.basey = endy;
               _loc7_.baseAlpha = 0.5 + Math.random() * 0.5;
               _loc7_.baseRotation = baseRotation + 180;
               _loc7_.baseScaleX = 1;
               _loc7_.baseScaleY = 1;
               _loc7_.additive = true;
            }
         }
         var _loc5_:int = 100 * charge + 15;
         if(ticks > _loc5_ - 10)
         {
            setAlpha(1 - (ticks - (_loc5_ - 10)) / 10);
         }
         if(ticks > _loc5_ || _loc14_._removed)
         {
            remove();
         }
         var _loc6_:CollisionMath = CollisionMath.getSingleton();
         if(ticks % 10 == 0 && ticks > 15)
         {
            for each(_loc8_ in gs.objects)
            {
               // Online, a copy of the guest's beam: the guest decides which enemies it hits (Net).
               if(_loc8_ is EnemyBase && !vars["netShot"])
               {
                  _loc9_ = EnemyBase(_loc8_);
                  _loc10_ = _loc9_.collisionWidth();
                  _loc11_ = _loc9_.collisionHeight();
                  if(_loc10_ > 0 && _loc11_ > 0)
                  {
                     _loc12_ = _loc8_.distanceToPoint(endx,endy) < 20 + (_loc8_.baseWidth + _loc8_.baseHeight) / 4;
                     if(_loc6_.circleLineCollision(startx,starty,endx,endy,_loc8_.basex,_loc8_.basey,(_loc10_ + _loc11_) / 4) || _loc12_)
                     {
                        _loc9_.hitBy(this);
                        if(_loc9_.hitSucceeded)
                        {
                           _loc9_.emitConditionalParticles("LaserHit");
                        }
                     }
                  }
               }
               if(_loc8_ is FloorProp)
               {
                  _loc13_ = FloorProp(_loc8_);
                  _loc10_ = _loc13_.collisionWidth();
                  _loc11_ = _loc13_.collisionHeight();
                  if(_loc10_ > 0 && _loc11_ > 0)
                  {
                     _loc12_ = _loc8_.distanceToPoint(endx,endy) < 20 + (_loc8_.baseWidth + _loc8_.baseHeight) / 4;
                     if(_loc6_.circleLineCollision(startx,starty,endx,endy,_loc8_.basex,_loc8_.basey,(_loc10_ + _loc11_) / 4) || _loc12_)
                     {
                        if(_loc13_.destructable(_loc13_.animFrame))
                        {
                           _loc13_.emitConditionalParticles("LaserHit");
                        }
                        _loc13_.hasBeenHit(this);
                     }
                  }
               }
            }
         }
      }
   }
}

