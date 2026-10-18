package ObjectBase
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.GruntLegs;
   import flash.display.Bitmap;
   
   public class ChargeBase extends EnemyBase
   {
      
      public var blah:Object = new Object();
      
      public var inCover:int = 0;
      
      public var cover:Array;
      
      public var coverLength:int = 200;
      
      public var nextInCover:int = 0;
      
      public function ChargeBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         legs = new GruntLegs(param1,0,0);
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(2));
         baseHandleY = 0.7;
         baseHealth *= 4;
         extraHealth *= 4;
         coverLength = 50 + 150 * Math.random();
      }
      
      public function pushBack(param1:Number, param2:Number) : void
      {
         basex += cosd(param1 + 90) * param2;
         basey += sind(param1 + 90) * param2;
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:GameObject = null;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         if(inCover == 0)
         {
            moveTowardsPlayer(2);
            legs.animFreeze = false;
         }
         else
         {
            moveTowardsPlayer(0);
            legs.animFreeze = true;
            legs.baseRotation = baseRotation;
         }
         if(inCover)
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
         }
      }
      
      override public function hitBy(param1:BulletBase, param2:int = 0) : void
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
   }
}

