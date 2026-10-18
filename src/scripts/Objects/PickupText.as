package Objects
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterFadeInOut;
   import GameScene.GameScene;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   
   public class PickupText extends GameObject
   {
      
      public function PickupText(param1:GameScene, param2:int, param3:int, param4:String, param5:int = -1)
      {
         var _loc6_:GameObjectFilterFadeInOut = null;
         super(param1,null,"BeforeTextLayer",param2,param3);
         fontName = "Pixelation-34";
         setText(param4,7,param5);
         TextField(obj).antiAliasType = AntiAliasType.ADVANCED;
         _loc6_ = new GameObjectFilterFadeInOut();
         _loc6_.FadeIn = 1;
         _loc6_.FadeInDelay = 0;
         _loc6_.FadeInDuration = 10;
         _loc6_.FadeOut = 1;
         _loc6_.FadeOutTime = 100;
         _loc6_.FadeOutDuration = 10;
         addFilter(_loc6_);
      }
      
      override public function _update() : void
      {
      }
   }
}

