package Layout
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilter;
   import GameObject.GameObjectFilterAddOrigin;
   import GameObject.GameObjectFilterDampenInterpolateIn;
   import GameObject.GameObjectFilterFadeInOut;
   import GameObject.GameObjectFilterSqrtInterpolateIn;
   import flash.display.BlendMode;
   
   public class LayerFilter
   {
      
      public function LayerFilter()
      {
         super();
      }
      
      public static function applyAlphaInOut(param1:Object, param2:int, param3:int, param4:int, param5:int) : *
      {
         var _loc7_:GameObject = null;
         var _loc8_:GameObjectFilterFadeInOut = null;
         var _loc6_:Array = getObjectsArray(param1);
         for each(_loc7_ in _loc6_)
         {
            _loc8_ = new GameObjectFilterFadeInOut();
            _loc8_.FadeIn = 1;
            _loc8_.FadeInDelay = param2;
            _loc8_.FadeInDuration = param3;
            _loc8_.FadeOut = 1;
            _loc8_.FadeOutTime = param4;
            _loc8_.FadeOutDuration = param5;
            _loc7_.addFilter(_loc8_);
         }
      }
      
      public static function applyAlphaInStep(param1:Object, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:int = 0;
         var _loc8_:Layout = Layout(param1);
         for each(param1 in _loc8_.children)
         {
            applyAlphaInOut(param1,param2 + param6 * _loc7_,param3,param4,param5);
            _loc7_++;
         }
      }
      
      public static function reverse(param1:Object) : void
      {
         var _loc3_:GameObject = null;
         var _loc4_:GameObjectFilter = null;
         var _loc2_:Array = getObjectsArray(param1);
         for each(_loc3_ in _loc2_)
         {
            for each(_loc4_ in _loc3_.filters)
            {
               _loc4_.reverse();
               _loc4_.removeWhenDone();
            }
         }
      }
      
      public static function bakeToObject(param1:GameObject, param2:Object) : void
      {
         var _loc4_:GameObject = null;
         var _loc3_:Array = getObjectsArray(param2);
         for each(_loc4_ in _loc3_)
         {
            param1.drawToPixmap(_loc4_.obj,_loc4_.obj.x,_loc4_.obj.y,_loc4_.baseRotation,_loc4_.baseScaleX,_loc4_.baseScaleY,BlendMode.NORMAL);
         }
      }
      
      public static function getObjectsArray(param1:Object) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         if(param1 is Array)
         {
            _loc2_ = new Array();
            for each(_loc3_ in param1)
            {
               _loc4_ = getObjectsArray(_loc3_);
               for each(_loc5_ in _loc4_)
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         if(param1 is Layout)
         {
            _loc2_ = Layout(param1).getGameObjects();
         }
         if(param1 is GameObject)
         {
            _loc2_ = [param1];
         }
         return _loc2_;
      }
      
      public static function setLayerOrigin(param1:Object, param2:Number, param3:Number) : void
      {
         var _loc5_:GameObject = null;
         var _loc6_:Boolean = false;
         var _loc7_:GameObjectFilter = null;
         var _loc8_:GameObjectFilterAddOrigin = null;
         var _loc4_:Array = getObjectsArray(param1);
         for each(_loc5_ in _loc4_)
         {
            _loc6_ = false;
            for each(_loc7_ in _loc5_.filters)
            {
               if(_loc7_ is GameObjectFilterAddOrigin)
               {
                  _loc6_ = true;
                  _loc8_ = GameObjectFilterAddOrigin(_loc7_);
                  _loc8_.dx = param2;
                  _loc8_.dy = param3;
               }
            }
            if(!_loc6_)
            {
               _loc8_ = new GameObjectFilterAddOrigin();
               _loc8_.dx = param2;
               _loc8_.dy = param3;
               _loc5_.addFilter(_loc8_);
            }
         }
      }
      
      public static function applySlideIn(param1:Object, param2:int = 0, param3:int = 800, param4:int = 0, param5:Boolean = false, param6:int = 80) : void
      {
         var _loc9_:GameObject = null;
         var _loc10_:GameObjectFilterSqrtInterpolateIn = null;
         var _loc7_:Array = getObjectsArray(param1);
         var _loc8_:int = 1;
         for each(_loc9_ in _loc7_)
         {
            _loc10_ = new GameObjectFilterSqrtInterpolateIn();
            if(param2 != 0)
            {
               _loc8_ = param2;
            }
            _loc10_.dx = _loc8_ * param3;
            _loc10_.dy = param4;
            _loc10_.FadeTime = param6;
            _loc10_.useAlpha = param5;
            _loc9_.addFilter(_loc10_);
            _loc8_ *= -1;
         }
      }
      
      public static function applySqrtSlide(param1:Object, param2:int = 0, param3:int = 0, param4:int = 80, param5:Boolean = false) : void
      {
         var _loc7_:GameObject = null;
         var _loc8_:GameObjectFilterSqrtInterpolateIn = null;
         var _loc6_:Array = getObjectsArray(param1);
         for each(_loc7_ in _loc6_)
         {
            _loc8_ = new GameObjectFilterSqrtInterpolateIn();
            _loc8_.dx = param2;
            _loc8_.dy = param3;
            _loc8_.FadeTime = param4;
            _loc8_.killWhenDone = param5;
            _loc8_.useSquareSquare = true;
            _loc7_.addFilter(_loc8_);
         }
      }
      
      public static function applyDampenIn(param1:Object, param2:int = 800, param3:int = 0, param4:int = 5) : void
      {
         var _loc7_:GameObject = null;
         var _loc8_:GameObjectFilterDampenInterpolateIn = null;
         var _loc5_:Array = getObjectsArray(param1);
         var _loc6_:int = 0;
         for each(_loc7_ in _loc5_)
         {
            _loc8_ = new GameObjectFilterDampenInterpolateIn();
            _loc8_.dx = param2;
            _loc8_.dy = param3;
            _loc8_.FadeTime = 200;
            _loc8_.Delay = _loc6_;
            _loc6_ += param4;
            _loc7_.addFilter(_loc8_);
         }
      }
      
      public static function setAlpha(param1:Object, param2:Number) : void
      {
         var _loc4_:GameObject = null;
         var _loc3_:Array = getObjectsArray(param1);
         for each(_loc4_ in _loc3_)
         {
            _loc4_.baseAlpha = param2;
         }
      }
      
      public static function removeAll(param1:Object) : void
      {
         var _loc3_:GameObject = null;
         var _loc2_:Array = getObjectsArray(param1);
         for each(_loc3_ in _loc2_)
         {
            _loc3_.remove();
         }
      }
   }
}

