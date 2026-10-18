package Objects
{
   import GameScene.GameScene;
   import ObjectBase.PulseBulletBase;
   import ObjectConstructors.PulseBullet_constructor;
   
   public class PulseBullet extends PulseBulletBase
   {
      
      public function PulseBullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,PulseBullet_constructor.baseim_embed,PulseBullet_constructor.LayerName,param2,param3);
         PulseBullet_constructor.setup(param1,this);
      }
   }
}

