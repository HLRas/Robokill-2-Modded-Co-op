package Misc
{
   public class SpawnPoints
   {
      
      public var points:Array = new Array();
      
      public var curTick:int = 0;
      
      public function SpawnPoints()
      {
         super();
      }
      
      public function getPoint(param1:int, param2:int) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:Number = 99999;
         var _loc5_:int = 0;
         while(_loc5_ < points.length)
         {
            if(points[_loc5_][0] >= 0)
            {
               if(points[_loc5_][2] > _loc4_ || _loc3_ == null)
               {
                  _loc3_ = points[_loc5_];
                  _loc4_ = Number(points[_loc5_][2]);
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getDistance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 - param3;
         var _loc6_:Number = param2 - param4;
         return Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
      }
      
      public function removePoint(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < points.length)
         {
            if(points[_loc3_][0] == param1 && points[_loc3_][1] == param2)
            {
               points[_loc3_][0] = -1000;
            }
            _loc3_++;
         }
      }
      
      public function setPoint(param1:int, param2:int) : void
      {
         ++curTick;
         var _loc3_:int = 0;
         while(_loc3_ < points.length)
         {
            if(points[_loc3_][0] == param1 && points[_loc3_][1] == param2)
            {
               points[_loc3_][2] = curTick;
               return;
            }
            _loc3_++;
         }
         points.push([param1,param2,curTick]);
      }
      
      public function contains(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < points.length)
         {
            if(points[_loc3_][0] == param1 && points[_loc3_][1] == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}

