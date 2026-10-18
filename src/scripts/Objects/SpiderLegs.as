package Objects
{
   import GameScene.GameScene;
   import ObjectBase.LegsBase;
   import ObjectConstructors.SpiderLegs_constructor;
   
   public class SpiderLegs extends LegsBase
   {
      
      public function SpiderLegs(param1:GameScene, param2:int, param3:int)
      {
         super(param1,SpiderLegs_constructor.baseim_embed,SpiderLegs_constructor.LayerName,param2,param3);
         SpiderLegs_constructor.setup(param1,this);
      }
   }
}

