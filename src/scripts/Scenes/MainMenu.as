package Scenes
{
   import Audio.GameSound;
   import Audio.GameSoundScene;
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Layout.*;
   import ObjectBase.*;
   import Objects.*;
   import PremiumContent.PremiumContentNotifier;
   import PremiumContent.PremiumContentPanel;
   import SceneConstructors.*;
   import Serialization.*;
   import Tools.GUILayer;
   import Tools.Input;
   import Tools.Net;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import preload.CustomPreloader;
   
   public class MainMenu extends GameScene
   {
      
      public static var musicEnabled:Boolean = true;
      
      public static var soundEnabled:Boolean = true;
      
      public static var levelOfDetail:Boolean = true;
      
      public static var popUpNag:Boolean = false;
      
      public var effects:Array = new Array();
      
      public var enterNameInput:GameObject;
      
      public var layer:GUILayer;
      
      public var profileToDelete:int = 0;
      
      public var enterNameOK:GameObject;
      
      public var changed:Boolean = false;
      
      public var unlockAllEpisodes:Boolean = false;
      
      public var globalMenuY:Number = 350;

      // Up, down, left, right, up, up, down, left on the mission select screen.
      public static const CHEAT_CODE:Array = [38,40,37,39,38,38,40,37];

      // The mod's version, shown on the title screen (PremiumContentNotifier). Goes up by 0.01 with each update.
      // Online play only connects players with the same version.
      public static const MOD_VERSION:String = "1.03";

      // ---- Updates ----
      // Two channels: RELEASE = the main branch on GitHub, BETA = the working-tree branch. channel.txt (written
      // by fscommand\updaterelease.exe / updatebeta.exe) says which one is installed. Switching or updating runs that updater and quits;
      // it downloads the exe, swaps it in and restarts the game.
      public static const REPO_RAW:String = "https://raw.githubusercontent.com/HLRas/Robokill-2-Modded-Co-op/";

      public static var channel:String = "release";

      // Latest version per channel on GitHub ("" until loaded, "?" if it couldn't be read).
      public static var latest:Object = {
         release:"",
         beta:""
      };

      public static var updatesChecked:Boolean = false;

      public static var updatePrompted:Boolean = false;

      public var pendingChannel:String = "release";

      public var confirmIsUpdate:Boolean = false;

      public var updatesInfo:GameObject;

      public var releaseButton:GameObject;

      public var betaButton:GameObject;

      public var updatesShown:String = "";

      public var confirmText:GameObject;

      public var quitAt:int = 0;

      public static const CHEAT_LEVEL:int = 49;

      public var cheatProgress:int = 0;

      public var joinInput:GameObject;

      public var joinStatus:GameObject;

      public var joinStatusShown:String = "";
      
      public var profileToDeleteName:String = "";
      
      public var reglayer:GUILayer;
      
      public function MainMenu()
      {
         super();
         Profile.initProfiles("RobokillProfiles",5);
         readPrefs();
         checkUpdates();
      }

      public static function channelName(param1:String) : String
      {
         return param1 == "beta" ? "BETA" : "RELEASE";
      }

      // Shown on the title screen (PremiumContentNotifier).
      public static function versionLabel() : String
      {
         return "CO-OP MOD V" + MOD_VERSION + (channel == "beta" ? " BETA" : "");
      }

      public static function newerAvailable(param1:String) : Boolean
      {
         var v:Number = Number(latest[param1]);
         return latest[param1] != "" && !isNaN(v) && v > Number(MOD_VERSION) + 0.0001;
      }

      // Once per run: which channel is installed, and the latest version of each on GitHub.
      public static function checkUpdates() : void
      {
         if(updatesChecked)
         {
            return;
         }
         updatesChecked = true;
         loadText("channel.txt",function(param1:String):void
         {
            channel = param1.indexOf("beta") >= 0 ? "beta" : "release";
         },null);
         var stamp:String = "?t=" + new Date().time;
         loadText(REPO_RAW + "main/version.txt" + stamp,function(param1:String):void
         {
            latest.release = param1.replace(/\s+/g,"");
         },function():void
         {
            latest.release = "?";
         });
         loadText(REPO_RAW + "working-tree/version.txt" + stamp,function(param1:String):void
         {
            latest.beta = param1.replace(/\s+/g,"");
         },function():void
         {
            latest.beta = "?";
         });
      }

      public static function loadText(param1:String, param2:Function, param3:Function) : void
      {
         var done:Function = param2;
         var failed:Function = param3;
         var loader:URLLoader = new URLLoader();
         var fail:Function = function(param1:Event):void
         {
            if(failed != null)
            {
               failed();
            }
         };
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            done(String(loader.data));
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,fail);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,fail);
         try
         {
            loader.load(new URLRequest(param1));
         }
         catch(e:Error)
         {
            fail(null);
         }
      }

      public function versionText(param1:String) : String
      {
         var v:String = latest[param1];
         return v == "" ? "..." : (v == "?" ? "(CAN'T CHECK)" : "V" + v);
      }

      public function updatesLine() : String
      {
         return "INSTALLED: V" + MOD_VERSION + " " + channelName(channel);
      }

      public function updatesScreen() : Array
      {
         var title:GameObject = txt("UPDATES",32);
         title.helper.addBacking();
         title.vars["backing"].baseAlpha = 0.6;
         updatesInfo = txt(updatesLine(),16);
         releaseButton = addButton("UPDATE_RELEASE");
         betaButton = addButton("UPDATE_BETA");
         var back:GameObject = addButton("BACK");
         updatesShown = "";
         refreshUpdatesScreen();
         var all:Array = [title,updatesInfo,releaseButton,betaButton,back];
         vert(all,8,400,globalMenuY);
         LayerFilter.applySlideIn(all);
         return all;
      }

      public function refreshUpdatesScreen() : void
      {
         var key:String = updatesLine() + versionText("release") + versionText("beta");
         if(key == updatesShown || !releaseButton)
         {
            return;
         }
         updatesShown = key;
         updatesInfo.setText(updatesLine());
         releaseButton.setButtonText("RELEASE " + versionText("release"));
         betaButton.setButtonText("BETA " + versionText("beta"));
      }

      public function confirmScreen() : Array
      {
         var v:String = latest[pendingChannel];
         var target:String = channelName(pendingChannel) + " " + (v == "" || v == "?" ? "(LATEST VERSION)" : "V" + v);
         var question:String = confirmIsUpdate ? "UPDATE AVAILABLE: " + target + ". INSTALL IT?" : (pendingChannel == channel && !newerAvailable(pendingChannel) ? "REINSTALL " + target + "?" : "SWITCH TO " + target + "?");
         var q:GameObject = txt(question,20);
         q.helper.addBacking();
         q.vars["backing"].baseAlpha = 0.6;
         confirmText = txt("THE GAME WILL CLOSE, DOWNLOAD IT AND RESTART.",16);
         var yes:GameObject = addButton("UPDATE_YES");
         yes.setButtonText("YES, RESTART");
         var no:GameObject = addButton("UPDATE_NO");
         no.setButtonText(confirmIsUpdate ? "LATER" : "NO");
         var all:Array = [q,confirmText,yes,no];
         vert(all,10,400,globalMenuY);
         LayerFilter.applySlideIn(all);
         return all;
      }

      // Starts fscommand\update<channel>.exe (after checking it's there, since quitting without it would just
      // close the game) and quits so it can replace the exe. Flash ignores exec names with a hyphen.
      public function runUpdater(param1:String) : void
      {
         var file:String = "update" + param1 + ".exe";
         if(Capabilities.playerType != "StandAlone")
         {
            confirmText.setText("UPDATES ONLY WORK IN THE CO-OP EXE.");
            return;
         }
         var bin:URLLoader = new URLLoader();
         bin.dataFormat = URLLoaderDataFormat.BINARY;
         bin.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            fscommand("exec",file);
            quitAt = Ticks + 40;
            confirmText.setText("STARTING THE UPDATER...");
         });
         bin.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
            confirmText.setText("THE UPDATER IS MISSING (FSCOMMAND FOLDER).");
         });
         try
         {
            bin.load(new URLRequest("fscommand/" + file));
         }
         catch(e:Error)
         {
            confirmText.setText("THE UPDATER IS MISSING (FSCOMMAND FOLDER).");
         }
      }
      
      public static function setMusic() : void
      {
         GameSoundScene.forName("Main").setBackgroundMusic(Sounds.menuTrack,0);
      }
      
      public static function addNormalStyledButton(param1:GameScene, param2:String, param3:Class = null, param4:Class = null, param5:String = "", param6:int = -999, param7:Boolean = true) : GameObject
      {
         var _loc10_:GameObject = null;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:TextFormat = null;
         if(param3 == null)
         {
            param3 = Embeds.menu_button_png;
         }
         if(param4 == null)
         {
            param4 = Embeds.menu_button_over_png;
         }
         var _loc8_:GameObject = new GameObject(param1,SimpleButton,"TextLayer",0,0);
         _loc8_.overGlow = 0.4;
         _loc8_.selectGlow = 0.4;
         _loc8_.buttonTextOffsetX = -35 - 25;
         if(param6 > -500)
         {
            _loc8_.buttonTextOffsetX = param6;
         }
         _loc8_.defaultCol = 16755200;
         _loc8_.fontName = "SFC";
         var _loc9_:int = 16766499;
         _loc8_.setupButton(param3,param2,param4,false,param7);
         for each(_loc10_ in _loc8_.children)
         {
            _loc11_ = 0;
            while(_loc11_ <= param2.length - 1)
            {
               _loc12_ = param2.substr(_loc11_,1);
               if(String(int(_loc12_)) == _loc12_)
               {
                  _loc13_ = TextField(_loc10_.obj).defaultTextFormat;
                  _loc13_.color = _loc9_;
                  TextField(_loc10_.obj).setTextFormat(_loc13_,_loc11_,_loc11_ + 1);
               }
               _loc11_++;
            }
            _loc10_.baseHandleX = 0;
         }
         _loc8_.baseWidth = _loc8_.obj.width;
         _loc8_.baseHeight = _loc8_.obj.height;
         if(param5 != "")
         {
            _loc8_.name = param5;
         }
         if(param4 != null)
         {
            _loc8_.showButtonOnOutline = true;
         }
         return _loc8_;
      }
      
      public static function writePrefs() : void
      {
         StoreObject.storeValue("musicpref",musicEnabled);
         StoreObject.storeValue("soundpref",soundEnabled);
         StoreObject.storeValue("lodpref",levelOfDetail);
      }
      
      public static function createNormalText(param1:GameScene, param2:String, param3:int = 16) : GameObject
      {
         var _loc4_:GameObject = new GameObject(param1,null,"TextLayer",0,0);
         _loc4_.defaultCol = 16755200;
         _loc4_.fontName = "SFC";
         _loc4_.setText(param2,param3);
         return _loc4_;
      }
      
      public static function readPrefs() : void
      {
         if(StoreObject.retrieveValue("musicpref") != null)
         {
            musicEnabled = Boolean(StoreObject.retrieveValue("musicpref"));
         }
         if(StoreObject.retrieveValue("soundpref") != null)
         {
            soundEnabled = Boolean(StoreObject.retrieveValue("soundpref"));
         }
         if(StoreObject.retrieveValue("lodpref") != null)
         {
            levelOfDetail = Boolean(StoreObject.retrieveValue("lodpref"));
         }
      }
      
      public function enterName() : Array
      {
         var _loc2_:GameObject = null;
         var _loc1_:GameObject = new GameObject(this,null,"TextLayer",0,0);
         _loc1_.setText("ENTER YOUR NAME:",-1,16755200);
         _loc2_ = new GameObject(this,null,"TextLayer",0,0);
         _loc2_.setText(" ",-1,16755200);
         _loc2_.setupTextInput(12);
         var _loc3_:GameObject = addButton("CONTINUE");
         var _loc4_:Array = [_loc1_,_loc2_,_loc3_];
         TextField(_loc2_.obj).text = "";
         _loc2_.obj.width = 300;
         _loc2_.obj.height = 45;
         _loc2_.basex -= 150;
         vert([vert([_loc1_,_loc2_],0),_loc3_],40,400,300);
         enterNameOK = _loc3_;
         enterNameInput = _loc2_;
         LayerFilter.applySlideIn(_loc4_,1,0,-600);
         return _loc4_;
      }
      
      // Online co-op: type the host's join code (shown in the host's pause menu).
      public function joinOnline() : Array
      {
         var title:GameObject = new GameObject(this,null,"TextLayer",0,0);
         title.setText("ENTER THE HOST'S JOIN CODE:",-1,16755200);
         var input:GameObject = new GameObject(this,null,"TextLayer",0,0);
         input.setText(" ",-1,16755200);
         input.setupTextInput(8);
         TextField(input.obj).text = "";
         TextField(input.obj).restrict = "A-Za-z0-9";
         input.obj.width = 300;
         input.obj.height = 45;
         input.basex -= 150;
         var connectButton:GameObject = addButton("CONNECT");
         var back:GameObject = addButton("BACK");
         joinStatusShown = joinStatusLine();
         var st:GameObject = createNormalText(this,joinStatusShown,16);
         var all:Array = [title,input,connectButton,back,st];
         vert([vert([title,input],0),connectButton,back,st],20,400,300);
         joinInput = input;
         joinStatus = st;
         LayerFilter.applySlideIn(all,1,0,-600);
         return all;
      }

      public function joinStatusLine() : String
      {
         return Net.mode != 1 && Net.status.length > 0 ? Net.status : "THE HOST SEES THE CODE IN THEIR PAUSE MENU";
      }

      public function flushhelp() : Array
      {
         var _loc1_:GameObject = new GameObject(this,Embeds.settings_panel_png,"TextLayer",400,300);
         var _loc2_:GameObject = addButton("BACK",Embeds.settings_button_png,Embeds.settings_button_png);
         _loc2_.basey = 482;
         _loc2_.basex = 400;
         _loc2_.stripText();
         LayerFilter.applySlideIn([_loc1_,_loc2_],0,0,-700);
         return [_loc1_,_loc2_];
      }
      
      public function startButtons() : Array
      {
         var _loc9_:GameObject = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = int(Profile.current.lookup("currentmission"));
         var _loc3_:int = 0;
         while(_loc3_ <= 11)
         {
            _loc1_[_loc3_] = addButton("MISSION " + String(_loc3_ + 1));
            _loc1_[_loc3_].changeZOrder("AfterTextLayer");
            _loc1_[_loc3_].children[0].changeZOrder("AfterTextLayer");
            if(_loc3_ > _loc2_ && !unlockAllEpisodes)
            {
               _loc9_ = _loc1_[_loc3_];
               _loc9_.disableButton(true);
            }
            _loc3_++;
         }
         var _loc4_:Array = [getEpisode(_loc1_,1,0,4),getEpisode(_loc1_,2,4,8),getEpisode(_loc1_,3,8,12)];
         var _loc5_:Layout = horiz(_loc4_,32);
         var _loc6_:GameObject = addButton("BACK");
         var _loc7_:GameObject = txt("SELECT A MISSION",32);
         _loc7_.helper.addBacking();
         _loc7_.vars["backing"].baseAlpha = 0.6;
         var _loc8_:Layout = vert([_loc7_,_loc5_,_loc6_],-2,400,globalMenuY + 10 + 3);
         _loc1_.push(_loc6_);
         LayerFilter.applySlideIn(_loc4_[0],-1);
         LayerFilter.applySlideIn(_loc4_[1],1);
         LayerFilter.applySlideIn(_loc4_[2],1);
         LayerFilter.applySlideIn(_loc6_,-1);
         LayerFilter.applySlideIn(_loc7_,-1);
         return _loc8_.getGameObjects();
      }
      
      public function mainButtons() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(addButton("START"));
         _loc1_.push(addButton("JOIN ONLINE"));
         _loc1_.push(addButton("UPDATES"));
         _loc1_.push(addButton("OPTIONS"));
         _loc1_.push(addButton("CREDITS"));
         vert(_loc1_,8,400,300);
         LayerFilter.applySlideIn(_loc1_);
         return _loc1_;
      }
      
      override public function _register(param1:Sprite) : void
      {
         var _loc3_:GameObject = null;
         var _loc2_:MainMenu_constructor = new MainMenu_constructor();
         _loc2_.register(this,param1,true);
         for each(_loc3_ in objects)
         {
            effects.push(_loc3_);
         }
      }
      
      public function addButton(param1:String, param2:Class = null, param3:Class = null, param4:String = "", param5:Boolean = true) : GameObject
      {
         return addNormalStyledButton(this,param1,param2,param3,param4,-999,param5);
      }
      
      public function getEpisode(param1:Array, param2:int, param3:int, param4:int) : Layout
      {
         var _loc6_:Array = null;
         var _loc7_:GameObject = null;
         var _loc5_:int = int(Profile.current.lookup("currentmission"));
         _loc6_ = param1.slice(param3,param4);
         if(_loc6_.length < 4)
         {
            _loc7_ = new GameObject(this,null,"AfterTextLayer",0,0);
            _loc7_.baseHeight = _loc6_[0].baseHeight;
            _loc6_.push(_loc7_);
         }
         _loc7_ = _loc6_[0];
         var _loc8_:GameObject = new GameObject(null,[Embeds.episode_1_png,Embeds.episode_2_png,Embeds.episode_3_png][param2 - 1],"AfterTextLayer",0,0);
         _loc8_.baseHeight = 110;
         return vert([_loc8_,vert(_loc6_)]);
      }
      
      public function nothing() : Array
      {
         return [];
      }
      
      public function destroyProfile(param1:int) : void
      {
         Profile.getProfile(param1).setCurrent();
         Profile.defStoreArray("playerWeapons",[]);
         Profile.defStoreArray("playerInventory",[]);
         Profile.defStoreArray("playerItems",[]);
         Profile.defStore("expediateddrop","");
         Profile.defStore("level","");
         Profile.defStore("experience","");
         Profile.defStore("cash","");
         Profile.defStore("totalkills","");
         Profile.defStore("teleporthelp","");
         Profile.defStore("maphelp","");
         Profile.defStore("shophelp","");
         Profile.defStore("inventoryhelp","");
         Profile.defStore("chargehelp","");
         Profile.defStore("activehelp","");
         Profile.getProfile(param1).destroy();
      }
      
      override public function init() : void
      {
         layer = new GUILayer();
         layer.push(mainButtons);
         reglayer = new GUILayer();
         reglayer.push(registrationButtons);
         if(popUpNag)
         {
            pushPremiumContentPanel();
         }
      }
      
      public function creditBlock(param1:String, param2:String) : Layout
      {
         return LayoutOverhang.Horiz([txt(param1 + ":",32),txt("",32),txt(param2,32)],0,500,180);
      }
      
      public function selectButton(param1:String, param2:Array, param3:Boolean) : Boolean
      {
         var _loc4_:GameObject = findObjectByName(param1 + param2[0]);
         var _loc5_:GameObject = findObjectByName(param1 + param2[1]);
         if(Boolean(_loc4_) && Boolean(_loc5_))
         {
            if(_loc4_.mHit())
            {
               param3 = false;
               changed = true;
            }
            if(_loc5_.mHit())
            {
               param3 = true;
               changed = true;
            }
            _loc4_.setButtonOn(!param3);
            _loc5_.setButtonOn(param3);
         }
         return param3;
      }
      
      public function registrationButtons() : Array
      {
         var _loc1_:PremiumContentNotifier = new PremiumContentNotifier(this,Embeds.item_description_small_png,"AfterTextLayer",700,500);
         _loc1_.layer = layer;
         _loc1_.reglayer = reglayer;
         return [_loc1_];
      }
      
      public function credits() : Array
      {
         var _loc1_:Layout = vert([txt("CREDITS",48),creditBlock("PROGRAMMING","MICHAEL REITZENSTEIN"),creditBlock("GRAPHICS AND SFX","ROD SMITH"),creditBlock("LEVEL DESIGN","ANDY WILTSHIRE"),creditBlock("ADDITIONAL GRAPHICS","PAUL GREASLEY"),addButton("BACK")],16,400,globalMenuY);
         LayerFilter.applySlideIn(_loc1_);
         return _loc1_.getGameObjects();
      }
      
      public function pushPremiumContentPanel() : void
      {
         var _loc1_:GameObject = null;
         layer.push(nothing);
         reglayer.push(PremiumContentPanel.create);
         for each(_loc1_ in objects)
         {
            if(_loc1_ is PremiumContentPanel)
            {
               PremiumContentPanel(_loc1_).layer = layer;
               PremiumContentPanel(_loc1_).reglayer = reglayer;
            }
         }
      }
      
      public function anyProfilesExist() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            if(Profile.getProfile(_loc1_).exists())
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function options() : Array
      {
         var _loc1_:Layout = makeLayout("Music",["Off","On"],"Music",1);
         var _loc2_:Layout = makeLayout("Sound",["Off","On"],"Sound",-1);
         var _loc3_:Layout = makeLayout("Level of Detail",["Low","High"],"LOD",1);
         var _loc4_:GameObject = addButton("BACK");
         var _loc5_:Layout = vert([_loc1_,_loc2_,_loc3_,_loc4_],8,400,globalMenuY);
         LayerFilter.applySlideIn(_loc4_,-1);
         return _loc5_.getGameObjects();
      }
      
      public function chooseProfileButtons() : Array
      {
         var _loc8_:Object = null;
         var _loc9_:GameObject = null;
         var _loc10_:GameObject = null;
         var _loc11_:Profile = null;
         var _loc12_:int = 0;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < 5)
         {
            _loc9_ = addButton("PROFILE" + _loc4_);
            _loc10_ = addButton("DELETE" + _loc4_);
            _loc10_.setButtonText("DELETE");
            _loc11_ = Profile.getProfile(_loc4_);
            _loc12_ = int(String(_loc11_.lookup("level"))) + 1;
            if(_loc11_.exists())
            {
               _loc3_ = true;
               _loc9_.setButtonText(String(_loc11_.lookup("name")),22);
            }
            else
            {
               _loc10_.hide();
               _loc9_.setButtonText("(EMPTY SLOT)",22);
            }
            _loc2_.push(_loc10_);
            _loc1_.push(_loc9_);
            _loc4_++;
         }
         var _loc5_:Layout = vert(_loc1_,8,200,globalMenuY);
         var _loc6_:Layout = vert(_loc2_,8,200,globalMenuY);
         var _loc7_:GameObject = addButton("BACK");
         if(_loc3_)
         {
            _loc8_ = horiz([_loc5_,_loc6_],16);
         }
         else
         {
            _loc8_ = _loc5_;
         }
         vert([_loc8_,_loc7_],32,400,globalMenuY);
         _loc1_.push(_loc7_);
         for each(_loc9_ in _loc2_)
         {
            _loc1_.push(_loc9_);
         }
         if(_loc3_)
         {
            LayerFilter.applySlideIn(_loc5_,-1);
            LayerFilter.applySlideIn(_loc6_,1);
            LayerFilter.applySlideIn(_loc7_,0,0,400);
         }
         else
         {
            LayerFilter.applySlideIn(_loc1_);
         }
         return _loc1_;
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:int = 0;
         var _loc4_:MainScene = null;
         var _loc5_:String = null;
         if(Ticks == 100)
         {
            StoreObject.testStorage();
         }
         changed = false;
         musicEnabled = selectButton("Music",["Off","On"],musicEnabled);
         soundEnabled = selectButton("Sound",["Off","On"],soundEnabled);
         levelOfDetail = selectButton("LOD",["Low","High"],levelOfDetail);
         GameSound.globalMusicVolume = musicEnabled ? 1 : 0;
         GameSound.globalSoundVolume = soundEnabled ? 1 : 0;
         var _loc1_:Stage = m.stage;
         if(MainMenu.levelOfDetail)
         {
            _loc1_.quality = StageQuality.BEST;
         }
         else
         {
            _loc1_.quality = StageQuality.MEDIUM;
         }
         for each(_loc2_ in effects)
         {
            if(_loc2_.baseWidth < 600)
            {
               _loc2_.hidden = !MainMenu.levelOfDetail;
            }
         }
         if(changed)
         {
            writePrefs();
         }
         for each(_loc2_ in objects)
         {
            if(_loc2_.obj is Bitmap)
            {
               Bitmap(_loc2_.obj).smoothing = true;
            }
         }
         if(Ticks == 10)
         {
            setMusic();
         }
         for each(_loc2_ in objects)
         {
            if(_loc2_ is PremiumContentPanel)
            {
               return;
            }
         }
         if(enterNameInput)
         {
            if(!enterNameInput._removed)
            {
               if(Boolean(Input.i.keyHit(13)) || enterNameOK.mHit())
               {
                  if(TextField(enterNameInput.obj).text.length > 0)
                  {
                     enterNameInput.isInputEnterHit = false;
                     Profile.current.store("name",TextField(enterNameInput.obj).text);
                     layer.push(startButtons,true);
                     enterNameInput = null;
                  }
               }
            }
         }
         updateCheat();
         if(joinInput && !joinInput._removed)
         {
            if(Boolean(Input.i.keyHit(13)) || layer.buttonHit("CONNECT"))
            {
               Net.join(TextField(joinInput.obj).text);
            }
            if(joinStatusShown != joinStatusLine())
            {
               joinStatusShown = joinStatusLine();
               joinStatus.setText(joinStatusShown);
            }
         }
         if(layer.buttonHit("JOIN ONLINE"))
         {
            layer.push(joinOnline);
         }
         if(layer.buttonHit("UPDATES"))
         {
            layer.push(updatesScreen);
         }
         if(releaseButton && !releaseButton._removed)
         {
            refreshUpdatesScreen();
         }
         // (buttonHit only reports a click once, so read each button once.)
         var pickRelease:Boolean = layer.buttonHit("UPDATE_RELEASE");
         var pickBeta:Boolean = layer.buttonHit("UPDATE_BETA");
         if(pickRelease || pickBeta)
         {
            pendingChannel = pickBeta ? "beta" : "release";
            confirmIsUpdate = false;
            layer.push(confirmScreen);
         }
         // A newer version on the installed channel: offer it once, on the title screen.
         if(!updatePrompted && newerAvailable(channel) && layer.getButton("START"))
         {
            updatePrompted = true;
            pendingChannel = channel;
            confirmIsUpdate = true;
            layer.push(confirmScreen);
         }
         if(layer.buttonHit("UPDATE_YES") && quitAt == 0)
         {
            runUpdater(pendingChannel);
         }
         if(layer.buttonHit("UPDATE_NO"))
         {
            layer.pop();
         }
         if(quitAt > 0 && Ticks >= quitAt)
         {
            fscommand("quit");
         }
         // For testing online play: online.txt "autostart=1" jumps straight into mission 1 on the first save.
         if(Ticks == 60 && Net.config["autostart"])
         {
            Profile.getProfile(0).setCurrent();
            if(String(Profile.current.lookup("name")) == "null")
            {
               Profile.current.store("name","TEST");
            }
            _loc4_ = new MainScene();
            _loc4_.currentEpisode = 0;
            pushScene(_loc4_,true);
            return;
         }
         if(layer.buttonHit("CREDITS"))
         {
            layer.push(credits);
         }
         if(layer.buttonHit("OPTIONS"))
         {
            layer.push(options);
         }
         if(layer.buttonHit("START"))
         {
            Profile.initProfiles("RobokillProfiles",5);
            if(CustomPreloader.demo)
            {
               Net.openURL("http://www.rocksolidarcade.com/games/robokill2/");
            }
            else if(!StoreObject.couldFlush())
            {
               layer.push(flushhelp);
            }
            else if(anyProfilesExist())
            {
               layer.push(chooseProfileButtons);
            }
            else
            {
               Profile.getProfile(0).setCurrent();
               layer.push(enterName);
            }
         }
         if(layer.buttonHit("BACK"))
         {
            layer.pop();
         }
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            if(layer.buttonHit("MISSION " + (_loc3_ + 1)))
            {
               if(_loc3_ >= 4 && !PremiumContentNotifier.registered)
               {
                  pushPremiumContentPanel();
               }
               else
               {
                  _loc4_ = new MainScene();
                  _loc4_.currentEpisode = _loc3_;
                  pushScene(_loc4_,true);
               }
            }
            _loc3_++;
         }
         if(layer.buttonHit("YesDelete"))
         {
            destroyProfile(profileToDelete);
            layer.pop();
         }
         if(layer.buttonHit("NoDelete"))
         {
            layer.pop();
         }
         if(layer.buttonHit("ENDING"))
         {
            pushScene(new End(),true);
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(layer.buttonHit("PROFILE" + _loc3_))
            {
               Profile.getProfile(_loc3_).setCurrent();
               _loc5_ = String(Profile.current.lookup("name"));
               if(_loc5_ == "null" || _loc5_.length == 0)
               {
                  trace("enterName");
                  layer.push(enterName);
               }
               else
               {
                  layer.push(startButtons);
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(layer.buttonHit("DELETE" + _loc3_))
            {
               Profile.getProfile(_loc3_).setCurrent();
               profileToDelete = _loc3_;
               profileToDeleteName = String(Profile.current.lookup("name"));
               layer.push(deleteAreYouSure);
            }
            _loc3_++;
         }
      }
      
      // The mission select screen is only reachable with a save selected, so the cheat only changes that save.
      public function updateCheat() : void
      {
         var _loc1_:int = -1;
         var _loc2_:int = 37;
         while(_loc2_ <= 40)
         {
            if(Input.i.keyHit(_loc2_))
            {
               _loc1_ = _loc2_;
            }
            _loc2_++;
         }
         if(layer.getButton("MISSION 1") == null)
         {
            cheatProgress = 0;
            return;
         }
         if(_loc1_ < 0)
         {
            return;
         }
         if(_loc1_ == CHEAT_CODE[cheatProgress])
         {
            ++cheatProgress;
         }
         else
         {
            cheatProgress = _loc1_ == CHEAT_CODE[0] ? 1 : 0;
         }
         if(cheatProgress == CHEAT_CODE.length)
         {
            cheatProgress = 0;
            Profile.current.store("currentmission",11);
            Profile.current.store("cash",int(Profile.current.lookup("cash")) + 1000000);
            // The game has no level cap; the best gear needs level 44. Stored levels are shown +1, so this is level 50.
            if(int(Profile.current.lookup("level")) < CHEAT_LEVEL)
            {
               Profile.current.store("level",CHEAT_LEVEL);
               Profile.current.store("experience",0);
            }
            Sounds.doorUnlock.play();
            layer.push(startButtons,true);
         }
      }

      public function deleteAreYouSure() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:GameObject = txt("ARE YOU SURE YOU WANT TO DELETE THIS PROFILE?",36);
         var _loc3_:GameObject = txt("\"" + profileToDeleteName + "\"",36);
         var _loc4_:GameObject = addButton("YES",null,null,"YesDelete");
         var _loc5_:GameObject = addButton("NO",null,null,"NoDelete");
         vert([_loc2_,_loc3_,horiz([_loc4_,_loc5_],48)],0,400,globalMenuY);
         _loc1_.push(_loc2_);
         _loc1_.push(_loc3_);
         _loc1_.push(_loc4_);
         _loc1_.push(_loc5_);
         LayerFilter.applySlideIn(_loc2_,-1);
         LayerFilter.applySlideIn(_loc3_,1);
         LayerFilter.applySlideIn(_loc4_,-1);
         LayerFilter.applySlideIn(_loc5_,1);
         return _loc1_;
      }
      
      public function storageWarning() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(txt("WARNING: FLASH STORAGE  IS DISABLED",24));
         _loc1_.push(txt("PLAYER PROFILES WILL NOT BE STORED UNLESS YOU ENABLE LOCAL STORAGE IN FLASH PROPERTIES"));
         _loc1_.push(addButton("OK",null,null,"OKStorage"));
         vert(_loc1_);
         LayerFilter.applySlideIn(_loc1_,1,0,-600);
         return _loc1_;
      }
      
      public function makeLayout(param1:String, param2:Array, param3:String, param4:int = 0) : Layout
      {
         var _loc7_:String = null;
         var _loc8_:Layout = null;
         var _loc9_:Layout = null;
         var _loc5_:GameObject = txt(param1,32);
         var _loc6_:Array = new Array();
         for each(_loc7_ in param2)
         {
            _loc6_.push(addButton(_loc7_,null,null,param3 + _loc7_,false));
         }
         _loc8_ = horiz(_loc6_);
         _loc9_ = vert([_loc5_,_loc8_]);
         LayerFilter.applySlideIn(_loc9_,param4);
         return _loc9_;
      }
      
      public function txt(param1:String, param2:int = 16) : GameObject
      {
         return createNormalText(this,param1,param2);
      }
   }
}

