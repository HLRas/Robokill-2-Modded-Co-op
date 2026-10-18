package Objects
{
   import GameScene.GameScene;
   import ObjectBase.EnemyLaserBase;
   import ObjectConstructors.EnemyLaser_constructor;
   
   public class EnemyLaser extends EnemyLaserBase
   {
      
      public function EnemyLaser(param1:GameScene, param2:int, param3:int)
      {
         super(param1,EnemyLaser_constructor.baseim_embed,EnemyLaser_constructor.LayerName,param2,param3);
         EnemyLaser_constructor.setup(param1,this);
      }
   }
}

