package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class EnemyCrack_constructor
   {
      
      public static var collision_44:GameObjectCollision;
      
      public static var LayerName:String = "BelowFloor";
      
      public static var baseim_embed:Class = Embeds.tile_bust001_png;
      
      public static var baseim:BitmapData = new Embeds.tile_bust001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.tile_bust001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.tile_bust001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.tile_bust002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.tile_bust002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.tile_bust003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.tile_bust003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.tile_bust004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.tile_bust004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.tile_bust005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.tile_bust005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.tile_bust006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.tile_bust006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.tile_bust007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.tile_bust007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.tile_bust008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.tile_bust008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.tile_bust009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.tile_bust009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.tile_bust010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.tile_bust010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.tile_bust011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.tile_bust011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.tile_bust012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.tile_bust012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.tile_bust013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.tile_bust013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.tile_bust014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.tile_bust014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.tile_bust015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.tile_bust015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.tile_bust016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.tile_bust016_png().bitmapData;
      
      public static var imageSet_17_embed:Class = Embeds.tile_bust017_png;
      
      public static var imageSet_17:BitmapData = new Embeds.tile_bust017_png().bitmapData;
      
      public static var imageSet_18_embed:Class = Embeds.tile_bust018_png;
      
      public static var imageSet_18:BitmapData = new Embeds.tile_bust018_png().bitmapData;
      
      public static var imageSet_19_embed:Class = Embeds.tile_bust019_png;
      
      public static var imageSet_19:BitmapData = new Embeds.tile_bust019_png().bitmapData;
      
      public static var imageSet_20_embed:Class = Embeds.tile_bust020_png;
      
      public static var imageSet_20:BitmapData = new Embeds.tile_bust020_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16,imageSet_17,imageSet_18,imageSet_19,imageSet_20];
      
      public function EnemyCrack_constructor()
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
         var _loc6_:GameObjectCollision = collision_44;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_44 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         EnemyCrack(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

