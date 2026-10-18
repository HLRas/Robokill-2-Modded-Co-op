package ObjectBase
{
   import GameScene.GameScene;
   
   public class GrenadeBase extends EnemyBulletBase
   {
      
      public var hasLanded:Boolean = false;
      
      public var ignoreCollision:Boolean = true;
      
      public var _speed:Number = 2;
      
      public function GrenadeBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         collidesWithWalls = false;
      }
      
      public function setSpeedBasedOnDistance(param1:Number) : Number
      {
         speed = param1 / 150;
         if(speed > 3)
         {
            speed = 3;
         }
         _speed = speed;
         return speed;
      }
      
      override public function _update() : void
      {
         collidesWithWalls = false;
         if(!hasLanded)
         {
            if(ticks > 150)
            {
               hasLanded = true;
               landed();
            }
         }
         if(!hasLanded)
         {
            setFrame(ticks * imageSet.length / 150);
            speed = _speed;
         }
         super._update();
      }
      
      override public function handlePlayerCollision() : void
      {
         if(ignoreCollision)
         {
            return;
         }
         super.handlePlayerCollision();
      }
      
      override public function damage() : int
      {
         return 50;
      }
      
      public function landed() : void
      {
      }
      
      override public function _init() : void
      {
         additive = false;
         changeZOrder("AbovePlayer");
      }
   }
}

