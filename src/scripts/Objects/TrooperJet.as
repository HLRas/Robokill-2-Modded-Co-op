package Objects
{
   import GameScene.GameScene;
   import ObjectConstructors.TrooperJet_constructor;
   
   public class TrooperJet extends Trooper
   {
      
      public function TrooperJet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         TrooperJet_constructor.setup(param1,this);
         baseHealth *= 5;
         extraHealth *= 5;
      }
      
      override public function _update() : void
      {
         super._update();
         collidesWithWalls = !inJetpack();
         doCollisions = !inJetpack();
      }
      
      override public function _experience() : int
      {
         return 100;
      }
      
      override public function canFall() : Boolean
      {
         return !inJetpack();
      }
   }
}

