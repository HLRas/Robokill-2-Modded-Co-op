package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.GruntLegs;
   import flash.display.Bitmap;
   
   public class BeserkerBase extends EnemyBase
   {
      
      public var side:Boolean = false;
      
      public var blah:Object = new Object();
      
      public var inCover:int = 0;
      
      public var cover:Array;
      
      public var coverLength:int = 400;
      
      public var nextInCover:int = 0;
      
      public function BeserkerBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         legs = new GruntLegs(param1,0,0);
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(2));
         baseHandleY = 0;
         baseHealth *= 150;
         extraHealth *= 150;
      }
      
      public function fireticks() : int
      {
         return 200;
      }
      
      public function pushBack(param1:Number, param2:Number) : void
      {
         basex += cosd(param1 + 90) * param2;
         basey += sind(param1 + 90) * param2;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.shieldGunnerFire;
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:GameObject = null;
         baseHandleY = 0.7;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         moveTowardsPlayer(0.5);
         if(inCover > 0)
         {
            ++inCover;
            if(inCover > coverLength)
            {
               inCover = 0;
            }
            _loc1_ = inCover;
            if(inCover > coverLength - 10)
            {
               _loc1_ = coverLength - inCover;
            }
            if(_loc1_ >= 7)
            {
               _loc1_ = 6;
            }
            Bitmap(obj).bitmapData = cover[_loc1_];
            randTicks = 200;
         }
         else
         {
            --nextInCover;
            if(nextInCover < 0)
            {
               inCover = 1;
               nextInCover = Math.random() * 100 + 150;
            }
            _loc2_ = 0;
            for each(_loc3_ in gs.objects)
            {
               if(_loc3_ is ChargeBase)
               {
                  _loc2_++;
               }
            }
            coverLength = 50 + 150 * Math.random() + 50 * (_loc2_ - 1);
            if(randTicks % 300 > fireticks())
            {
               if(distanceToPlayer() > 300)
               {
                  if(randTicks % 20 == 0)
                  {
                     shootMissile(10,-20);
                  }
               }
               else if(randTicks % 10 == 0)
               {
                  shootBullet(10,-10,2);
               }
            }
         }
      }
      
      override public function _experience() : int
      {
         return 400;
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         if(inCover != 0)
         {
            if(blah[param1.id] != "asdf")
            {
               blah[param1.id] = "asdf";
               pushBack(param1.baseRotation,3);
               param1.hitByShield();
            }
         }
         else
         {
            super.hitBy(param1,param2);
         }
      }
      
      override public function shrapnelCount() : int
      {
         return 6;
      }
      
      override public function legOffsetMultiplier() : Number
      {
         return 1;
      }
   }
}

