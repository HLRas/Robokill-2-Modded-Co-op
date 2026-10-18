package Tools
{
   public class Random
   {
      
      public function Random()
      {
         super();
      }
      
      public static function randInt(param1:int, param2:int) : int
      {
         var _loc3_:Number = Math.random() - 0.001;
         return int(param1 + int(_loc3_ * (param2 - param1 + 1)));
      }
      
      public static function randArrayElements(param1:Array, param2:int) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         if(param1.length < param2)
         {
            return param1;
         }
         while(_loc4_.length < param2)
         {
            _loc5_ = randInt(0,param1.length - 1);
            if(_loc3_[_loc5_] != 1)
            {
               _loc4_.push(param1[_loc5_]);
               _loc3_[_loc5_] = 1;
            }
         }
         return _loc4_;
      }
   }
}

