package Objects
{
   import GameScene.GameScene;
   import ObjectConstructors.MinigunBrute_constructor;
   
   public class MinigunBrute extends Brute
   {
      
      public function MinigunBrute(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         MinigunBrute_constructor.setup(param1,this);
         hasMinigun = true;
         baseHealth *= 10;
         extraHealth *= 6;
      }
      
      override public function _experience() : int
      {
         return 200;
      }
   }
}

