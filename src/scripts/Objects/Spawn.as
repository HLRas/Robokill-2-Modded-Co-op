package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SpawnBase;
   import ObjectConstructors.Spawn_constructor;
   
   public class Spawn extends SpawnBase
   {
      
      public function Spawn(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Spawn_constructor.baseim_embed,Spawn_constructor.LayerName,param2,param3);
         Spawn_constructor.setup(param1,this);
      }
   }
}

