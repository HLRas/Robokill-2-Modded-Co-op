package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class HulkBullet_constructor
   {
      
      public static var LayerName:String = "BelowPlayer";
      
      public static var baseim_embed:Class = Embeds.particle_png;
      
      public static var baseim:BitmapData = new Embeds.particle_png().bitmapData;
      
      public function HulkBullet_constructor()
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
         param2.additive = true;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 0;
      }
   }
}

