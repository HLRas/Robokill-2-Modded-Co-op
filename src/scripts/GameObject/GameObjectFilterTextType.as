package GameObject
{
   public class GameObjectFilterTextType extends GameObjectFilter
   {
      
      public var speed:Number = 5;
      
      public var targetArray:Array;
      
      public var txt:String;
      
      public var offset:int = 40;
      
      public var finishCallbackCalled:Boolean = false;
      
      public var finishCallback:Function;
      
      public function GameObjectFilterTextType()
      {
         super();
      }
      
      public function setTargetArrayText(param1:String) : void
      {
      }
      
      override public function update(param1:GameObject) : void
      {
         var _loc3_:String = null;
         ++ticks;
         var _loc2_:int = int((ticks - offset + 2) / speed);
         if(_loc2_ >= 0)
         {
            _loc3_ = txt.substr(0,_loc2_);
            if(_loc3_ == txt)
            {
               if(Boolean(finishCallback))
               {
                  if(!finishCallbackCalled)
                  {
                     finishCallback();
                     finishCallbackCalled = true;
                  }
               }
            }
            while(_loc3_.indexOf("~") != -1)
            {
               _loc3_ = _loc3_.replace("~","");
            }
            if(targetArray)
            {
               setTargetArrayText(_loc3_);
            }
            else
            {
               param1.setText(_loc3_);
            }
         }
      }
      
      public function setTextArray(param1:Array, param2:Array) : void
      {
         var _loc3_:String = flattenArray(param1);
         targetArray = param2;
         if(_loc3_ != txt)
         {
            txt = _loc3_;
            ticks = 0;
         }
      }
      
      public function flattenArray(param1:Array) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = 0;
            while(_loc4_ < param1[_loc3_].length)
            {
               _loc2_ += param1[_loc3_][_loc4_] + "|";
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

