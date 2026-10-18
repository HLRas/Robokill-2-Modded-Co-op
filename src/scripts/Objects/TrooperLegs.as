package Objects
{
   import GameScene.GameScene;
   import ObjectBase.LegsBase;
   import ObjectConstructors.TrooperLegs_constructor;
   
   public class TrooperLegs extends LegsBase
   {
      
      public function TrooperLegs(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,TrooperLegs_constructor.baseim_embed,TrooperLegs_constructor.LayerName,param2,param3);
         TrooperLegs_constructor.setup(param1,this);
      }
   }
}

