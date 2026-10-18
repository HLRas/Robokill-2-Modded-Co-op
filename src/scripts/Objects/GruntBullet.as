package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBulletBase;
   import ObjectConstructors.GruntBullet_constructor;
   
   public class GruntBullet extends HulkBulletBase
   {
      
      public function GruntBullet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,GruntBullet_constructor.baseim_embed,GruntBullet_constructor.LayerName,param2,param3);
         GruntBullet_constructor.setup(param1,this);
      }
   }
}

