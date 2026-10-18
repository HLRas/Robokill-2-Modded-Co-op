package Objects
{
   import GameScene.GameScene;
   import ObjectBase.LegsBase;
   import ObjectConstructors.PlayerLegs_constructor;
   
   public class PlayerLegs extends LegsBase
   {
      
      public function PlayerLegs(param1:GameScene, param2:int, param3:int)
      {
         super(param1,PlayerLegs_constructor.baseim_embed,PlayerLegs_constructor.LayerName,param2,param3);
         PlayerLegs_constructor.setup(param1,this);
      }
   }
}

