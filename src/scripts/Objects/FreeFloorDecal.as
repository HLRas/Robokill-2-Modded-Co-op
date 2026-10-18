package Objects
{
   import GameScene.GameScene;
   import ObjectBase.FloorDecalBase;
   import ObjectConstructors.FreeFloorDecal_constructor;
   
   public class FreeFloorDecal extends FloorDecalBase
   {
      
      public function FreeFloorDecal(param1:GameScene, param2:int, param3:int)
      {
         super(param1,FreeFloorDecal_constructor.baseim_embed,FreeFloorDecal_constructor.LayerName,param2,param3);
         FreeFloorDecal_constructor.setup(param1,this);
      }
   }
}

