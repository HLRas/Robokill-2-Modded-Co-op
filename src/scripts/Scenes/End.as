package Scenes
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import SceneConstructors.End_constructor;
   import Serialization.Profile;
   import Tools.HumanReadable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class End extends GameScene
   {
      
      public var skipped:Boolean = false;
      
      public var skip:GameObject;
      
      public function End()
      {
         super();
      }
      
      override public function _register(param1:Sprite) : void
      {
         var _loc2_:End_constructor = new End_constructor();
         _loc2_.register(this,param1,true);
      }
      
      public function addText(param1:String, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : GameObject
      {
         var _loc7_:int = 28;
         var _loc8_:Array = [132,517];
         var _loc9_:Array = [252,281];
         param2 = int(_loc8_[param2]);
         param3 = int(_loc9_[param3]);
         var _loc10_:GameObject = new GameObject(this,null,"TextLayer",0,0);
         _loc10_.fontName = "SFC";
         _loc10_.defaultCol = 16755200;
         _loc10_.basex = param2;
         _loc10_.basey = param3;
         _loc10_.baseHandleX = 0;
         _loc10_.baseHandleY = 0;
         _loc10_.setText(param1,_loc7_);
         _loc10_.updateDespitePaused = true;
         return _loc10_;
      }
      
      override public function init() : void
      {
         var _loc1_:GameObject = new GameObject(this,Embeds.mission_complete_png,"TextLayer",400,265);
         skip = MainMenu.addNormalStyledButton(this,"OK",Embeds.levelup_ok_png,Embeds.levelup_ok_over_png,"OK",16 - 35);
         skip.basex = 632 + (589 - 576) + 2;
         skip.basey = 321 + (374 - 338) + 6 - (300 - 265);
         addText("Total Cash Gained Before Destruction:",0,0);
         addText("Total Number Of Robots Destroyed:",0,1);
         addText("$" + HumanReadable.formatInteger(int(Profile.defLookup("cash"))),1,0);
         addText(HumanReadable.formatInteger(int(Profile.defLookup("totalkills"))),1,1);
         MainMenu.setMusic();
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in objects)
         {
            if(_loc1_.obj is Bitmap)
            {
               Bitmap(_loc1_.obj).smoothing = true;
            }
         }
         if(skip.mHit())
         {
            pushScene(new MainMenu(),true);
         }
      }
   }
}

