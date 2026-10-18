package ObjectBase
{
   import GameScene.GameScene;
   
   public class PulseBulletBase extends BulletBase
   {
      
      public var lastBounced:int = -100;
      
      public var bounceCount:int = 0;
      
      public function PulseBulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         pushedByWalls = false;
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(ticks - lastBounced < 3)
         {
            return;
         }
         ++bounceCount;
         if(bounceCount > 1)
         {
            super.hasHitWall();
         }
         lastBounced = ticks;
         if(param1 != 0 && param2 != 0)
         {
            baseRotation += 180;
            angle += 180;
            return;
         }
         var _loc4_:Number = cosd(baseRotation - 90);
         var _loc5_:Number = sind(baseRotation - 90);
         if(param2 != 0)
         {
            _loc4_ *= -1;
         }
         if(param1 != 0)
         {
            _loc5_ *= -1;
         }
         baseRotation = 180 * Math.atan2(_loc5_,_loc4_) / Math.PI - 90;
         angle = baseRotation;
      }
   }
}

