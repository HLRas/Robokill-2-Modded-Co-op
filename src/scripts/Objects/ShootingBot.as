package Objects
{
   import GameScene.GameScene;
   import ObjectBase.FlyingBotBase;
   import ObjectConstructors.ShootingBot_constructor;
   import Particles.ParticleEmitter;
   import Weapons.Blaster;
   import Weapons.WeaponBase;
   import flash.geom.Point;
   
   public class ShootingBot extends FlyingBotBase
   {
      
      public var side:Boolean = false;
      
      public var weapon:WeaponBase;
      
      public var damage:int = 0;
      
      public function ShootingBot(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ShootingBot_constructor.baseim_embed,ShootingBot_constructor.LayerName,param2,param3);
         ShootingBot_constructor.setup(param1,this);
         weapon = new Blaster();
         weapon.level = 0;
      }
      
      override public function _update() : void
      {
         var _loc3_:Point = null;
         Blaster(weapon).overrideDamage = damage;
         super._update();
         var _loc1_:Number = sind(randTicks / 2) * 100;
         var _loc2_:Number = sind(randTicks / 2 + 135) * 100;
         hoverAroundPlayer(_loc1_,_loc2_);
         if(target)
         {
            if(helperFilter.rotationAligned())
            {
               if(ticks % 10 == 0)
               {
                  side = !side;
                  _loc3_ = tformed(side ? -5 : 5,-10);
                  weapon.shoot(gs,_loc3_.x,_loc3_.y,target.basex,target.basey);
                  ParticleEmitter.tempDisableLayerOverride = true;
                  emitConditionalParticles("Shoot",side ? -8 : 8,-16,false,helperFilter.getModifiedRotation());
                  ParticleEmitter.tempDisableLayerOverride = false;
               }
            }
         }
      }
      
      override public function spawnY() : Number
      {
         return sind(135) * 20;
      }
      
      override public function spawnX() : Number
      {
         return sind(0) * 20;
      }
   }
}

