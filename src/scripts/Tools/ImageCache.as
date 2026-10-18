package Tools
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class ImageCache
   {
      
      public static var ic:ImageCache;
      
      public var cacheSize:int = 0;
      
      public var names:Object = new Object();
      
      public var cacheObjects:Array = new Array();
      
      public var lookup:Object = new Object();
      
      public var cacheHitCount:Array = new Array();
      
      public function ImageCache()
      {
         super();
      }
      
      public static function singleton() : ImageCache
      {
         if(!ic)
         {
            ic = new ImageCache();
         }
         return ic;
      }
      
      public function cacheRotation(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc4_:String = null;
         while(param2 < 0)
         {
            param2 += 360;
         }
         while(param2 > 360)
         {
            param2 -= 360;
         }
         var _loc3_:int = int(param2 / 6);
         if(names[param1])
         {
            _loc4_ = names[param1];
         }
         else
         {
            _loc4_ = String(Math.random());
            names[param1] = _loc4_;
         }
         var _loc5_:String = _loc4_ + "," + _loc3_;
         if(!lookup[_loc5_])
         {
            lookup[_loc5_] = createImage(param1,param2);
         }
         return lookup[_loc5_];
      }
      
      public function createImage(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc3_:Number = Math.max(param1.width,param1.height);
         var _loc4_:Number = Math.sqrt(2) * _loc3_;
         var _loc5_:BitmapData = new BitmapData(_loc4_,_loc4_,true,16777215);
         var _loc6_:Matrix = new Matrix();
         _loc6_.rotate(Math.PI * param2 / 180);
         _loc6_.translate(_loc4_ / 2,_loc4_ / 2);
         _loc5_.draw(param1,_loc6_);
         return _loc5_;
      }
   }
}

