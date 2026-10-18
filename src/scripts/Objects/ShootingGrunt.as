package Objects
{
   import GameScene.GameScene;
   import ObjectBase.ShootingGruntBase;
   import ObjectConstructors.ShootingGrunt_constructor;
   
   public class ShootingGrunt extends ShootingGruntBase
   {
      
      public function ShootingGrunt(param1:GameScene, param2:int, param3:int)
      {
         super(param1,ShootingGrunt_constructor.baseim_embed,ShootingGrunt_constructor.LayerName,param2,param3);
         ShootingGrunt_constructor.setup(param1,this);
         inertia = 0.95;
      }
   }
}

