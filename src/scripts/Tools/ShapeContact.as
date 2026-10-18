package Tools
{
   import flash.geom.Point;
   
   public class ShapeContact
   {
      
      private var ProjectedA:Array = new Array();
      
      private var ProjectedB:Array = new Array();
      
      public function ShapeContact()
      {
         super();
         SetPointArrayLength(ProjectedA,30);
         SetPointArrayLength(ProjectedB,30);
      }
      
      private function project(param1:Array, param2:Array, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         SetPointArrayLength(param1,param2.length);
         var _loc6_:Number = param5;
         while(_loc6_ < -3.14159265)
         {
            _loc6_ += 6.28318531;
         }
         while(_loc6_ > 3.14159265)
         {
            _loc6_ -= 6.28318531;
         }
         if(_loc6_ < 0)
         {
            _loc7_ = 1.27323954 * _loc6_ + 0.405284735 * _loc6_ * _loc6_;
            if(_loc7_ < 0)
            {
               _loc7_ = 0.225 * (_loc7_ * -_loc7_ - _loc7_) + _loc7_;
            }
            else
            {
               _loc7_ = 0.225 * (_loc7_ * _loc7_ - _loc7_) + _loc7_;
            }
         }
         else
         {
            _loc7_ = 1.27323954 * _loc6_ - 0.405284735 * _loc6_ * _loc6_;
            if(_loc7_ < 0)
            {
               _loc7_ = 0.225 * (_loc7_ * -_loc7_ - _loc7_) + _loc7_;
            }
            else
            {
               _loc7_ = 0.225 * (_loc7_ * _loc7_ - _loc7_) + _loc7_;
            }
         }
         _loc6_ += 1.57079632;
         if(_loc6_ > 3.14159265)
         {
            _loc6_ -= 6.28318531;
         }
         if(_loc6_ < 0)
         {
            _loc8_ = 1.27323954 * _loc6_ + 0.405284735 * _loc6_ * _loc6_;
            if(_loc8_ < 0)
            {
               _loc8_ = 0.225 * (_loc8_ * -_loc8_ - _loc8_) + _loc8_;
            }
            else
            {
               _loc8_ = 0.225 * (_loc8_ * _loc8_ - _loc8_) + _loc8_;
            }
         }
         else
         {
            _loc8_ = 1.27323954 * _loc6_ - 0.405284735 * _loc6_ * _loc6_;
            if(_loc8_ < 0)
            {
               _loc8_ = 0.225 * (_loc8_ * -_loc8_ - _loc8_) + _loc8_;
            }
            else
            {
               _loc8_ = 0.225 * (_loc8_ * _loc8_ - _loc8_) + _loc8_;
            }
         }
         var _loc9_:Number = _loc7_ * param4;
         var _loc10_:Number = _loc8_ * param4;
         var _loc11_:Number = _loc8_ * param3;
         var _loc12_:Number = -_loc7_ * param3;
         var _loc15_:int = 0;
         while(_loc15_ < param2.length)
         {
            _loc13_ = param2[_loc15_];
            _loc14_ = param1[_loc15_];
            _loc14_.x = _loc11_ * _loc13_.x + _loc9_ * _loc13_.y;
            _loc14_.y = _loc12_ * _loc13_.x + _loc10_ * _loc13_.y;
            _loc15_++;
         }
      }
      
      public function test(param1:Array, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Array, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number) : Boolean
      {
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Point = null;
         var _loc18_:Point = null;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         project(ProjectedA,param1,param4,param5,param6);
         project(ProjectedB,param7,param10,param11,param12);
         _loc15_ = 0;
         while(_loc15_ < param1.length)
         {
            if(_loc15_ == 0)
            {
               _loc17_ = ProjectedA[param1.length - 1];
               _loc18_ = ProjectedA[0];
            }
            else
            {
               _loc17_ = ProjectedA[_loc15_ - 1];
               _loc18_ = ProjectedA[_loc15_];
            }
            _loc13_ = _loc17_.y - _loc18_.y;
            _loc14_ = _loc18_.x - _loc17_.x;
            _loc19_ = Math.sqrt(_loc13_ * _loc13_ + _loc14_ * _loc14_);
            _loc13_ /= _loc19_;
            _loc14_ /= _loc19_;
            _loc17_ = ProjectedA[0];
            _loc20_ = _loc21_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
            _loc16_ = 1;
            while(_loc16_ < param1.length)
            {
               _loc17_ = ProjectedA[_loc16_];
               _loc19_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
               if(_loc19_ > _loc21_)
               {
                  _loc21_ = _loc19_;
               }
               else if(_loc19_ < _loc20_)
               {
                  _loc20_ = _loc19_;
               }
               _loc16_++;
            }
            _loc19_ = param2 * _loc13_ + param3 * _loc14_;
            _loc20_ += _loc19_;
            _loc21_ += _loc19_;
            _loc17_ = ProjectedB[0];
            _loc22_ = _loc23_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
            _loc16_ = 1;
            while(_loc16_ < param7.length)
            {
               _loc17_ = ProjectedB[_loc16_];
               _loc19_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
               if(_loc19_ > _loc23_)
               {
                  _loc23_ = _loc19_;
               }
               else if(_loc19_ < _loc22_)
               {
                  _loc22_ = _loc19_;
               }
               _loc16_++;
            }
            _loc19_ = param8 * _loc13_ + param9 * _loc14_;
            _loc22_ += _loc19_;
            _loc23_ += _loc19_;
            if(_loc21_ < _loc22_ || _loc20_ > _loc23_)
            {
               return false;
            }
            _loc15_++;
         }
         _loc15_ = 0;
         while(_loc15_ < param7.length)
         {
            if(_loc15_ == 0)
            {
               _loc17_ = ProjectedB[param1.length - 1];
               _loc18_ = ProjectedB[0];
            }
            else
            {
               _loc17_ = ProjectedB[_loc15_ - 1];
               _loc18_ = ProjectedB[_loc15_];
            }
            if(!_loc17_ || !_loc18_)
            {
               return false;
            }
            _loc13_ = _loc17_.y - _loc18_.y;
            _loc14_ = _loc18_.x - _loc17_.x;
            _loc19_ = Math.sqrt(_loc13_ * _loc13_ + _loc14_ * _loc14_);
            _loc13_ /= _loc19_;
            _loc14_ /= _loc19_;
            _loc17_ = ProjectedA[0];
            _loc20_ = _loc21_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
            _loc16_ = 1;
            while(_loc16_ < param1.length)
            {
               _loc17_ = ProjectedA[_loc16_];
               _loc19_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
               if(_loc19_ > _loc21_)
               {
                  _loc21_ = _loc19_;
               }
               else if(_loc19_ < _loc20_)
               {
                  _loc20_ = _loc19_;
               }
               _loc16_++;
            }
            _loc19_ = param2 * _loc13_ + param3 * _loc14_;
            _loc20_ += _loc19_;
            _loc21_ += _loc19_;
            _loc17_ = ProjectedB[0];
            _loc22_ = _loc23_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
            _loc16_ = 1;
            while(_loc16_ < param7.length)
            {
               _loc17_ = ProjectedB[_loc16_];
               _loc19_ = _loc17_.x * _loc13_ + _loc17_.y * _loc14_;
               if(_loc19_ > _loc23_)
               {
                  _loc23_ = _loc19_;
               }
               else if(_loc19_ < _loc22_)
               {
                  _loc22_ = _loc19_;
               }
               _loc16_++;
            }
            _loc19_ = param8 * _loc13_ + param9 * _loc14_;
            _loc22_ += _loc19_;
            _loc23_ += _loc19_;
            if(_loc21_ < _loc22_ || _loc20_ > _loc23_)
            {
               return false;
            }
            _loc15_++;
         }
         return true;
      }
      
      private function SetPointArrayLength(param1:Array, param2:int) : void
      {
         while(param1.length < param2)
         {
            param1.push(new Point(0,0));
         }
      }
   }
}

