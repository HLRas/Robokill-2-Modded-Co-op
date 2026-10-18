package Objects
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.EnemyCrackFake_constructor;
   
   public class EnemyCrackFake extends GameObjectBase
   {
      
      public function EnemyCrackFake(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Embeds.fake_trap_png,"BelowFloor",param2,param3);
         EnemyCrackFake_constructor.setup(param1,this);
         pushable = false;
         collidesWithWalls = false;
         tintBasedOnPosition = true;
      }
      
      override public function _update() : void
      {
         super._update();
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey"];
      }
   }
}

