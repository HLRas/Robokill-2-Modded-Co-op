package Objects
{
   import GameScene.GameScene;
   import ObjectBase.TreasureChestBase;
   import ObjectConstructors.TreasureChest_constructor;
   
   public class TreasureChest extends TreasureChestBase
   {
      
      public function TreasureChest(param1:GameScene, param2:int, param3:int)
      {
         super(param1,TreasureChest_constructor.baseim_embed,TreasureChest_constructor.LayerName,param2,param3);
         TreasureChest_constructor.setup(param1,this);
         collidesWithWalls = false;
      }
   }
}

