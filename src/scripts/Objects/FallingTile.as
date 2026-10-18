package Objects
{
   import GameScene.GameScene;
   import ObjectBase.FallingTileBase;
   import ObjectConstructors.FallingTile_constructor;
   
   public class FallingTile extends FallingTileBase
   {
      
      public function FallingTile(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,FallingTile_constructor.baseim_embed,FallingTile_constructor.LayerName,param2,param3);
         FallingTile_constructor.setup(param1,this);
         pushable = false;
      }
   }
}

