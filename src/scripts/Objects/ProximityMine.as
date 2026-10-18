package Objects
{
   import GameScene.GameScene;
   import ObjectBase.ProximityMineBase;
   import ObjectConstructors.ProximityMine_constructor;
   
   public class ProximityMine extends ProximityMineBase
   {
      
      public function ProximityMine(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ProximityMine_constructor.baseim_embed,ProximityMine_constructor.LayerName,param2,param3);
         ProximityMine_constructor.setup(param1,this);
      }
   }
}

