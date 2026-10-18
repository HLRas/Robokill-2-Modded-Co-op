package Objects
{
   import Audio.GameSoundChannel;
   import Audio.GameSoundScene;
   import GameObject.GameObject;
   import GameObject.GameObjectFilter;
   import GameObject.GameObjectFilterFadeInOut;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectConstructors.CommWindow_constructor;
   import PremiumContent.PremiumContentNotifier;
   import Scenes.End;
   import Scenes.MainMenu;
   import Scenes.MainScene;
   import Tools.Logging;
   import flash.display.SimpleButton;
   
   public class CommWindow extends GameObject
   {
      
      public var text:GameObject;
      
      public var displayText:String = "THE MAIN LIFT IS OFFLINE.     \nTRY AND FIND A SERVICE LIFT TO DECK 1.         \nGOOD LUCK.";
      
      public var killButton:GameObject;
      
      public var finishLevel:Boolean = false;
      
      public var chan:GameSoundChannel;
      
      public var displayTextOptions:Array = ["LEVIATHAN FIVE COMMS ARE DOWN BUT I\'M PICKING UP MULTIPLE LIFEFORMS \nON OUR SCANS.    SOMETHING\'S NOT RIGHT HERE. INVESTIGATE,\nAND PREPARE TO ENGAGE HOSTILES.","IT LOOKS LIKE THE HOSTILES ARE NOW ON FULL ALERT,\nEXPECT HEAVY ENEMY REINFORCMENTS.","WE HAVE NOT BEEN ABLE TO CONTACT THE LEVIATHAN FIVE ENGINEERS, \nLOCATE A TERMINAL SO WE CAN DOWNLOAD THE FACILITY LOGS.","ACCORDING TO THE FACILITY LOGS THERE ARE SECURITY TURRETS ON THE\nLOWER DECKS. THEY ARE CURRENTLY OFFLINE.\nFIND THE CONTROL COM AND POWER THEM UP.","THE SECURITY TURRETS ARE NOW ONLINE, THEY SHOULD ASSIST YOU\nTO DESTROY HOSTILES.   DO NOT ATTACK THEM OR THEY WILL RETURN FIRE.","NOW THAT THE UPPER DECKS ARE CLEAR, WE CAN START REPAIRING OUR SHIP. \nCOLLECT ANY USEFUL PARTS YOU FIND.","THE POWER IS OUT ON THE MINING DECKS BELOW,\nFIND THE BACKUP GENERATORS AND START THEM.","I\'M PICKING UP A WEAK DISTRESS SIGNAL FROM DECK NINE.\nMAKE YOUR WAY DOWN THERE AND SEE WHAT YOU CAN FIND."
      ,"LOCATE THE SOURCE OF THE DISTRESS SIGNAL AND RESCUE ANY SURVIVORS.","JUDGING FROM THE REMAINS WE\'VE SEEN HERE I DONT THINK THERE\'S MUCH \nHOPE FOR FINDING ANYONE ALIVE. \nKEEP SEARCHING WHILE WE CONTINUE SHIP REPAIRS.","THERE IS NO INFORMATION IN THE FACILITY LOGS ON THE LOWER LEVEL. \nCOLLECT ANY INTEL YOU CAN ON THE LOWER DECK LAYOUT.","SHIP REPAIRS ARE COMPLETE, FIGHT YOUR WAY TO THE MAINTENANCE LIFT. \nTHERE\'S A LOT OF HOSTILE ACTIVITY NEAR THE LIFT SO PROCEDE WITH CAUTION."];
      
      public var foreman:Foreman;
      
      public var killed:Boolean = false;
      
      public var endOfLevelText:String = "EXCELLENT. MISSION COMPLETE.";
      
      public function CommWindow(param1:GameScene, param2:int, param3:int, param4:Boolean = false)
      {
         displayText = displayTextOptions[MainScene(param1).currentEpisode];
         if(param4)
         {
            displayText = endOfLevelText;
         }
         param2 = 400;
         param3 = 120;
         super(param1,CommWindow_constructor.baseim_embed,CommWindow_constructor.LayerName,param2,param3);
         CommWindow_constructor.setup(param1,this);
         var _loc5_:GameObjectFilterFadeInOut = new GameObjectFilterFadeInOut();
         _loc5_.FadeIn = 1;
         _loc5_.FadeInDuration = 30;
         _loc5_.FadeOut = 1;
         _loc5_.FadeOutTime = 400 + displayText.length * 4;
         _loc5_.FadeOutDuration = 20;
         addFilter(_loc5_);
         updateDespitePaused = true;
         finishLevel = param4;
         killButton = new GameObject(param1,SimpleButton,"AfterTextLayer",640 - 678 + 329 - 9,145 + 10 + 4);
         killButton.setupButton(Embeds.ok_png,"Skip");
         _loc5_ = new GameObjectFilterFadeInOut();
         _loc5_.FadeIn = 1;
         _loc5_.FadeInDuration = 30;
         _loc5_.FadeOut = 1;
         _loc5_.FadeOutTime = 400 + displayText.length * 4;
         _loc5_.FadeOutDuration = 20;
         killButton.addFilter(_loc5_);
      }
      
      override public function _remove() : void
      {
         var _loc1_:GameSoundScene = null;
         killButton.remove();
         if(!finishLevel)
         {
            if(MainScene(gs).currentEpisode == 0)
            {
               Logging.Log("robokill","startgame");
               new ControlHelp(gs,180,295);
            }
         }
         if(finishLevel)
         {
            Logging.Log("robokill","finishlevel");
            if(MainScene(gs).currentEpisode == 11)
            {
               MainScene(gs).pushScene(new End(),true);
            }
            else if(MainScene(gs).currentEpisode == 3 && !PremiumContentNotifier.registered)
            {
               MainMenu.popUpNag = true;
               gs.pushScene(new MainMenu(),true);
            }
            else
            {
               MainScene(gs).fading = 1;
               MainScene(gs).fadingLevelComplete = true;
            }
         }
         else
         {
            _loc1_ = GameSoundScene.forName("Main");
            _loc1_.setBackgroundMusic(Sounds.droneBig,2000);
         }
      }
      
      override public function _init() : void
      {
         foreman = new Foreman(gs,0,0);
         addChild(foreman);
         foreman.basex = -244;
         foreman.basey = foreman.baseHeight / 2 - baseHeight / 2 + 4;
         foreman.isTalking = true;
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObjectFilterFadeInOut = null;
         var _loc1_:String = displayText;
         if(foreman)
         {
            foreman.isTalking = chan ? chan.playing() : false;
         }
         if(chan)
         {
            if(chan.playing())
            {
               if(chan.chan.leftPeak < 0.1)
               {
                  foreman.isTalking = false;
               }
            }
         }
         if(!killed)
         {
            if(ticks == 40)
            {
               text = new GameObject(gs,null,"AfterTextLayer",246,74);
               text.baseHandleX = 0;
               text.baseHandleY = 0;
               text.setText("",18);
               _loc2_ = new GameObjectFilterFadeInOut();
               _loc2_.FadeOut = 1;
               _loc2_.FadeOutTime = 400 + displayText.length * 4 - 40;
               _loc2_.FadeOutDuration = 20;
               text.addFilter(_loc2_);
               if(finishLevel)
               {
                  chan = Sounds.missionComplete.playSpecific(0);
               }
               else
               {
                  chan = Sounds.Quest.playSpecific(MainScene(gs).currentEpisode);
               }
            }
            else if(ticks > 40)
            {
               if(text)
               {
                  text.setText(_loc1_.substr(0,(ticks - 40 + 2) / 5));
               }
            }
         }
         if(killButton.mHit())
         {
            if(!killed)
            {
               killed = true;
               addFilter(killFilter());
               killButton.addFilter(killFilter());
               if(text)
               {
                  text.addFilter(killFilter());
               }
               if(chan)
               {
                  chan.stop();
                  chan = null;
               }
            }
         }
      }
      
      public function killFilter() : GameObjectFilter
      {
         var _loc1_:GameObjectFilterFadeInOut = new GameObjectFilterFadeInOut();
         _loc1_.FadeOut = 1;
         _loc1_.FadeOutTime = 0;
         _loc1_.FadeOutDuration = 20;
         _loc1_.FadeOutKill = 1;
         return _loc1_;
      }
   }
}

