package Misc
{
   import GameObject.*;
   import ObjectBase.EnemyBase;
   import Objects.*;
   import Tools.Random;
   import flash.utils.*;
   
   public class EnemyLeveling
   {
      
      public var initialized:Boolean = false;
      
      public var enemyLevels:Object = new Object();
      
      public function EnemyLeveling()
      {
         super();
      }
      
      public function initialize() : void
      {
         if(initialized)
         {
            return;
         }
         initialized = true;
         _initialize();
      }
      
      public function levelEnemies(param1:Array, param2:int) : void
      {
         var _loc5_:GameObject = null;
         var _loc6_:Class = null;
         initialize();
         var _loc3_:Object = new Object();
         var _loc4_:Array = new Array();
         for each(_loc5_ in param1)
         {
            if(_loc5_ is EnemyBase)
            {
               _loc6_ = Class(getDefinitionByName(getQualifiedClassName(_loc5_)));
               if(!_loc3_[_loc6_])
               {
                  _loc3_[_loc6_] = true;
                  applyLevel(param1,_loc6_,param2);
               }
            }
         }
      }
      
      public function applyLevelToGroup(param1:Array, param2:int, param3:int = -1) : void
      {
         var _loc4_:EnemyBase = null;
         if(param2 > 0 && param3 != -1)
         {
            applyLevelToGroup(param1,param2 - 1,-1);
         }
         if(param3 != -1)
         {
            param1 = Random.randArrayElements(param1,param3);
         }
         for each(_loc4_ in param1)
         {
            _loc4_.setupDifficulty(param2);
         }
      }
      
      public function applyLevel(param1:Array, param2:Class, param3:int) : void
      {
         var _loc5_:GameObject = null;
         var _loc6_:Array = null;
         var _loc7_:Class = null;
         var _loc4_:Array = new Array();
         for each(_loc5_ in param1)
         {
            if(_loc5_ is EnemyBase)
            {
               _loc7_ = Class(getDefinitionByName(getQualifiedClassName(_loc5_)));
               if(param2 == _loc7_)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         _loc6_ = getLevelInformation(param2,param3);
         applyLevelToGroup(_loc4_,_loc6_[0],_loc6_[1]);
      }
      
      public function pushLevels(param1:Class, param2:Array) : void
      {
         enemyLevels[param1] = param2;
      }
      
      public function getLevelInformation(param1:Class, param2:int) : Array
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = -1;
         if(enemyLevels[param1])
         {
            _loc5_ = enemyLevels[param1];
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               if(int(_loc5_[_loc6_][0]) <= param2)
               {
                  _loc3_ = int(_loc5_[_loc6_][1]);
                  if(_loc5_[_loc6_].length > 2)
                  {
                     _loc4_ = int(_loc5_[_loc6_][2]);
                  }
                  else
                  {
                     _loc4_ = -1;
                  }
               }
               _loc6_++;
            }
         }
         return [_loc3_,_loc4_];
      }
      
      public function _initialize() : void
      {
         pushLevels(Grunt,[[2,1,4],[3,1],[4,2,4],[5,2]]);
         pushLevels(Spawn,[[2,1,1],[3,1,4],[4,1],[6,2,1],[7,2,4],[8,2]]);
         pushLevels(Nest,[[4,1],[7,2]]);
         pushLevels(Trooper,[[2,1,2],[3,1],[4,2,2],[5,2]]);
         pushLevels(ShootingGrunt,[[3,1,1],[4,1,4],[5,1],[6,2,1],[7,2,4],[8,2]]);
         pushLevels(RocketGrunt,[[8,1,1],[9,1],[11,2,1],[12,2]]);
         pushLevels(Swarm,[[2,1,1],[3,1,4],[4,1],[5,2,1],[6,2,4],[7,2]]);
         pushLevels(Bull,[[5,1],[10,2]]);
         pushLevels(Maggot,[[3,1,1],[4,1,4],[5,1],[6,2,1],[7,2,4],[8,2]]);
         pushLevels(Critter,[[2,1,1],[3,1,4],[4,1],[5,2,1],[6,2,4],[7,2]]);
         pushLevels(BigSpiderGunner,[[4,1],[8,2]]);
         pushLevels(MountableTurret,[[3,1,1],[4,1],[7,2]]);
         pushLevels(Brute,[[2,1,1],[3,1,2],[4,1],[6,2,1],[7,2,2],[8,2]]);
         pushLevels(BatNest,[[5,1,4],[6,1],[8,2,4],[9,2]]);
         pushLevels(Spider,[[6,1],[10,1]]);
         pushLevels(RocketBrute,[[6,1,1],[7,1,4],[10,2,1],[11,2]]);
         pushLevels(Bomber,[[6,1],[10,2]]);
         pushLevels(LargeCritter,[[6,1,1],[7,1],[10,2,1],[11,2]]);
         pushLevels(SpiderSpit,[[8,1,1],[9,1],[10,2,1],[11,2]]);
         pushLevels(MinigunBrute,[[7,1,1],[8,1],[10,2,1],[11,2]]);
         pushLevels(GruntRider,[[8,1],[11,2]]);
         pushLevels(TrooperJet,[[7,1],[10,2]]);
         pushLevels(TrooperCommander,[[8,1],[11,2]]);
         pushLevels(BatNest,[[8,1,1],[9,1],[11,1,1]]);
         pushLevels(RocketGrunt,[[8,1,4],[9,1],[10,2,4],[11,2]]);
         pushLevels(GooTurretSpawn,[[9,1],[11,2]]);
         pushLevels(NestSwarm,[[9,1],[11,2]]);
         pushLevels(CritterJump,[[9,1,4],[10,1],[11,2,4]]);
         pushLevels(BomberSmall,[[10,1,4],[11,1]]);
      }
   }
}

