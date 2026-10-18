package Objects
{
   import GameScene.GameScene;
   import ObjectBase.ShotgunBulletBase;
   import ObjectConstructors.ShotgunBullet_constructor;
   
   public class ShotgunBullet extends ShotgunBulletBase
   {
      
      public function ShotgunBullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,ShotgunBullet_constructor.baseim_embed,ShotgunBullet_constructor.LayerName,param2,param3);
         ShotgunBullet_constructor.setup(param1,this);
      }
   }
}

