package Objects
{
   import GameScene.GameScene;
   import InventoryScreen.HUDDisplay;
   import InventoryScreen.Shop;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.ShopTile_constructor;
   
   public class ShopTile extends GameObjectBase
   {
      
      public var canUse:Boolean = false;
      
      public function ShopTile(param1:GameScene, param2:int, param3:int)
      {
         super(param1,ShopTile_constructor.baseim_embed,ShopTile_constructor.LayerName,param2,param3);
         ShopTile_constructor.setup(param1,this);
         pushable = false;
         collidesWithWalls = false;
      }
      
      override public function handlePlayerCollision() : void
      {
         if(canUse)
         {
            HUDDisplay.open(gs,Shop);
            canUse = false;
         }
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         super.hasHitWall(param1,param2,param3);
      }
      
      override public function _update() : void
      {
         if(distanceToPlayer() > 52)
         {
            canUse = true;
         }
         super._update();
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey"];
      }
      
      override public function _init() : void
      {
         super._init();
      }
   }
}

