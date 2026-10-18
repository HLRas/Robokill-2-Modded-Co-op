package Objects
{
   import GameScene.GameScene;
   import ObjectBase.FastLaserBulletBase;
   import ObjectConstructors.FastLaserBullet_constructor;
   
   public class FastLaserBullet extends FastLaserBulletBase
   {
      
      public function FastLaserBullet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,FastLaserBullet_constructor.baseim_embed,FastLaserBullet_constructor.LayerName,param2,param3);
         FastLaserBullet_constructor.setup(param1,this);
      }
   }
}

