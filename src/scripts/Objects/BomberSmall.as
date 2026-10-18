package Objects
{
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import ObjectBase.BomberBase;
   import ObjectConstructors.BomberSmall_constructor;
   
   public class BomberSmall extends BomberBase
   {
      
      public var killed:Boolean = false;
      
      public function BomberSmall(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BomberSmall_constructor.baseim_embed,BomberSmall_constructor.LayerName,param2,param3);
         BomberSmall_constructor.setup(param1,this);
         addFilter(new GameObjectFilterRotateSlowly(2));
         baseHealth *= 5;
      }
      
      override public function _update() : void
      {
         super._update();
         if(blockUpdating())
         {
            return;
         }
         moveTowardsPlayer(1.5);
      }
      
      override public function _experience() : int
      {
         return 100;
      }
      
      override public function kill() : void
      {
         if(!killed)
         {
            createBombs(4,0.5);
            super.kill();
         }
         killed = true;
      }
   }
}

