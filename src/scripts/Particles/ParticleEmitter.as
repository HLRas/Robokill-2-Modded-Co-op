package Particles
{
   import GameScene.GameScene;
   import Tools.Random;
   import flash.display.BlendMode;
   
   public class ParticleEmitter
   {
      
      public static var tempDisableLayerOverride:Boolean = false;
      
      public var y:Number;
      
      public var startrotationhigh:Number = 0;
      
      public var imageSet:Array;
      
      public var startScale:Number = 0;
      
      public var yspeedhigh:Number = 0;
      
      public var killatanimend:int = 0;
      
      public var rotatespeedtodirection:int = 0;
      
      public var Friction:Number = 0;
      
      public var layeroverride:String = "";
      
      public var lifehigh:int = 100;
      
      public var xspeedlow:Number = 0;
      
      public var yspeedlow:Number = 0;
      
      public var animspeedrange:int = 0;
      
      public var Name:String;
      
      public var endScale:Number = 0;
      
      public var x:Number;
      
      public var Test:int = 0;
      
      public var Frequency:int = 0;
      
      public var startalpha:Number = 1;
      
      public var dRotationHigh:Number = 0;
      
      public var gravitylow:Number = 0;
      
      public var impath:String;
      
      public var Identifier:String = "";
      
      public var StayAfterDeath:Boolean = false;
      
      public var additive:int = 0;
      
      public var lifelow:int = 100;
      
      public var image:Class;
      
      public var animspeed:Number = 1;
      
      public var endalpha:Number = 1;
      
      public var animframecap:int = 0;
      
      public var gravityhigh:Number = 0;
      
      public var xspeedhigh:Number = 0;
      
      public var dRotationLow:Number = 0;
      
      public var startrotationlow:Number = 0;
      
      public var filters:Array = new Array();
      
      public function ParticleEmitter()
      {
         super();
      }
      
      public function emitOnto(param1:ParticleLayer, param2:Number, param3:Number, param4:Number = 0, param5:Function = null) : Array
      {
         var _loc9_:ParticleLayer = null;
         var _loc10_:Particle = null;
         if(isNaN(param2) || isNaN(param3) || param2 == 0 && param3 == 0)
         {
            return new Array();
         }
         if(!tempDisableLayerOverride)
         {
            if(layeroverride != "" && layeroverride != null)
            {
               _loc9_ = GameScene.current().getZOrder(layeroverride).pl;
               if(_loc9_)
               {
                  param1 = _loc9_;
               }
            }
         }
         var _loc6_:int = 0;
         if(Frequency >= 0)
         {
            _loc6_ = Frequency;
         }
         else if(int(Math.random() > 1 - 1 / (1 - Frequency)) == 1)
         {
            _loc6_ = 1;
         }
         if(Frequency == 0)
         {
            _loc6_ = 1;
         }
         var _loc7_:Array = new Array(_loc6_);
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_)
         {
            _loc10_ = param1.addParticle(image);
            _loc7_[_loc8_] = _loc10_;
            _loc10_.imageSet = imageSet;
            if(imageSet)
            {
               _loc10_.lastframe = Random.randInt(imageSet.length - animframecap - 1,imageSet.length - 1);
            }
            _loc10_.layer = param1;
            _loc10_.x = param2;
            _loc10_.y = param3;
            _loc10_.TotalLife = rand(lifelow,lifehigh);
            _loc10_.Rotation = rand(startrotationlow,startrotationhigh) + param4;
            _loc10_.dRotation = rand(dRotationLow,dRotationHigh);
            _loc10_.deathCallback = param5;
            _loc10_.baseWidth = _loc10_.b.width;
            _loc10_.baseHeight = _loc10_.b.height;
            _loc10_.dx = rand(xspeedlow,xspeedhigh);
            _loc10_.dy = rand(yspeedlow,yspeedhigh);
            _loc10_.ay = rand(gravitylow,gravityhigh);
            _loc10_.StartAlpha = startalpha;
            _loc10_.EndAlpha = endalpha;
            _loc10_.StartScale = startScale;
            _loc10_.EndScale = endScale;
            _loc10_.StayAfterDeath = StayAfterDeath;
            _loc10_.b.alpha = _loc10_.StartAlpha;
            _loc10_.b.scaleX = _loc10_.StartScale;
            _loc10_.b.scaleY = _loc10_.StartScale;
            _loc10_.Friction = Friction;
            _loc10_.identifier = Identifier;
            _loc10_.filters = filters;
            _loc10_.animSpeed = animspeed + Random.randInt(0,animspeedrange);
            _loc10_.killatanimend = killatanimend;
            if(additive)
            {
               _loc10_.Blend = BlendMode.ADD;
            }
            _loc10_.update();
            _loc8_++;
         }
         return _loc7_;
      }
      
      public function addFilter(param1:ParticleFilter) : void
      {
         filters.push(param1);
      }
      
      public function rand(param1:Number, param2:Number) : Number
      {
         return param1 + Math.random() * (param2 - param1);
      }
   }
}

