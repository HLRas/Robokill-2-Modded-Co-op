package Tools
{
   import flash.geom.Point;
   
   public class Interpolation
   {
      
      public function Interpolation()
      {
         super();
      }
      
      public static function sqrtInterpolate(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 + (param2 - param1) * Math.sqrt(param3);
      }
      
      public static function dampenInterpolateLock(param1:Number, param2:Number, param3:Number) : Number
      {
         return dampenInterpolate(param1,param2,lockValue(param3,0,1));
      }
      
      public static function fromTo(param1:Number, param2:Number, param3:Number) : Number
      {
         return (param1 - param2) / (param3 - param2);
      }
      
      public static function lockValue(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function squareSquareInterpolate(param1:Number, param2:Number, param3:Number) : Number
      {
         param3 *= 2;
         if(param3 < 1)
         {
            return param1 + (param2 - param1) * Math.pow(param3,2) / 2;
         }
         return param1 + (param2 - param1) * (-Math.pow(param3 - 2,2) + 2) / 2;
      }
      
      public static function lockValueInt(param1:int, param2:int, param3:int) : int
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function sqrtInterpolateLock(param1:Number, param2:Number, param3:Number) : Number
      {
         return sqrtInterpolate(param1,param2,lockValue(param3,0,1));
      }
      
      public static function flipAngleLeft(param1:Number) : Number
      {
         return param1 - 360;
      }
      
      public static function fromToLock(param1:Number, param2:Number, param3:Number) : Number
      {
         return lockValue(fromTo(param1,param2,param3),0,1);
      }
      
      public static function squareSquareInterpolateLock(param1:Number, param2:Number, param3:Number) : Number
      {
         return squareSquareInterpolate(param1,param2,lockValue(param3,0,1));
      }
      
      public static function flipAngleRight(param1:Number) : Number
      {
         return param1 + 360;
      }
      
      public static function cubicInterpolate(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         var _loc6_:Number = param4 - param3 - (param1 - param2);
         var _loc7_:Number = param1 - param2 - _loc6_;
         var _loc8_:Number = param3 - param1;
         var _loc9_:Number = param2;
         return _loc6_ * param5 * param5 * param5 + _loc7_ * param5 * param5 + _loc8_ * param5 + _loc9_;
      }
      
      public static function tendTowardsVector(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Point
      {
         var _loc6_:Number = param3 - param1;
         var _loc7_:Number = param4 - param2;
         if(_loc6_ == 0 && _loc7_ == 0)
         {
            return new Point(param3,param4);
         }
         if(_loc6_ * _loc6_ + _loc7_ * _loc7_ <= param5 * param5)
         {
            return new Point(param3,param4);
         }
         var _loc8_:Number = Math.atan2(_loc7_,_loc6_);
         var _loc9_:Number = param1 + Math.cos(_loc8_) * param5;
         var _loc10_:Number = param2 + Math.sin(_loc8_) * param5;
         return new Point(_loc9_,_loc10_);
      }
      
      public static function directionToAngle(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param2 - param1;
         while(abs(param2 - param1) > 181)
         {
            param2 -= sgn(param2 - param1) * 360;
         }
         return sgn(param2 - param1);
      }
      
      public static function sgn(param1:Number) : Number
      {
         if(param1 < 0)
         {
            return -1;
         }
         if(param1 == 0)
         {
            return 0;
         }
         return 1;
      }
      
      public static function linearInterpolate(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 + (param2 - param1) * param3;
      }
      
      public static function tendTowardsAngle(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc4_:Number = param2 - param1;
         while(abs(param2 - param1) > 181)
         {
            param2 -= sgn(param2 - param1) * 360;
         }
         return tendTowards(param1,param2,param3);
      }
      
      public static function tendTowardsSmoothed(param1:Number, param2:Number, param3:Number, param4:Number = 2) : Number
      {
         var _loc5_:Number = Math.abs(param1 - param2) / param4;
         if(_loc5_ > param3)
         {
            _loc5_ = param3;
         }
         param3 = _loc5_;
         if(Math.abs(param2 - param1) < Math.abs(param3))
         {
            return param2;
         }
         if(param2 > param1)
         {
            return param1 + param3;
         }
         return param1 - param3;
      }
      
      public static function distanceToAngle(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param2 - param1;
         while(abs(param2 - param1) > 181)
         {
            param2 -= sgn(param2 - param1) * 360;
         }
         return abs(param2 - param1);
      }
      
      public static function squareInterpolate(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 + (param2 - param1) * Math.pow(param3,2);
      }
      
      public static function linearInterpolateLock(param1:Number, param2:Number, param3:Number) : Number
      {
         return linearInterpolate(param1,param2,lockValue(param3,0,1));
      }
      
      public static function snapToAngle(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param1 + param2 * 999999;
         var _loc4_:Number = _loc3_ - _loc3_ % param2;
         var _loc5_:Number = _loc3_ + (param2 - _loc3_ % param2);
         _loc4_ -= param2 * 999999;
         _loc5_ -= param2 * 999999;
         if(param1 - _loc4_ > _loc5_ - param1)
         {
            return _loc5_;
         }
         return _loc4_;
      }
      
      public static function squareInterpolateLock(param1:Number, param2:Number, param3:Number) : Number
      {
         return squareInterpolate(param1,param2,lockValue(param3,0,1));
      }
      
      public static function abs(param1:Number) : Number
      {
         return Math.abs(param1);
      }
      
      public static function tendTowards(param1:Number, param2:Number, param3:Number) : Number
      {
         if(Math.abs(param2 - param1) < Math.abs(param3))
         {
            return param2;
         }
         if(param2 > param1)
         {
            return param1 + param3;
         }
         return param1 - param3;
      }
      
      public static function dampenInterpolate(param1:Number, param2:Number, param3:Number) : Number
      {
         param3 = Math.sqrt(param3);
         var _loc4_:Number = 1 - Math.sin(15 * (Math.pow(param3,2.5) - 5) / Math.PI) * Math.pow(1 - param3,2) / 0.95;
         return param1 + _loc4_ * (param2 - param1);
      }
   }
}

