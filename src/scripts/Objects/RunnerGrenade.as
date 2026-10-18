package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GrenadeBase;
   import ObjectConstructors.RunnerGrenade_constructor;
   import flash.geom.Point;
   
   public class RunnerGrenade extends GrenadeBase
   {
      
      public var effect:int = 0;
      
      public var difficulty:int = 1;
      
      public function RunnerGrenade(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,RunnerGrenade_constructor.baseim_embed,RunnerGrenade_constructor.LayerName,param2,param3);
         RunnerGrenade_constructor.setup(param1,this);
         collidesWithWalls = false;
      }
      
      override public function _update() : void
      {
         super._update();
         collidesWithWalls = false;
      }
      
      override public function landed() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Critter = null;
         if(effect == 0)
         {
            if(ms.countEnemies() != 0)
            {
               _loc1_ = tformed(0,-10);
               if(ms.squarePassable(_loc1_.x,_loc1_.y))
               {
                  _loc2_ = new Critter(gs,_loc1_.x,_loc1_.y);
                  _loc2_.ticks = 200;
                  _loc2_.setupDifficulty(1);
                  emitConditionalParticles("TeleportSmall");
               }
            }
         }
         else
         {
            doSplashDamage(100,1,false,true,true);
            emitConditionalParticles("Destroy");
            remove();
         }
         remove();
      }
   }
}

