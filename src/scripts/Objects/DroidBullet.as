package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBulletBase;
   import ObjectConstructors.DroidBullet_constructor;
   
   public class DroidBullet extends HulkBulletBase
   {
      
      public function DroidBullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,DroidBullet_constructor.baseim_embed,DroidBullet_constructor.LayerName,param2,param3);
         DroidBullet_constructor.setup(param1,this);
      }
   }
}

