package preload
{
   import Tools.Interpolation;
   import Tools.Logging;
   import Tools.Net;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.system.Security;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   [SWF(width="800", height="600", backgroundColor="#ffffff", frameRate="60")]
   public class CustomPreloader extends MovieClip
   {
      
      public static var sharedObjectGenerator:Function;
      
      public static var loadingImage:Class = CustomPreloader_loadingImage;
      
      public static var preloaderBarImage:Class = CustomPreloader_preloaderBarImage;
      
      public static var demo:Boolean = false;
      
      public static var corner_embed:Class = CustomPreloader_corner_embed;
      
      public var but:Bitmap;
      
      public var startMS:int;
      
      public var count:int = 0;
      
      public var clip:MovieClip;
      
      public var _finished:Boolean = false;
      
      public var preloaderBar:Bitmap;
      
      public var _mochiad:MovieClip;
      
      public var b:Bitmap;
      
      public var opened:Boolean = false;
      
      public var endStartMS:int = 0;
      
      public var ticks:int = 0;
      
      public var setup:Boolean = false;
      
      public var _mochiad_loaded:Boolean = false;
      
      public function CustomPreloader()
      {
         super();
         Security.allowDomain("*");
         Logging.Log("robokill","startload");
         startMS = getTimer();
         stop();
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR,[0],[1],[1]);
         graphics.drawRect(0,0,800,600);
         addEventListener(Event.ENTER_FRAME,onEnterFrame);
         but = new loadingImage();
         but.alpha = 0;
         addChild(but);
         preloaderBar = new preloaderBarImage();
         preloaderBar.x = 400 - preloaderBar.width / 2;
         preloaderBar.y = 528;
         preloaderBar.alpha = 0;
         addChild(preloaderBar);
      }
      
      public function unloadAd() : void
      {
      }
      
      public function adfinished() : void
      {
         _finished = true;
      }
      
      private function init() : void
      {
         var _loc2_:Object = null;
         var _loc1_:Class = Class(getDefinitionByName("Main"));
         if(_loc1_)
         {
            _loc2_ = new _loc1_();
            addChild(_loc2_ as DisplayObject);
         }
      }
      
      public function setSharedObjectGenerator(param1:Function) : void
      {
         sharedObjectGenerator = param1;
      }
      
      public function blah(param1:Event) : void
      {
         Net.openURL("http://www.rocksolidarcade.com/");
      }
      
      public function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = getTimer() - startMS;
         ++ticks;
         but.alpha = Interpolation.squareInterpolateLock(0,1,Interpolation.fromTo(_loc2_,500,1400));
         if(endStartMS)
         {
            but.alpha *= Interpolation.linearInterpolateLock(1,0,Interpolation.fromTo(getTimer() - endStartMS,0,300));
         }
         preloaderBar.alpha = but.alpha;
         preloaderBar.blendMode = BlendMode.ADD;
         var _loc3_:String = root.loaderInfo.url.split("/")[2];
         var _loc4_:Array = _loc3_.split(".");
         var _loc5_:String = _loc4_[_loc4_.length - 2];
         if(_loc5_ == "rocksolidarcade" || root.loaderInfo.url == "http://e1.simplecdn.net/rocksolidarcade/robokill2.swf")
         {
            demo = false;
         }
         else
         {
            demo = false;
         }
         var _loc6_:Boolean = false;
         if(framesLoaded == totalFrames && _finished && !_loc6_)
         {
            ++count;
            if(endStartMS == 0)
            {
               if(_loc2_ > 6000)
               {
                  endStartMS = getTimer();
               }
            }
            if(endStartMS != 0)
            {
               if(getTimer() - endStartMS > 500)
               {
                  removeChild(preloaderBar);
                  removeChild(but);
                  graphics.clear();
                  removeEventListener(Event.ENTER_FRAME,onEnterFrame);
                  nextFrame();
                  init();
                  _loc6_ = true;
                  return;
               }
            }
         }
         var _loc7_:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
         if(_loc7_ > 1)
         {
            _loc7_ = 1;
         }
         preloaderBar.scaleX = _loc7_;
         _finished = root.loaderInfo.bytesLoaded == root.loaderInfo.bytesTotal;
      }
      
      public function unload() : void
      {
      }
   }
}

