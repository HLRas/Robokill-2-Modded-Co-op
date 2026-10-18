package GameObject
{
   public class GameObjectFilterRotate extends GameObjectFilter
   {
      
      public var startRotation:Number = Math.random() * 360;
      
      public var Speed:Number = 1;
      
      public var direction:Boolean = Math.random() < 0.5 ? true : false;
      
      public function GameObjectFilterRotate()
      {
         super();
      }
      
      override public function update(param1:GameObject) : void
      {
         startRotation += Speed;
         param1.baseRotation = startRotation;
         if(param1.baseRotation < 360 * 5000)
         {
            if(param1.baseRotation > -360 * 5000)
            {
               while(param1.baseRotation > 360)
               {
                  param1.baseRotation -= 360;
               }
               while(param1.baseRotation < -360)
               {
                  param1.baseRotation += 360;
               }
            }
         }
      }
   }
}

