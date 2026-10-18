package Objects
{
   import GameObject.*;
   import GameScene.GameScene;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import flash.display.*;
   
   public class BullGunner extends Bull
   {
      
      public var turrets:Array = new Array();
      
      public function BullGunner(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         Bull_constructor.setup(param1,this);
         baseHealth *= 10;
         addTurret(0,-20);
      }
      
      public function addTurret(param1:Number, param2:Number) : void
      {
         var _loc3_:WalkerTurret = null;
         _loc3_ = new WalkerTurret(null,0,0);
         _loc3_.baseHealth *= 48;
         _loc3_.setupDifficulty(0);
         turrets.push(_loc3_);
      }
      
      override public function _remove() : void
      {
         var _loc1_:WalkerTurretBase = null;
         for each(_loc1_ in turrets)
         {
            _loc1_.remove();
         }
      }
      
      override public function _update() : void
      {
         super._update();
         animFreeze = false;
         turrets[0].basex = tformedX(0,-20);
         turrets[0].basey = tformedY(0,-20);
      }
      
      override public function _experience() : int
      {
         return 500;
      }
      
      override public function kill() : void
      {
         var _loc1_:WalkerTurretBase = null;
         super.kill();
         for each(_loc1_ in turrets)
         {
            _loc1_.kill();
         }
      }
   }
}

