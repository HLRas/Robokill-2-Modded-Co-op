package NagScreen
{
   import Audio.GameSound;
   import GameConfig.GameConfig;
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Layout.*;
   import Tools.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   
   public class NagScreen extends GameScene
   {
      
      public static var allGames:Array;
      
      public static var data:SafeRequest;
      
      public static var iconRequests:Array;
      
      public static var free1:Class = NagScreen_free1;
      
      public static var free2:Class = NagScreen_free2;
      
      public static var lastGame:Class = NagScreen_lastGame;
      
      public static var nextGame:Class = NagScreen_nextGame;
      
      public static var dataFetched:Boolean = false;
      
      public static var gameNames:Array = null;
      
      public var ccc:int = 0;
      
      public var nextButton:GameObject;
      
      public var allLoaded:Boolean = false;
      
      public var but1:GameObject;
      
      public var but2:GameObject;
      
      public var leftText:GameObject;
      
      public var iconObjects:Array;
      
      public var OK:GameObject;
      
      public var lastButton:GameObject;
      
      public var gobs:Layout;
      
      public var okClass:Class;
      
      public function NagScreen()
      {
         super();
      }
      
      public static function preload() : void
      {
         if(GameConfig.nagEnabled == false)
         {
            return;
         }
         if(!data)
         {
            data = new SafeRequest("http://www.rocksolidarcade.com/newrandomselection/" + GameConfig.shortName,finishFetch);
         }
      }
      
      public static function requestIcons(param1:Array) : *
      {
         var _loc2_:String = null;
         var _loc3_:SafeImageRequest = null;
         iconRequests = new Array();
         gameNames = param1;
         for each(_loc2_ in param1)
         {
            _loc3_ = new SafeImageRequest("http://www.rocksolidarcade.com/static/" + _loc2_ + "/icon.png");
            iconRequests.push(_loc3_);
         }
      }
      
      public static function finishFetch() : void
      {
         var _loc3_:String = null;
         var _loc4_:NagScreenGame = null;
         dataFetched = true;
         var _loc1_:Array = data.data.split(":::");
         var _loc2_:String = _loc1_[0];
         _loc1_.splice(0,1);
         _loc1_.splice(_loc1_.length - 1,1);
         allGames = new Array();
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = NagScreenGame.create(_loc3_);
            if(_loc4_)
            {
               _loc4_.baseURL = _loc2_;
               allGames.push(_loc4_);
            }
         }
         if(allGames.length > 0)
         {
            allGames[0].cache();
         }
      }
      
      public static function gamesHaveLoaded() : Boolean
      {
         var _loc1_:SafeImageRequest = null;
         if(allGames)
         {
            return true;
         }
         return false;
      }
      
      public static function create(param1:GameScene, param2:Class) : void
      {
         var _loc3_:NagScreen = null;
         if(GameConfig.nagEnabled == false)
         {
            param1.pushScene(new param2(),true);
            return;
         }
         if(gamesHaveLoaded())
         {
            _loc3_ = new NagScreen();
            _loc3_.okClass = param2;
            param1.pushScene(_loc3_,true);
         }
         else
         {
            param1.pushScene(new param2(),true);
         }
      }
      
      public function getTextFromJavascript(param1:String) : void
      {
         leftText.setText(param1);
      }
      
      public function getLastGame() : NagScreenGame
      {
         if(ccc == 0)
         {
            return allGames[allGames.length - 1];
         }
         return allGames[ccc - 1];
      }
      
      override public function init() : void
      {
         nextButton = new GameObject(this,SimpleButton,"TextLayer",400,300);
         lastButton = new GameObject(this,SimpleButton,"TextLayer",400,300);
         nextButton.setupButton(nextGame,"",null,true);
         lastButton.setupButton(lastGame,"",null,true);
         but1 = new GameObject(this,SimpleButton,"TextLayer",400,100);
         but2 = new GameObject(this,SimpleButton,"TextLayer",400,200);
         but1.setupButton(free1,"",null,true);
         but2.setupButton(free2,"",null,true);
         OK = new GameObject(this,SimpleButton,"TextLayer",0,0);
         OK.setupButton(Embeds.menu_button_png,"Keep Playing",null,true);
         OK.basex = 400;
         OK.basey = 600 - 48;
         var _loc1_:NagScreenGame = allGames[0];
         gobs = _loc1_.getGameObjects(this);
         nextButton.basey = gobs.getGameObjects()[2].basey;
         lastButton.basey = nextButton.basey;
         slideGames(gobs,null,1);
         var _loc2_:Array = gobs.getGameObjects();
         LayerFilter.applySlideIn(but1,0,-800);
         LayerFilter.applySlideIn(but2,0,800);
         LayerFilter.applySqrtSlide(lastButton,-800);
         LayerFilter.applySqrtSlide(nextButton,-800);
         LayerFilter.applySlideIn(OK,0,0,400);
      }
      
      public function buildGames() : *
      {
         var _loc2_:String = null;
         var _loc3_:GameObject = null;
         iconObjects = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < iconRequests.length)
         {
            _loc2_ = gameNames[_loc1_];
            _loc3_ = new GameObject(this,SimpleButton,"TextLayer",0,0);
            _loc3_.setupButton(iconRequests[_loc1_].ldr,"game" + _loc1_,null,true);
            _loc3_.stripText();
            iconObjects.push(_loc3_);
            _loc1_++;
         }
      }
      
      override public function _update() : void
      {
         var _loc4_:GameObject = null;
         var _loc5_:Layout = null;
         var _loc6_:String = null;
         var _loc1_:int = ccc;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         getNextGame().cache();
         getLastGame().cache();
         if(nextButton.mHit())
         {
            _loc2_ = true;
            ++ccc;
         }
         if(lastButton.mHit())
         {
            _loc3_ = true;
            --ccc;
         }
         if(ccc < 0)
         {
            ccc = allGames.length - 1;
         }
         if(ccc >= allGames.length)
         {
            ccc = 0;
         }
         if(_loc1_ != ccc)
         {
            _loc5_ = gobs;
            gobs = allGames[ccc].getGameObjects(this);
            if(_loc2_)
            {
               slideGames(gobs,_loc5_,1);
            }
            else
            {
               slideGames(gobs,_loc5_,-1);
            }
            lastButton.changeZOrder("TextLayer");
            nextButton.changeZOrder("TextLayer");
         }
         if(but1.mHit())
         {
            Net.openURL("http://www.rocksolidarcade.com/");
            GameSound.globalMusicVolume = 0;
         }
         if(but2.mHit())
         {
            Net.openURL("http://www.rocksolidarcade.com/");
            GameSound.globalMusicVolume = 0;
         }
         for each(_loc4_ in gobs.getGameObjects())
         {
            if(_loc4_.mHit())
            {
               _loc6_ = Extern.sendMessage("nav","http://www.rocksolidarcade.com/games/" + allGames[ccc].shortName + "/fn");
               if(_loc6_ != "ss")
               {
                  Net.openURL("http://www.rocksolidarcade.com/games/" + allGames[ccc].shortName + "/fn");
               }
               GameSound.globalMusicVolume = 0;
            }
         }
         if(OK.mHit())
         {
            pushScene(new okClass(),true);
         }
      }
      
      public function getNextGame() : NagScreenGame
      {
         if(ccc == allGames.length - 1)
         {
            return allGames[0];
         }
         return allGames[ccc + 1];
      }
      
      public function slideGames(param1:Object, param2:Object, param3:int) : void
      {
         vert([but2,but1,horiz([lastButton,param1,nextButton])],32,400,270);
         lastButton.basex += 800;
         nextButton.basex += 800;
         lastButton.basex -= 2;
         lastButton.basey = Layout(param1).getGameObjects()[1].basey;
         nextButton.basey = lastButton.basey;
         if(param2)
         {
            LayerFilter.applySqrtSlide(param2,-800 * param3,0,80,true);
            LayerFilter.applyAlphaInOut(param2,0,0,0,60);
         }
         LayerFilter.setLayerOrigin(param1,800 * param3,0);
         LayerFilter.applySqrtSlide(param1,-800 * param3,0);
         LayerFilter.applyAlphaInOut(param1,20,60,9999999,9);
      }
   }
}

