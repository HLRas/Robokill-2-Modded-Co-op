package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectBase.SwarmBase;
   import ObjectConstructors.Critter_constructor;
   
   public class Critter extends SwarmBase
   {
      
      public var willClimb:Boolean = false;
      
      public var setFrame11:Boolean = false;
      
      public var following:SpiderSpit;
      
      public var outOfTrap:Boolean = false;
      
      public var climbSpeed:int = 4;
      
      public var followAngle:Number = 0;
      
      public var climb:Array;
      
      public function Critter(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Critter_constructor.baseim_embed,Critter_constructor.LayerName,param2,param3);
         Critter_constructor.setup(param1,this);
         followAngle = 90 + Math.random() * 10;
      }
      
      override public function stunnable() : Boolean
      {
         if(outOfTrap && ticks / climbSpeed < climb.length)
         {
            return false;
         }
         return true;
      }
      
      override public function dropsItem() : Boolean
      {
         return false;
      }
      
      override public function doMovement() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(willClimb)
         {
            if(distanceToPlayer() < 200)
            {
               willClimb = false;
               trapEffect();
            }
            ticks = 3;
            return;
         }
         if(outOfTrap)
         {
            if(ticks == 50)
            {
               for each(_loc1_ in gs.objects)
               {
                  if(_loc1_ is Critter)
                  {
                     if(distanceToObject(_loc1_) < 150)
                     {
                        Critter(_loc1_).willClimb = false;
                     }
                  }
               }
            }
            collidesWithWalls = ticks > 100;
            if(ticks / climbSpeed < climb.length)
            {
               baseRotation = rotationLock;
               return;
            }
            if(ticks < 80)
            {
               slowAroundCorners = false;
               moveAlongAngle(1,baseRotation);
               return;
            }
         }
         outOfTrap = false;
         slowAroundCorners = true;
         if(!following)
         {
            for each(_loc1_ in gs.objects)
            {
               if(_loc1_ is SpiderSpit)
               {
                  if(distanceToObject(_loc1_) < 200)
                  {
                     if(SpiderSpit(_loc1_).followers < 8)
                     {
                        following = SpiderSpit(_loc1_);
                     }
                  }
               }
            }
         }
         if(following)
         {
            _loc2_ = distanceToObject(following);
            facePlayer = false;
            _loc3_ = followAngle;
            if(_loc2_ > 100)
            {
               _loc3_ /= _loc2_ - 100;
            }
            moveAlongAngle(1.7,angleToObject(following) + _loc3_);
            if(following._removed)
            {
               following = null;
            }
            return;
         }
         super.doMovement();
      }
      
      override public function nextSquareInvalid() : Boolean
      {
         if(ticks < 100 && outOfTrap)
         {
            return false;
         }
         return super.nextSquareInvalid();
      }
      
      override public function _update() : void
      {
         if(ticks == 1)
         {
            if(!ms.logicalSquareExists(logicalSquareX(),logicalSquareY()))
            {
               baseRotation = 0;
               if(ms.logicalSquareExists(logicalSquareX() + 1,logicalSquareY()))
               {
                  baseRotation = 90;
               }
               if(ms.logicalSquareExists(logicalSquareX() - 1,logicalSquareY()))
               {
                  baseRotation = 270;
               }
               if(ms.logicalSquareExists(logicalSquareX(),logicalSquareY() + 1))
               {
                  baseRotation = 180;
               }
               move(52 * (Math.random() - 0.5),-18);
               rotationLock = baseRotation;
               willClimb = true;
               outOfTrap = true;
            }
         }
         doCollisions = ticks / climbSpeed > climb.length;
         super._update();
         updateAnimation();
      }
      
      override public function canFall() : Boolean
      {
         return !(willClimb || outOfTrap);
      }
      
      override public function _init() : void
      {
         super._init();
         changeZOrder(zOrderString,true);
      }
      
      override public function shockwaveWeight() : Number
      {
         if(ticks < 100 && outOfTrap)
         {
            return 0;
         }
         return 1;
      }
      
      override public function collisionWidth() : Number
      {
         if(outOfTrap)
         {
            return 0;
         }
         return super.collisionWidth();
      }
      
      override public function collisionHeight() : Number
      {
         if(outOfTrap)
         {
            return 0;
         }
         return super.collisionHeight();
      }
      
      public function updateAnimation() : void
      {
         var _loc1_:int = ticks / climbSpeed;
         if(_loc1_ < climb.length && outOfTrap)
         {
            if(climb[_loc1_])
            {
               helperAnimation.setFrame(climb[_loc1_]);
            }
         }
         else if(!setFrame11)
         {
            animFrame = 10;
            setFrame11 = true;
         }
      }
   }
}

