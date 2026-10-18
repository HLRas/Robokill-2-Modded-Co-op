package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class FallingTile_constructor
   {
      
      public static var collision_55:GameObjectCollision;
      
      public static var LayerName:String = "BelowFloor";
      
      public static var baseim_embed:Class = Embeds.falling_tile_001_png;
      
      public static var baseim:BitmapData = new Embeds.falling_tile_001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.falling_tile_001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.falling_tile_001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.falling_tile_002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.falling_tile_002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.falling_tile_003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.falling_tile_003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.falling_tile_004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.falling_tile_004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.falling_tile_005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.falling_tile_005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.falling_tile_006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.falling_tile_006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.falling_tile_007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.falling_tile_007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.falling_tile_008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.falling_tile_008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.falling_tile_009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.falling_tile_009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.falling_tile_010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.falling_tile_010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.falling_tile_011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.falling_tile_011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.falling_tile_012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.falling_tile_012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.falling_tile_013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.falling_tile_013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.falling_tile_014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.falling_tile_014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.falling_tile_015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.falling_tile_015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.falling_tile_016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.falling_tile_016_png().bitmapData;
      
      public static var imageSet_17_embed:Class = Embeds.falling_tile_017_png;
      
      public static var imageSet_17:BitmapData = new Embeds.falling_tile_017_png().bitmapData;
      
      public static var imageSet_18_embed:Class = Embeds.falling_tile_018_png;
      
      public static var imageSet_18:BitmapData = new Embeds.falling_tile_018_png().bitmapData;
      
      public static var imageSet_19_embed:Class = Embeds.falling_tile_019_png;
      
      public static var imageSet_19:BitmapData = new Embeds.falling_tile_019_png().bitmapData;
      
      public static var imageSet_20_embed:Class = Embeds.falling_tile_020_png;
      
      public static var imageSet_20:BitmapData = new Embeds.falling_tile_020_png().bitmapData;
      
      public static var imageSet_21_embed:Class = Embeds.falling_tile_021_png;
      
      public static var imageSet_21:BitmapData = new Embeds.falling_tile_021_png().bitmapData;
      
      public static var imageSet_22_embed:Class = Embeds.falling_tile_022_png;
      
      public static var imageSet_22:BitmapData = new Embeds.falling_tile_022_png().bitmapData;
      
      public static var imageSet_23_embed:Class = Embeds.falling_tile_023_png;
      
      public static var imageSet_23:BitmapData = new Embeds.falling_tile_023_png().bitmapData;
      
      public static var imageSet_24_embed:Class = Embeds.falling_tile_024_png;
      
      public static var imageSet_24:BitmapData = new Embeds.falling_tile_024_png().bitmapData;
      
      public static var imageSet_25_embed:Class = Embeds.falling_tile_025_png;
      
      public static var imageSet_25:BitmapData = new Embeds.falling_tile_025_png().bitmapData;
      
      public static var imageSet_26_embed:Class = Embeds.falling_tile_026_png;
      
      public static var imageSet_26:BitmapData = new Embeds.falling_tile_026_png().bitmapData;
      
      public static var imageSet_27_embed:Class = Embeds.falling_tile_027_png;
      
      public static var imageSet_27:BitmapData = new Embeds.falling_tile_027_png().bitmapData;
      
      public static var imageSet_28_embed:Class = Embeds.falling_tile_028_png;
      
      public static var imageSet_28:BitmapData = new Embeds.falling_tile_028_png().bitmapData;
      
      public static var imageSet_29_embed:Class = Embeds.falling_tile_029_png;
      
      public static var imageSet_29:BitmapData = new Embeds.falling_tile_029_png().bitmapData;
      
      public static var imageSet_30_embed:Class = Embeds.falling_tile_030_png;
      
      public static var imageSet_30:BitmapData = new Embeds.falling_tile_030_png().bitmapData;
      
      public static var imageSet_31_embed:Class = Embeds.falling_tile_031_png;
      
      public static var imageSet_31:BitmapData = new Embeds.falling_tile_031_png().bitmapData;
      
      public static var imageSet_32_embed:Class = Embeds.falling_tile_032_png;
      
      public static var imageSet_32:BitmapData = new Embeds.falling_tile_032_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16,imageSet_17,imageSet_18,imageSet_19,imageSet_20,imageSet_21,imageSet_22,imageSet_23,imageSet_24,imageSet_25,imageSet_26,imageSet_27,imageSet_28,imageSet_29,imageSet_30,imageSet_31,imageSet_32];
      
      public function FallingTile_constructor()
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
         param2.animSpeed = 0;
         var _loc6_:GameObjectCollision = collision_55;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_55 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         FallingTile(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

