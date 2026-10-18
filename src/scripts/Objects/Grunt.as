package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GruntBase;
   import ObjectConstructors.Grunt_constructor;
   
   public class Grunt extends GruntBase
   {
      
      public function Grunt(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Grunt_constructor.baseim_embed,Grunt_constructor.LayerName,param2,param3);
         Grunt_constructor.setup(param1,this);
      }
   }
}

