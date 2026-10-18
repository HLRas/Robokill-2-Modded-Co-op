package Objects
{
   import GameScene.GameScene;
   import ObjectBase.CashBase;
   import ObjectConstructors.Cash_constructor;
   
   public class Cash extends CashBase
   {
      
      public function Cash(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Cash_constructor.baseim_embed,Cash_constructor.LayerName,param2,param3);
         Cash_constructor.setup(param1,this);
         pushable = false;
      }
   }
}

