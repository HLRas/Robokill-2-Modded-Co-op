package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SwarmBase;
   import ObjectConstructors.LargeCritter_constructor;
   
   public class LargeCritter extends SwarmBase
   {
      
      public var killed:Boolean = false;
      
      public function LargeCritter(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,LargeCritter_constructor.baseim_embed,LargeCritter_constructor.LayerName,param2,param3);
         LargeCritter_constructor.setup(param1,this);
         baseHealth *= 8;
         extraHealth *= 8;
         baseSpeed *= 1.25;
         dist *= 3;
      }
      
      override public function _experience() : int
      {
         return 50;
      }
      
      override public function preKill() : void
      {
         var _loc2_:Critter = null;
         if(killed)
         {
            return;
         }
         killed = true;
         super.preKill();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = Critter(spawn(Critter,basex + (Math.random() - 0.5) * 10,basey + (Math.random() - 0.5) * 10,toughness));
            if(_loc2_)
            {
               _loc2_.baseRotation = Math.random() * 360;
            }
            _loc1_++;
         }
      }
   }
}

