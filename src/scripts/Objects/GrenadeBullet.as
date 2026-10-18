package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GrenadeBulletBase;
   import ObjectConstructors.GrenadeBullet_constructor;
   
   public class GrenadeBullet extends GrenadeBulletBase
   {
      
      public function GrenadeBullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,GrenadeBullet_constructor.baseim_embed,GrenadeBullet_constructor.LayerName,param2,param3);
         GrenadeBullet_constructor.setup(param1,this);
      }
   }
}

