package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BarBase;
   import ObjectConstructors.EnemyHealthBar_constructor;
   
   public class EnemyHealthBar extends BarBase
   {
      
      public function EnemyHealthBar(param1:GameScene, param2:int, param3:int)
      {
         super(param1,EnemyHealthBar_constructor.baseim_embed,EnemyHealthBar_constructor.LayerName,param2,param3);
         EnemyHealthBar_constructor.setup(param1,this);
      }
   }
}

