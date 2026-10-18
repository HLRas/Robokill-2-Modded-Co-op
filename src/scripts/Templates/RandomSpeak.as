package Templates
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import Tools.Random;
   
   public class RandomSpeak
   {
      
      public var channel:GameSoundChannel;
      
      public var last:int = -1;
      
      public var sound:GameSound;
      
      public function RandomSpeak()
      {
         super();
      }
      
      public function play() : void
      {
         var _loc1_:int = last;
         while(_loc1_ == last)
         {
            _loc1_ = Random.randInt(0,sound.alternates.length - 1);
         }
         if(sound)
         {
            channel = sound.playSpecific(_loc1_);
         }
         last = _loc1_;
         trace(_loc1_);
      }
      
      public function update() : void
      {
         if(!channel)
         {
            play();
         }
         else if(!channel.playing())
         {
            play();
         }
         else if(channel.position() > sound.s.length - 400)
         {
            play();
         }
      }
   }
}

