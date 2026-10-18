package PremiumContent
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilter;
   import GameObject.GameObjectFilterSqrtInterpolateIn;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Serialization.StoreObject;
   import Tools.GUILayer;
   import Tools.SafeRequest;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   
   public class PremiumContentNotifier extends GameObject
   {
      
      public static var registered:Boolean = true;
      
      public static var registeredEmail:String = "";
      
      public static var hasLoaded:Boolean = false;
      
      public var reglayer:GUILayer;
      
      public var checking:int = 0;
      
      public var loadRequest:SafeRequest;
      
      public var panel:GameObject;
      
      public var registeredText:GameObject;
      
      public var layer:GUILayer;
      
      public var offsetDone:Boolean = false;
      
      public var child:GameObject;
      
      public var registeredTo:GameObject;
      
      public function PremiumContentNotifier(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         load();
         child = new GameObject(param1,Embeds.unlock_panel_png,"AfterTextLayer",0,0);
         registeredText = new GameObject(param1,null,"AfterTextLayer",0,0);
         registeredText.setText("Unregistered",18,4473924);
         registeredTo = new GameObject(param1,null,"AfterTextLayer",0,0);
         registeredTo.fontName = "Pixelation-34";
         registeredTo.setText("",7,4473924);
         super(param1,SimpleButton,param3,param4,param5);
         setupButton(Embeds.unlock_button_png,"Premium");
         stripText();
         var _loc6_:Bitmap = new Embeds.unlock_button_png();
         var _loc7_:Bitmap = new Embeds.unlock_panel_png();
         basex = 800 - _loc6_.width + 400;
         basey = 600 - _loc6_.height - 6;
         baseHandleX = 0;
         baseHandleY = 0;
         var _loc8_:GameObjectFilterSqrtInterpolateIn = new GameObjectFilterSqrtInterpolateIn();
         _loc8_.dx = -400;
         _loc8_.FadeTime = 100;
         _loc8_.useSquareSquare = true;
         addFilter(_loc8_);
         child.basey = _loc6_.height - _loc7_.height + 6;
         child.basex = _loc6_.width - _loc7_.width;
         child.baseHandleX = 0;
         child.baseHandleY = 0;
         addChild(child);
         addChild(registeredText);
         addChild(registeredTo);
         registeredText.basex += 24;
         registeredText.basey -= 24;
         registeredText.baseHandleX = 0;
         registeredText.baseHandleY = 0;
         registeredText.obj.filters = [];
         registeredTo.basex += 24;
         registeredTo.baseHandleX = 0;
         registeredTo.baseHandleY = 0;
         registeredTo.obj.filters = [];
      }
      
      public static function save() : void
      {
         StoreObject.storeValue("nonemail",registeredEmail);
      }
      
      public function load() : void
      {
         if(hasLoaded)
         {
            return;
         }
         hasLoaded = true;
         if(StoreObject.retrieveValue("nonemail"))
         {
            registeredEmail = String(StoreObject.retrieveValue("nonemail"));
            trace(registeredEmail);
            loadRequest = PremiumContentPanel.doVerify(registeredEmail,checkValid);
            checking = 1;
         }
      }
      
      public function nothing() : Array
      {
         return [];
      }
      
      override public function _init() : void
      {
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObjectFilter = null;
         var _loc2_:String = null;
         var _loc3_:GameObject = null;
         if(checking)
         {
            ++checking;
            if(checking > 100)
            {
               checking = 0;
            }
            for each(_loc1_ in filters)
            {
               if(_loc1_ is GameObjectFilterSqrtInterpolateIn)
               {
                  _loc1_.ticks = 0;
               }
            }
         }
         registeredTo.basex = int(registeredTo.basex);
         registeredTo.basey = int(registeredTo.basey);
         if(registered)
         {
            if(!offsetDone)
            {
               basey += 200;
               child.basey -= 160;
               registeredText.basey -= 164;
               registeredTo.basey -= 166;
               basex += 30;
               registeredText.fontName = "Pixelation-34";
               registeredText.setText("Cracked by Ignite / THETA             ",7,4473924);
               registeredText.obj.filters = [];
               registeredText.basey += 12;
               --registeredTo.basex;
               _loc2_ = registeredEmail;
               _loc2_ = _loc2_.toUpperCase();
               registeredTo.fontName = "Pixelation-34";
               registeredTo.setText(_loc2_,7,4473924);
               registeredTo.obj.filters = [];
               offsetDone = true;
            }
         }
         if(panel)
         {
            if(!panel._removed)
            {
               return;
            }
         }
         if(reglayer.buttonHit("Premium") && !registered)
         {
            layer.push(nothing);
            reglayer.push(PremiumContentPanel.create);
            for each(_loc3_ in gs.objects)
            {
               if(_loc3_ is PremiumContentPanel)
               {
                  PremiumContentPanel(_loc3_).layer = layer;
                  PremiumContentPanel(_loc3_).reglayer = reglayer;
               }
            }
         }
      }
      
      public function checkValid() : void
      {
         checking = 0;
         trace("valid");
         if(!loadRequest)
         {
         }
         if(!(loadRequest.data = "Valid"))
         {
         }
         registered = true;
      }
   }
}

