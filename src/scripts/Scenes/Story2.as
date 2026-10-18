package Scenes
{
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.StoryShip2;
   import SceneConstructors.Story2_constructor;
   import Tools.Interpolation;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Story2 extends GameScene
   {
      
      public var textSound:GameSoundChannel;
      
      public var ship:StoryShip2;
      
      public var skipped:Boolean = false;
      
      public var skip:GameObject;
      
      public function Story2()
      {
         super();
         Story.setStoryText(this,"DESTINATION: MARS MINING FACILITY LEVIATHAN FIVE. \nMISSION: PREPARE FOR EMERGENCY LANDING.",finishSound);
         updateWhenRemoving = true;
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc1_:Number = Ticks / 800;
         ship.basex = Interpolation.linearInterpolate(0,489,_loc1_);
         ship.basey = Interpolation.linearInterpolate(64,182,_loc1_);
         for each(_loc2_ in objects)
         {
            if(_loc2_.obj is Bitmap)
            {
               Bitmap(_loc2_.obj).smoothing = true;
            }
         }
         if(Ticks == 40)
         {
            textSound = Sounds.textPrint.play();
         }
         if(Ticks == 660 && !skipped)
         {
            pushScene(new MainMenu(),true);
         }
         if(!skipped)
         {
            if(skip.mHit())
            {
               pushScene(new MainMenu(),true);
               Story.introTrackPlay.stop(250);
               skipped = true;
            }
         }
      }
      
      override public function _register(param1:Sprite) : void
      {
         var _loc2_:Story2_constructor = new Story2_constructor();
         _loc2_.register(this,param1,true);
         ship = new StoryShip2(this,0,64);
      }
      
      override public function init() : void
      {
         skip = MainMenu.addNormalStyledButton(this,"SKIP",Embeds.levelup_ok_png,Embeds.levelup_ok_over_png,"",-25);
         skip.basex = 734;
         skip.basey = 573;
      }
      
      public function finishSound() : void
      {
         textSound.stop();
      }
   }
}

