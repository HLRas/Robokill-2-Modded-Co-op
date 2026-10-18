package Objects
{
   import GameScene.GameScene;
   import ObjectBase.RespawnPointBase;
   import ObjectConstructors.RespawnPoint_constructor;
   
   public class RespawnPoint extends RespawnPointBase
   {
      
      public function RespawnPoint(param1:GameScene, param2:int, param3:int)
      {
         super(param1,RespawnPoint_constructor.baseim_embed,RespawnPoint_constructor.LayerName,param2,param3);
         RespawnPoint_constructor.setup(param1,this);
      }
   }
}

