package Objects
{
   import GameScene.GameScene;
   import ObjectBase.TurretBase;
   import ObjectConstructors.Turret_constructor;
   
   public class Turret extends TurretBase
   {
      
      public function Turret(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Turret_constructor.baseim_embed,Turret_constructor.LayerName,param2,param3);
         Turret_constructor.setup(param1,this);
      }
   }
}

