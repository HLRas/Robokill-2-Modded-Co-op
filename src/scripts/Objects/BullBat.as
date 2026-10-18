package Objects
{
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import ObjectBase.HoverSwarmBase;
   import ObjectConstructors.BullBat_constructor;
   
   public class BullBat extends HoverSwarmBase
   {
      
      public var bomb:BullBatBombObject;
      
      public var hasBomb:Boolean = false;
      
      public function BullBat(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BullBat_constructor.baseim_embed,BullBat_constructor.LayerName,param2,param3);
         BullBat_constructor.setup(param1,this);
         addFilter(new GameObjectFilterRotateSlowly(2));
         doingLegSpeed = false;
         doCollisions = false;
         chargeAmount = 200;
      }
      
      override public function _experience() : int
      {
         return 150;
      }
      
      override public function collidesWithAnything() : Boolean
      {
         return false;
      }
      
      override public function kill() : void
      {
         super.kill();
         if(bomb)
         {
            bomb.released = 1;
         }
      }
      
      override public function _update() : void
      {
         if(hasBomb)
         {
            if(!bomb)
            {
               bomb = new BullBatBombObject();
               bomb.changeZOrder(zOrderString,true);
               bomb.additive = true;
            }
            bomb.dx = basex - bomb.basex;
            bomb.dy = basey - bomb.basey;
            bomb.basex = basex;
            bomb.basey = basey;
         }
         super._update();
         animFreeze = false;
         updateAnimation();
      }
   }
}

