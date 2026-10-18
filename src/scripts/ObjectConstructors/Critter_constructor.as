package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Critter_constructor
   {
      
      public static var collision_45:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.runner_walk001_png;
      
      public static var baseim:BitmapData = new Embeds.runner_walk001_png().bitmapData;
      
      public static var climb_1_embed:Class = Embeds.runner_climb001_png;
      
      public static var climb_1:BitmapData = new Embeds.runner_climb001_png().bitmapData;
      
      public static var climb_2_embed:Class = Embeds.runner_climb002_png;
      
      public static var climb_2:BitmapData = new Embeds.runner_climb002_png().bitmapData;
      
      public static var climb_3_embed:Class = Embeds.runner_climb003_png;
      
      public static var climb_3:BitmapData = new Embeds.runner_climb003_png().bitmapData;
      
      public static var climb_4_embed:Class = Embeds.runner_climb004_png;
      
      public static var climb_4:BitmapData = new Embeds.runner_climb004_png().bitmapData;
      
      public static var climb_5_embed:Class = Embeds.runner_climb005_png;
      
      public static var climb_5:BitmapData = new Embeds.runner_climb005_png().bitmapData;
      
      public static var climb_6_embed:Class = Embeds.runner_climb006_png;
      
      public static var climb_6:BitmapData = new Embeds.runner_climb006_png().bitmapData;
      
      public static var climb_7_embed:Class = Embeds.runner_climb007_png;
      
      public static var climb_7:BitmapData = new Embeds.runner_climb007_png().bitmapData;
      
      public static var climb_8_embed:Class = Embeds.runner_climb008_png;
      
      public static var climb_8:BitmapData = new Embeds.runner_climb008_png().bitmapData;
      
      public static var climb_9_embed:Class = Embeds.runner_climb009_png;
      
      public static var climb_9:BitmapData = new Embeds.runner_climb009_png().bitmapData;
      
      public static var climb_10_embed:Class = Embeds.runner_climb010_png;
      
      public static var climb_10:BitmapData = new Embeds.runner_climb010_png().bitmapData;
      
      public static var climb:Array = [climb_1,climb_2,climb_3,climb_4,climb_5,climb_6,climb_7,climb_8,climb_9,climb_10];
      
      public static var imageSet_1_embed:Class = Embeds.runner_walk001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.runner_walk001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.runner_walk002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.runner_walk002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.runner_walk003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.runner_walk003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.runner_walk004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.runner_walk004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.runner_walk005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.runner_walk005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.runner_walk006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.runner_walk006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.runner_walk007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.runner_walk007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.runner_walk008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.runner_walk008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.runner_walk009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.runner_walk009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.runner_walk010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.runner_walk010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.runner_walk011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.runner_walk011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.runner_walk012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.runner_walk012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.runner_walk013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.runner_walk013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.runner_walk014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.runner_walk014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.runner_walk015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.runner_walk015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.runner_walk016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.runner_walk016_png().bitmapData;
      
      public static var imageSet_17_embed:Class = Embeds.runner_walk017_png;
      
      public static var imageSet_17:BitmapData = new Embeds.runner_walk017_png().bitmapData;
      
      public static var imageSet_18_embed:Class = Embeds.runner_walk018_png;
      
      public static var imageSet_18:BitmapData = new Embeds.runner_walk018_png().bitmapData;
      
      public static var imageSet_19_embed:Class = Embeds.runner_walk019_png;
      
      public static var imageSet_19:BitmapData = new Embeds.runner_walk019_png().bitmapData;
      
      public static var imageSet_20_embed:Class = Embeds.runner_walk020_png;
      
      public static var imageSet_20:BitmapData = new Embeds.runner_walk020_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16,imageSet_17,imageSet_18,imageSet_19,imageSet_20];
      
      public function Critter_constructor()
      {
         super();
      }
      
      public static function setup(param1:GameScene, param2:GameObject) : void
      {
         var _loc3_:GameObjectFilter = null;
         var _loc4_:ParticleEmitter = null;
         var _loc5_:ParticleFilter = null;
         var _loc7_:GameObject = null;
         var _loc8_:GameObjectFilter = null;
         var _loc9_:GameObjectCollisionPoly = null;
         param2.baseHandleX = 0.5;
         param2.baseHandleY = 0.5;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 1.29999995;
         var _loc6_:GameObjectCollision = collision_45;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_45 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Critter(param2).climb = climb;
         param2.imageSet = climb;
         Critter(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

