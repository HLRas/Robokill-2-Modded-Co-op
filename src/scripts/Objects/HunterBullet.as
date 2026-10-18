package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBulletBase;
   import ObjectConstructors.HunterBullet_constructor;
   
   public class HunterBullet extends HulkBulletBase
   {
      
      public function HunterBullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,HunterBullet_constructor.baseim_embed,HunterBullet_constructor.LayerName,param2,param3);
         HunterBullet_constructor.setup(param1,this);
      }
      
      override public function damage() : int
      {
         return super.damage() * 4;
      }
   }
}

