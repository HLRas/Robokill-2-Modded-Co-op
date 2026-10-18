package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBase;
   import ObjectConstructors.Hulk_constructor;
   
   public class Hulk extends HulkBase
   {
      
      public function Hulk(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Hulk_constructor.baseim_embed,Hulk_constructor.LayerName,param2,param3);
         Hulk_constructor.setup(param1,this);
      }
   }
}

