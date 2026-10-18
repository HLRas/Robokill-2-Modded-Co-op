package Objects
{
   import GameScene.GameScene;
   import ObjectBase.LegsBase;
   import ObjectConstructors.BruteLegs_constructor;
   
   public class BruteLegs extends LegsBase
   {
      
      public function BruteLegs(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BruteLegs_constructor.baseim_embed,BruteLegs_constructor.LayerName,param2,param3);
         BruteLegs_constructor.setup(param1,this);
      }
   }
}

