package ObjectBase
{
   import GameScene.GameScene;
   
   public class HumanBase extends EnemyBase
   {
      
      public function HumanBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function _update() : void
      {
         handleSideBounce();
         moveRandomly();
      }
      
      override public function handlePlayerCollision() : void
      {
         remove();
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
      }
   }
}

