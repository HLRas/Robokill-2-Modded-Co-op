package Objects
{
   import GameScene.GameScene;
   import ObjectBase.InertiaBase;
   import ObjectConstructors.Inertia_constructor;
   
   public class Inertia extends InertiaBase
   {
      
      public function Inertia(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Inertia_constructor.baseim_embed,Inertia_constructor.LayerName,param2,param3);
         Inertia_constructor.setup(param1,this);
      }
   }
}

