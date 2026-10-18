package Scenes
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterTextType;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.StoryShip1;
   import SceneConstructors.Story_constructor;
   import Tools.GraphicsTools;
   import Tools.Interpolation;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageQuality;
   
   public class Story extends GameScene
   {
      
      public static var introTrackPlay:GameSoundChannel;
      
      public var textSound:GameSoundChannel;
      
      public var skipped:Boolean = false;
      
      public var fading:GameObject;
      
      public var ship:StoryShip1;
      
      public var skip:GameObject;
      
      public function Story()
      {
         super();
         setStoryText(this,"MERCENARY SHIP: DARKSTAR \nSTATUS: HEAVILY DAMAGED",finishSound);
         updateWhenRemoving = true;
         MainMenu.readPrefs();
         GameSound.globalMusicVolume = MainMenu.musicEnabled ? 1 : 0;
         GameSound.globalSoundVolume = MainMenu.soundEnabled ? 1 : 0;
         fading = new GameObject(this,GraphicsTools.createFilledSprite(800,600,4278190080),"AfterTextLayer",400,300);
         ship = new StoryShip1(this,0,297);
      }
      
      public static function setStoryText(param1:GameScene, param2:String, param3:Function = null) : void
      {
         var _loc4_:GameObject = new GameObject(param1,null,"TextLayer",7,4);
         _loc4_.setText("",20);
         var _loc5_:GameObjectFilterTextType = new GameObjectFilterTextType();
         _loc5_.txt = param2;
         _loc5_.speed = 1.25;
         _loc5_.finishCallback = param3;
         _loc4_.addFilter(_loc5_);
         _loc4_.baseHandleX = 0;
         _loc4_.baseHandleY = 0;
      }
      
      public function finishSound() : void
      {
         textSound.stop();
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc1_:Number = Ticks / 400;
         _loc1_ = Math.pow(_loc1_,0.65);
         ship.basex = Interpolation.linearInterpolate(0,733,_loc1_);
         ship.basey = Interpolation.linearInterpolate(297,456,_loc1_);
         ship.baseScaleX = Interpolation.linearInterpolate(1,0.4,_loc1_);
         ship.baseScaleY = ship.baseScaleX;
         if(Ticks == 10)
         {
            introTrackPlay = Sounds.introTrack.play();
         }
         if(fading)
         {
            fading.baseAlpha -= 0.02;
            if(fading.baseAlpha < 0)
            {
               fading.remove();
               fading = null;
            }
         }
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
         if(Ticks == 700 && !skipped)
         {
            pushScene(new Story2(),true);
         }
         if(!skipped)
         {
            if(skip.mHit())
            {
               pushScene(new MainMenu(),true);
               if(Story.introTrackPlay)
               {
                  Story.introTrackPlay.stop(250);
               }
               skipped = true;
            }
         }
      }
      
      override public function _register(param1:Sprite) : void
      {
         var _loc2_:Story_constructor = new Story_constructor();
         _loc2_.register(this,param1,true);
      }
      
      override public function init() : void
      {
         skip = MainMenu.addNormalStyledButton(this,"SKIP",Embeds.levelup_ok_png,Embeds.levelup_ok_over_png,"",-25);
         skip.basex = 734;
         skip.basey = 573;
         Sounds.introTrack.isMusic = true;
         var _loc1_:Stage = m.stage;
         if(_loc1_)
         {
            if(MainMenu.levelOfDetail)
            {
               _loc1_.quality = StageQuality.BEST;
            }
            else
            {
               _loc1_.quality = StageQuality.MEDIUM;
            }
         }
      }
   }
}

