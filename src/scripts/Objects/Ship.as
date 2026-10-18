package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.Ship_constructor;
   
   public class Ship extends GameObjectBase
   {
      
      public function Ship(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Ship_constructor.baseim_embed,Ship_constructor.LayerName,param2,param3);
         Ship_constructor.setup(param1,this);
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
   }
}

