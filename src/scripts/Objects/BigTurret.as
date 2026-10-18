package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BigTurretBase;
   import ObjectConstructors.BigTurret_constructor;
   
   public class BigTurret extends BigTurretBase
   {
      
      public function BigTurret(param1:GameScene, param2:int, param3:int)
      {
         super(param1,BigTurret_constructor.baseim_embed,BigTurret_constructor.LayerName,param2,param3);
         BigTurret_constructor.setup(param1,this);
         pushable = false;
      }
      
      override public function canBeFrozen() : Boolean
      {
         return false;
      }
   }
}

