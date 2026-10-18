package ObjectBase
{
   import GameScene.GameScene;
   
   public class PulseBase extends IdiotLightBase
   {
      
      public function PulseBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function _update() : void
      {
         super._update();
         baseAlpha *= (1 + sind(randTicks * 2)) / 2;
      }
   }
}

