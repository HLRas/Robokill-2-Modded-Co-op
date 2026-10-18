package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectConstructors.StoryShip1_constructor;
   
   public class StoryShip1 extends GameObject
   {
      
      public function StoryShip1(param1:GameScene, param2:int, param3:int)
      {
         super(param1,StoryShip1_constructor.baseim_embed,StoryShip1_constructor.LayerName,param2,param3);
         StoryShip1_constructor.setup(param1,this);
      }
   }
}

