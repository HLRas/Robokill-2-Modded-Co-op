package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HoverSpawnBase;
   import ObjectConstructors.HoverSpawn_constructor;
   
   public class HoverSpawn extends HoverSpawnBase
   {
      
      public function HoverSpawn(param1:GameScene, param2:int, param3:int)
      {
         super(param1,HoverSpawn_constructor.baseim_embed,HoverSpawn_constructor.LayerName,param2,param3);
         HoverSpawn_constructor.setup(param1,this);
      }
   }
}

