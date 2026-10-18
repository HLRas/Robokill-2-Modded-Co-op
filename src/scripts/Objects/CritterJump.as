package Objects
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterHeight;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectConstructors.CritterJump_constructor;
   import Tools.Interpolation;
   
   public class CritterJump extends Critter
   {
      
      public var isJumping:int = 0;
      
      public var jump:Array;
      
      public var heightFilter:GameObjectFilterHeight;
      
      public function CritterJump(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         CritterJump_constructor.setup(param1,this);
         heightFilter = new GameObjectFilterHeight(0);
         addFilter(heightFilter);
         extraHealth *= 6;
         baseHealth *= 10;
      }
      
      override public function doMovement() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:Number = NaN;
         ms.currentLevel.enragedBugs = true;
         heightFilter.height = Math.sin(isJumping / 100 * Math.PI) * 10;
         _loc1_ = helper.conditionallyCreateChild(Embeds.runner2_shadow_png,"Shadow",isJumping > 0,1);
         if(_loc1_)
         {
            _loc1_.basex = basex + heightFilter.height * 2;
            _loc1_.basey = basey + heightFilter.height * 2;
            _loc1_.baseRotation = baseRotation;
            _loc1_.changeZOrder("Floor",true);
         }
         if(isJumping)
         {
            changeZOrder(zOrderString);
            moveAlongAngle(4,baseRotation - 90);
            ++isJumping;
            if(isJumping > 100)
            {
               isJumping = 0;
            }
         }
         else
         {
            super.doMovement();
            if(helperFilter.rotationAligned())
            {
               _loc2_ = angleToObject(ms.player) + 90;
               if(Interpolation.distanceToAngle(_loc2_,baseRotation) < 2)
               {
                  if(distanceToPlayer() < 200)
                  {
                     if(ticks > 200)
                     {
                        isJumping = 1;
                     }
                  }
               }
            }
         }
      }
      
      override public function _update() : void
      {
         collidesWithWalls = !isJumping;
         super._update();
      }
      
      override public function _experience() : int
      {
         return 60;
      }
      
      override public function updateAnimation() : void
      {
         if(isJumping)
         {
            if(isJumping < 50)
            {
               helperAnimation.setFrame(jump[int(isJumping / 10)]);
            }
            else if(isJumping > 50)
            {
               helperAnimation.setFrame(jump[int((100 - isJumping) / 10)]);
            }
            else
            {
               helperAnimation.setFrame(jump[4]);
            }
            animFreeze = true;
         }
         else
         {
            animFreeze = false;
            super.updateAnimation();
         }
      }
   }
}

