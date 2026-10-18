package GameObject
{
   import Tools.Input;
   
   public class GameObjectFilterDraggable extends GameObjectFilter
   {
      
      public static var lastDragged:*;
      
      public var dormant:Boolean = false;
      
      public var lowX:Number = -999999999;
      
      public var lowY:Number = -99999999999;
      
      public var startFunc:Function;
      
      public var handleX:Number = 0;
      
      public var handleY:Number = 0;
      
      public var beingDragged:Boolean = false;
      
      public var highX:Number = 99999999999;
      
      public var finishFunc:Function;
      
      public var highY:Number = 9999999999;
      
      public function GameObjectFilterDraggable()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         if(dormant)
         {
            return;
         }
         var _loc2_:Number = Input.i.mouseX() + param1.gs.camX;
         var _loc3_:Number = Input.i.mouseY() + param1.gs.camY;
         if(!beingDragged)
         {
            if(param1.mOver())
            {
               if(param1.gs.mHit())
               {
                  if(!anyInFront(param1))
                  {
                     if(param1.mOverPixelCheck())
                     {
                        handleX = param1.basex - _loc2_;
                        handleY = param1.basey - _loc3_;
                        beingDragged = true;
                        if(Boolean(startFunc))
                        {
                           startFunc();
                        }
                     }
                  }
               }
            }
         }
         if(beingDragged)
         {
            if(!Input.i.mouseDown())
            {
               beingDragged = false;
               if(finishFunc != null)
               {
                  finishFunc();
               }
            }
         }
         if(beingDragged)
         {
            param1.basex = _loc2_ + handleX;
            param1.basey = _loc3_ + handleY;
            if(param1.basex < lowX)
            {
               param1.basex = lowX;
            }
            if(param1.basex > highX)
            {
               param1.basex = highX;
            }
            if(param1.basey < lowY)
            {
               param1.basey = lowY;
            }
            if(param1.basey > highY)
            {
               param1.basey = highY;
            }
         }
      }
      
      public function anyInFront(param1:GameObject) : Boolean
      {
         var _loc4_:GameObject = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         for(; _loc3_ < param1.gs.objects.length; _loc3_++)
         {
            _loc4_ = param1.gs.objects[_loc3_];
            if(_loc4_ == param1)
            {
               _loc2_ = true;
            }
            _loc5_ = param1.gs.zOrderInt(param1.zOrderString);
            _loc6_ = param1.gs.zOrderInt(_loc4_.zOrderString);
            _loc7_ = true;
            if(_loc6_ < _loc5_)
            {
               _loc7_ = false;
            }
            if(_loc6_ == _loc5_)
            {
               if(!_loc2_)
               {
                  _loc7_ = false;
               }
            }
            if(_loc4_ == param1)
            {
               _loc7_ = false;
            }
            if(_loc7_)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc4_.filters.length)
               {
                  if(_loc4_.filters[_loc8_] is GameObjectFilterDraggable)
                  {
                     if(_loc4_.mOver())
                     {
                        if(_loc4_.mOverPixelCheck())
                        {
                           return true;
                           break;
                        }
                     }
                  }
                  _loc8_++;
               }
            }
         }
         return false;
      }
   }
}

