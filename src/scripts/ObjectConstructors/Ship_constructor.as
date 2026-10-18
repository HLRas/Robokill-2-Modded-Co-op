package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Ship_constructor
   {
      
      public static var LayerName:String = "AbovePlayer";
      
      public static var baseim_embed:Class = Embeds.ship_png;
      
      public static var baseim:BitmapData = new Embeds.ship_png().bitmapData;
      
      public static var child1_embed:Class = Embeds.pulse_01_png;
      
      public static var child1:BitmapData = new Embeds.pulse_01_png().bitmapData;
      
      public static var child2_embed:Class = Embeds.pulse_01_png;
      
      public static var child2:BitmapData = new Embeds.pulse_01_png().bitmapData;
      
      public static var child3_embed:Class = Embeds.decal_free_33_png;
      
      public static var child3:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public static var child4_embed:Class = Embeds.decal_free_33_png;
      
      public static var child4:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public static var child5_embed:Class = Embeds.decal_free_20_png;
      
      public static var child5:BitmapData = new Embeds.decal_free_20_png().bitmapData;
      
      public static var child6_embed:Class = Embeds.decal_free_20_png;
      
      public static var child6:BitmapData = new Embeds.decal_free_20_png().bitmapData;
      
      public static var child7_embed:Class = Embeds.pulse_04_png;
      
      public static var child7:BitmapData = new Embeds.pulse_04_png().bitmapData;
      
      public static var child8_embed:Class = Embeds.pulse_04_png;
      
      public static var child8:BitmapData = new Embeds.pulse_04_png().bitmapData;
      
      public function Ship_constructor()
      {
         super();
      }
      
      public static function setup(param1:GameScene, param2:GameObject) : void
      {
         var _loc3_:GameObjectFilter = null;
         var _loc4_:ParticleEmitter = null;
         var _loc5_:ParticleFilter = null;
         var _loc6_:GameObject = null;
         var _loc7_:GameObjectFilter = null;
         param2.baseHandleX = 0.5;
         param2.baseHandleY = 0.5;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 0;
         _loc6_ = new GameObject(param1,child1_embed,"AbovePlayer",46,-189);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 46;
         _loc6_.basey = -189;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterBlink();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterBlink(_loc7_).Interval = 6;
         GameObjectFilterBlink(_loc7_).AliveTime = 0;
         GameObjectFilterBlink(_loc7_).BlinkAlpha = 0.800000012;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child2_embed,"AbovePlayer",-46,-188);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -46;
         _loc6_.basey = -188;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterBlink();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterBlink(_loc7_).Interval = 6;
         GameObjectFilterBlink(_loc7_).AliveTime = 0;
         GameObjectFilterBlink(_loc7_).BlinkAlpha = 0.800000012;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child3_embed,"AbovePlayer",6,138);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 6;
         _loc6_.basey = 138;
         _loc6_.baseScaleX = 0.730000257;
         _loc6_.baseScaleY = 0.730000257;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child4_embed,"AbovePlayer",-7,139);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -7;
         _loc6_.basey = 139;
         _loc6_.baseScaleX = 0.57000041;
         _loc6_.baseScaleY = 0.57000041;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child5_embed,"AbovePlayer",-71,-73);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -71;
         _loc6_.basey = -73;
         _loc6_.baseScaleX = 1.74999928;
         _loc6_.baseScaleY = 1.74999928;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child6_embed,"AbovePlayer",72,-74);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 72;
         _loc6_.basey = -74;
         _loc6_.baseScaleX = 1.78999925;
         _loc6_.baseScaleY = 1.78999925;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child7_embed,"AbovePlayer",-7,-54);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -7;
         _loc6_.basey = -54;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterBlink();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterBlink(_loc7_).Interval = 200;
         GameObjectFilterBlink(_loc7_).AliveTime = 0;
         GameObjectFilterBlink(_loc7_).BlinkAlpha = 0.100000001;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child8_embed,"AbovePlayer",8,-54);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 8;
         _loc6_.basey = -54;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterBlink();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterBlink(_loc7_).Interval = 200;
         GameObjectFilterBlink(_loc7_).AliveTime = 0;
         GameObjectFilterBlink(_loc7_).BlinkAlpha = 0.100000001;
         param2.addChild(_loc6_);
      }
   }
}

