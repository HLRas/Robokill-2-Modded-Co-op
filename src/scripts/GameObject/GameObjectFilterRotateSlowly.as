package GameObject
{
   import Tools.Interpolation;
   
   public class GameObjectFilterRotateSlowly extends GameObjectFilter
   {
      
      public var rotSpeed:Number = 1;
      
      public var paused:Boolean = false;
      
      public var internalRotationSet:Boolean = false;
      
      public var internalRotation:Number = 0;
      
      public function GameObjectFilterRotateSlowly(param1:Number = 1)
      {
         super();
         rotSpeed = param1;
      }
      
      override public function update(param1:GameObject) : void
      {
         if(!internalRotationSet)
         {
            internalRotation = param1.baseRotation;
            internalRotationSet = true;
         }
         if(!paused)
         {
            internalRotation = Interpolation.tendTowardsAngle(internalRotation,param1.baseRotation,rotSpeed);
         }
         param1.modifiedRotation = internalRotation;
      }
   }
}

