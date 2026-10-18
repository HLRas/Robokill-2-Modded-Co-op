package Audio
{
   import GameObject.GameObject;
   import Tools.Interpolation;
   import flash.events.Event;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class GameSoundChannel
   {
      
      public static var allChannels:Array = new Array();
      
      public var fadeIn:Number = 0;
      
      public var chan:SoundChannel;
      
      public var fullVolumeSet:Boolean = false;
      
      public var fadeOutTime:Number = 0;
      
      public var _remove:Boolean = false;
      
      public var _pan:Number;
      
      public var gs:GameSound;
      
      public var _playing:Boolean = true;
      
      public var chanStart:Number = 0;
      
      public var currentVolume:Number = 1;
      
      public var fadeOut:Number = 0;
      
      public var tiedObject:GameObject;
      
      public var looping:Boolean = false;
      
      public function GameSoundChannel(param1:GameSound, param2:SoundChannel, param3:Boolean = false, param4:Number = 0)
      {
         super();
         if(param2)
         {
            chanStart = param2.position;
            chan = param2;
         }
         else
         {
            _playing = false;
         }
         if(chan)
         {
            chan.addEventListener(Event.SOUND_COMPLETE,complete);
         }
         fadeIn = param4;
         looping = param3;
         gs = param1;
         if(gs)
         {
            allChannels.push(this);
         }
      }
      
      public static function updateAll() : void
      {
         var gsc:GameSoundChannel = null;
         allChannels = allChannels.filter(function(param1:GameSoundChannel, param2:int, param3:Array):Boolean
         {
            return !param1._remove;
         });
         for each(gsc in allChannels)
         {
            gsc.update();
         }
      }
      
      public function complete(param1:Event) : void
      {
         if(!chan)
         {
            return;
         }
         if(_playing == false)
         {
            return;
         }
         chan.removeEventListener(Event.SOUND_COMPLETE,complete);
         chan.stop();
         chanStart -= chan.position;
         fadeOutTime -= chan.position;
         if(looping)
         {
            chan = gs.s.play(0,0,new SoundTransform(vol(),pan()));
            if(chan)
            {
               chan.addEventListener(Event.SOUND_COMPLETE,complete);
            }
         }
         else
         {
            _playing = false;
            _remove = true;
         }
      }
      
      public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:SoundTransform = null;
         if(!chan)
         {
            return;
         }
         if(fadeIn != 0 || fadeOut != 0)
         {
            if(chan.position - chanStart < fadeIn || fadeOut != 0)
            {
               _loc1_ = Interpolation.linearInterpolateLock(0,1,Interpolation.fromTo(chan.position - chanStart,0,fadeIn));
               _loc2_ = 1;
               if(fadeOut != 0)
               {
                  _loc2_ = Interpolation.linearInterpolateLock(1,0,Interpolation.fromTo(chan.position,fadeOutTime,fadeOutTime + fadeOut));
               }
               _loc3_ = new SoundTransform(_loc1_ * _loc2_ * vol(),pan());
               chan.soundTransform = _loc3_;
            }
            else
            {
               fullVolumeSet = true;
               _loc3_ = new SoundTransform(vol(),pan());
               chan.soundTransform = _loc3_;
            }
         }
         else
         {
            _loc3_ = new SoundTransform(vol());
            chan.soundTransform = _loc3_;
         }
         if(tiedObject)
         {
            if(tiedObject._removed)
            {
               stop();
            }
         }
         if(fadeOut != 0)
         {
            if(chan.position > fadeOutTime + fadeOut)
            {
               stop();
            }
         }
      }
      
      public function tieTo(param1:GameObject) : void
      {
         tiedObject = param1;
      }
      
      public function stop(param1:Number = 0) : void
      {
         if(!chan)
         {
            return;
         }
         if(param1 != 0)
         {
            fadeOutTime = chan.position;
            fadeOut = param1;
            return;
         }
         _playing = false;
         chan.removeEventListener(Event.SOUND_COMPLETE,complete);
         chan.stop();
         _remove = true;
      }
      
      public function vol() : Number
      {
         if(!gs)
         {
            return 1;
         }
         var _loc1_:Number = currentVolume * gs.eqVolume;
         if(gs.isMusic)
         {
            _loc1_ *= GameSound.globalMusicVolume;
            if(GameSound.globalMusicMute)
            {
               _loc1_ = 0;
            }
         }
         else
         {
            _loc1_ *= GameSound.globalSoundVolume;
            if(GameSound.globalSoundMute)
            {
               _loc1_ = 0;
            }
         }
         return _loc1_;
      }
      
      public function setVolume(param1:Number) : void
      {
         currentVolume = param1;
      }
      
      public function pan() : Number
      {
         return _pan;
      }
      
      public function position() : Number
      {
         if(!chan)
         {
            return 0;
         }
         return chan.position;
      }
      
      public function playing() : Boolean
      {
         if(fadeOut != 0)
         {
            return false;
         }
         return _playing;
      }
   }
}

