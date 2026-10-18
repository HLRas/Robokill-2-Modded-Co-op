package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectConstructors.GooTurretSpawn_constructor;
   import Particles.Particle;
   import flash.geom.Point;
   
   public class GooTurretSpawn extends GooTurret
   {
      
      public var spawnMask:Array;
      
      public function GooTurretSpawn(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         GooTurretSpawn_constructor.setup(param1,this);
      }
      
      override public function _experience() : int
      {
         return 200;
      }
      
      public function rotationsOK(param1:Number) : Boolean
      {
         var _loc2_:int = -40;
         while(_loc2_ <= 40)
         {
            if(!(rotationOK(param1 + _loc2_,50) && rotationOK(param1 + _loc2_,100)))
            {
               return false;
            }
            _loc2_ += 20;
         }
         return true;
      }
      
      override internal function fireFrame() : int
      {
         var _loc1_:int = getPeriod();
         _loc1_ %= 20;
         if(_loc1_ < 10)
         {
            return 16 + int(4 * (_loc1_ / 10));
         }
         return 19 - int(4 * (_loc1_ - 10) / 10);
      }
      
      override public function _update() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         super._update();
         var _loc1_:int = getPeriod();
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(_loc1_ >= 50 && _loc1_ < 150)
         {
            _loc2_ = true;
            _loc3_ = fireFrame() - 16;
         }
         var _loc4_:GameObject = helper.conditionallyCreateChild(Embeds.snake_b_mask_001_png,"Mask2",_loc2_,1,null,1);
         if(_loc4_)
         {
            _loc4_.changeZOrder("AbovePlayer");
            _loc4_.helperAnimation.setFrame(spawnMask[_loc3_]);
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
      }
      
      public function rotationOK(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Number = Math.PI / 180;
         var _loc4_:Number = basex + Math.cos(-param1 * _loc3_) * 0 * modifiedScaleX + Math.sin(-param1 * _loc3_) * -param2 * modifiedScaleY;
         var _loc5_:Number = basey + -Math.sin(-param1 * _loc3_) * 0 * modifiedScaleX + Math.cos(-param1 * _loc3_) * -param2 * modifiedScaleY;
         return ms.getPassable(ms._getLogicalSquareX(_loc4_),ms._getLogicalSquareY(_loc5_));
      }
      
      override internal function fixRotation() : Boolean
      {
         super.fixRotation();
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            if(rotationsOK(rotationLock))
            {
               break;
            }
            rotationLock = Math.random() * 360;
            baseRotation = rotationLock - 40;
            _loc1_ = true;
            if(_loc2_ == 9)
            {
               trace("Rotation lock fail!");
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function updateAnimation() : void
      {
         var _loc1_:int = getPeriod();
         if(_loc1_ < 50)
         {
            helperAnimation.setFrame(emerge[int(16 * _loc1_ / 50)]);
         }
         else if(_loc1_ < 150)
         {
            helperAnimation.setFrame(emerge[fireFrame()]);
         }
         else if(_loc1_ < 200)
         {
            helperAnimation.setFrame(emerge[16 - int(16 * (_loc1_ - 150) / 50)]);
         }
      }
      
      override public function updateFiring() : void
      {
         var _loc2_:Swarm = null;
         var _loc3_:Point = null;
         var _loc4_:Particle = null;
         var _loc1_:int = getPeriod();
         if(_loc1_ >= 50 && _loc1_ <= 140)
         {
            if(_loc1_ % 20 == 0)
            {
               _loc2_ = Swarm(spawn(Swarm,basex,basey,1));
               if(_loc2_)
               {
                  _loc3_ = helper.vectorForAngle(baseRotation);
                  _loc2_.extradx += _loc3_.x * 3;
                  _loc2_.extrady += _loc3_.y * 3;
                  _loc2_.baseRotation = baseRotation;
                  _loc2_.helperFilter.resetRotation();
                  _loc2_.rotationLock = _loc2_.baseRotation - 90;
                  _loc2_.rotationLockTicks = 50;
                  Sounds.splatter.play();
                  _loc4_ = emitConditionalParticles("Vomit")[0];
                  if(_loc4_)
                  {
                     _loc4_.Rotation = baseRotation;
                     _loc4_.dx = _loc3_.x * 2;
                     _loc4_.dy = _loc3_.y * 2;
                  }
               }
            }
         }
      }
   }
}

