package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SwarmBase;
   import ObjectConstructors.Swarm_constructor;
   
   public class Swarm extends SwarmBase
   {
      
      public function Swarm(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Swarm_constructor.baseim_embed,Swarm_constructor.LayerName,param2,param3);
         Swarm_constructor.setup(param1,this);
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() / 2;
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() / 2;
      }
   }
}

