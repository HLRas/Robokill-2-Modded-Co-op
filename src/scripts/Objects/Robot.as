package Objects
{
   import Audio.GameSoundChannel;
   import GameScene.GameScene;
   import ObjectBase.AlienBase;
   import ObjectConstructors.Robot_constructor;
   
   public class Robot extends AlienBase
   {
      
      public var chan:GameSoundChannel;
      
      public var audio:Boolean = true;
      
      public function Robot(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Robot_constructor.baseim_embed,Robot_constructor.LayerName,param2,param3);
         Robot_constructor.setup(param1,this);
      }
      
      override public function _update() : void
      {
         super._update();
         if(ticks == 20 && audio)
         {
            chan = Sounds.textPrint.play(true);
            chan.setVolume(0.2);
         }
         if(!isTalking)
         {
            if(chan)
            {
               chan.stop();
            }
         }
      }
      
      override public function _remove() : void
      {
         if(chan)
         {
            chan.stop();
         }
      }
   }
}

