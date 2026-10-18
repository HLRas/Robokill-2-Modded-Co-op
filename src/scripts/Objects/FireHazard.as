package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HazardBase;
   import ObjectConstructors.FireHazard_constructor;
   
   public class FireHazard extends HazardBase
   {
      
      public function FireHazard(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,FireHazard_constructor.baseim_embed,FireHazard_constructor.LayerName,param2,param3);
         FireHazard_constructor.setup(param1,this);
      }
   }
}

