package Objects
{
   import GameScene.GameScene;
   import ObjectBase.AlienBase;
   import ObjectConstructors.Foreman_constructor;
   
   public class Foreman extends AlienBase
   {
      
      public function Foreman(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Foreman_constructor.baseim_embed,Foreman_constructor.LayerName,param2,param3);
         Foreman_constructor.setup(param1,this);
      }
   }
}

