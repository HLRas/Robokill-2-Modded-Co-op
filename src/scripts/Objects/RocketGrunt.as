package Objects
{
   import GameScene.GameScene;
   import ObjectBase.ShootingGruntBase;
   import ObjectConstructors.RocketGrunt_constructor;
   
   public class RocketGrunt extends ShootingGruntBase
   {
      
      public function RocketGrunt(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,RocketGrunt_constructor.baseim_embed,RocketGrunt_constructor.LayerName,param2,param3);
         RocketGrunt_constructor.setup(param1,this);
      }
      
      override public function _experience() : int
      {
         return 100;
      }
   }
}

