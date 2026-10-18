package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SpiderBase;
   import ObjectConstructors.Spider_constructor;
   
   public class Spider extends SpiderBase
   {
      
      public function Spider(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Spider_constructor.baseim_embed,Spider_constructor.LayerName,param2,param3);
         Spider_constructor.setup(param1,this);
      }
   }
}

