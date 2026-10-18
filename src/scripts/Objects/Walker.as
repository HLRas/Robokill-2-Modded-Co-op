package Objects
{
   import GameScene.GameScene;
   import ObjectBase.WalkerBase;
   import ObjectConstructors.Walker_constructor;
   
   public class Walker extends WalkerBase
   {
      
      public function Walker(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Walker_constructor.baseim_embed,Walker_constructor.LayerName,param2,param3);
         Walker_constructor.setup(param1,this);
      }
   }
}

