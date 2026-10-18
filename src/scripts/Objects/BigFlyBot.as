package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BigFlyBotBase;
   import ObjectConstructors.BigFlyBot_constructor;
   
   public class BigFlyBot extends BigFlyBotBase
   {
      
      public function BigFlyBot(param1:GameScene, param2:int, param3:int)
      {
         super(param1,BigFlyBot_constructor.baseim_embed,BigFlyBot_constructor.LayerName,param2,param3);
         BigFlyBot_constructor.setup(param1,this);
      }
      
      override public function canMoveOnLand() : Boolean
      {
         return true;
      }
   }
}

