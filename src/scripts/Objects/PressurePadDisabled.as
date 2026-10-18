package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.PressurePadDisabled_constructor;
   
   public class PressurePadDisabled extends GameObjectBase
   {
      
      public function PressurePadDisabled(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,PressurePadDisabled_constructor.baseim_embed,PressurePadDisabled_constructor.LayerName,param2,param3);
         PressurePadDisabled_constructor.setup(param1,this);
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey"];
      }
   }
}

