package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GrenadeBase;
   import ObjectConstructors.TrooperGrenade_constructor;
   
   public class TrooperGrenade extends GrenadeBase
   {
      
      public function TrooperGrenade(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,TrooperGrenade_constructor.baseim_embed,TrooperGrenade_constructor.LayerName,param2,param3);
         TrooperGrenade_constructor.setup(param1,this);
      }
      
      override public function _update() : void
      {
         collidesWithWalls = false;
         super._update();
      }
      
      override public function landed() : void
      {
         emitConditionalParticles("Destroy");
         doSplashDamage(100,1,false,true,true);
         remove();
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
      }
   }
}

