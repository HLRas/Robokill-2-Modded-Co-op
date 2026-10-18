package Objects
{
   import GameScene.GameScene;
   import ObjectBase.LegsBase;
   import ObjectConstructors.GruntLegs_constructor;
   
   public class GruntLegs extends LegsBase
   {
      
      public function GruntLegs(param1:GameScene, param2:int, param3:int)
      {
         super(param1,GruntLegs_constructor.baseim_embed,GruntLegs_constructor.LayerName,param2,param3);
         GruntLegs_constructor.setup(param1,this);
      }
   }
}

