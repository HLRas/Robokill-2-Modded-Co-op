package GameObject
{
   import Tools.Random;
   
   public class GameObjectFilterBlink extends GameObjectFilter
   {
      
      public var BlinkAlpha:Number = 0;
      
      public var dead:Boolean = false;
      
      public var Interval:int = 100;
      
      public var AliveTime:int = 0;
      
      public function GameObjectFilterBlink()
      {
         super();
         ticks = Random.randInt(0,100);
      }
      
      override public function update(param1:GameObject) : void
      {
         if(dead)
         {
            return;
         }
         ++ticks;
         if(ticks % Interval > Interval / 2)
         {
            param1.modifiedAlpha *= BlinkAlpha;
         }
         if(AliveTime > 0 && ticks > AliveTime)
         {
            dead = true;
         }
      }
   }
}

