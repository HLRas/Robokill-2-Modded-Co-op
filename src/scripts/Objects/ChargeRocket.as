package Objects
{
   import Audio.GameSoundChannel;
   import GameScene.GameScene;
   import ObjectBase.BulletBase;
   import ObjectBase.PlayerBase;
   import ObjectConstructors.ChargeRocket_constructor;
   import Tools.Input;
   import Tools.Interpolation;
   
   public class ChargeRocket extends BulletBase
   {
      
      public var initialTargetX:Number = 0;
      
      public var initialTargetY:Number = 0;
      
      public var heavy:Array;
      
      public var delay:int = 0;
      
      public var light:Array;
      
      public var extraSpeed:Number = 2.3 + Math.random() * 0.3;
      
      public var stopTracking:Boolean = false;
      
      public var speedUpTime:int = 80 + Math.random() * 40;
      
      public var lastTargetX:Number = 0;
      
      public var medium:Array;
      
      public var baseSpeed:Number = 2.8 + Math.random() * 0.4;
      
      public var lastTargetY:Number = 0;
      
      public function ChargeRocket(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ChargeRocket_constructor.baseim_embed,ChargeRocket_constructor.LayerName,param2,param3);
         ChargeRocket_constructor.setup(param1,this);
         baseHandleY = 0.2;
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() / 2;
      }
      
      override public function hitByShield() : void
      {
         removeWithEffects();
      }
      
      override public function _update() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(ticks == 1)
         {
            _loc2_ = 50 + 30 * Math.random();
            initialTargetX = Math.random() * 800;
            initialTargetY = Math.random() * 600;
            lastTargetX = source is PlayerBase ? PlayerBase(source).lockTargetX : Input.i.mouseX();
            lastTargetY = source is PlayerBase ? PlayerBase(source).lockTargetY : Input.i.mouseY();
         }
         var _loc1_:Array = light;
         if(wep.level == 1)
         {
            _loc1_ = medium;
         }
         else if(wep.level == 2)
         {
            _loc1_ = heavy;
         }
         if(ticks % 10 < 5)
         {
            helperAnimation.setFrame(_loc1_[2]);
         }
         else
         {
            helperAnimation.setFrame(_loc1_[3]);
         }
         super._update();
         if(!stopTracking)
         {
            if(ticks > 30)
            {
               _loc3_ = helper.angleToPoint(lastTargetX,lastTargetY) + 90;
               baseRotation = Interpolation.tendTowardsAngle(baseRotation,_loc3_,1);
               angle = baseRotation;
               if(Interpolation.distanceToAngle(baseRotation,_loc3_) > 90)
               {
                  stopTracking = true;
               }
            }
         }
         speed = baseSpeed + Interpolation.linearInterpolateLock(0,extraSpeed,ticks / speedUpTime);
         if(delay > 0)
         {
            --delay;
            hide();
            speed = 0;
         }
         else
         {
            show();
         }
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() / 2;
      }
      
      override public function removeWithEffects() : void
      {
         var _loc1_:GameSoundChannel = Sounds.rocketHit.play();
         if(_loc1_)
         {
            _loc1_.setVolume(_loc1_.vol() * 0.5);
         }
         emitConditionalParticles("RocketExplosion");
         remove();
      }
   }
}

