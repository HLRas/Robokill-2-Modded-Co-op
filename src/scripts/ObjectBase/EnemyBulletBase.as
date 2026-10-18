package ObjectBase
{
   import GameScene.GameScene;
   import Scenes.MainScene;
   
   public class EnemyBulletBase extends BulletBase
   {
      
      public var from:EnemyBase = null;
      
      public var playRicochet:Boolean = false;
      
      public var toughness:int = 0;
      
      public var speedMult:Number = 0.9 + Math.random() * 0.2;
      
      public var boxDamage:int = 1;
      
      public var damageMult:Number = 1;
      
      public function EnemyBulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         additive = true;
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      override public function kill() : void
      {
         emitConditionalParticles("EnemyHit");
         remove();
      }
      
      override public function damage() : int
      {
         return damageMult * (8 + 6 * toughness);
      }
      
      override public function handlePlayerCollision() : void
      {
         if(!canHitPlayer)
         {
            return;
         }
         if(!MainScene(gs).player.inShield())
         {
            emitConditionalParticles("BulletHitPlayer",MainScene(gs).player.basex,MainScene(gs).player.basey,true);
         }
         MainScene(gs).player.handleHit(this);
         if(!MainScene(gs).player.inShield())
         {
            kill();
         }
         Sounds.objectHit.play();
      }
      
      override public function _init() : void
      {
         speed = 4 * speedMult;
      }
      
      override public function hitByShockwave() : void
      {
         super.hitByShockwave();
         source = ms.player;
         angle = helper.angleForVector(dx,dy) + 90;
         baseRotation = angle;
      }
   }
}

