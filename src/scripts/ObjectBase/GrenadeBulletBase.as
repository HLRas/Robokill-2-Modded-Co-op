package ObjectBase
{
   import Audio.GameSoundChannel;
   import GameScene.GameScene;
   import flash.display.Bitmap;
   
   public class GrenadeBulletBase extends BulletBase
   {
      
      public var bounce:int = 0;
      
      public var bounceMag:int = 0;
      
      public var dir:int = 1;
      
      public var releasedTicks:int = 0;
      
      public var bounceSet:Array;
      
      public var released:Boolean = true;
      
      public function GrenadeBulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         speed = 5;
      }
      
      override public function collisionHeight() : Number
      {
         return 15;
      }
      
      override public function hitByShield() : void
      {
         removeWithEffects();
      }
      
      override public function _update() : void
      {
         if(releasedTicks > 30)
         {
            if(releasedTicks % 15 > 7)
            {
               Bitmap(obj).bitmapData = bounceSet[bounceSet.length - 2];
            }
            else
            {
               Bitmap(obj).bitmapData = bounceSet[bounceSet.length - 1];
            }
         }
         else
         {
            setFrameFromRange(releasedTicks,30,bounceSet);
         }
         if(released)
         {
            ++releasedTicks;
         }
         super._update();
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
      
      override public function collisionWidth() : Number
      {
         return 15;
      }
   }
}

