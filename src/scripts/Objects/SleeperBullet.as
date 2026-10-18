package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBulletBase;
   import ObjectConstructors.SleeperBullet_constructor;
   
   public class SleeperBullet extends HulkBulletBase
   {
      
      public function SleeperBullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,SleeperBullet_constructor.baseim_embed,SleeperBullet_constructor.LayerName,param2,param3);
         SleeperBullet_constructor.setup(param1,this);
      }
      
      override public function damage() : int
      {
         return super.damage() * 2.5;
      }
   }
}

