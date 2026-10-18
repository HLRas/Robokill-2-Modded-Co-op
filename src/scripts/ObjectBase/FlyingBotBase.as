package ObjectBase
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Tools.Interpolation;
   import Tools.Random;
   import flash.geom.Point;
   
   public class FlyingBotBase extends ActorBase
   {
      
      public var target:EnemyBase;
      
      public var life:int = 2000;
      
      public function FlyingBotBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         collidesWithWalls = false;
         health = 200;
         addFilter(new GameObjectFilterRotateSlowly(2));
      }
      
      public function getTarget() : EnemyBase
      {
         var _loc2_:GameObject = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is EnemyBase)
            {
               if(!(_loc2_ is TerranTurretBase) || ms.currentLevel.angryTerranTurrets)
               {
                  if(EnemyBase(_loc2_).collisionWidth() > 0)
                  {
                     if(!EnemyBase(_loc2_).isTeleporting())
                     {
                        if(!EnemyBase(_loc2_).falling)
                        {
                           _loc1_.push(_loc2_);
                        }
                     }
                  }
               }
            }
         }
         if(_loc1_.length)
         {
            return _loc1_[Random.randInt(0,_loc1_.length - 1)];
         }
         return null;
      }
      
      public function hoverAroundPlayer(param1:Number = 0, param2:Number = 0) : void
      {
         var _loc5_:Point = null;
         var _loc3_:Number = ms.player.basex + param1;
         var _loc4_:Number = ms.player.basey + param2;
         _loc3_ = Interpolation.linearInterpolate(_loc3_,400,0.2);
         _loc4_ = Interpolation.linearInterpolate(_loc4_,300,0.2);
         _loc5_ = helper.vectorToPoint(_loc3_,_loc4_);
         var _loc6_:Number = 0.2 + distanceToPoint(_loc3_,_loc4_) / 100;
         basex += _loc5_.x * _loc6_;
         basey += _loc5_.y * _loc6_;
      }
      
      public function handleHit(param1:GameObject) : void
      {
         lastHit = 0;
         trace(EnemyBulletBase(param1).damage());
         health -= EnemyBulletBase(param1).damage();
         emitConditionalParticles("Hit");
         if(health < 0)
         {
            param1.remove();
            emitConditionalParticles("Destroy");
            remove();
         }
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      public function spawnX() : Number
      {
         return (Math.random() - 0.5) * 50;
      }
      
      public function spawnY() : Number
      {
         return (Math.random() - 0.5) * 50;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         _loc1_ = helper.conditionallyCreateChild(Embeds.bot_shadow_png,"Shadow",true,1);
         if(_loc1_)
         {
            _loc1_.basex = basex + 40 * (0.95 + sind(ticks * 2 + 342) * 0.05);
            _loc1_.basey = basey + 40 * (0.95 + sind(ticks * 2 + 342) * 0.05);
            _loc1_.baseRotation = baseRotation;
            _loc1_.changeZOrder("BelowPlayer");
         }
         super._update();
         if(!target)
         {
            target = getTarget();
         }
         if(!target)
         {
            baseRotation = angleToObject(ms.player) + 90;
         }
         if(target)
         {
            baseRotation = helper.angleToObject(target) + 90;
            if(target._killed || target._removed)
            {
               target = null;
            }
         }
         if(ticks > life)
         {
            emitConditionalParticles("Teleport");
            remove();
         }
      }
   }
}

