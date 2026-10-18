package ObjectBase
{
   import GameScene.GameScene;
   
   public class HulkBulletBase extends EnemyBulletBase
   {
      
      public function HulkBulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         additive = true;
      }
   }
}

