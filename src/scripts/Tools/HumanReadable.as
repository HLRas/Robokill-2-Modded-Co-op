package Tools
{
   public class HumanReadable
   {
      
      public function HumanReadable()
      {
         super();
      }
      
      public static function combineSentences(param1:Array, param2:Boolean = true) : String
      {
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] != "")
            {
               _loc3_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ += _loc3_[_loc4_];
            if(_loc4_ != _loc3_.length - 1)
            {
               _loc5_ += ", ";
            }
            _loc4_++;
         }
         if(param2 && _loc3_.length > 0)
         {
            _loc5_ += ".";
         }
         return _loc5_;
      }
      
      public static function firstUpper(param1:String) : String
      {
         return param1.substr(0,1).toUpperCase() + param1.substr(1);
      }
      
      public static function splitIntoLines(param1:String, param2:String, param3:int, param4:int = -1) : Array
      {
         var _loc9_:int = 0;
         var _loc5_:Array = new Array();
         if(param4 > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < param4)
            {
               _loc5_[_loc9_] = "";
               _loc9_++;
            }
         }
         var _loc6_:Array = param1.split(param2);
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc6_.length)
         {
            _loc8_ = int(_loc5_[_loc7_].length);
            if(_loc8_ > 0 && (_loc7_ < param4 || param4 == -1))
            {
               if(_loc8_ + _loc6_[_loc9_].length + _loc6_.length > param3)
               {
                  _loc8_ = 0;
                  _loc7_++;
               }
            }
            if(!(_loc5_[_loc7_] is String))
            {
               _loc5_[_loc7_] = "";
            }
            _loc5_[_loc7_] += _loc6_[_loc9_];
            if(_loc9_ < _loc6_.length - 1)
            {
               _loc5_[_loc7_] += param2;
            }
            _loc9_++;
         }
         return _loc5_;
      }
      
      public static function truncateFloat(param1:Number, param2:int = 2) : String
      {
         var _loc3_:String = String(param1);
         var _loc4_:String = _loc3_.split(".")[0];
         var _loc5_:String = _loc3_.split(".")[1];
         if(_loc5_)
         {
            if(_loc5_.length > 2)
            {
               _loc5_ = _loc5_.substr(0,2);
            }
         }
         var _loc6_:String = _loc4_;
         if(_loc5_)
         {
            if(_loc5_.length > 0)
            {
               _loc6_ += "." + _loc5_;
            }
         }
         return _loc6_;
      }
      
      public static function formatInteger(param1:int) : String
      {
         var _loc2_:String = String(param1);
         var _loc3_:String = "";
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_.substring(_loc2_.length - _loc4_ - 1,_loc2_.length - _loc4_) + _loc3_;
            if(_loc4_ % 3 == 2 && _loc4_ < _loc2_.length - 1)
            {
               _loc3_ = "," + _loc3_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function padInteger(param1:int, param2:int = 8) : String
      {
         var _loc3_:String = String(param1);
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      public static function timeFromTicks(param1:int) : String
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc2_:String = String((param1 - param1 % 100) / 100);
         var _loc3_:String = String(param1 % 100);
         while(_loc2_.length < 2)
         {
            _loc2_ = "0" + _loc2_;
         }
         while(_loc3_.length < 2)
         {
            _loc3_ += "0";
         }
         return _loc2_ + ":" + _loc3_;
      }
   }
}

