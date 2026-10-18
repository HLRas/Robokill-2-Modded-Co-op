package ObjectBase
{
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.GruntLegs;
   import Objects.WalkerTurret;
   
   public class WalkerBase extends EnemyBase
   {
      
      public var rearTurret:WalkerTurret;
      
      public var frontTurret:WalkerTurret;
      
      public function WalkerBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         addFilter(new GameObjectFilterRotateSlowly(1));
         baseHealth *= 40;
         extraHealth *= 20;
         legs = new GruntLegs(param1,0,16);
         legs2 = new GruntLegs(param1,0,-16);
         rotateTowardsPlayer = false;
         frontTurret = new WalkerTurret(param1,0,0);
         frontTurret.setsImpassable = false;
         frontTurret.front = true;
         rearTurret = new WalkerTurret(param1,0,0);
         rearTurret.setsImpassable = false;
         frontTurret.baseHealth *= 16;
         frontTurret.extraHealth *= 12;
         rearTurret.baseHealth *= 8;
         rearTurret.extraHealth *= 8;
         frontTurret.walker = this;
         rearTurret.walker = this;
         frontTurret.setupDifficulty(0);
         rearTurret.setupDifficulty(0);
         frontTurret.save = false;
         rearTurret.save = false;
         pushable = false;
      }
      
      override public function _experience() : int
      {
         return 200;
      }
      
      override public function itemDropLevel() : int
      {
         return 2;
      }
      
      override public function shrapnelCount() : int
      {
         return 8;
      }
      
      override public function _update() : void
      {
         super._update();
         if(!blockUpdating())
         {
            moveRandomly(0.35);
         }
         legs.basex = tformedX(0,-16);
         legs.basey = tformedY(0,-16);
         legs2.basex = tformedX(0,16);
         legs2.basey = tformedY(0,16);
         legs.hidden = hidden;
         legs2.hidden = hidden;
         frontTurret.basex = tformedX(0,-16);
         frontTurret.basey = tformedY(0,-16);
         rearTurret.basex = tformedX(0,16);
         rearTurret.basey = tformedY(0,16);
         baseRotation = legs.baseRotation;
      }
      
      override public function _remove() : void
      {
         legs.remove();
         legs2.remove();
         super._remove();
      }
      
      override public function kill() : void
      {
         legs.remove();
         legs2.remove();
         frontTurret.kill();
         rearTurret.kill();
         super.kill();
      }
      
      override public function setupDifficulty(param1:int) : void
      {
         frontTurret.setupDifficulty(param1);
         rearTurret.setupDifficulty(param1);
         super.setupDifficulty(param1);
      }
   }
}

