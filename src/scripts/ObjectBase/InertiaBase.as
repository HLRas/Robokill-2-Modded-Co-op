package ObjectBase
{
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.InertiaTrail;
   import Scenes.MainScene;
   
   public class InertiaBase extends EnemyBase
   {
      
      public function InertiaBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         inertia = 0.98;
         baseHealth *= 10;
         extraHealth *= 10;
         addFilter(new GameObjectFilterRotateSlowly(10));
         rotateTowardsPlayer = true;
         slowAroundCorners = false;
         var _loc6_:InertiaTrail = new InertiaTrail(param1,0,0);
         addChild(_loc6_);
         collidesWithWalls = false;
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         moveTowardsPlayerFly(Math.sqrt(ticks / 100));
         super._update();
         baseRotation = angleToObject(MainScene(gs).player) + 90;
      }
      
      override public function _experience() : int
      {
         return 100;
      }
      
      override public function canMoveOnLand() : Boolean
      {
         return true;
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
   }
}

