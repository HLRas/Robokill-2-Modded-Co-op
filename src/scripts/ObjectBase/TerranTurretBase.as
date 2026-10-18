package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.EnemyCrack;
   import Objects.HulkBullet;
   import Tools.Random;
   
   public class TerranTurretBase extends EnemyBase
   {
      
      public var playerHits:int = 0;
      
      public var target:GameObjectBase;
      
      public var angryAtPlayer:Boolean = false;
      
      public function TerranTurretBase(param1:GameScene, param2:Class, param3:String, param4:int = 0, param5:int = 0)
      {
         super(param1,param2,param3,param4,param5);
         pushWeight = 99999999999;
         setsImpassable = true;
         baseHealth *= 20;
         collidesWithPlayer = false;
         addFilter(new GameObjectFilterRotateSlowly(2));
         collidesWithWalls = false;
         organic = false;
         pushable = false;
         tintBasedOnPosition = true;
      }
      
      internal function getTarget() : GameObjectBase
      {
         var _loc2_:GameObject = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is EnemyBase)
            {
               if(!(_loc2_ is TerranTurretBase || _loc2_ is EnemyCrack))
               {
                  if(EnemyBase(_loc2_).collisionWidth() > 0)
                  {
                     if(!EnemyBase(_loc2_).isTeleporting())
                     {
                        _loc1_.push(_loc2_);
                     }
                  }
               }
            }
         }
         if(ms.currentLevel.angryTerranTurrets)
         {
            _loc1_.push(ms.player);
         }
         return _loc1_[Random.randInt(0,_loc1_.length - 1)];
      }
      
      override public function _update() : void
      {
         if(ticks % 100 == 0)
         {
            if(playerHits > 0)
            {
               --playerHits;
            }
         }
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.terran_pissed_png,"Pissed",ms.currentLevel.angryTerranTurrets);
         if(_loc1_)
         {
            _loc1_.basex = basex;
            _loc1_.basey = basey - 48;
         }
         super._update();
         if(!target)
         {
            target = getTarget();
         }
         if(target)
         {
            if(target._removed)
            {
               target = null;
            }
         }
         if(target)
         {
            if(target.collisionWidth() == 0 || target.collisionHeight() == 0)
            {
               target = null;
            }
         }
         if(!stunned)
         {
            if(target)
            {
               baseRotation = helper.angleToObject(target) + 90;
               handleShooting();
               if(Math.random() < 0.02)
               {
                  if(target is PlayerBase)
                  {
                     if(!ms.currentLevel.angryTerranTurrets)
                     {
                        target = null;
                     }
                  }
               }
            }
         }
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      override public function _experience() : int
      {
         return 0;
      }
      
      override public function handlePlayerCollision() : void
      {
      }
      
      public function handleShooting() : void
      {
         var _loc1_:BulletBase = null;
         if(ticks % 10 == 0)
         {
            _loc1_ = shoot(HulkBullet);
            _loc1_.source = this;
         }
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
      
      override public function shootTarget() : GameObject
      {
         return target;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.explosion;
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         super.hitBy(param1,param2);
         if(param1)
         {
            if(param1.source is PlayerBase)
            {
               ++playerHits;
               if(playerHits > 8)
               {
                  if(!ms.currentLevel.angryTerranTurrets)
                  {
                     Sounds.terranPissed.play();
                     ms.currentLevel.angryTerranTurrets = true;
                     ms.currentLevel.angryTerranTurretsTicks = 0;
                  }
               }
            }
         }
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
   }
}

