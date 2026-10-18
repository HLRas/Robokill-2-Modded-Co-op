package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.FloorProp;
   import Tools.Interpolation;
   import flash.geom.Point;
   
   public class BullBase extends EnemyBase
   {
      
      public var stateChargeStop:int = 3;
      
      public var stateStanding:int = 0;
      
      public var state:int = 0;
      
      public var stateTicks:int = 0;
      
      public var stateCharging:int = 1;
      
      public var stateChargeEnd:int = 2;
      
      public var blah:Object = new Object();
      
      public var killed:Boolean = false;
      
      public function BullBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         addFilter(new GameObjectFilterRotateSlowly(1));
         baseHealth *= 30;
         extraHealth *= 20;
         collidesWithWalls = false;
         pushable = false;
         doingLegSpeed = false;
      }
      
      public function changeState(param1:int) : void
      {
         state = param1;
         stateTicks = 0;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.alienBigDie;
      }
      
      override public function growlSound() : GameSound
      {
         return Sounds.alienBigGrowl;
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         if(param1)
         {
            if(blah[param1.id] == "asdf")
            {
               return;
            }
            if(Interpolation.distanceToAngle(param1.baseRotation + 180,helperFilter.getModifiedRotation()) < 50)
            {
               if(blah[param1.id] != "asdf")
               {
                  blah[param1.id] = "asdf";
                  param1.hitByShield();
                  return;
               }
            }
         }
         super.hitBy(param1,param2 / 2);
      }
      
      override public function kill() : void
      {
         if(killed)
         {
            return;
         }
         killed = true;
         emitConditionalParticles("GasTankDestroy");
         super.kill();
      }
      
      public function closeToScreen() : Boolean
      {
         var _loc1_:Number = basex + dx * 50;
         var _loc2_:Number = basey + dy * 50;
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
      
      override public function _update() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:GameObject = null;
         super._update();
         animFreeze = false;
         animFreeze2 = false;
         ++stateTicks;
         _loc1_ = helper.vectorToObject(ms.player);
         if(state == stateCharging || state == stateChargeEnd)
         {
            animSpeed = 2.5;
         }
         else if(!helperFilter.rotationAligned())
         {
            animSpeed = 4;
         }
         else
         {
            animSpeed = 0;
         }
         if(state == stateStanding)
         {
            baseRotation = helper.angleForVector(_loc1_.x,_loc1_.y) + 90;
            if(stateTicks > 200 && helperFilter.rotationAligned())
            {
               changeState(stateCharging);
            }
         }
         else if(state == stateCharging)
         {
            dx += _loc1_.x / 8;
            dy += _loc1_.y / 8;
            _loc2_ = helper.angleForVector(dx,dy);
            _loc3_ = helper.angleForVector(_loc1_.x,_loc1_.y);
            if(stateTicks > 30)
            {
               if(Interpolation.distanceToAngle(_loc2_,_loc3_) > 30)
               {
                  changeState(stateChargeEnd);
               }
            }
         }
         else if(state == stateChargeEnd)
         {
            if(!closeToScreen())
            {
               dx *= 1.03;
               dy *= 1.03;
            }
            else
            {
               changeState(stateChargeStop);
            }
         }
         else if(state == stateChargeStop)
         {
            dx *= 0.98;
            dy *= 0.98;
            _loc4_ = Math.abs(dx * dx + dy * dy);
            if(_loc4_ < 0.01)
            {
               changeState(stateStanding);
            }
         }
         if(state != stateStanding)
         {
            baseRotation = helper.angleForVector(dx,dy) + 90;
            basex += dx;
            basey += dy;
            dx *= 0.97;
            dy *= 0.97;
         }
         if(state == stateCharging || state == stateChargeEnd)
         {
            for each(_loc5_ in gs.objects)
            {
               if(_loc5_.distanceToObject(this) < 40)
               {
                  if(_loc5_ is FloorProp)
                  {
                     FloorProp(_loc5_).hasBeenHit(_loc5_);
                  }
                  if(_loc5_ is EnemyBase)
                  {
                     if(!(_loc5_ is BullBase) && !(_loc5_ is WalkerTurretBase))
                     {
                        if(EnemyBase(_loc5_).collisionWidth() != 0)
                        {
                           if(_loc5_ is TerranTurretBase)
                           {
                              dx *= 0.1;
                              dy *= 0.1;
                           }
                           EnemyBase(_loc5_).hitBy(null,10000);
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() * 3 / 4;
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() * 3 / 4;
      }
   }
}

