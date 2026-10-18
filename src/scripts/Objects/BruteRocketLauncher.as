package Objects
{
   import Audio.GameSound;
   import GameScene.GameScene;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.BruteRocketLauncher_constructor;
   
   public class BruteRocketLauncher extends EnemyBase
   {
      
      public var blowUpTicks:int = 0;
      
      public function BruteRocketLauncher(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BruteRocketLauncher_constructor.baseim_embed,BruteRocketLauncher_constructor.LayerName,param2,param3);
         BruteRocketLauncher_constructor.setup(param1,this);
         inertia = 0.99;
         doCollisions = false;
      }
      
      override public function collisionHeight() : Number
      {
         return 0;
      }
      
      override public function killSound() : GameSound
      {
         return null;
      }
      
      override public function collisionWidth() : Number
      {
         return 0;
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
      
      override public function _update() : void
      {
         super._update();
         basex += dx;
         basey += dy;
         dx *= 0.95;
         dy *= 0.95;
         if(Math.abs(dx) + Math.abs(dy) < 0.05)
         {
            dx = 0;
            dy = 0;
         }
         if(dx < 0.001)
         {
            if(!blowUpTicks)
            {
               blowUpTicks = 1;
               changeZOrder("Floor");
            }
            else
            {
               ++blowUpTicks;
               if(blowUpTicks % 25 == 0)
               {
                  lastHit = 0;
               }
               if(blowUpTicks > 100)
               {
                  doSplashDamage(100,1,false,true,true);
                  Sounds.explosion.play();
                  remove();
               }
            }
         }
      }
   }
}

