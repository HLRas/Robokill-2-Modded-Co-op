package Audio
{
   import Tools.Random;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.*;
   
   public class GameSound
   {
      
      public static var globalSoundVolume:Number = 1;
      
      public static var globalMusicVolume:Number = 1;
      
      public static var globalSoundMute:Boolean = false;
      
      public static var globalMusicMute:Boolean = false;
      
      public static var __id:int = 0;
      
      public static var allSounds:Array = new Array();
      
      public var alternates:Array;
      
      public var lastAlternate:int = 0;
      
      public var lastPlayed:int = -10;
      
      public var eqVolume:Number = 1;
      
      public var sc:SoundChannel;
      
      public var minDelay:int = 0;
      
      public var s:Sound;
      
      public var embed:Class;
      
      public var isMusic:Boolean = false;
      
      public var id:int = 0;
      
      public function GameSound(param1:Class, param2:Number, param3:int = 0)
      {
         super();
         embed = param1;
         s = new embed();
         eqVolume = param2;
         minDelay = param3;
         allSounds.push(this);
      }
      
      public static function forEmbedArray(param1:Array, param2:Number, param3:int = 0) : GameSound
      {
         var _loc5_:int = 0;
         if(!(param1[0] is Class))
         {
            return null;
         }
         var _loc4_:GameSound = forEmbed(param1[0],param2,param3);
         if(_loc4_)
         {
            _loc5_ = 1;
            while(_loc5_ < param1.length)
            {
               _loc4_.addAlternate(forEmbed(param1[_loc5_],param2,param3));
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public static function forEmbed(param1:Class, param2:Number, param3:int = 0) : GameSound
      {
         var _loc5_:GameSound = null;
         var _loc6_:GameSound = null;
         var _loc4_:Sound = new param1();
         for each(_loc5_ in allSounds)
         {
            if(_loc5_.s.bytesTotal == _loc4_.bytesTotal && _loc5_.s.length == _loc4_.length)
            {
               return _loc5_;
            }
         }
         _loc6_ = new GameSound(param1,param2,param3);
         ++__id;
         _loc6_.id = __id;
         return _loc6_;
      }
      
      public function addAlternate(param1:GameSound) : void
      {
         if(!alternates)
         {
            alternates = new Array();
            alternates.push(this);
         }
         alternates.push(param1);
      }
      
      public function play(param1:Boolean = false, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Boolean = false) : GameSoundChannel
      {
         var _loc9_:int = 0;
         var _loc10_:GameSoundChannel = null;
         if(!param5)
         {
            if(getTimer() - lastPlayed < minDelay)
            {
               return new GameSoundChannel(null,null);
            }
            lastPlayed = getTimer();
         }
         if(Boolean(alternates) && !param5)
         {
            _loc9_ = lastAlternate;
            while(_loc9_ == lastAlternate && alternates.length > 0)
            {
               _loc9_ = Random.randInt(0,alternates.length - 1);
            }
            lastAlternate = _loc9_;
            return alternates[_loc9_].play(param1,param2,param3,param4,true);
         }
         var _loc6_:Number = eqVolume;
         if(isMusic)
         {
            _loc6_ *= globalMusicVolume;
            if(globalMusicMute)
            {
               _loc6_ = 0;
            }
         }
         else
         {
            _loc6_ *= globalSoundVolume;
            if(globalSoundMute)
            {
               _loc6_ = 0;
            }
         }
         var _loc7_:SoundTransform = new SoundTransform(_loc6_,param4);
         if(param3)
         {
            _loc7_.volume = 0;
         }
         param2 %= s.length;
         sc = null;
         var _loc8_:Boolean = false;
         while(sc == null)
         {
            if(param1)
            {
               if(param2 == 0)
               {
                  sc = s.play(param2,99,_loc7_);
               }
               else
               {
                  sc = s.play(param2,0,_loc7_);
               }
            }
            else
            {
               sc = s.play(param2,0,_loc7_);
            }
            if(sc == null)
            {
               return new GameSoundChannel(null,null);
            }
         }
         if(sc)
         {
            _loc10_ = new GameSoundChannel(this,sc,param1,param3);
            _loc10_._pan = param4;
            return _loc10_;
         }
         return new GameSoundChannel(null,null);
      }
      
      public function playSpecific(param1:int) : GameSoundChannel
      {
         if(!alternates)
         {
            return play();
         }
         if(alternates.length <= param1)
         {
            return play();
         }
         return alternates[param1].play(false,0,0,0,true);
      }
   }
}

