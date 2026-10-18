package Objects
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import ObjectBase.EnemyBase;
   import ObjectBase.HumanBase;
   import ObjectConstructors.GruntRider_constructor;
   
   public class GruntRider extends EnemyBase
   {
      
      public var acc:Number = 0;
      
      public var accTicks:int = 0;
      
      public function GruntRider(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,GruntRider_constructor.baseim_embed,GruntRider_constructor.LayerName,param2,param3);
         GruntRider_constructor.setup(param1,this);
         addFilter(new GameObjectFilterRotateSlowly(2));
         baseHealth *= 10;
         extraHealth *= 10;
         collidesWithWalls = false;
      }
      
      override public function nextSquareInvalid() : Boolean
      {
         return false;
      }
      
      override public function _update() : void
      {
         var _loc4_:GameObject = null;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         var _loc1_:Boolean = false;
         var _loc2_:Number = 1;
         var _loc3_:Number = 0.8;
         moveAlongAngle(_loc2_ + _loc3_,angleToObject(ms.player));
         for each(_loc4_ in gs.objects)
         {
            if(_loc4_.distanceToObject(this) < 40)
            {
               if(_loc4_ is FloorProp)
               {
                  FloorProp(_loc4_).hasBeenHit(_loc4_);
               }
            }
         }
         for each(_loc4_ in gs.objects)
         {
            if(_loc4_ is HumanBase)
            {
               if(spriteCollidesWith(HumanBase(_loc4_)))
               {
                  _loc4_.remove();
               }
            }
         }
      }
      
      override public function _experience() : int
      {
         return 100;
      }
   }
}

