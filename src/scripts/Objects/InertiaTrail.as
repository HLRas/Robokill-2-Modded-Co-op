package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectConstructors.InertiaTrail_constructor;
   
   public class InertiaTrail extends GameObject
   {
      
      public function InertiaTrail(param1:GameScene, param2:int, param3:int)
      {
         super(param1,InertiaTrail_constructor.baseim_embed,InertiaTrail_constructor.LayerName,param2,param3);
         InertiaTrail_constructor.setup(param1,this);
         additive = true;
      }
   }
}

