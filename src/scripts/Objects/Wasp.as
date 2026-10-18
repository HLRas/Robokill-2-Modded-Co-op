package Objects
{
   import GameObject.GameObjectFilter;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.HoverSwarmBase;
   import ObjectConstructors.Wasp_constructor;
   import Scenes.MainScene;
   import flash.display.BitmapData;
   
   public class Wasp extends HoverSwarmBase
   {
      
      public var isHero:Boolean = false;
      
      public var lockRotationRotation:Number = 0;
      
      public var lockRotation:int = 0;
      
      public var shakeRotation:Number = -9999;
      
      public var formUpTime:Number = 400 + Math.random() * 400;
      
      public var alternateMovementTicks:int = Math.random() * 3000;
      
      public var alternateMovement:Boolean = false;
      
      public var creationFrame:BitmapData;
      
      public var baseExtraAngle:Number = -60 + 120 * Math.random();
      
      public function Wasp(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Wasp_constructor.baseim_embed,Wasp_constructor.LayerName,param2,param3);
         Wasp_constructor.setup(param1,this);
         moveLikeBull = false;
         inertia = 0.96;
         legSpeedConst = 0.8;
         baseHealth *= 0.4;
      }
      
      override public function _experience() : int
      {
         if(isHero)
         {
            return 100;
         }
         return 25;
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() * 1.4;
      }
      
      override public function pauseShadow() : Boolean
      {
         return lockRotation > 0;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObjectFilter = null;
         var _loc2_:GameObjectFilterRotateSlowly = null;
         if(isHero)
         {
            imageSet = Embeds.waspHero;
         }
         if(shakeRotation < -999)
         {
            shakeRotation = lockRotationRotation;
         }
         pushable = lockRotation == 0;
         if(lockRotation > 0)
         {
            --lockRotation;
            moveAlongAngle(1,lockRotationRotation - 90);
            baseRotation = shakeRotation;
            if(ticks % 5 == 0)
            {
               shakeRotation = lockRotationRotation + (Math.random() - 0.5) * 10;
            }
            if(lockRotation == 0)
            {
               animFrame = 3;
            }
            else
            {
               helperAnimation.setFrame(creationFrame);
            }
         }
         super._update();
         for each(_loc1_ in filters)
         {
            if(_loc1_ is GameObjectFilterRotateSlowly)
            {
               _loc2_ = GameObjectFilterRotateSlowly(_loc1_);
               if(lockRotation)
               {
                  _loc2_.rotSpeed = 0.05;
               }
               else if(_loc2_.rotSpeed < 2)
               {
                  _loc2_.rotSpeed += 0.01;
               }
            }
         }
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() * 1.4;
      }
      
      override public function doMovement() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(lockRotation == 0)
         {
            ++alternateMovementTicks;
            slowAroundCorners = false;
            _loc1_ = angleToObject(MainScene(gs).player) + 90;
            _loc2_ = Math.sin(2 * Math.PI * alternateMovementTicks / 1000);
            _loc3_ = baseExtraAngle * _loc2_;
            moveAlongAngle(2.2,_loc1_ + _loc3_,true);
            baseRotation = _loc1_ + _loc3_;
         }
      }
   }
}

