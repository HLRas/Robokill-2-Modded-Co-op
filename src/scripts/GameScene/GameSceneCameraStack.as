package GameScene
{
   import Tools.*;
   
   public class GameSceneCameraStack
   {
      
      public static var globalCameraX:Number;
      
      public static var globalCameraY:Number;
      
      public var Camera:GameSceneCamera;
      
      public var ticks:Number = 0;
      
      public function GameSceneCameraStack()
      {
         super();
      }
      
      public static function cameraSort(param1:GameSceneCameraStack, param2:GameSceneCameraStack) : int
      {
         if(param1.ticks > param2.ticks)
         {
            return -1;
         }
         if(param1.ticks < param2.ticks)
         {
            return 1;
         }
         return 0;
      }
      
      public static function flatten(param1:Array) : GameSceneCamera
      {
         var _loc5_:GameSceneCameraStack = null;
         var _loc6_:GameSceneCamera = null;
         var _loc7_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         for each(_loc5_ in param1)
         {
            if(_loc5_.ticks > 0)
            {
               if(_loc5_.Camera.linear)
               {
                  _loc7_ = Number(_loc5_.ticks) / Number(_loc5_.Camera.totalTicks);
               }
               else
               {
                  _loc7_ = Interpolation.squareSquareInterpolateLock(0,1,Number(_loc5_.ticks) / Number(_loc5_.Camera.totalTicks));
               }
               _loc2_ += _loc5_.Camera.x * _loc7_;
               _loc3_ += _loc5_.Camera.y * _loc7_;
               _loc4_ += _loc7_;
            }
         }
         _loc6_ = new GameSceneCamera();
         if(_loc4_ > 0)
         {
            _loc6_.x = _loc2_ / _loc4_;
            _loc6_.y = _loc3_ / _loc4_;
         }
         else if(param1.length > 0)
         {
            _loc6_.x = param1[0].Camera.x;
            _loc6_.y = param1[0].Camera.y;
         }
         else
         {
            _loc6_.x = 0;
            _loc6_.y = 0;
         }
         globalCameraX = _loc6_.x;
         globalCameraY = _loc6_.y;
         return _loc6_;
      }
      
      public function decay() : void
      {
         ticks -= Camera.frameChange;
         if(ticks < 0)
         {
            ticks = 0;
         }
      }
      
      public function increment() : void
      {
         ticks += Camera.frameChange * 2;
         if(ticks > Camera.totalTicks)
         {
            ticks = Camera.totalTicks;
         }
      }
   }
}

