package Serialization
{
   import flash.utils.*;
   
   public class SerializedObject
   {
      
      public var val:Array = new Array();
      
      public var typeName:String;
      
      public function SerializedObject()
      {
         super();
      }
      
      public static function serialize(param1:Object) : SerializedObject
      {
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc2_:SerializedObject = new SerializedObject();
         var _loc3_:XML = describeType(param1);
         var _loc4_:Array = param1["serializeFields"]();
         _loc2_.typeName = _loc3_.attribute("name")[0];
         var _loc5_:XMLList = _loc3_.descendants("variable");
         for each(_loc6_ in _loc5_)
         {
            _loc7_ = _loc6_.attribute("name")[0];
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length)
            {
               if(_loc7_ == _loc4_[_loc8_])
               {
                  if(_loc6_.attribute("type") == "Array")
                  {
                     _loc9_ = param1[_loc7_];
                     _loc10_ = new Array(_loc9_.length);
                     _loc11_ = 0;
                     while(_loc11_ < _loc9_.length)
                     {
                        if(_loc9_[_loc11_])
                        {
                           _loc10_[_loc11_] = serialize(_loc9_[_loc11_]).toArray();
                        }
                        _loc11_++;
                     }
                     _loc2_.val.push([_loc7_,_loc10_,_loc6_.attribute("type")[0]]);
                  }
                  else
                  {
                     _loc2_.val.push([_loc7_,param1[_loc7_],_loc6_.attribute("type")[0]]);
                  }
               }
               _loc8_++;
            }
         }
         return _loc2_;
      }
      
      public static function fromArray(param1:Array) : SerializedObject
      {
         var _loc2_:SerializedObject = new SerializedObject();
         _loc2_.typeName = param1[0];
         _loc2_.val = param1[1];
         return _loc2_;
      }
      
      public function applyTo(param1:Object) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < val.length)
         {
            param1[val[_loc2_][0]] = val[_loc2_][1];
            _loc2_++;
         }
      }
      
      public function toArray() : Array
      {
         return [typeName,val];
      }
   }
}

