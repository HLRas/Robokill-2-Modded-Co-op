package Serialization
{
   import GameConfig.GameConfig;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.utils.*;
   
   public class StoreObject
   {
      
      public static var lastSharedObject:SharedObject;
      
      public static var ihateflash:SharedObject;
      
      public static var dirty:Boolean = false;
      
      public static var couldNotFlush:Boolean = false;
      
      public function StoreObject()
      {
         super();
      }
      
      public static function couldFlush() : Boolean
      {
         var _loc1_:Boolean = !couldNotFlush;
         couldNotFlush = false;
         return _loc1_;
      }
      
      public static function unPackArray(param1:Array) : Array
      {
         var _loc2_:Array = new Array(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] is Array)
            {
               _loc2_[_loc3_] = unPackObject(param1[_loc3_]);
            }
            else
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function unPackField(param1:Array) : *
      {
         var _loc2_:String = param1[2];
         if(_loc2_ == "Array")
         {
            return unPackArray(param1[1]);
         }
         return param1[1];
      }
      
      public static function testStorage() : Boolean
      {
         var _loc1_:SharedObject = getSharedObject();
         _loc1_.flush(80 * 1024);
         return true;
      }
      
      public static function retrieveArray(param1:String) : Array
      {
         var _loc2_:SharedObject = getSharedObject();
         var _loc3_:Array = _loc2_.data[param1];
         if(_loc3_ == null)
         {
            return new Array(0);
         }
         if(_loc3_.length > 1000)
         {
            return null;
         }
         return unPackArray(_loc3_);
      }
      
      public static function netHandler(param1:NetStatusEvent) : void
      {
         if(param1.info.code == "SharedObject.Flush.Failed")
         {
            couldNotFlush = true;
         }
         else
         {
            couldNotFlush = false;
         }
      }
      
      public static function storeValue(param1:String, param2:Object) : void
      {
         var _loc3_:SharedObject = getSharedObject();
         _loc3_.data[param1] = param2;
         dirty = true;
      }
      
      public static function unPackObject(param1:Array) : *
      {
         var _loc5_:Array = null;
         var _loc2_:String = param1[0];
         var _loc3_:Array = param1[1];
         var _loc4_:Object = new (getDefinitionByName(_loc2_) as Class)();
         for each(_loc5_ in _loc3_)
         {
            _loc4_[_loc5_[0]] = unPackField(_loc5_);
         }
         return _loc4_;
      }
      
      public static function flush() : void
      {
         if(!dirty)
         {
            return;
         }
         try
         {
         }
         catch(exp:Error)
         {
            couldNotFlush = true;
         }
      }
      
      public static function retrieveValue(param1:String) : Object
      {
         var _loc2_:SharedObject = getSharedObject();
         return _loc2_.data[param1];
      }
      
      public static function updateStoreObject() : void
      {
         if(lastSharedObject)
         {
            flush();
            ihateflash = lastSharedObject;
            lastSharedObject.removeEventListener(NetStatusEvent.NET_STATUS,netHandler);
            lastSharedObject = null;
         }
      }
      
      public static function storeArray(param1:String, param2:Array) : void
      {
         var _loc3_:SharedObject = getSharedObject();
         var _loc4_:Array = new Array(param2.length);
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            if(param2[_loc5_])
            {
               if(param2[_loc5_] is String || param2[_loc5_] is int)
               {
                  _loc4_[_loc5_] = param2[_loc5_];
               }
               else
               {
                  _loc4_[_loc5_] = SerializedObject.serialize(param2[_loc5_]).toArray();
               }
            }
            else
            {
               _loc4_[_loc5_] = null;
            }
            _loc5_++;
         }
         _loc3_.data[param1] = _loc4_;
         dirty = true;
      }
      
      public static function getSharedObject() : SharedObject
      {
         if(!lastSharedObject)
         {
            lastSharedObject = SharedObject.getLocal(GameConfig.shortName,"/");
            lastSharedObject.addEventListener(NetStatusEvent.NET_STATUS,netHandler);
            dirty = false;
         }
         return lastSharedObject;
      }
      
      public static function describe(param1:Array) : String
      {
         var _loc2_:String = " [ ";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] is Array)
            {
               _loc2_ += describe(param1[_loc3_]);
            }
            else
            {
               _loc2_ += String(param1[_loc3_]);
            }
            if(_loc3_ < param1.length - 1)
            {
               _loc2_ += ", ";
            }
            _loc3_++;
         }
         return _loc2_ + " ] ";
      }
   }
}

