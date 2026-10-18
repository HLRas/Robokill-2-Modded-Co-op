package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.FloorTile_constructor;
   
   public class FloorTile extends GameObjectBase
   {
      
      public var images:Array;
      
      public function FloorTile(param1:GameScene, param2:int, param3:int)
      {
         super(param1,FloorTile_constructor.baseim_embed,FloorTile_constructor.LayerName,param2,param3);
         FloorTile_constructor.setup(param1,this);
      }
   }
}

