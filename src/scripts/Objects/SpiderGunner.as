package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SpiderGunnerBase;
   import ObjectConstructors.SpiderGunner_constructor;
   
   public class SpiderGunner extends SpiderGunnerBase
   {
      
      public function SpiderGunner(param1:GameScene, param2:int, param3:int)
      {
         super(param1,SpiderGunner_constructor.baseim_embed,SpiderGunner_constructor.LayerName,param2,param3);
         SpiderGunner_constructor.setup(param1,this);
      }
   }
}

