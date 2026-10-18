package GameObject
{
   import Tools.Random;
   import flash.display.*;
   
   public class GameObjectFilterRepeats extends GameObjectFilter
   {
      
      public var others:Array = new Array();
      
      public var created:Boolean = false;
      
      public var imageSets:Array = new Array();
      
      public function GameObjectFilterRepeats()
      {
         super();
      }
      
      override public function remove(param1:GameObject) : void
      {
         var _loc2_:GameObject = null;
         for each(_loc2_ in others)
         {
            _loc2_.remove();
         }
      }
      
      override public function update(param1:GameObject) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < others.length)
         {
            others[_loc2_].baseWidth = param1.baseWidth;
            others[_loc2_].baseHeight = param1.baseHeight;
            _loc2_++;
         }
      }
      
      override public function addedTo(param1:GameObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GameObjectFilterStayOnScreen = null;
         var _loc4_:int = 0;
         var _loc5_:GameObject = null;
         var _loc6_:GameObjectFilter = null;
         var _loc7_:int = 0;
         var _loc8_:GameObjectFilterDampenOrigin = null;
         if(!created)
         {
            param1.hide();
            _loc2_ = 800 / param1.baseWidth + 2;
            _loc3_ = new GameObjectFilterStayOnScreen();
            _loc3_.multiplier = _loc2_;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = new GameObject(param1.gs,param1.imClass,param1.zOrderString,param1.basex + _loc4_ * param1.baseWidth,param1.basey);
               _loc5_.addFilter(_loc3_);
               _loc5_.imageSet = param1.imageSet;
               _loc5_.animSpeed = param1.animSpeed;
               if(imageSets.length > 0)
               {
                  _loc7_ = Random.randInt(0,imageSets.length - 1);
                  _loc5_.imageSet = imageSets[_loc7_];
               }
               others.push(_loc5_);
               for each(_loc6_ in param1.filters)
               {
                  if(_loc6_ is GameObjectFilterDampenOrigin)
                  {
                     _loc8_ = new GameObjectFilterDampenOrigin();
                     _loc8_.factor = GameObjectFilterDampenOrigin(_loc6_).factor;
                     _loc8_.StickToBottom = GameObjectFilterDampenOrigin(_loc6_).StickToBottom;
                     _loc8_.StickToTop = GameObjectFilterDampenOrigin(_loc6_).StickToTop;
                     _loc5_.addFilter(_loc8_);
                  }
               }
               _loc4_++;
            }
            param1.addFilter(_loc3_);
            created = true;
         }
      }
   }
}

