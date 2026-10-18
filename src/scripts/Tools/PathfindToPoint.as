package Tools
{
   public class PathfindToPoint
   {
      
      public var width:int = 0;
      
      public var reevaluate:Boolean = false;
      
      public var basdf:int = 0;
      
      public var iteration:int = 0;
      
      public var markNext:Array = new Array(512);
      
      public var master:PathfindToPoint;
      
      public var markNextLength:int = 0;
      
      public var height:int = 0;
      
      public var marked:Array = new Array(512);
      
      public var markedLength:int = 0;
      
      public var lastMarkX:int = -1;
      
      public var lastMarkY:int = -1;
      
      public var allowFlying:Boolean = false;
      
      public var field:Array;
      
      public function PathfindToPoint(param1:int, param2:int)
      {
         super();
         this.width = param1;
         this.height = param2;
         constructArray();
      }
      
      public function createChild() : PathfindToPoint
      {
         var _loc1_:PathfindToPoint = new PathfindToPoint(width,height);
         _loc1_.master = this;
         return _loc1_;
      }
      
      public function constructArray() : void
      {
         var _loc2_:int = 0;
         field = new Array(width);
         var _loc1_:int = 0;
         while(_loc1_ < width)
         {
            field[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < height)
            {
               field[_loc1_][_loc2_] = new PathfindSquare();
               field[_loc1_][_loc2_].x = _loc1_;
               field[_loc1_][_loc2_].y = _loc2_;
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function getField(param1:int, param2:int) : PathfindSquare
      {
         if(param1 >= 0 && param1 < width)
         {
            if(param2 >= 0 && param2 < height)
            {
               return field[param1][param2];
            }
         }
         return null;
      }
      
      public function search(param1:int, param2:int) : *
      {
         var _loc4_:int = 0;
         var _loc5_:PathfindSquare = null;
         var _loc6_:PathfindSquare = null;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         ++basdf;
         var _loc3_:int = -1;
         while(_loc3_ < 2)
         {
            _loc4_ = -1;
            while(_loc4_ < 2)
            {
               if(_loc3_ != 0 || _loc4_ != 0)
               {
                  if(param1 + _loc3_ >= 0 && param1 + _loc3_ < width && param2 + _loc4_ >= 0 && param2 + _loc4_ < height)
                  {
                     _loc6_ = _loc5_ = field[param1 + _loc3_][param2 + _loc4_];
                     if(master)
                     {
                        _loc6_ = master.field[param1 + _loc3_][param2 + _loc4_];
                     }
                     _loc7_ = _loc3_ == 0 || _loc4_ == 0 ? 1 : 1.4;
                     if(_loc7_ < 1.1)
                     {
                        if(field[param1][param2].dist + _loc7_ < _loc5_.dist || _loc5_.seq < iteration)
                        {
                           _loc5_.seq = iteration;
                           _loc5_.dist = field[param1][param2].dist + _loc7_;
                           _loc5_.dirx = -_loc3_;
                           _loc5_.diry = -_loc4_;
                           _loc8_ = _loc6_.passable;
                           if(allowFlying && !_loc6_.exists)
                           {
                              _loc8_ = true;
                           }
                           _loc9_ = 0;
                           while(_loc9_ < markNextLength)
                           {
                              if(markNext[_loc9_] == field[param1 + _loc3_][param2 + _loc4_])
                              {
                                 _loc8_ = false;
                              }
                              _loc9_++;
                           }
                           if(_loc8_)
                           {
                              markNext[markNextLength] = field[param1 + _loc3_][param2 + _loc4_];
                              ++markNextLength;
                           }
                        }
                     }
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function reconstructGraph(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         if(param1 < 0 || param2 < 0 || param1 >= width || param2 >= height)
         {
            return;
         }
         if(param1 == lastMarkX && param2 == lastMarkY && !reevaluate)
         {
            return;
         }
         reevaluate = false;
         lastMarkX = param1;
         lastMarkY = param2;
         basdf = 0;
         ++iteration;
         var _loc3_:int = 0;
         while(_loc3_ < width)
         {
            _loc4_ = 0;
            while(_loc4_ < height)
            {
               field[_loc3_][_loc4_].isDest = param1 == _loc3_ && param2 == _loc4_;
               _loc4_++;
            }
            _loc3_++;
         }
         field[param1][param2].dist = 0;
         markNextLength = 1;
         markNext[0] = field[param1][param2];
      }
      
      public function lazyUpdate() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(markNextLength > 0)
         {
            _loc1_ = marked;
            marked = markNext;
            markedLength = markNextLength;
            markNext = _loc1_;
            markNextLength = 0;
            _loc2_ = 0;
            while(_loc2_ < markedLength)
            {
               marked[_loc2_].seq = iteration;
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < markedLength)
            {
               search(marked[_loc2_].x,marked[_loc2_].y);
               _loc2_++;
            }
         }
      }
   }
}

