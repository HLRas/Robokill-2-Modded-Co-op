package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class LevelUpFrame_constructor
   {
      
      public static var LayerName:String = "";
      
      public static var baseim_embed:Class = Embeds.levelup_frame_png;
      
      public static var baseim:BitmapData = new Embeds.levelup_frame_png().bitmapData;
      
      public static var child1_embed:Class = Embeds.flare_1_png;
      
      public static var child1:BitmapData = new Embeds.flare_1_png().bitmapData;
      
      public static var child2_embed:Class = Embeds.flare_1_png;
      
      public static var child2:BitmapData = new Embeds.flare_1_png().bitmapData;
      
      public static var child3_embed:Class = Embeds.flare_1_png;
      
      public static var child3:BitmapData = new Embeds.flare_1_png().bitmapData;
      
      public static var child4_embed:Class = Embeds.flare_1_png;
      
      public static var child4:BitmapData = new Embeds.flare_1_png().bitmapData;
      
      public static var child5_embed:Class = Embeds.levelup_star2_png;
      
      public static var child5:BitmapData = new Embeds.levelup_star2_png().bitmapData;
      
      public function LevelUpFrame_constructor()
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
         _loc6_ = new GameObject(param1,child1_embed,"",-155,-20);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -155;
         _loc6_.basey = -20;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 0.699999988;
         _loc7_ = new GameObjectFilterRotate();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterRotate(_loc7_).Speed = 0.200000003;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child2_embed,"",-156,-20);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -156;
         _loc6_.basey = -20;
         _loc6_.baseScaleX = 0.660000324;
         _loc6_.baseScaleY = 0.660000324;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         _loc7_ = new GameObjectFilterRotate();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterRotate(_loc7_).Speed = 0.100000001;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child3_embed,"",69,-21);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 69;
         _loc6_.basey = -21;
         _loc6_.baseScaleX = 0.670000315;
         _loc6_.baseScaleY = 0.670000315;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         _loc7_ = new GameObjectFilterRotate();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterRotate(_loc7_).Speed = 0.200000003;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child4_embed,"",70,-22);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 70;
         _loc6_.basey = -22;
         _loc6_.baseScaleX = 0.620000362;
         _loc6_.baseScaleY = 0.620000362;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         _loc7_ = new GameObjectFilterRotate();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterRotate(_loc7_).Speed = 0.300000012;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child5_embed,"",232,-1);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 232;
         _loc6_.basey = -1;
         _loc6_.baseScaleX = 1.03999996;
         _loc6_.baseScaleY = 1.03999996;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
      }
   }
}

