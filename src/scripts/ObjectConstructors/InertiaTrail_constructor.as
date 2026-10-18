package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class InertiaTrail_constructor
   {
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.inertia_trail_001_png;
      
      public static var baseim:BitmapData = new Embeds.inertia_trail_001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.inertia_trail_001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.inertia_trail_001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.inertia_trail_002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.inertia_trail_002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.inertia_trail_003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.inertia_trail_003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.inertia_trail_004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.inertia_trail_004_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4];
      
      public function InertiaTrail_constructor()
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
         param2.baseHandleY = -0.200000003;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 3;
         InertiaTrail(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

