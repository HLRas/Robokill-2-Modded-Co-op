package Tools
{
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.system.Security;
   
   public class Logging
   {
      
      public static var lastRequest:URLStream;
      
      public static var loggingEnabled:Boolean = false;
      
      public static var allLoggingConnections:Array = new Array();
      
      public function Logging()
      {
         super();
      }
      
      private static function ioErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public static function Log(param1:String, param2:String, param3:String = "", param4:String = "") : void
      {
         var link:String;
         var gamename:String = param1;
         var event:String = param2;
         var extradata:String = param3;
         var splittest:String = param4;
         if(!loggingEnabled)
         {
            return;
         }
         if(Security.sandboxType != Security.REMOTE)
         {
            return;
         }
         splittest = SplitTest.splitTestName;
         if(lastRequest)
         {
            if(lastRequest.bytesAvailable > 0)
            {
               lastRequest.close();
               lastRequest = null;
            }
         }
         Security.allowDomain("www.rocksolidarcade.com");
         Security.allowInsecureDomain("www.rocksolidarcade.com");
         link = "http://www.rocksolidarcade.com/event2/" + gamename + "/" + event + "/";
         if(splittest != "")
         {
            if(extradata == "")
            {
               extradata = "null";
            }
            link += extradata + "/" + splittest + "/";
         }
         else if(extradata != "")
         {
            link += extradata + "/";
         }
         lastRequest = new URLStream();
         try
         {
            lastRequest.load(new URLRequest(link));
            lastRequest.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
            lastRequest.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
         }
         catch(error:Error)
         {
         }
      }
      
      private static function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
      }
   }
}

