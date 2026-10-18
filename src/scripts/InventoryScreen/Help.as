package InventoryScreen
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.AlienBase;
   import Objects.Robot;
   import Scenes.MainScene;
   
   public class Help extends HUDDisplay
   {
      
      public static var helpText:String;
      
      public var shieldText:GameObject;
      
      public var available:GameObject;
      
      public var robot:AlienBase;
      
      public var damageText:GameObject;
      
      public function Help(param1:GameScene)
      {
         super(param1,Embeds.shop_character_png,"TextLayer",400,300);
         basex = 400;
         basey = 246;
         robot = new Robot(param1,0,0);
         addChild(robot);
         robot.basex = -244;
         robot.basey = -1;
         robot.isTalking = true;
         var _loc2_:GameObject = createText(-(baseWidth - 314) / 2,-(baseHeight - 14) / 2,finishTalking,helpText);
         addChild(_loc2_);
      }
      
      public function finishTalking() : void
      {
         robot.isTalking = false;
      }
      
      override public function _update() : void
      {
         MainScene(gs).fadeOverlay.hide();
         ok.basex = 352 + (352 - 422);
         ok.basey = 323 + (323 - 360);
         super._update();
      }
   }
}

