package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HoverSwarmBase;
   import ObjectConstructors.HoverSwarm_constructor;
   
   public class HoverSwarm extends HoverSwarmBase
   {
      
      public function HoverSwarm(param1:GameScene, param2:int, param3:int)
      {
         super(param1,HoverSwarm_constructor.baseim_embed,HoverSwarm_constructor.LayerName,param2,param3);
         HoverSwarm_constructor.setup(param1,this);
      }
   }
}

