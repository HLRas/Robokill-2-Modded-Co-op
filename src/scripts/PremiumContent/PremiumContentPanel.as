package PremiumContent
{
   import GameConfig.GameConfig;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterSqrtInterpolateIn;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Scenes.MainMenu;
   import Tools.Extern;
   import Tools.GUILayer;
   import Tools.Input;
   import Tools.Net;
   import Tools.SafeRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class PremiumContentPanel extends GameObject
   {
      
      public var buy:GameObject;
      
      public var active:Boolean = true;
      
      public var layer:GUILayer;
      
      public var email:GameObject;
      
      public var _email:GameObject;
      
      public var verifyEmail:String = "";
      
      public var ok:GameObject;
      
      public var emailOK:GameObject;
      
      public var verify:SafeRequest;
      
      public var reglayer:GUILayer;
      
      public function PremiumContentPanel(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,Embeds.buynow_panel_png,"TextLayer",400,300);
         addSlide(this);
         helper.addBacking();
      }
      
      public static function addSlide(param1:GameObject) : void
      {
         param1.basey -= 700;
         var _loc2_:GameObjectFilterSqrtInterpolateIn = new GameObjectFilterSqrtInterpolateIn();
         _loc2_.dy = 700;
         _loc2_.FadeTime = 100;
         _loc2_.useSquareSquare = true;
         param1.addFilter(_loc2_);
      }
      
      public static function doVerify(param1:String, param2:Function) : SafeRequest
      {
         return new SafeRequest("Cracked by Ignite / THETA             " + GameConfig.shortName + "/" + param1 + "/",param2);
      }
      
      public static function create() : Array
      {
         var _loc6_:GameObject = null;
         var _loc1_:GameScene = GameScene.current();
         var _loc2_:PremiumContentPanel = new PremiumContentPanel(_loc1_,null,"TextLayer",0,0);
         var _loc3_:GameObject = MainMenu.addNormalStyledButton(_loc1_,"PanelBuy",Embeds.buynow_buynow_button_png,Embeds.buynow_buynow_button_png);
         _loc3_.stripText();
         _loc3_.basex = 400;
         _loc3_.basey = 230;
         _loc3_.basey -= 20;
         var _loc4_:GameObject = new GameObject(_loc1_,null,"TextLayer",400,300 - 10 + 1 - 26);
         _loc4_.setText("Enter Your Email Here",18,4473924);
         TextField(_loc4_.obj).autoSize = TextFieldAutoSize.NONE;
         _loc4_.obj.width = 250;
         _loc4_.obj.height = 24;
         _loc4_.obj.filters = [];
         _loc4_.basex = 400 - 250 / 2;
         _loc4_.baseHandleX = 0;
         _loc4_.baseHandleY = 0;
         _loc4_.setupTextInput();
         _loc2_._email = _loc4_;
         var _loc5_:GameObject = MainMenu.addNormalStyledButton(_loc1_,"PanelSubmit",Embeds.buynow_submit_png,Embeds.buynow_submit_png);
         _loc5_.stripText();
         _loc5_.basex = 400;
         _loc5_.basey = 325 - 26;
         _loc6_ = MainMenu.addNormalStyledButton(_loc1_,"PanelOK",Embeds.buynow_cancel_button_png,Embeds.buynow_cancel_button_png);
         _loc6_.stripText();
         _loc6_.basex = 400;
         _loc6_.basey = 500 + 28;
         addSlide(_loc3_);
         addSlide(_loc4_);
         addSlide(_loc5_);
         addSlide(_loc6_);
         return [_loc2_,_loc3_,_loc4_,_loc5_,_loc6_];
      }
      
      public function applyToNotifiers() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is PremiumContentSuccess)
            {
               PremiumContentSuccess(_loc1_).layer = layer;
               PremiumContentSuccess(_loc1_).reglayer = reglayer;
            }
         }
      }
      
      override public function _update() : void
      {
         var _loc1_:String = null;
         reglayer = MainMenu(gs).reglayer;
         layer = MainMenu(gs).layer;
         if(reglayer.buttonHit("PanelBuy"))
         {
            if(active)
            {
               active = false;
               PremiumContentSuccess.buyHit = true;
               PremiumContentSuccess.success = false;
               reglayer.push(PremiumContentSuccess.create);
               applyToNotifiers();
               _loc1_ = Extern.sendMessage("nav","https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=sales%40rocksolidgames%2ecom&item_name=Robokill%202&item_number=2&no_shipping=1&no_note=1&currency_code=USD&lc=NZ&bn=PP%2dBuyNowBF&amount=9%2e95");
               if(_loc1_ != "ss")
               {
                  Net.openURL("https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=sales%40rocksolidgames%2ecom&item_name=Robokill%202&item_number=2&no_shipping=1&no_note=1&currency_code=USD&lc=NZ&bn=PP%2dBuyNowBF&amount=9%2e95");
               }
            }
         }
         if(reglayer.buttonHit("PanelSubmit") || Boolean(Input.i.keyHit(13)))
         {
            verify = doVerify(TextField(_email.obj).text,verifycheck);
            verifyEmail = TextField(_email.obj).text;
         }
         if(reglayer.buttonHit("PanelOK"))
         {
            if(active)
            {
               reglayer.pop();
               layer.pop();
               active = false;
            }
         }
      }
      
      override public function _remove() : void
      {
      }
      
      override public function _init() : void
      {
      }
      
      public function verifycheck() : *
      {
         if(verify.data == "Valid")
         {
         }
         PremiumContentNotifier.registered = true;
         PremiumContentNotifier.registeredEmail = verifyEmail;
         PremiumContentNotifier.save();
         if(active)
         {
            active = false;
            PremiumContentSuccess.success = true;
            reglayer.push(PremiumContentSuccess.create,true);
         }
         applyToNotifiers();
      }
   }
}

