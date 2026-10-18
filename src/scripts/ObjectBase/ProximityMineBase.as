package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   
   public class ProximityMineBase extends ActorBase
   {
      
      public function ProximityMineBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         pushable = false;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         super._update();
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is EnemyBase)
            {
               if(!EnemyBase(_loc1_).isFlying())
               {
                  if(distanceToObject(_loc1_) < 40)
                  {
                     explode();
                  }
               }
            }
         }
         basex += dx;
         basey += dy;
         dx *= 0.97;
         dy *= 0.97;
         var _loc2_:Boolean = false;
         if(Math.abs(dx) > 0.2)
         {
            if(basex - baseWidth / 2 < ms.wallstartx || basex + baseWidth / 2 > ms.wallendx)
            {
               _loc2_ = true;
            }
         }
         if(Math.abs(dy) > 0.2)
         {
            if(basey - baseHeight / 2 < ms.wallstarty || basey + baseHeight / 2 > ms.wallendy)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            explode();
         }
      }
      
      public function explode() : void
      {
         if(_removed)
         {
            return;
         }
         createSplashDamage(basex,basey,140);
         emitConditionalParticles("Destroy");
         remove();
      }
      
      public function createSplashDamage(param1:Number, param2:Number, param3:int) : void
      {
         doSplashDamage(param3,1,true,true,false);
      }
   }
}

