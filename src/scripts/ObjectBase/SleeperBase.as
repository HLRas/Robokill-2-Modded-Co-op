package ObjectBase
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Tools.Interpolation;
   
   public class SleeperBase extends GunFighterBase
   {
      
      public var awake:Boolean = false;
      
      public var awakeProgress:int = 0;
      
      public function SleeperBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         baseHealth *= 2;
         extraHealth *= 1.2;
      }
      
      override public function fireticks() : int
      {
         return 240;
      }
      
      override public function canMove() : Boolean
      {
         return awakeProgress > 100 && awake;
      }
      
      public function awakeSpeed() : Number
      {
         return Interpolation.linearInterpolateLock(0,1,(awakeProgress - 100) / 100);
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.sleeperFire;
      }
      
      public function synergy() : int
      {
         var _loc2_:GameObject = null;
         var _loc1_:int = 0;
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is SleeperBase)
            {
               if(SleeperBase(_loc2_).awake)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         if(blockUpdating())
         {
            super._update();
            return;
         }
         _loc1_ = findChildrenByName("Glow")[0];
         _loc1_.basex = tformedX(6,4) - basex;
         _loc1_.basey = tformedY(6,4) - basey;
         super._update();
         if(awake)
         {
            ++awakeProgress;
            doFacePlayer();
            if(awakeProgress < 100)
            {
               doTinting(false,0.7 + awakeProgress / 100 * 0.3);
               _loc1_.baseAlpha = awakeProgress / 100;
            }
            else
            {
               _loc1_.baseAlpha = 1;
            }
            holdFire = awakeProgress < 200;
         }
         else
         {
            _loc1_.baseAlpha = 0;
            doTinting(false,0.7);
            legs.animFreeze = true;
         }
         if(ticks % 100 < 50)
         {
            _loc1_.baseAlpha *= 0.5;
         }
      }
      
      override public function _experience() : int
      {
         return 200;
      }
      
      override public function speed() : Number
      {
         return awakeSpeed() * Math.sqrt(Number(synergy()));
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         awake = true;
         super.hitBy(param1,param2);
      }
   }
}

