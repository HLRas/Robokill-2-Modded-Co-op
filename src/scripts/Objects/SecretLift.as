package Objects
{
   import GameObject.*;
   import GameScene.GameScene;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import flash.display.*;
   
   public class SecretLift extends GameObjectBase
   {
      
      public static var secretElevatorX:int = 0;
      
      public static var secretElevatorY:int = 0;
      
      public var hasBeenOver:Boolean = false;
      
      public var animProgress:int = 0;
      
      public var open:Boolean = false;
      
      public var animPlaying:Boolean = false;
      
      public function SecretLift(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,SecretLift_constructor.baseim_embed,SecretLift_constructor.LayerName,param2,param3);
         SecretLift_constructor.setup(param1,this);
      }
      
      public function getGrid() : Array
      {
         var _loc1_:int = 0;
         while(_loc1_ < ms.player.lg.grid[ms.player.gridy].length)
         {
            if(ms.player.lg.getCellData(_loc1_,ms.player.gridy,"SecretTarget"))
            {
               return [_loc1_,ms.player.gridy];
            }
            _loc1_++;
         }
         return null;
      }
      
      override public function _update() : void
      {
         if(!(this is SecretLiftFloor))
         {
            if(open)
            {
               if(!animPlaying)
               {
                  Sounds.elevatorOpen.play();
                  animPlaying = true;
                  hasBeenOver = true;
               }
            }
            if(animPlaying)
            {
               if(ticks % 5 == 0)
               {
                  ++animProgress;
               }
               if(animProgress >= imageSet.length)
               {
                  animProgress = imageSet.length - 1;
               }
               helperAnimation.setFrame(imageSet[animProgress]);
            }
         }
         if(readyToBeUsed())
         {
            if(ms.countEnemies() == 0)
            {
               if(ms.player.spriteCollidesWith(this))
               {
                  if(hasBeenOver)
                  {
                     if(!ms.fading)
                     {
                        if(!(this is SecretLiftFloor))
                        {
                           secretElevatorX = ms.player.gridx;
                           secretElevatorY = ms.player.gridy;
                        }
                        ms.fading = 1;
                        ms.player.gridx = getGrid()[0];
                        ms.player.gridy = getGrid()[1];
                        ms.player.seekLift = true;
                        Sounds.elevatorUse.play();
                     }
                  }
               }
               else
               {
                  hasBeenOver = true;
               }
            }
         }
         super._update();
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey","open","animPlaying","animProgress"];
      }
      
      public function readyToBeUsed() : Boolean
      {
         return open && animProgress == imageSet.length - 1;
      }
   }
}

