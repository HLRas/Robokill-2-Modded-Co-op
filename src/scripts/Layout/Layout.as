package Layout
{
   import GameObject.GameObject;
   
   public class Layout
   {
      
      public var y:Number = 0;
      
      public var spacing:Number = 0;
      
      public var dir:int = 0;
      
      public var freePlacement:Boolean = false;
      
      public var leaf:GameObject;
      
      public var freeX:Number = 0;
      
      public var freeY:Number = 0;
      
      public var globalx:Number = 0;
      
      public var globaly:Number = 0;
      
      public var x:Number = 0;
      
      public var children:Array;
      
      public function Layout()
      {
         super();
      }
      
      public static function createLeaves(param1:Array) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:Layout = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_ is Array)
            {
               _loc2_.push(createLeaves(Array(_loc4_)));
            }
            else if(_loc4_ is GameObject)
            {
               _loc5_ = new Layout();
               _loc5_.leaf = GameObject(_loc4_);
               _loc2_.push(_loc5_);
            }
            else
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function Vert(param1:Array, param2:int = 8, param3:Number = 0, param4:Number = 0) : Layout
      {
         param1 = createLeaves(param1);
         var _loc5_:Layout = new Layout();
         _loc5_.dir = 1;
         _loc5_.spacing = param2;
         _loc5_.children = param1;
         _loc5_.layout(param3,param4);
         return _loc5_;
      }
      
      public static function Horiz(param1:Array, param2:Number = 8, param3:Number = 0, param4:Number = 0) : Layout
      {
         param1 = createLeaves(param1);
         var _loc5_:Layout = new Layout();
         _loc5_.dir = 0;
         _loc5_.spacing = param2;
         _loc5_.children = param1;
         _loc5_.layout(param3,param4);
         return _loc5_;
      }
      
      public function getGameObjects() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Layout = null;
         var _loc3_:GameObject = null;
         if(leaf)
         {
            return [leaf];
         }
         _loc1_ = new Array();
         for each(_loc2_ in children)
         {
            for each(_loc3_ in _loc2_.getGameObjects())
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function width() : Number
      {
         var _loc2_:Layout = null;
         if(leaf)
         {
            return leaf.baseWidth;
         }
         var _loc1_:Number = 0;
         if(dir == 0)
         {
            _loc1_ = -spacing;
            for each(_loc2_ in children)
            {
               if(!_loc2_.freePlacement)
               {
                  _loc1_ += _loc2_.width() + spacing;
               }
            }
         }
         else
         {
            for each(_loc2_ in children)
            {
               if(!_loc2_.freePlacement)
               {
                  _loc1_ = Math.max(_loc1_,_loc2_.width() + spacing);
               }
            }
         }
         return _loc1_;
      }
      
      public function height() : Number
      {
         var _loc2_:Layout = null;
         if(leaf)
         {
            return leaf.baseHeight;
         }
         var _loc1_:Number = 0;
         if(dir == 1)
         {
            _loc1_ = -spacing;
            for each(_loc2_ in children)
            {
               if(!_loc2_.freePlacement)
               {
                  _loc1_ += _loc2_.height() + spacing;
               }
            }
         }
         else
         {
            for each(_loc2_ in children)
            {
               if(!_loc2_.freePlacement)
               {
                  _loc1_ = Math.max(_loc1_,_loc2_.height() + spacing);
               }
            }
         }
         return _loc1_;
      }
      
      public function layout(param1:Number = 0, param2:Number = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(leaf)
         {
            leaf.basex = param1;
            leaf.basey = param2;
            return;
         }
         if(dir == 0)
         {
            _loc4_ = 0;
            _loc5_ = width();
            _loc3_ = 0;
            while(_loc3_ < children.length)
            {
               children[_loc3_].x = _loc4_ - _loc5_ / 2 + children[_loc3_].width() / 2;
               _loc4_ += children[_loc3_].width() + spacing;
               _loc3_++;
            }
         }
         else
         {
            _loc6_ = 0;
            _loc7_ = height();
            _loc3_ = 0;
            while(_loc3_ < children.length)
            {
               children[_loc3_].y = _loc6_ - _loc7_ / 2 + children[_loc3_].height() / 2;
               _loc6_ += children[_loc3_].height() + spacing;
               _loc3_++;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < children.length)
         {
            if(children[_loc3_].freePlacement)
            {
               children[_loc3_].x = children[_loc3_].freeX;
               children[_loc3_].y = children[_loc3_].freeY;
            }
            children[_loc3_].layout(param1 + children[_loc3_].x,param2 + children[_loc3_].y);
            _loc3_++;
         }
      }
   }
}

