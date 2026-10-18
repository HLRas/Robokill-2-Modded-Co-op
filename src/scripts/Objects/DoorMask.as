package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectConstructors.DoorMask_constructor;
   
   public class DoorMask extends GameObject
   {
      
      public function DoorMask(param1:GameScene, param2:int, param3:int)
      {
         super(param1,DoorMask_constructor.baseim_embed,DoorMask_constructor.LayerName,param2,param3);
         DoorMask_constructor.setup(param1,this);
      }
   }
}

