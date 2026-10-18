package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HoverBase;
   import ObjectConstructors.Hover_constructor;
   
   public class Hover extends HoverBase
   {
      
      public function Hover(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Hover_constructor.baseim_embed,Hover_constructor.LayerName,param2,param3);
         Hover_constructor.setup(param1,this);
      }
   }
}

