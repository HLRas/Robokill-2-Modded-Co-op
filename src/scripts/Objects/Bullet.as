package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BulletBase;
   import ObjectConstructors.Bullet_constructor;
   
   public class Bullet extends BulletBase
   {
      
      public function Bullet(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Bullet_constructor.baseim_embed,Bullet_constructor.LayerName,param2,param3);
         Bullet_constructor.setup(param1,this);
      }
   }
}

