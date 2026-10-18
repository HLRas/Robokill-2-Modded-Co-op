package Objects
{
   import GameScene.GameScene;
   import ObjectBase.PulseBulletBase;
   import ObjectConstructors.PulseShotgunBullet_constructor;
   
   public class PulseShotgunBullet extends PulseBulletBase
   {
      
      public function PulseShotgunBullet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,PulseShotgunBullet_constructor.baseim_embed,PulseShotgunBullet_constructor.LayerName,param2,param3);
         PulseShotgunBullet_constructor.setup(param1,this);
      }
   }
}

