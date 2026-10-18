package ObjectBase
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Scenes.MainScene;
   import Tools.Interpolation;
   
   public class HoverSwarmBase extends SwarmBase
   {
      
      public var stateIdle:int = 1;
      
      public var speed:Number = 0;
      
      public var state:int = 0;
      
      public var stateCharge:int = 2;
      
      public var animSpeedTarget:Number = 0;
      
      public var chargeAmount:int = 50;
      
      public var stateTicks:int = stateCharge;
      
      public var speedTarget:Number = 0;
      
      public var moveLikeBull:Boolean = true;
      
      public var chargeAngle:int = 0;
      
      public function HoverSwarmBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,"AbovePlayer",param4,param5);
         baseHealth *= 5;
         extraHealth *= 5;
         inertia = 0.98;
         addFilter(new GameObjectFilterRotateSlowly(3));
         collidesWithWalls = false;
         slowAroundCorners = false;
      }
      
      public function changeState(param1:int) : void
      {
         state = param1;
         stateTicks = 0;
      }
      
      public function updateAnimation() : void
      {
         if(state == stateCharge)
         {
            animSpeedTarget = 4;
         }
         else
         {
            animSpeedTarget = 2;
         }
         animSpeed = Interpolation.tendTowards(animSpeed,animSpeedTarget,0.2);
      }
      
      override public function _experience() : int
      {
         return 30;
      }
      
      override public function canMoveOnLand() : Boolean
      {
         return true;
      }
      
      override public function doMovement() : void
      {
         if(moveLikeBull)
         {
            ++stateTicks;
            if(state == stateCharge)
            {
               speedTarget = 4;
               if(stateTicks > chargeAmount || closeToScreen())
               {
                  changeState(stateIdle);
               }
            }
            else
            {
               speedTarget = 1.4;
               chargeAngle = angleToObject(ms.player);
               if(stateTicks > 100)
               {
                  if(Math.random() > 0.99)
                  {
                     changeState(stateCharge);
                  }
               }
            }
            speed = Interpolation.tendTowards(speed,speedTarget,0.1);
            moveAlongAngle(speed,chargeAngle);
         }
         else
         {
            moveTowardsPlayerFly(1.6);
            baseRotation = angleToObject(MainScene(gs).player) + 90;
         }
      }
      
      public function closeToScreen() : Boolean
      {
         var _loc1_:Number = basex + dx * 100;
         var _loc2_:Number = basey + dy * 100;
         if(_loc1_ < 0 || _loc1_ > 800)
         {
            return true;
         }
         if(_loc2_ < 0 || _loc2_ > 600)
         {
            return true;
         }
         return false;
      }
      
      override public function isFlying() : Boolean
      {
         return true;
      }
      
      override public function _update() : void
      {
         var _loc4_:GameObject = null;
         super._update();
         var _loc1_:Number = basex + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1);
         var _loc2_:Number = basey + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1);
         var _loc3_:Boolean = false;
         if(!ms.squareExists(_loc1_,_loc2_))
         {
            _loc3_ = true;
         }
         _loc4_ = helper.conditionallyCreateChild(Embeds.bat_shadow001_png,"shadow",!(_loc3_ || beforeTeleporting() || pauseShadow()),0.05,null,baseAlpha * fallingAlpha());
         if(_loc4_)
         {
            _loc4_.basex = basex + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1);
            _loc4_.basey = basey + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1);
            _loc4_.baseRotation = baseRotation;
            _loc4_.imageSet = Embeds.batShadow;
            if(pauseShadow())
            {
               _loc4_.animSpeed = 0;
            }
            else
            {
               _loc4_.animSpeed = animSpeed;
            }
            _loc4_.changeZOrder("Floor");
            _loc4_.animFreeze = animFreeze;
         }
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      public function pauseShadow() : Boolean
      {
         return false;
      }
   }
}

