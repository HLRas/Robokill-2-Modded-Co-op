package InventoryScreen
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterTextType;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Layout.LayerFilter;
   import Objects.Brute;
   import Scenes.MainScene;
   import Templates.RewardText;
   import Tools.GraphicsTools;
   import flash.display.SimpleButton;
   
   public class HUDDisplay extends GameObject
   {
      
      public static var lastCreated:GameObject;
      
      public var ok:GameObject;
      
      public var shopkeeper:GameObject;
      
      public var shopkeeperText:GameObject;
      
      public var backing:GameObject;
      
      public var killed:Boolean = false;
      
      public var gof:GameObjectFilterTextType;
      
      public function HUDDisplay(param1:GameScene, param2:Object, param3:String, param4:int, param5:int)
      {
         var _loc6_:GameObject = null;
         super(param1,param2,param3,param4,param5);
         updateDespitePaused = true;
         pausesGame = true;
         _loc6_ = new GameObject(param1,GraphicsTools.createFilledSprite(800,600,855638016),"BeforeTextLayer",400,300);
         _loc6_.updateDespitePaused = true;
         _loc6_.baseWidth = 800;
         _loc6_.baseHeight = 600;
         LayerFilter.applyAlphaInOut(_loc6_,0,15,999999,99);
         _loc6_.baseAlpha = 0.4;
         backing = _loc6_;
         lastCreated = this;
      }
      
      public static function any() : Boolean
      {
         if(!lastCreated)
         {
            return false;
         }
         return !lastCreated._removed;
      }
      
      public static function open(param1:GameScene, param2:Class) : void
      {
         var _loc3_:GameObject = null;
         var _loc4_:HUDDisplay = null;
         for each(_loc3_ in param1.objects)
         {
            if(_loc3_ is HUDDisplay)
            {
               if(_loc3_.ticks >= 15)
               {
                  HUDDisplay(_loc3_).kill();
               }
               return;
            }
         }
         if(MainScene(param1).player._removed)
         {
            return;
         }
         for each(_loc3_ in param1.objects)
         {
            if(_loc3_ is RewardText)
            {
               _loc3_.remove();
            }
         }
         _loc4_ = HUDDisplay(new param2(param1));
         _loc4_.ok = _loc4_.createOK();
         _loc4_.slide(_loc4_);
         _loc4_._open(param1);
         Sounds.slide.play();
         for each(_loc3_ in param1.objects)
         {
            if(_loc3_ is Brute)
            {
               if(Brute(_loc3_).minigunFiringChannel)
               {
                  Brute(_loc3_).minigunFiringChannel.stop();
                  Brute(_loc3_).minigunFiringChannel = null;
               }
            }
         }
      }
      
      public function _open(param1:GameScene) : void
      {
      }
      
      public function _kill() : void
      {
      }
      
      public function kill() : void
      {
         if(killed)
         {
            return;
         }
         killed = true;
         LayerFilter.reverse(this);
         LayerFilter.reverse(ok);
         LayerFilter.applyAlphaInOut(backing,0,0,0,15);
         Sounds.slide.play();
         _kill();
      }
      
      public function createText(param1:Number, param2:Number, param3:Function, param4:String) : GameObject
      {
         var _loc5_:GameObject = null;
         _loc5_ = new GameObject(gs,null,"TextLayer",0,0);
         _loc5_.updateDespitePaused = true;
         _loc5_.setText("",18);
         _loc5_.baseHandleX = 0;
         _loc5_.baseHandleY = 0;
         _loc5_.basex = param1;
         _loc5_.basey = param2;
         gof = new GameObjectFilterTextType();
         gof.txt = param4;
         gof.speed /= 3;
         gof.finishCallback = param3;
         _loc5_.addFilter(gof);
         return _loc5_;
      }
      
      public function createButton(param1:String, param2:int, param3:int) : GameObject
      {
         var _loc4_:GameObject = new GameObject(gs,SimpleButton,"AfterTextLayer",param2,param3);
         _loc4_.setupButton(Embeds.ok_png,param1);
         _loc4_.updateDespitePaused = true;
         slide(_loc4_);
         return _loc4_;
      }
      
      override public function _update() : void
      {
         if(ok.mHit())
         {
            kill();
         }
      }
      
      public function slide(param1:Object) : *
      {
         LayerFilter.applySlideIn(param1,0,0,-700,false,15);
      }
      
      public function createOK() : GameObject
      {
         return createButton("OK",396,523 - 300 + basey);
      }
   }
}

