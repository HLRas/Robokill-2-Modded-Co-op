package Tools
{
   import GameObject.*;
   import Layout.*;
   
   public class GUILayer
   {
      
      public var creation:Function;
      
      public var elements:Array;
      
      public var children:Array = new Array();
      
      public function GUILayer()
      {
         super();
      }
      
      public function buttonHit(param1:String) : Boolean
      {
         var _loc2_:GUILayer = null;
         var _loc3_:GameObject = null;
         for each(_loc2_ in children)
         {
            if(_loc2_.buttonHit(param1))
            {
               return true;
            }
         }
         for each(_loc3_ in elements)
         {
            if(_loc3_.name == param1)
            {
               return _loc3_.mHit();
            }
         }
         return false;
      }
      
      public function flattenLayouts(param1:Array) : Array
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         param1 = flattenArray(param1);
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            if(_loc3_ is GameObject)
            {
               _loc2_.push(_loc3_);
            }
            if(_loc3_ is Layout)
            {
               _loc4_ = Layout(_loc3_).getGameObjects();
               for each(_loc5_ in _loc4_)
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getButton(param1:String) : GameObject
      {
         var _loc2_:GUILayer = null;
         var _loc3_:GameObject = null;
         for each(_loc2_ in children)
         {
            _loc3_ = _loc2_.getButton(param1);
            if(_loc3_)
            {
               return _loc3_;
            }
         }
         for each(_loc3_ in elements)
         {
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function pop() : void
      {
         var _loc4_:GameObject = null;
         var _loc5_:GameObject = null;
         var _loc1_:GUILayer = GUILayer(children.pop());
         var _loc2_:Array = _loc1_.elements;
         _loc1_.destroyElements();
         var _loc3_:GUILayer = GUILayer(children[children.length - 1]);
         if(_loc3_)
         {
            _loc3_.destroyElements();
         }
         if(_loc3_)
         {
            _loc3_.elements = flattenLayouts(_loc3_.creation());
            for each(_loc4_ in _loc3_.elements)
            {
               _loc4_.enableButton();
            }
         }
         for each(_loc4_ in _loc2_)
         {
            _loc4_.changeZOrder(_loc4_.zOrderString);
            for each(_loc5_ in _loc4_.children)
            {
               _loc5_.changeZOrder(_loc5_.zOrderString);
            }
         }
      }
      
      public function flattenArray(param1:Array) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] is Array)
            {
               _loc4_ = flattenArray(param1[_loc3_]);
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  _loc2_.push(_loc4_[_loc5_]);
                  _loc5_++;
               }
            }
            else
            {
               _loc2_.push(param1[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function destroyElements() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:GameObjectFilter = null;
         if(!elements)
         {
            return;
         }
         for each(_loc1_ in elements)
         {
            for each(_loc2_ in _loc1_.filters)
            {
               _loc2_.reverse();
               _loc2_.removeWhenDone();
            }
            _loc1_.disableButton();
         }
         elements = new Array();
      }
      
      public function push(param1:Function, param2:Boolean = false) : void
      {
         var _loc4_:GameObject = null;
         var _loc5_:GUILayer = null;
         if(children.length > 0)
         {
            children[children.length - 1].destroyElements();
         }
         if(param2)
         {
            children.pop();
         }
         var _loc3_:Array = flattenLayouts(param1());
         for each(_loc4_ in _loc3_)
         {
            _loc4_.obj.alpha = 0;
         }
         _loc5_ = new GUILayer();
         _loc5_.elements = _loc3_;
         _loc5_.creation = param1;
         children.push(_loc5_);
      }
   }
}

