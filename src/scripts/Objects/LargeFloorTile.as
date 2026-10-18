package Objects
{
   import GameScene.GameScene;
   import ObjectConstructors.LargeFloorTile_constructor;
   
   public class LargeFloorTile extends FloorTile
   {
      
      public function LargeFloorTile(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         LargeFloorTile_constructor.setup(param1,this);
         helperAnimation.setFrame(images[int(animFrame)]);
      }
   }
}

