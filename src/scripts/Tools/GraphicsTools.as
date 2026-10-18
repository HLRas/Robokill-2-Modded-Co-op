package Tools
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class GraphicsTools
   {
      
      public function GraphicsTools()
      {
         super();
      }
      
      public static function createFilledSprite(param1:int, param2:int, param3:int, param4:Boolean = false) : Bitmap
      {
         var _loc5_:BitmapData = new BitmapData(param1,param2,param4,param3);
         return new Bitmap(_loc5_);
      }
   }
}

