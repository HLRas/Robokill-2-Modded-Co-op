package PremiumContent
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Scenes.MainMenu;
   import Tools.GUILayer;
   
   public class PremiumContentSuccess extends GameObject
   {
      
      public static var buyHit:Boolean = false;
      
      public static var success:Boolean = true;
      
      public var layer:GUILayer;
      
      public var _success:Boolean = false;
      
      public var _buyHit:Boolean = false;
      
      public var reglayer:GUILayer;
      
      public function PremiumContentSuccess(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,400,300);
         PremiumContentPanel.addSlide(this);
         helper.addBacking();
      }
      
      public static function create() : Array
      {
         var _loc2_:Class = null;
         var _loc1_:GameScene = GameScene.current();
         if(buyHit)
         {
            _loc2_ = Embeds.purchasehit_png;
         }
         else if(success)
         {
            _loc2_ = Embeds.unlocked_success_png;
         }
         else
         {
            _loc2_ = Embeds.unlocked_failure_png;
         }
         var _loc3_:PremiumContentSuccess = new PremiumContentSuccess(_loc1_,_loc2_,"TextLayer",0,0);
         _loc3_._success = success;
         _loc3_._buyHit = buyHit;
         var _loc4_:GameObject = MainMenu.addNormalStyledButton(_loc1_,"PremiumSuccessOK",Embeds.unlocked_ok_png,Embeds.unlocked_ok_png);
         _loc4_.basex = 400;
         _loc4_.basey = 325;
         if(buyHit)
         {
            _loc4_.basey += 9;
         }
         if(!(success || buyHit))
         {
            _loc4_.basey += 46;
         }
         _loc4_.stripText();
         PremiumContentPanel.addSlide(_loc4_);
         buyHit = false;
         return [_loc3_,_loc4_];
      }
      
      override public function _update() : void
      {
         if(reglayer.buttonHit("PremiumSuccessOK"))
         {
            reglayer.pop();
            if(_success)
            {
               layer.pop();
            }
         }
      }
   }
}

