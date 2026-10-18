package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObjectFilterRecoil;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import Objects.GruntLegs;
   import Scenes.MainScene;
   import Tools.Random;
   
   public class HulkBase extends EnemyBase
   {
      
      public var lastDitchedDirection:int = 0;
      
      public var shooting:int = 0;
      
      public var guns:Array;
      
      public var nextShot:int = Random.randInt(50,150);
      
      public var turn:Boolean = false;
      
      public var justShot:int = 0;
      
      public function HulkBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         legs = new GruntLegs(param1,0,0);
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(2));
         baseHealth *= 6;
         extraHealth *= 4;
      }
      
      public function shootAtPlayer() : void
      {
         turn = !turn;
         var _loc1_:int = turn ? -1 : 1;
         var _loc2_:int = _loc1_ * 12;
         var _loc3_:int = -8;
         if(shootBullet(_loc2_,_loc3_))
         {
            addFilter(new GameObjectFilterRecoil(15,-4));
         }
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.hulkFire;
      }
      
      override public function pushing(param1:GameObjectBase) : void
      {
         if(lastDitchedDirection > 20)
         {
            lastDitchedDirection = 0;
            lastDestX = -1;
         }
      }
      
      override public function _experience() : int
      {
         return 40;
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         ++lastDitchedDirection;
         super._update();
         if(shooting == 0)
         {
            moveRandomly();
         }
         if(frozen)
         {
            return;
         }
         if(shooting == 0)
         {
            if(!isTeleporting())
            {
               --nextShot;
            }
            if(justShot > 0)
            {
               --justShot;
            }
            if(nextShot < 0 && justShot == 0)
            {
               nextShot = Math.random() * 50 + 80;
               shooting = 1;
            }
            legs.animFreeze = false;
         }
         else
         {
            legs.animFreeze = true;
            baseRotation = angleToObject(MainScene(gs).player) + 90;
            legs.baseRotation = baseRotation;
            ++shooting;
            if(shooting >= 80)
            {
               if(shooting % 10 == 1)
               {
                  shootAtPlayer();
               }
            }
            if(shooting == 140)
            {
               shooting = 0;
               justShot = 50;
            }
         }
      }
      
      override public function shrapnelCount() : int
      {
         return 3;
      }
   }
}

