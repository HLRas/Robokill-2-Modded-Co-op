package Audio
{
   import Tools.Interpolation;
   import flash.utils.getTimer;
   
   public class GameSoundScene
   {
      
      public static var allScenes:Array = new Array();
      
      public var breakLoop:GameSound;
      
      public var breakLoopChannel:GameSoundChannel;
      
      public var permanentBreakCurrent:int = 0;
      
      public var volumeTarget:Number = 1;
      
      public var mainLoopChannel:GameSoundChannel;
      
      public var mainLoopStopped:Number = 0;
      
      public var restartTime:Number;
      
      public var permanentBreakTime:int = 0;
      
      public var permanentBreak:Boolean = false;
      
      public var currentVolume:Number = 1;
      
      public var sceneName:String;
      
      public var deadBreak:Boolean = false;
      
      public var mainLoop:GameSound;
      
      public function GameSoundScene(param1:String)
      {
         super();
         sceneName = param1;
         allScenes.push(this);
      }
      
      public static function forName(param1:String) : GameSoundScene
      {
         var _loc2_:GameSoundScene = null;
         for each(_loc2_ in allScenes)
         {
            if(_loc2_.sceneName == param1)
            {
               return _loc2_;
            }
         }
         return new GameSoundScene(param1);
      }
      
      public static function updateAll() : void
      {
         var _loc1_:GameSoundScene = null;
         GameSoundChannel.updateAll();
         for each(_loc1_ in allScenes)
         {
            _loc1_.update();
         }
      }
      
      public function update() : void
      {
         currentVolume = Interpolation.tendTowards(currentVolume,volumeTarget,0.01);
         if(mainLoopChannel)
         {
            if(mainLoopChannel.playing())
            {
               if(currentVolume != volumeTarget)
               {
                  mainLoopChannel.setVolume(currentVolume);
               }
            }
         }
         if(breakLoopChannel)
         {
            if(!breakLoopChannel.playing())
            {
               breakLoopChannel.stop();
               breakLoopChannel = null;
               mainLoopChannel.stop();
               mainLoopChannel = mainLoop.play(true,mainLoopStopped,500);
               mainLoopStopped = 0;
            }
         }
         if(deadBreak)
         {
            if(getTimer() > restartTime)
            {
               deadBreak = false;
               mainLoopChannel.stop();
               mainLoopChannel = mainLoop.play(true,mainLoopStopped,500);
               mainLoopStopped = 0;
            }
         }
         if(permanentBreak)
         {
            if(mainLoopChannel != null)
            {
               if(!mainLoopChannel.playing())
               {
                  ++permanentBreakCurrent;
                  if(permanentBreakCurrent > permanentBreakTime)
                  {
                     permanentBreakCurrent = 0;
                     mainLoopChannel = mainLoop.play(false,0,500);
                  }
               }
            }
         }
      }
      
      public function insertDeadBreak(param1:Number) : void
      {
         mainLoopStopped = mainLoopChannel.position();
         mainLoopChannel.stop(2000);
         deadBreak = true;
         restartTime = getTimer() + param1;
      }
      
      public function setPermanentBreak(param1:int) : void
      {
         permanentBreak = true;
         permanentBreakTime = param1;
      }
      
      public function setBackgroundMusic(param1:GameSound, param2:int = 500) : void
      {
         if(mainLoop)
         {
            if(mainLoop == param1)
            {
               return;
            }
         }
         if(mainLoop)
         {
            if(mainLoopChannel)
            {
               mainLoopChannel.stop(param2);
            }
         }
         mainLoop = param1;
         param1.isMusic = true;
         volumeTarget = 1;
         mainLoopChannel = param1.play(!permanentBreak,0,param2);
      }
      
      public function queueBackgroundMusic(param1:GameSound) : void
      {
         mainLoop = param1;
      }
      
      public function insertBreak(param1:GameSound) : void
      {
         param1.isMusic = true;
         mainLoopStopped = mainLoopChannel.position();
         mainLoopChannel.stop(500);
         breakLoop = param1;
         breakLoopChannel = param1.play();
         deadBreak = false;
      }
   }
}

