package Tools
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GameTimer
   {
      
      private var ticker:Timer;
      
      private var func:Function;
      
      public function GameTimer(param1:int, param2:Function)
      {
         super();
         ticker = new Timer(param1);
         ticker.addEventListener(TimerEvent.TIMER,onTick);
         func = param2;
         ticker.start();
      }
      
      internal function onTick(param1:TimerEvent) : void
      {
         func();
      }
   }
}

