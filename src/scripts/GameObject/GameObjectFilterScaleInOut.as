package GameObject
{
   import Tools.Interpolation;
   
   public class GameObjectFilterScaleInOut extends GameObjectFilter
   {
      
      public var ScaleOutEndX:Number = 0;
      
      public var ScaleOut:int = 0;
      
      public var ScaleInStartX:Number = 1;
      
      public var ScaleOutEndY:Number = 0;
      
      public var ScaleInStartY:Number = 1;
      
      public var ScaleInDelay:Number = 0;
      
      public var ScaleInDuration:Number = 0;
      
      public var paused:Boolean = false;
      
      public var ScaleIn:int = 0;
      
      public var ScaleOutTime:Number = 0;
      
      public var ScaleOutDuration:Number = 0;
      
      public function GameObjectFilterScaleInOut()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         if(!paused)
         {
            ticks += 1;
         }
         var _loc2_:Number = 1;
         var _loc3_:Number = 1;
         if(ScaleIn)
         {
            _loc2_ *= Interpolation.linearInterpolateLock(ScaleInStartX,1,Interpolation.fromTo(ticks,ScaleInDelay,ScaleInDelay + ScaleInDuration));
            _loc3_ *= Interpolation.linearInterpolateLock(ScaleInStartY,1,Interpolation.fromTo(ticks,ScaleInDelay,ScaleInDelay + ScaleInDuration));
         }
         if(ScaleOut)
         {
            _loc2_ *= Interpolation.linearInterpolateLock(1,ScaleOutEndX,Interpolation.fromTo(ticks,ScaleOutTime,ScaleOutTime + ScaleOutDuration));
            _loc3_ *= Interpolation.linearInterpolateLock(1,ScaleOutEndY,Interpolation.fromTo(ticks,ScaleOutTime,ScaleOutTime + ScaleOutDuration));
         }
         param1.pushScale(_loc2_,_loc3_);
      }
      
      public function pause() : void
      {
         paused = true;
      }
   }
}

