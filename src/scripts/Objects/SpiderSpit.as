package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SpiderSpitBase;
   import ObjectConstructors.SpiderSpit_constructor;
   
   public class SpiderSpit extends SpiderSpitBase
   {
      
      public function SpiderSpit(param1:GameScene, param2:int, param3:int)
      {
         super(param1,SpiderSpit_constructor.baseim_embed,SpiderSpit_constructor.LayerName,param2,param3);
         SpiderSpit_constructor.setup(param1,this);
      }
      
      override public function _experience() : int
      {
         return 100;
      }
   }
}

