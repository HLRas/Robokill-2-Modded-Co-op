package Objects
{
   import GameScene.GameScene;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.GruntRiderCannon_constructor;
   
   public class GruntRiderCannon extends EnemyBase
   {
      
      public var detached:Boolean = false;
      
      public var blowingUp:int = 0;
      
      public function GruntRiderCannon(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,GruntRiderCannon_constructor.baseim_embed,GruntRiderCannon_constructor.LayerName,param2,param3);
         GruntRiderCannon_constructor.setup(param1,this);
         baseHealth *= 20;
         _canFall = false;
      }
      
      override public function _update() : void
      {
         var _loc1_:BigTurretBullet = null;
         super._update();
         if(!detached)
         {
            if(randTicks % 100 == 0)
            {
               _loc1_ = BigTurretBullet(shoot(BigTurretBullet));
               if(_loc1_)
               {
                  _loc1_.speedMult *= 1.5;
               }
            }
         }
         else
         {
            remove();
         }
      }
      
      override public function _experience() : int
      {
         return 0;
      }
   }
}

