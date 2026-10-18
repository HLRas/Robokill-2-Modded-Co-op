package Serialization
{
   public class Profile
   {
      
      public static var profiles:Array;
      
      public static var current:Profile;
      
      public var keyLocation:String = "";
      
      public var key:String = "";
      
      public function Profile()
      {
         super();
      }
      
      public static function getProfiles() : Array
      {
         return null;
      }
      
      public static function defLookupArray(param1:String) : Array
      {
         return current.lookupArray(param1);
      }
      
      public static function getRandomKey() : String
      {
         var _loc4_:int = 0;
         var _loc1_:String = "";
         var _loc2_:Array = ["A","B","C","D","E","F","G","H","I","J","K","L"];
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            _loc4_ = Math.random() * 0.9 * _loc2_.length;
            _loc1_ += _loc2_[_loc4_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      public static function bindProfile(param1:String, param2:int) : Profile
      {
         var _loc3_:String = param1 + String(param2);
         var _loc4_:Profile = new Profile();
         _loc4_.keyLocation = _loc3_;
         if(StoreObject.retrieveValue(_loc3_) is String)
         {
            _loc4_.key = String(StoreObject.retrieveValue(_loc3_));
         }
         else
         {
            StoreObject.storeValue(_loc3_,null);
         }
         return _loc4_;
      }
      
      public static function getProfile(param1:int) : Profile
      {
         return profiles[param1];
      }
      
      public static function initProfiles(param1:String, param2:int = 3) : void
      {
         profiles = new Array(param2);
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            profiles[_loc3_] = bindProfile(param1,_loc3_);
            _loc3_++;
         }
      }
      
      public static function defStore(param1:String, param2:Object) : void
      {
         current.store(param1,param2);
      }
      
      public static function defStoreArray(param1:String, param2:Array) : void
      {
         current.storeArray(param1,param2);
      }
      
      public static function defLookup(param1:String) : Object
      {
         return current.lookup(param1);
      }
      
      public function store(param1:String, param2:Object) : void
      {
         StoreObject.storeValue(key + "_" + param1,param2);
      }
      
      public function exists() : Boolean
      {
         return key != "";
      }
      
      public function lookupArray(param1:String) : Array
      {
         return StoreObject.retrieveArray(key + "_" + param1);
      }
      
      public function destroy() : void
      {
         key = "";
         StoreObject.storeValue(keyLocation,null);
      }
      
      public function setCurrent() : void
      {
         create();
         current = this;
      }
      
      public function storeArray(param1:String, param2:Array) : void
      {
         StoreObject.storeArray(key + "_" + param1,param2);
      }
      
      public function lookup(param1:String) : Object
      {
         return StoreObject.retrieveValue(key + "_" + param1);
      }
      
      public function create() : void
      {
         if(exists())
         {
            return;
         }
         key = getRandomKey();
         StoreObject.storeValue(keyLocation,key);
      }
   }
}

