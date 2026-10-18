package InventoryScreen
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Layout.LayerFilter;
   import Scenes.MainMenu;
   import Tools.GraphicsTools;
   
   public class PauseMenu extends HUDDisplay
   {
      
      public var hasQuit:Boolean = false;
      
      public var pText:GameObject;
      
      public var quit:GameObject;
      
      public function PauseMenu(param1:GameScene)
      {
         super(param1,GraphicsTools.createFilledSprite(1,1,0),"TextLayer",400,300);
      }
      
      override public function _kill() : void
      {
         LayerFilter.reverse(quit);
         LayerFilter.reverse(pText);
         super._kill();
      }
      
      override public function createButton(param1:String, param2:int, param3:int) : GameObject
      {
         var _loc4_:GameObject = MainMenu.addNormalStyledButton(gs,param1);
         _loc4_.basex = param2;
         _loc4_.basey = param3;
         _loc4_.updateDespitePaused = true;
         slide(_loc4_);
         return _loc4_;
      }
      
      override public function _update() : void
      {
         if(!hasQuit)
         {
            if(quit.mHit())
            {
               hasQuit = true;
               gs.pushScene(new MainMenu(),true);
            }
         }
         super._update();
      }
      
      override public function createOK() : GameObject
      {
         return createButton("CONTINUE",400,330);
      }
      
      override public function _open(param1:GameScene) : void
      {
         quit = createButton("MAIN MENU",400,270);
         pText = MainMenu.createNormalText(param1,"GAME PAUSED",40);
         pText.basex = 400;
         pText.basey = 240;
         pText.updateDespitePaused = true;
         param1.vert([pText,quit,ok],16,400,300);
         slide(pText);
      }
   }
}

