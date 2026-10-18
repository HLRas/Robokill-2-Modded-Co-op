package Objects
{
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import flash.display.*;
   
   public class SecretLiftFloor extends SecretLift
   {
      
      public function SecretLiftFloor(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         SecretLiftFloor_constructor.setup(param1,this);
         imageSet = null;
         open = true;
      }
      
      override public function getGrid() : Array
      {
         return [SecretLift.secretElevatorX,SecretLift.secretElevatorY];
      }
      
      override public function readyToBeUsed() : Boolean
      {
         return true;
      }
      
      override public function _init() : void
      {
         super._init();
         helperAnimation.setFrame(new Embeds.secret_lift_floor_png().bitmapData);
      }
   }
}

