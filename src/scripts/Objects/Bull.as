package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BullBase;
   import ObjectConstructors.Bull_constructor;
   
   public class Bull extends BullBase
   {
      
      public function Bull(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Bull_constructor.baseim_embed,Bull_constructor.LayerName,param2,param3);
         Bull_constructor.setup(param1,this);
      }
      
      override public function _experience() : int
      {
         return 200;
      }
   }
}

