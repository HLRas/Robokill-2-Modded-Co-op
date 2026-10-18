package Objects
{
   import GameScene.GameScene;
   import ObjectBase.FloorDecalBase;
   import ObjectConstructors.FloorDecal_constructor;
   import Scenes.MainScene;
   
   public class FloorDecal extends FloorDecalBase
   {
      
      public function FloorDecal(param1:GameScene, param2:int, param3:int)
      {
         super(param1,FloorDecal_constructor.baseim_embed,FloorDecal_constructor.LayerName,param2,param3);
         FloorDecal_constructor.setup(param1,this);
         hide();
      }
      
      override public function _update() : void
      {
         super._update();
      }
      
      public function isStraightRail() : Boolean
      {
         var _loc1_:Array = [11,28,29,56,61,62];
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(int(animFrame) == _loc1_[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      override public function _init() : void
      {
         super._init();
         MainScene(gs).setPassable(MainScene.getLogicalSquareX(basex),MainScene.getLogicalSquareY(basey),false);
      }
   }
}

