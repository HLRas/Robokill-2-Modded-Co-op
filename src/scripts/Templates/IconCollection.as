package Templates
{
   import GameObject.*;
   import GameScene.*;
   import Layout.Layout;
   import flash.display.Bitmap;
   
   public class IconCollection extends GameObject
   {
      
      public var spriteWidth:Number;
      
      public var threshold:int = 3;
      
      public var sprites:Array = new Array();
      
      public var displayText:GameObject;
      
      public var fontSize:int = 48;
      
      public var value:int = 5;
      
      public var iconClass:Class;
      
      public function IconCollection(param1:GameScene, param2:Class, param3:String, param4:int, param5:int, param6:int = 3, param7:int = 32, param8:Boolean = false)
      {
         super(param1,null,param3,param4,param5);
         threshold = param6;
         this.fontSize = param7;
         var _loc9_:int = 0;
         while(_loc9_ < threshold)
         {
            sprites[_loc9_] = new GameObject(param1,param2,param3,0,0);
            _loc9_++;
         }
         displayText = new GameObject(param1,null,param3,param4,param5);
         displayText.setText("x 3",param7);
         displayText.baseHandleX = 0;
         displayText.baseHandleY = 0;
         if(param8)
         {
            displayText.baseHandleX = 1;
            sprites.reverse();
         }
         var _loc10_:Layout = param1.horiz(sprites,-2,param4,param5);
         var _loc11_:Number = param4 + _loc10_.width() / 2;
         if(param8)
         {
            _loc11_ = param4 - _loc10_.width() / 2;
         }
         param1.horiz(sprites,-2,_loc11_,param5 + _loc10_.height() / 2);
         if(param8)
         {
            sprites.reverse();
         }
         if(param8)
         {
            displayText.basex = sprites[0].basex - sprites[0].baseWidth / 2;
         }
         else
         {
            displayText.basex = sprites[0].basex + sprites[0].baseWidth / 2;
         }
         spriteWidth = sprites[1].basex - sprites[0].basex;
      }
      
      override public function _remove() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in sprites)
         {
            _loc1_.remove();
         }
         displayText.remove();
      }
      
      public function setValue(param1:int) : void
      {
         value = param1;
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < threshold)
         {
            sprites[_loc1_].isGlobal = isGlobal;
            sprites[_loc1_].hide();
            _loc1_++;
         }
         displayText.hide();
         if(value > threshold || threshold == 1)
         {
            sprites[0].show();
            displayText.show();
            displayText.setText("x " + value);
            displayText.isGlobal = isGlobal;
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < value)
            {
               sprites[_loc1_].show();
               _loc1_++;
            }
         }
      }
      
      public function copyIcon(param1:int) : GameObject
      {
         var _loc2_:GameObject = sprites[param1];
         var _loc3_:GameObject = new GameObject(_loc2_.gs,_loc2_.imClass,_loc2_.zOrderString,_loc2_.basex,_loc2_.basey);
         Bitmap(_loc3_.obj).bitmapData = Bitmap(_loc2_.obj).bitmapData;
         return _loc3_;
      }
      
      public function copyCurrentIcon() : GameObject
      {
         var _loc1_:GameObject = sprites[value - 1];
         return new GameObject(_loc1_.gs,_loc1_.imClass,_loc1_.zOrderString,_loc1_.basex,_loc1_.basey);
      }
   }
}

