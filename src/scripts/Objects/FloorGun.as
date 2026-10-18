package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.TerranTurretBase;
   import ObjectConstructors.FloorGun_constructor;
   import Tools.Interpolation;
   
   public class FloorGun extends TerranTurretBase
   {
      
      public var baseFrames:Array;
      
      public var popped:int = 0;
      
      public function FloorGun(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,FloorGun_constructor.baseim_embed,FloorGun_constructor.LayerName,param2,param3);
         FloorGun_constructor.setup(param1,this);
      }
      
      override public function collisionWidth() : Number
      {
         if(popped < 50)
         {
            return 0;
         }
         return super.collisionWidth();
      }
      
      override public function _update() : void
      {
         var _loc2_:int = 0;
         if(popped < 50)
         {
            doCollisions = false;
         }
         else
         {
            doCollisions = true;
         }
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.floor_gun001_png,"Floor",true,1);
         _loc1_.changeZOrder("Floor",true);
         _loc1_.tint(tintPositionR,tintPositionG,tintPositionB);
         super._update();
         if(popped < 100)
         {
            _loc2_ = _loc1_.setFrameFromRange(popped,100,baseFrames);
            if(_loc2_ == baseFrames.length - 1)
            {
               baseAlpha = 1;
               obj.alpha = 1;
               tint(tintPositionR,tintPositionG,tintPositionB);
            }
            else
            {
               baseRotation = 0;
               baseAlpha = 0;
            }
         }
         if(!target)
         {
            baseRotation = 0;
            if(Interpolation.distanceToAngle(0,helperFilter.getModifiedRotation()) < 1)
            {
               --popped;
            }
         }
         popped = Interpolation.lockValueInt(popped,0,100);
      }
      
      override public function collisionHeight() : Number
      {
         if(popped < 50)
         {
            return 0;
         }
         return super.collisionHeight();
      }
      
      override public function handleShooting() : void
      {
         var _loc1_:BulletBase = null;
         if(popped >= 100)
         {
            if(Interpolation.distanceToAngle(helperFilter.getModifiedRotation(),baseRotation) < 1)
            {
               if(randTicks % 200 < 100)
               {
                  if(randTicks % 10 == 0)
                  {
                     _loc1_ = shoot(HulkBullet,randTicks % 20 == 0 ? -10 : 10,-22);
                     if(_loc1_)
                     {
                        Sounds.enemyShoot.play();
                        _loc1_.canHitPlayer = ms.currentLevel.angryTerranTurrets;
                     }
                  }
               }
            }
         }
         else
         {
            ++popped;
         }
      }
   }
}

