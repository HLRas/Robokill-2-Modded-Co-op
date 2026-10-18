package Tools
{
   import flash.external.*;
   
   public class Extern
   {
      
      public static var _callJavascript:Function;
      
      public static var messages:Array = new Array();
      
      public static var _setup:Boolean = false;
      
      public function Extern()
      {
         super();
      }
      
      public static function getMessage(param1:String) : String
      {
         var _loc3_:Array = null;
         setup();
         var _loc2_:int = 0;
         while(_loc2_ < messages.length)
         {
            _loc3_ = messages[_loc2_].split(",",2);
            if(_loc3_[0] == param1)
            {
               messages = messages.splice(_loc2_,1);
               return _loc3_[1];
            }
            _loc2_++;
         }
         return "";
      }
      
      public static function receive(param1:String) : void
      {
         messages.push(param1);
      }
      
      public static function callJavascript(param1:String, param2:String = "") : String
      {
         var o:Object = null;
         var js:String = param1;
         var args:String = param2;
         if(Boolean(_callJavascript))
         {
            return _callJavascript(js,args);
         }
         try
         {
            try
            {
               o = ExternalInterface.call(js,args);
               if(o is String)
               {
                  return String(o);
               }
               return "";
            }
            catch(err2:Error)
            {
               return "";
            }
         }
         catch(err:SecurityError)
         {
            return "";
         }
      }
      
      public static function setup() : void
      {
         if(!_setup)
         {
            return;
         }
         _setup = true;
         ExternalInterface.addCallback("rsaGetText",receive);
      }
      
      public static function sendMessage(param1:String, param2:String = "") : String
      {
         setup();
         return callJavascript(param1,param2);
      }
   }
}

