package ObjectBase
{
   import GameObject.*;
   import GameScene.*;
   import Objects.*;
   import Scenes.*;
   import Tools.*;
   
   public class SpawnBase extends EnemyBase
   {
      
      public var nextCreation:int = 100 + Math.random() * 200;
      
      public var spawnDifficultyOverride:int = -1;
      
      public var created:int = 0;
      
      public var offset:int = Random.randInt(0,1000);
      
      public var determinedEnemy:Boolean = false;
      
      public var creationType:Class;
      
      public function SpawnBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         pushable = false;
         baseHealth *= 5;
         extraHealth *= 3.5;
         setsImpassable = true;
         creationType = Grunt;
         organic = false;
      }
      
      public function creationOverride() : Class
      {
         return null;
      }
      
      override public function _experience() : int
      {
         return 30;
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         if(onScreen())
         {
            super.hitBy(param1,param2);
         }
      }
      
      override public function shrapnelCount() : int
      {
         return 4;
      }
      
      override public function _update() : void
      {
         var _loc2_:int = 0;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         determineEnemy();
         var _loc1_:Class = creationOverride();
         if(_loc1_)
         {
            creationType = _loc1_;
         }
         if(nextCreation > 0)
         {
            --nextCreation;
         }
         else
         {
            nextCreation = 170 + Math.random() * 60 + ms.countEnemies() * 10;
            if(created < 15)
            {
               _loc2_ = toughness;
               if(spawnDifficultyOverride >= 0)
               {
                  _loc2_ = spawnDifficultyOverride;
               }
               if(spawn(creationType,basex,basey,_loc2_))
               {
                  ++created;
                  emitConditionalParticles("TeleportSmall");
                  Sounds.enemySpawn.play();
               }
            }
         }
      }
      
      public function determineEnemy() : void
      {
         var _loc1_:GameObject = null;
         if(determinedEnemy)
         {
            return;
         }
         determinedEnemy = true;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is EnemyBase)
            {
               if(!(_loc1_ is Spawn))
               {
                  if(distanceToObject(_loc1_) < 26)
                  {
                     creationType = Object(_loc1_).constructor;
                     spawnDifficultyOverride = EnemyBase(_loc1_).toughness;
                     _loc1_.remove();
                     return;
                  }
               }
            }
         }
      }
      
      public function onScreen() : Boolean
      {
         if(basex < 0 || basex > 800 || basey < 0 || basey > 600)
         {
            return false;
         }
         return true;
      }
   }
}

