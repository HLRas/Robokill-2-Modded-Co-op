package Objects
{
   import GameScene.GameScene;
   import ObjectBase.LegsBase;
   import ObjectConstructors.RancorLegs_constructor;
   
   public class RancorLegs extends LegsBase
   {
      
      public function RancorLegs(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,RancorLegs_constructor.baseim_embed,RancorLegs_constructor.LayerName,param2,param3);
         RancorLegs_constructor.setup(param1,this);
      }
   }
}

