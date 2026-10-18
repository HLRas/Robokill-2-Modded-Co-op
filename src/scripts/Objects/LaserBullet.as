package Objects
{
   import GameScene.GameScene;
   import ObjectBase.LaserBulletBase;
   import ObjectConstructors.LaserBullet_constructor;
   
   public class LaserBullet extends LaserBulletBase
   {
      
      public function LaserBullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,LaserBullet_constructor.baseim_embed,LaserBullet_constructor.LayerName,param2,param3);
         LaserBullet_constructor.setup(param1,this);
      }
   }
}

