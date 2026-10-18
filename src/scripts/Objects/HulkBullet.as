package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBulletBase;
   import ObjectConstructors.HulkBullet_constructor;
   
   public class HulkBullet extends HulkBulletBase
   {
      
      public function HulkBullet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,HulkBullet_constructor.baseim_embed,HulkBullet_constructor.LayerName,param2,param3);
         HulkBullet_constructor.setup(param1,this);
      }
   }
}

