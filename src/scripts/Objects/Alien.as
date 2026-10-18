package Objects
{
   import GameScene.GameScene;
   import ObjectBase.AlienBase;
   import ObjectConstructors.Alien_constructor;
   
   public class Alien extends AlienBase
   {
      
      public function Alien(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Alien_constructor.baseim_embed,Alien_constructor.LayerName,param2,param3);
         Alien_constructor.setup(param1,this);
      }
   }
}

