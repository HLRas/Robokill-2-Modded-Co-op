package Tools
{
   public class CollisionMath
   {
      
      public static var _singleton:CollisionMath = new CollisionMath();
      
      public function CollisionMath()
      {
         super();
      }
      
      public static function getSingleton() : CollisionMath
      {
         return _singleton;
      }
      
      public function lineDistance(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number
      {
         var _loc7_:Number = param3 - param1;
         var _loc8_:Number = param4 - param2;
         var _loc9_:Number = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
         var _loc10_:Number = param1 - param5;
         var _loc11_:Number = param2 - param6;
         var _loc12_:Number = (_loc7_ * _loc11_ - _loc10_ * _loc8_) / _loc9_;
         if(_loc12_ < 0)
         {
            _loc12_ = -_loc12_;
         }
         return _loc12_;
      }
      
      public function CalcX(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         if(param4 == param2)
         {
            return NaN;
         }
         return param2 + (param1 - param3) * (param5 - param3) / (param4 - param2);
      }
      
      public function CalcY(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         if(param4 == param2)
         {
            return NaN;
         }
         return param3 + (param1 - param2) * (param5 - param3) / (param4 - param2);
      }
      
      public function LineIntersectsSquare(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : int
      {
         var _loc9_:int = 0;
         if(CalcX(param8,param1,param2,param3,param4) < param7 && CalcX(param8,param1,param2,param3,param4) > param5)
         {
            _loc9_++;
         }
         if(CalcX(param6,param1,param2,param3,param4) < param7 && CalcX(param6,param1,param2,param3,param4) > param5)
         {
            _loc9_++;
         }
         if(CalcY(param5,param1,param2,param3,param4) < param6 && CalcY(param5,param1,param2,param3,param4) > param8)
         {
            _loc9_++;
         }
         if(CalcY(param7,param1,param2,param3,param4) < param6 && CalcY(param7,param1,param2,param3,param4) > param8)
         {
            _loc9_++;
         }
         return _loc9_;
      }
      
      public function circleLineCollision(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Boolean
      {
         var _loc8_:Number = param3 - param1;
         var _loc9_:Number = param4 - param2;
         var _loc10_:Number = Math.sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_);
         if(_loc10_ < 0.0001)
         {
            _loc10_ = 0.0001;
         }
         var _loc11_:Number = _loc8_ / _loc10_;
         var _loc12_:Number = _loc9_ / _loc10_;
         var _loc13_:Number = param5 - (param1 - _loc11_ * param7);
         var _loc14_:Number = param6 - (param2 - _loc12_ * param7);
         var _loc15_:Number = Math.sqrt(_loc13_ * _loc13_ + _loc14_ * _loc14_);
         _loc13_ /= _loc15_;
         _loc14_ /= _loc15_;
         var _loc16_:Number = param5 - (param3 + _loc11_ * param7);
         var _loc17_:Number = param6 - (param4 + _loc12_ * param7);
         _loc15_ = Math.sqrt(_loc16_ * _loc16_ + _loc17_ * _loc17_);
         _loc16_ /= _loc15_;
         _loc17_ /= _loc15_;
         var _loc18_:Number = _loc13_ * _loc11_ + _loc14_ * _loc12_;
         var _loc19_:Number = _loc16_ * _loc11_ + _loc17_ * _loc12_;
         return (_loc18_ >= 0 && _loc19_ <= 0 || _loc18_ <= 0 && _loc19_ >= 0) && lineDistance(param1,param2,param3,param4,param5,param6) <= param7;
      }
   }
}

