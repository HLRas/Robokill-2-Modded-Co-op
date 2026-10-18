package Objects
{
   import GameScene.GameScene;
   import ObjectBase.MineLayerBase;
   import ObjectConstructors.MineLayer_constructor;
   
   public class MineLayer extends MineLayerBase
   {
      
      public function MineLayer(param1:GameScene, param2:int, param3:int)
      {
         super(param1,MineLayer_constructor.baseim_embed,MineLayer_constructor.LayerName,param2,param3);
         MineLayer_constructor.setup(param1,this);
      }
   }
}

