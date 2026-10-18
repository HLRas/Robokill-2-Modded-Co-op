package Misc
{
   import GameObject.GameObject;
   import Objects.FloorProp;
   
   public class SortFloorProps
   {
      
      public function SortFloorProps()
      {
         super();
      }
      
      public static function sortFloorProps(param1:Array) : Array
      {
         var _loc4_:GameObject = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc9_:* = 0;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1)
         {
            if(_loc4_ is FloorProp)
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc5_ = new Array();
         _loc6_ = new Array();
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc5_[_loc7_] = _loc3_[_loc7_].logicalSquareX();
            _loc6_[_loc7_] = _loc3_[_loc7_].logicalSquareY();
            _loc7_++;
         }
         var _loc8_:* = 20;
         while(_loc8_ > 0)
         {
            _loc9_ = 20;
            while(_loc9_ > 0)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc3_.length)
               {
                  if(_loc5_[_loc7_] == _loc8_ && _loc6_[_loc7_] == _loc9_)
                  {
                     _loc2_.push(_loc3_[_loc7_]);
                  }
                  _loc7_++;
               }
               _loc9_--;
            }
            _loc8_--;
         }
         return _loc2_;
      }
   }
}

