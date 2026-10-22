package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Objects.FloorProp;
   import Tools.Interpolation;
   import flash.display.BlendMode;
   
   public class LaserBulletBase extends BulletBase
   {
      
      public var doneHit:Boolean = false;
      
      public var startx:Number = 0;
      
      public var starty:Number = 0;
      
      public var endx:Number = 0;
      
      public var endy:Number = 0;
      
      public function LaserBulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         obj.blendMode = BlendMode.ADD;
         collidesWithWalls = false;
         changeZOrder("AfterAbovePlayer");
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:GameObject = null;
         collidesWithWalls = false;
         _loc1_ = 30;
         var _loc2_:Number = getDist(startx,starty,endx,endy);
         if(_loc2_ < 600)
         {
            _loc1_ = _loc2_ / 20;
         }
         if(_loc1_ < 10)
         {
            _loc1_ = 10;
         }
         _loc1_ *= 1.2;
         _loc3_ = Interpolation.linearInterpolateLock(0,1,3 * Number(ticks) / _loc1_);
         _loc4_ = Interpolation.linearInterpolateLock(0,1,1.5 * Number(ticks) / _loc1_ - 0.5);
         _loc5_ = (_loc3_ + _loc4_) / 2;
         basex = Interpolation.linearInterpolate(startx,endx,_loc5_);
         basey = Interpolation.linearInterpolate(starty,endy,_loc5_);
         baseScaleX = 1;
         baseScaleY = _loc3_ - _loc4_;
         baseScaleY *= getDist(startx,starty,endx,endy) / baseHeight;
         if(ticks > _loc1_ / 3)
         {
            if(!doneHit)
            {
               emitConditionalParticles("LaserHit",endx,endy,true);
               for each(_loc6_ in gs.objects)
               {
                  // Online, a copy of the guest's shot: the guest decides which enemies it hits (Net).
                  if(_loc6_ is EnemyBase && !vars["netShot"])
                  {
                     if(_loc6_.distanceToPoint(endx,endy) < 50)
                     {
                        EnemyBase(_loc6_).hitBy(this);
                     }
                  }
                  if(_loc6_ is FloorProp)
                  {
                     if(_loc6_.distanceToPoint(endx,endy) < 50)
                     {
                        FloorProp(_loc6_).hasBeenHit(this);
                     }
                  }
               }
               doneHit = true;
            }
         }
         if(ticks > _loc1_)
         {
            remove();
         }
      }
      
      public function getDist(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param3 - param1;
         var _loc6_:Number = param4 - param2;
         return Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
      }
      
      override public function hitByShield() : void
      {
      }
      
      override public function hasHit(param1:EnemyBase) : void
      {
      }
   }
}

