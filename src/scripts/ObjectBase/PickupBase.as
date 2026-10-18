package ObjectBase
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterBlink;
   import GameObject.GameObjectFilterHeight;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.Cash;
   import Objects.EnemyCrack;
   import Objects.PickupText;
   import Objects.PressurePadActive;
   import Objects.RespawnPoint;
   import Objects.SecretLift;
   import Objects.SecretLiftFloor;
   import Objects.ShieldLargePickup;
   import Objects.ShieldPickup;
   import Objects.TimeRechargePickup;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Tools.PathfindSquare;
   import Weapons.Blaster;
   import flash.geom.Point;
   
   public class PickupBase extends GameObjectBase
   {
      
      public static var expediateControl:int = 0;
      
      public var drawnToPlayer:Boolean = false;
      
      public var heightFilter:GameObjectFilterHeight;
      
      public var flying:int = 0;
      
      public var flySpeed:Number = 0;
      
      public var pickMeUp:GameObject;
      
      public var flyAngle:Number = 0;
      
      public var flyInDelay:int = 0;
      
      public var flyIn:int = 0;
      
      public function PickupBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         heightFilter = new GameObjectFilterHeight(0);
         addFilter(heightFilter);
      }
      
      public static function maybeCreatePickup(param1:GameScene, param2:Number, param3:Number, param4:Boolean = false, param5:int = 0) : PickupBase
      {
         var _loc7_:GameObject = null;
         var _loc10_:GameObject = null;
         var _loc11_:PickupBase = null;
         var _loc12_:Boolean = false;
         var _loc13_:PathfindSquare = null;
         var _loc6_:MainScene = MainScene(param1);
         for each(_loc7_ in param1.objects)
         {
            if(_loc7_ is EnemyCrack || _loc7_ is SecretLift || _loc7_ is SecretLiftFloor || _loc7_ is PressurePadActive || _loc7_ is RespawnPoint)
            {
               if(_loc7_.distanceToPoint(param2,param3) < 52)
               {
                  return null;
               }
            }
         }
         if(!param4)
         {
            if(!MainScene(param1).squareExists(param2,param3))
            {
               return null;
            }
            _loc13_ = MainScene(param1).getSquare(param2,param3);
            if(!_loc13_)
            {
               return null;
            }
            if(!_loc13_.passable)
            {
               return null;
            }
         }
         var _loc8_:Number = MainScene(param1).player.chanceMult() * 1.5;
         if(param4)
         {
            _loc8_ /= 2;
         }
         var _loc9_:Number = 0.4;
         _loc9_ = _loc9_ * (1 - MainScene(param1).player.shields);
         if(_loc9_ > 0.2)
         {
            _loc9_ = 0.2;
         }
         for each(_loc10_ in param1.objects)
         {
            if(_loc10_ is PickupBase)
            {
               if(_loc10_.distanceToPoint(param2,param3) < 80)
               {
                  return null;
               }
            }
         }
         _loc12_ = false;
         if(!MainScene(param1).player.expediatedDrop)
         {
            ++expediateControl;
            if(expediateControl < 7)
            {
               return null;
            }
            _loc12_ = true;
            param5 = 2;
         }
         if(param5 == 2)
         {
            _loc11_ = new PickupWeapon(param1,param2,param3);
         }
         else if(Math.random() < _loc9_ * _loc8_)
         {
            _loc11_ = new ShieldPickup(param1,param2,param3);
         }
         else if(Math.random() < 0.2 * _loc8_)
         {
            _loc11_ = new Cash(param1,param2,param3);
         }
         else if(Math.random() < _loc8_ * 0.05 && param5 != 0)
         {
            _loc11_ = new PickupWeapon(param1,param2,param3);
         }
         else if(Math.random() < _loc8_ * 0.05 && param5 != 0)
         {
            _loc11_ = new PickupItem(param1,param2,param3);
         }
         else if(Math.random() < _loc9_ * _loc8_ / 8 && _loc6_.Ticks - _loc6_.lastShieldLargeDrop > 1000)
         {
            _loc11_ = new ShieldLargePickup(param1,param2,param3);
            _loc6_.lastShieldLargeDrop = _loc6_.Ticks;
         }
         else if(Math.random() < 0.2 * _loc8_)
         {
            _loc11_ = new TimeRechargePickup(param1,param2,param3);
         }
         if(_loc11_)
         {
            if(!MainScene(param1).currentLevel.pickupValid(_loc11_))
            {
               _loc11_.remove();
               return null;
            }
         }
         if(_loc12_)
         {
            MainScene(param1).player.expediatedDrop = true;
            if(_loc11_ is PickupWeapon)
            {
               PickupWeapon(_loc11_).createPickMeUp();
               PickupWeapon(_loc11_).wep = new Blaster();
               PickupWeapon(_loc11_).wep.level = 0;
            }
         }
         return _loc11_;
      }
      
      override public function handlePlayerCollision() : void
      {
         if(flyInDelay > 0 || flyIn > 0 || flying > 0)
         {
            return;
         }
         if(MainScene(gs).fading != 0)
         {
            return;
         }
         if(MainScene(gs).player.beforeTeleporting())
         {
            return;
         }
         var _loc1_:Boolean = pickup();
         if(_loc1_)
         {
            new PickupText(gs,basex,basey,pickupName());
            remove();
            playSound();
         }
         drawnToPlayer = false;
      }
      
      override public function _remove() : void
      {
         if(pickMeUp)
         {
            pickMeUp.remove();
            pickMeUp = null;
         }
      }
      
      public function pickupName() : String
      {
         return "";
      }
      
      override public function _update() : void
      {
         var _loc2_:Point = null;
         if(drawnToPlayer)
         {
            collidesWithWalls = false;
         }
         if(flyInDelay > 0)
         {
            --flyInDelay;
         }
         else if(flyIn > 0)
         {
            --flyIn;
            if(flyIn == 0)
            {
               dx = cosd(flyAngle) * flySpeed / 3;
               dy = sind(flyAngle) * flySpeed / 3;
               flying = 1;
            }
         }
         if(flying)
         {
            ++flying;
            heightFilter.height = sind(180 * (flying / 100)) * 20;
            if(flying > 100)
            {
               dx = 0;
               dy = 0;
               flying = 0;
               collidesWithWalls = true;
            }
         }
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.bomber_bomb_shadow_png,"Shadow",heightFilter.height > 0,1);
         if(_loc1_)
         {
            _loc1_.basex = basex + heightFilter.height / 2;
            _loc1_.basey = basey + heightFilter.height / 2;
            _loc1_.baseScaleX = 2;
            _loc1_.changeZOrder("Floor",true);
         }
         basex += dx;
         basey += dy;
         dx *= 0.98;
         dy *= 0.98;
         if(drawnToPlayer)
         {
            _loc2_ = helper.vectorToPoint(ms.player.basex + ms.player.lastdx * 30,ms.player.basey + ms.player.lastdy * 30);
            dx += _loc2_.x * 0.2;
            dy += _loc2_.y * 0.2;
         }
         collisionFudge = 0.8;
         basex = Interpolation.lockValue(basex,ms.wallstartx + baseWidth / 2,ms.wallendx - baseWidth / 2);
         basey = Interpolation.lockValue(basey,ms.wallstarty + baseHeight / 2,ms.wallendy - baseHeight / 2);
         super._update();
      }
      
      override public function canFall() : Boolean
      {
         if(drawnToPlayer)
         {
            return false;
         }
         return super.canFall();
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey"];
      }
      
      public function playSound() : void
      {
      }
      
      public function pickup() : Boolean
      {
         return true;
      }
      
      public function createPickMeUp() : void
      {
         if(!pickMeUp)
         {
            pickMeUp = new GameObject(gs,null,"AbovePlayer",basex - 2,basey - 26);
            pickMeUp.fontName = "Pixelation-34";
            pickMeUp.setText("PICK ME UP!",7);
            pickMeUp.addFilter(new GameObjectFilterBlink());
         }
      }
   }
}

