package InventoryScreen
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Layout.LayerFilter;
   import Scenes.MainMenu;
   import Tools.GraphicsTools;
   import Tools.Net;
   
   public class PauseMenu extends HUDDisplay
   {
      
      public var hasQuit:Boolean = false;
      
      public var pText:GameObject;
      
      public var quit:GameObject;

      // Online co-op status: pausing starts hosting and shows the join code.
      public var netText:GameObject;

      public var netShown:String = "";
      
      public function PauseMenu(param1:GameScene)
      {
         super(param1,GraphicsTools.createFilledSprite(1,1,0),"TextLayer",400,300);
      }
      
      override public function _kill() : void
      {
         LayerFilter.reverse(quit);
         LayerFilter.reverse(pText);
         LayerFilter.reverse(netText);
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
         if(netShown != onlineLine())
         {
            netShown = onlineLine();
            netText.setText(netShown);
         }
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
         Net.startHosting();
         netShown = onlineLine();
         netText = MainMenu.createNormalText(param1,netShown,20);
         netText.updateDespitePaused = true;
         param1.vert([pText,quit,ok,netText],16,400,300);
         slide(pText);
         slide(netText);
      }

      public function onlineLine() : String
      {
         return "ONLINE: " + (Net.status.length > 0 ? Net.status : "OFFLINE");
      }
   }
}

