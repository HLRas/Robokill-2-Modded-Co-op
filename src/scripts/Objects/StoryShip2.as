package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectConstructors.StoryShip2_constructor;
   
   public class StoryShip2 extends GameObject
   {
      
      public function StoryShip2(param1:GameScene, param2:int, param3:int)
      {
         super(param1,StoryShip2_constructor.baseim_embed,StoryShip2_constructor.LayerName,param2,param3);
         StoryShip2_constructor.setup(param1,this);
      }
   }
}

