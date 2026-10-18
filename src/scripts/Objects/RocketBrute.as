package Objects
{
   import GameScene.GameScene;
   import ObjectConstructors.RocketBrute_constructor;
   
   public class RocketBrute extends Brute
   {
      
      public function RocketBrute(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         RocketBrute_constructor.setup(param1,this);
         hasLauncher = true;
      }
      
      override public function _update() : void
      {
         super._update();
      }
      
      override public function _experience() : int
      {
         return 100;
      }
   }
}

