package Tools
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   
   public class SafeImageRequest
   {
      
      public var finished:Boolean = false;
      
      public var finishFunc:Function = null;
      
      public var ldr:Loader;
      
      public function SafeImageRequest(param1:String, param2:Function = null)
      {
         var url:String = param1;
         var finish:Function = param2;
         super();
         ldr = new Loader();
         finishFunc = finish;
         try
         {
            ldr.load(new URLRequest(url));
            ldr.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
         }
         catch(err:Error)
         {
         }
      }
      
      public function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         trace("security error");
      }
      
      public function ioErrorHandler(param1:IOErrorEvent) : void
      {
         trace("IO Error");
      }
      
      public function complete(param1:Event) : void
      {
         finished = true;
         if(finishFunc != null)
         {
            finishFunc();
         }
      }
   }
}

