package Objects
{
   import GameScene.GameScene;
   import ObjectBase.TopDecalBase;
   import ObjectConstructors.TopDecal_constructor;
   
   public class TopDecal extends TopDecalBase
   {
      
      public var images:Array;
      
      public function TopDecal(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,TopDecal_constructor.baseim_embed,TopDecal_constructor.LayerName,param2,param3);
         TopDecal_constructor.setup(param1,this);
      }
   }
}

