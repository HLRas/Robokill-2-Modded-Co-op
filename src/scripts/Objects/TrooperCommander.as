package Objects
{
   import GameScene.GameScene;
   import ObjectConstructors.TrooperCommander_constructor;
   
   public class TrooperCommander extends Trooper
   {
      
      public function TrooperCommander(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         extraHealth *= 10;
         baseHealth *= 10;
         TrooperCommander_constructor.setup(param1,this);
      }
      
      override public function _experience() : int
      {
         return 200;
      }
   }
}

