package Tools
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   
   public class Net
   {
      
      public function Net()
      {
         super();
      }
      
      public static function completeHandler(param1:Event) : void
      {
      }
      
      public static function openURL(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:URLRequestHeader = new URLRequestHeader("pragma","no-cache");
         _loc2_.requestHeaders.push(_loc3_);
         navigateToURL(_loc2_);
      }
      
      public static function postURL(param1:String, param2:Array, param3:Function = null) : void
      {
         var variables:URLVariables;
         var loader:URLLoader;
         var p:Array = null;
         var url:String = param1;
         var args:Array = param2;
         var finishFunc:Function = param3;
         var req:URLRequest = new URLRequest(url);
         req.method = URLRequestMethod.POST;
         variables = new URLVariables();
         for each(p in args)
         {
            variables[p[0]] = p[1];
         }
         req.data = variables;
         if(finishFunc == null)
         {
            finishFunc = completeHandler;
         }
         loader = new URLLoader(req);
         try
         {
            loader.load(req);
            loader.addEventListener(Event.COMPLETE,function(param1:Event):*
            {
               finishFunc();
            });
         }
         catch(error:Error)
         {
         }
      }
   }
}

