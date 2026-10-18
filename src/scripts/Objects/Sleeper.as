package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SleeperBase;
   import ObjectConstructors.Sleeper_constructor;
   
   public class Sleeper extends SleeperBase
   {
      
      public function Sleeper(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Sleeper_constructor.baseim_embed,Sleeper_constructor.LayerName,param2,param3);
         Sleeper_constructor.setup(param1,this);
      }
   }
}

