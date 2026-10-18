package Objects
{
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import Scenes.*;
   import Tools.Interpolation;
   import Tools.PathfindSquare;
   import flash.display.*;
   
   public class Door extends GameObject
   {
      
      public var targetGridX:int = 0;
      
      public var targetGridY:int = 0;
      
      public var openAnim2:Array;
      
      public var opening:Boolean = false;
      
      public var openProgress:int = 0;
      
      public var openAnim3:Array;
      
      public var dominant:Boolean = false;
      
      public var topMask:DoorMask;
      
      public var lockedSprite:GameObject;
      
      public var rotationCount:int = 0;
      
      public var openAnim:Array;
      
      public var floorTileX:int;
      
      public var floorTileY:int;
      
      public function Door(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Door_constructor.baseim_embed,Door_constructor.LayerName,param2,param3);
         Door_constructor.setup(param1,this);
      }
      
      public function unlock(param1:GameObject) : void
      {
         emitConditionalParticles("Teleport");
         MainScene(gs).player.unlockPath(targetGridX,targetGridY);
         if(MainScene(gs).currentLevel)
         {
            if(MainScene(gs).currentLevel.overArrows)
            {
               param1 = MainScene(gs).currentLevel.overArrows[rotationCount];
               if(param1)
               {
                  param1.remove();
               }
            }
         }
      }
      
      public function setOpen(param1:Boolean) : void
      {
         if(param1)
         {
            openProgress = 100;
         }
         else
         {
            openProgress = 0;
         }
         setBitmap();
      }
      
      override public function _remove() : void
      {
         if(topMask)
         {
            topMask.remove();
         }
      }
      
      override public function _update() : void
      {
         var _loc3_:GameObject = null;
         var _loc4_:int = 0;
         var _loc5_:GameObject = null;
         var _loc6_:int = 0;
         var _loc7_:GameObjectFilterSqrtInterpolateIn = null;
         var _loc1_:PathfindSquare = MainScene(gs).toPlayer.getField(floorTileX,floorTileY);
         if(!_loc1_.exists)
         {
            if(lockedSprite)
            {
               lockedSprite.hide();
            }
            hide();
         }
         else
         {
            if(lockedSprite)
            {
               lockedSprite.show();
            }
            show();
         }
         super._update();
         if(!dominant)
         {
            dominant = true;
            for each(_loc3_ in gs.objects)
            {
               if(_loc3_ != this)
               {
                  if(_loc3_ is Door)
                  {
                     if(Door(_loc3_).dominant)
                     {
                        dominant = false;
                     }
                  }
               }
            }
         }
         var _loc2_:Boolean = MainScene(gs).countEnemies() == 0;
         if(MainScene(gs).countKeys() != 0)
         {
            _loc2_ = false;
         }
         if(MainScene(gs).player.pathLocked(targetGridX,targetGridY))
         {
            _loc2_ = false;
            if(MainScene(gs).countEnemies() == 0)
            {
               if(MainScene(gs).currentLevel.overArrows)
               {
                  if(!opening)
                  {
                     if(MainScene(gs).player.hasKeysFor(targetGridX,targetGridY))
                     {
                        if(distanceToObject(MainScene(gs).player) < 100)
                        {
                           _loc4_ = MainScene(gs).player.removeKey(MainScene(gs).player.keyTypeFor(targetGridX,targetGridY));
                           _loc5_ = MainScene(gs).player.hudKeys.copyIcon(_loc4_);
                           _loc6_ = _loc4_;
                           while(_loc6_ < MainScene(gs).player.hudKeys.value)
                           {
                              _loc3_ = MainScene(gs).player.hudKeys.sprites[_loc6_];
                              _loc7_ = new GameObjectFilterSqrtInterpolateIn();
                              _loc7_.dx = MainScene(gs).player.hudKeys.spriteWidth;
                              _loc7_.removeFilterWhenDoneReposition = false;
                              _loc7_.FadeTime = 50;
                              _loc7_.removeFilterWhenDone = true;
                              _loc3_.addFilter(_loc7_);
                              _loc6_++;
                           }
                           opening = true;
                           Sounds.doorUnlock.play();
                           _loc5_.helper.slideTo(basex,basey,true,75,unlock);
                        }
                     }
                  }
               }
            }
         }
         if(MainScene(gs).player.inLevelEnd())
         {
            _loc2_ = false;
         }
         if(_loc2_)
         {
            if(openProgress == 0)
            {
               Sounds.doorOpen.play();
            }
            openProgress = Math.min(openProgress + 2.5,100);
         }
         else
         {
            openProgress = Math.max(openProgress - 2.5,0);
         }
         setBitmap();
         if(openProgress >= 0)
         {
            if(!topMask)
            {
               topMask = new DoorMask(gs,basex,basey);
               topMask.baseRotation = baseRotation;
               if(MainScene(gs).currentEpisode > 3)
               {
                  if(MainScene(gs).currentEpisode <= 7)
                  {
                     topMask.helperAnimation.setFrame(new Embeds.doormask_b_png().bitmapData);
                  }
                  else
                  {
                     topMask.helperAnimation.setFrame(new Embeds.doormask_b_png().bitmapData);
                  }
               }
            }
         }
         else if(MainScene(gs).fading == 0)
         {
            if(topMask)
            {
               topMask.remove();
               topMask = null;
            }
         }
         if(topMask)
         {
            topMask.baseAlpha = Interpolation.lockValue(openProgress / 30,0,1);
         }
         if(topMask)
         {
            topMask.hidden = hidden;
         }
      }
      
      public function setBitmap() : void
      {
         if(MainScene(gs).currentEpisode <= 3)
         {
            setFrameFromRange(openProgress,100,openAnim);
         }
         else if(MainScene(gs).currentEpisode <= 7)
         {
            setFrameFromRange(openProgress,100,openAnim2);
         }
         else
         {
            setFrameFromRange(openProgress,100,openAnim3);
         }
      }
   }
}

