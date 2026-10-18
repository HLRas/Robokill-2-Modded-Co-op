package Objects
{
   import GameScene.GameScene;
   import ObjectBase.PlayerBase;
   import ObjectConstructors.Player_constructor;
   
   public class Player extends PlayerBase
   {
      
      public function Player(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Player_constructor.baseim_embed,Player_constructor.LayerName,param2,param3);
         Player_constructor.setup(param1,this);
      }
   }
}

