package Tools
{
   public class Period
   {
      
      public function Period()
      {
         super();
      }
      
      public static function getPeriod(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : Number
      {
         var _loc7_:int = param1 % param2;
         if(_loc7_ < param3)
         {
            return 0;
         }
         if(_loc7_ < param4)
         {
            return Interpolation.linearInterpolate(0,1,Interpolation.fromTo(_loc7_,param3,param4));
         }
         if(_loc7_ < param5)
         {
            return 1;
         }
         return Interpolation.linearInterpolateLock(1,0,Interpolation.fromTo(_loc7_,param5,param6));
      }
   }
}

