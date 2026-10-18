package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBulletBase;
   import ObjectConstructors.SpiderGunnerShot_constructor;
   
   public class SpiderGunnerShot extends HulkBulletBase
   {
      
      public var lastBounced:int = 0;
      
      public function SpiderGunnerShot(param1:GameScene, param2:int, param3:int)
      {
         super(param1,SpiderGunnerShot_constructor.baseim_embed,SpiderGunnerShot_constructor.LayerName,param2,param3);
         SpiderGunnerShot_constructor.setup(param1,this);
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(ticks - lastBounced < 10)
         {
            return;
         }
         if(lastBounced > 0)
         {
            super.hasHitWall();
         }
         lastBounced = ticks;
         var _loc4_:Number = cosd(baseRotation);
         var _loc5_:Number = sind(baseRotation);
         if(param2 != 0)
         {
            _loc4_ *= -1;
         }
         if(param1 != 0)
         {
            _loc5_ *= -1;
         }
         baseRotation = 180 * Math.atan2(_loc5_,_loc4_) / Math.PI;
      }
   }
}

