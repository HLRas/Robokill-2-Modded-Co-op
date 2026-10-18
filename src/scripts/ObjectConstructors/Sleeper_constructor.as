package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Sleeper_constructor
   {
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.sleeper_png;
      
      public static var baseim:BitmapData = new Embeds.sleeper_png().bitmapData;
      
      public static var child1_embed:Class = Embeds.sleeper_light_png;
      
      public static var child1:BitmapData = new Embeds.sleeper_light_png().bitmapData;
      
      public function Sleeper_constructor()
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
         _loc6_ = new GameObject(param1,child1_embed,"AbovePlayer",6,4);
         _loc6_.name = "Glow";
         _loc6_.baseHandleX = 0.5;
         _loc6_.baseHandleY = 0.5;
         _loc6_.basex = 6;
         _loc6_.basey = 4;
         _loc6_.additive = true;
         _loc6_.animSpeed = 0;
         param2.addChild(_loc6_);
      }
   }
}

