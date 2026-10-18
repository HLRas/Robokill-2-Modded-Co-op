package Layout
{
   public class LayoutOverhang extends Layout
   {
      
      public var overhangWidth:Number = 0;
      
      public var fixedWidth:Number = 0;
      
      public function LayoutOverhang()
      {
         super();
      }
      
      public static function Horiz(param1:Array, param2:Number = 8, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0) : Layout
      {
         param1 = createLeaves(param1);
         var _loc7_:LayoutOverhang = new LayoutOverhang();
         _loc7_.fixedWidth = param3;
         _loc7_.overhangWidth = param4;
         _loc7_.dir = 0;
         _loc7_.spacing = param2;
         _loc7_.children = param1;
         _loc7_.layout(param5,param6);
         return _loc7_;
      }
      
      override public function width() : Number
      {
         return fixedWidth;
      }
      
      override public function layout(param1:Number = 0, param2:Number = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
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
               children[_loc3_].x = overhangWidth / 2;
               _loc3_++;
            }
            children[0].x = children[0].width() / 2 - _loc5_ / 2;
            _loc6_ = children.length - 1;
            children[_loc6_].x = children[_loc6_].width() / 2 + _loc5_ / 2 - overhangWidth;
         }
         _loc3_ = 0;
         while(_loc3_ < children.length)
         {
            children[_loc3_].layout(param1 + children[_loc3_].x,param2 + children[_loc3_].y);
            _loc3_++;
         }
      }
   }
}

