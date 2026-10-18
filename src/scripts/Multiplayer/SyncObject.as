package Multiplayer
{
   import flash.utils.*;
   
   public class SyncObject
   {
      
      public static var stateFieldNames:int = 4;
      
      public static var stateFieldTypes:int = 5;
      
      public static var stateFieldValues:int = 6;
      
      public static var stateSetFieldValues:int = 7;
      
      public static var stateCheckingValues:int = 8;
      
      public var owner:int = 0;
      
      public var state:int = 0;
      
      public var lastValues:Object = new Object();
      
      public var id:int = 0;
      
      public var fieldTypes:Array;
      
      public var _removed:Boolean = false;
      
      public var anyValuesChanged:Boolean = false;
      
      public var _mine:Boolean = false;
      
      public var fieldNames:Array;
      
      public var curFieldValue:int = 0;
      
      public var fieldValues:Array;
      
      public function SyncObject()
      {
         super();
      }
      
      public static function fixDataTypes(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] != null)
            {
               if(isBool(param1[_loc2_]))
               {
                  if(param1[_loc2_] == "true")
                  {
                     param1[_loc2_] = true;
                  }
                  else
                  {
                     param1[_loc2_] = false;
                  }
               }
               else
               {
                  _loc3_ = detectNumber(param1[_loc2_]);
                  if(_loc3_ == 1)
                  {
                     _loc4_ = int(param1[_loc2_]);
                     param1[_loc2_] = _loc4_;
                  }
                  else if(_loc3_ == 2)
                  {
                     _loc5_ = Number(param1[_loc2_]);
                     param1[_loc2_] = _loc5_;
                  }
               }
            }
            _loc2_++;
         }
         return param1;
      }
      
      public static function encodeArray(param1:Array, param2:Boolean = true) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = "";
         if(param1)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ += encodeObject(param1[_loc4_]);
               if(_loc4_ < param1.length - 1)
               {
                  _loc3_ += ",";
               }
               _loc4_++;
            }
         }
         if(param2)
         {
            return "[" + _loc3_ + "]";
         }
         return _loc3_;
      }
      
      public static function detectNumber(param1:String) : int
      {
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(Boolean(param1) && _loc3_ < param1.length)
         {
            _loc4_ = param1.charCodeAt(_loc3_);
            if(_loc4_ == 45)
            {
               _loc2_ = true;
            }
            else if((_loc4_ < 48 || _loc4_ > 57) && _loc4_ != 46)
            {
               return 0;
            }
            _loc3_++;
         }
         return _loc2_ ? 2 : 1;
      }
      
      public static function parse(param1:String, param2:String) : Array
      {
         var _loc8_:String = null;
         var _loc9_:Boolean = false;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         _loc3_[0] = "";
         var _loc5_:Boolean = false;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            _loc8_ = param1.substr(_loc7_,1);
            if(_loc8_ == "\"")
            {
               _loc5_ = !_loc5_;
            }
            _loc9_ = false;
            if(!_loc5_)
            {
               if(_loc6_ == 0)
               {
                  if(_loc8_ == param2)
                  {
                     _loc9_ = true;
                  }
               }
            }
            if(_loc9_)
            {
               _loc4_++;
               _loc3_[_loc4_] = "";
            }
            else
            {
               _loc3_[_loc4_] += _loc8_;
            }
            if(!_loc5_)
            {
               if(_loc8_ == "[" || _loc8_ == "(")
               {
                  _loc6_++;
               }
               if(_loc8_ == "]" || _loc8_ == ")")
               {
                  _loc6_--;
               }
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public static function decodeObject(param1:String) : Object
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Class = null;
         var _loc9_:SyncObject = null;
         var _loc2_:int = getTimer();
         if(!param1 || param1 == "" || param1 == "null")
         {
            return null;
         }
         if(param1.substr(0,1) == "[" && param1.substr(param1.length - 1,1) == "]")
         {
            _loc3_ = parse(param1.substr(1,param1.length - 2),",");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_] != "" && _loc3_[_loc4_] != "null")
               {
                  _loc3_[_loc4_] = decodeObject(_loc3_[_loc4_]);
               }
               else
               {
                  _loc3_[_loc4_] = null;
               }
               _loc4_++;
            }
            return fixDataTypes(_loc3_);
         }
         if(param1.indexOf("(") != -1)
         {
            _loc5_ = parse(param1,"(");
            _loc6_ = _loc5_[0];
            _loc7_ = _loc5_[1].substr(0,_loc5_[1].length - 1);
            _loc8_ = Class(getDefinitionByName(_loc6_));
            _loc9_ = new _loc8_();
            _loc9_.setFieldValues(parse(_loc7_,","));
            return _loc9_;
         }
         if(param1 == "null")
         {
            return null;
         }
         return param1;
      }
      
      public static function encodeObject(param1:Object) : String
      {
         if(param1 is SyncObject)
         {
            return SyncObject(param1).className() + "(" + encodeArray(SyncObject(param1).getFieldValues(),false) + ")";
         }
         if(param1 is Array)
         {
            return encodeArray(Array(param1)[0]);
         }
         return String(param1);
      }
      
      public static function isBool(param1:String) : Boolean
      {
         return param1 == "true" || param1 == "false";
      }
      
      public function registerFloat(param1:String, param2:Number) : Number
      {
         if(state == stateSetFieldValues)
         {
            if(curFieldValue >= fieldValues.length)
            {
               return param2;
            }
            param2 = Number(fieldValues[curFieldValue]);
            ++curFieldValue;
         }
         if(state == stateFieldNames)
         {
            fieldNames.push(param1);
         }
         if(state == stateFieldTypes)
         {
            fieldTypes.push("float");
         }
         if(state == stateFieldValues)
         {
            fieldValues.push(String(param2));
         }
         if(state == stateCheckingValues)
         {
            if(lastValues[param1] != param2)
            {
               anyValuesChanged = true;
            }
            lastValues[param1] = param2;
         }
         return param2;
      }
      
      public function remove() : void
      {
         if(_mine)
         {
            _removed = true;
         }
      }
      
      public function getFieldValues() : Array
      {
         fieldValues = new Array();
         state = stateFieldValues;
         curFieldValue = 0;
         register();
         return fieldValues;
      }
      
      public function registerObject(param1:String, param2:SyncObject) : SyncObject
      {
         if(state == stateSetFieldValues)
         {
            if(curFieldValue >= fieldValues.length)
            {
               return param2;
            }
            param2 = SyncObject(decodeObject(fieldValues[curFieldValue]));
            ++curFieldValue;
         }
         if(state == stateFieldNames)
         {
            fieldNames.push(param1);
         }
         if(state == stateFieldTypes)
         {
            fieldTypes.push("object");
         }
         if(state == stateFieldValues)
         {
            fieldValues.push(encodeObject(param2));
         }
         return param2;
      }
      
      public function mine() : Boolean
      {
         return _mine;
      }
      
      public function registerString(param1:String, param2:String) : String
      {
         if(state == stateSetFieldValues)
         {
            if(curFieldValue >= fieldValues.length)
            {
               return param2;
            }
            param2 = fieldValues[curFieldValue];
            ++curFieldValue;
         }
         if(state == stateFieldNames)
         {
            fieldNames.push(param1);
         }
         if(state == stateFieldTypes)
         {
            fieldTypes.push("string");
         }
         if(state == stateFieldValues)
         {
            fieldValues.push(param2);
         }
         if(state == stateCheckingValues)
         {
            if(lastValues[param1] != param2)
            {
               anyValuesChanged = true;
            }
            lastValues[param1] = param2;
         }
         return param2;
      }
      
      public function getFieldTypes() : Array
      {
         fieldTypes = new Array();
         state = stateFieldTypes;
         register();
         return fieldTypes;
      }
      
      public function register() : void
      {
      }
      
      public function checkForChanges() : Boolean
      {
         anyValuesChanged = false;
         state = stateCheckingValues;
         register();
         return anyValuesChanged;
      }
      
      public function className() : String
      {
         return getQualifiedClassName(this);
      }
      
      public function getFieldNames() : Array
      {
         fieldNames = new Array();
         state = stateFieldNames;
         register();
         return fieldNames;
      }
      
      public function registerInt(param1:String, param2:int) : int
      {
         if(state == stateSetFieldValues)
         {
            if(curFieldValue >= fieldValues.length)
            {
               return param2;
            }
            param2 = parseInt(fieldValues[curFieldValue],16);
            ++curFieldValue;
         }
         if(state == stateFieldNames)
         {
            fieldNames.push(param1);
         }
         if(state == stateFieldTypes)
         {
            fieldTypes.push("int");
         }
         if(state == stateFieldValues)
         {
            fieldValues.push(param2.toString(16));
         }
         if(state == stateCheckingValues)
         {
            if(lastValues[param1] != param2)
            {
               anyValuesChanged = true;
            }
            lastValues[param1] = param2;
         }
         return param2;
      }
      
      public function setFieldValues(param1:Array) : void
      {
         fieldValues = param1;
         state = stateSetFieldValues;
         curFieldValue = 0;
         register();
      }
      
      public function registerArray(param1:String, param2:Array) : Array
      {
         var _loc3_:Array = null;
         if(state == stateSetFieldValues)
         {
            if(curFieldValue >= fieldValues.length)
            {
               return param2;
            }
            _loc3_ = Array(decodeObject(fieldValues[curFieldValue]))[0];
            param2 = _loc3_;
            ++curFieldValue;
         }
         if(state == stateFieldNames)
         {
            fieldNames.push(param1);
         }
         if(state == stateFieldTypes)
         {
            fieldTypes.push("array");
         }
         if(state == stateFieldValues)
         {
            fieldValues.push(encodeArray(param2));
         }
         if(state == stateCheckingValues)
         {
         }
         return param2;
      }
   }
}

