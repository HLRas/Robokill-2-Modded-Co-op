package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class RespawnPoint_constructor
   {
      
      public static var LayerName:String = "";
      
      public static var baseim_embed:Class = Embeds.respawn2_png;
      
      public static var baseim:BitmapData = new Embeds.respawn2_png().bitmapData;
      
      public static var child1_embed:Class = Embeds.decal_free_33_png;
      
      public static var child1:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public static var child2_embed:Class = Embeds.decal_free_33_png;
      
      public static var child2:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public static var child3_embed:Class = Embeds.decal_free_33_png;
      
      public static var child3:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public static var child4_embed:Class = Embeds.decal_free_33_png;
      
      public static var child4:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public static var on_embed:Class = Embeds.respawn_png;
      
      public static var on:BitmapData = new Embeds.respawn_png().bitmapData;
      
      public function RespawnPoint_constructor()
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
         _loc6_ = new GameObject(param1,child1_embed,"",-15,-14);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -15;
         _loc6_.basey = -14;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child2_embed,"",14,-15);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 14;
         _loc6_.basey = -15;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child3_embed,"",-13,14);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = -13;
         _loc6_.basey = 14;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         _loc6_ = new GameObject(param1,child4_embed,"",16,16);
         _loc6_.name = "";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 16;
         _loc6_.basey = 16;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         _loc7_ = new GameObjectFilterPulse();
         _loc6_.addFilter(_loc7_);
         GameObjectFilterPulse(_loc7_).Speed = 1;
         param2.addChild(_loc6_);
         RespawnPoint(param2).on = on;
      }
   }
}

