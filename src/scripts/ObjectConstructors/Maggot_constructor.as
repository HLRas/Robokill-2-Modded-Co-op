package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Maggot_constructor
   {
      
      public static var collision_40:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.Maggot001_png;
      
      public static var baseim:BitmapData = new Embeds.Maggot001_png().bitmapData;
      
      public static var morph_1_embed:Class = Embeds.Spawn_morph001_png;
      
      public static var morph_1:BitmapData = new Embeds.Spawn_morph001_png().bitmapData;
      
      public static var morph_2_embed:Class = Embeds.Spawn_morph002_png;
      
      public static var morph_2:BitmapData = new Embeds.Spawn_morph002_png().bitmapData;
      
      public static var morph_3_embed:Class = Embeds.Spawn_morph003_png;
      
      public static var morph_3:BitmapData = new Embeds.Spawn_morph003_png().bitmapData;
      
      public static var morph_4_embed:Class = Embeds.Spawn_morph004_png;
      
      public static var morph_4:BitmapData = new Embeds.Spawn_morph004_png().bitmapData;
      
      public static var morph_5_embed:Class = Embeds.Spawn_morph005_png;
      
      public static var morph_5:BitmapData = new Embeds.Spawn_morph005_png().bitmapData;
      
      public static var morph_6_embed:Class = Embeds.Spawn_morph006_png;
      
      public static var morph_6:BitmapData = new Embeds.Spawn_morph006_png().bitmapData;
      
      public static var morph_7_embed:Class = Embeds.Spawn_morph007_png;
      
      public static var morph_7:BitmapData = new Embeds.Spawn_morph007_png().bitmapData;
      
      public static var morph_8_embed:Class = Embeds.Spawn_morph008_png;
      
      public static var morph_8:BitmapData = new Embeds.Spawn_morph008_png().bitmapData;
      
      public static var morph_9_embed:Class = Embeds.Spawn_morph009_png;
      
      public static var morph_9:BitmapData = new Embeds.Spawn_morph009_png().bitmapData;
      
      public static var morph:Array = [morph_1,morph_2,morph_3,morph_4,morph_5,morph_6,morph_7,morph_8,morph_9];
      
      public static var spawnImages_1_embed:Class = Embeds.spawn_a001_png;
      
      public static var spawnImages_1:BitmapData = new Embeds.spawn_a001_png().bitmapData;
      
      public static var spawnImages_2_embed:Class = Embeds.spawn_a002_png;
      
      public static var spawnImages_2:BitmapData = new Embeds.spawn_a002_png().bitmapData;
      
      public static var spawnImages_3_embed:Class = Embeds.spawn_a003_png;
      
      public static var spawnImages_3:BitmapData = new Embeds.spawn_a003_png().bitmapData;
      
      public static var spawnImages_4_embed:Class = Embeds.spawn_a004_png;
      
      public static var spawnImages_4:BitmapData = new Embeds.spawn_a004_png().bitmapData;
      
      public static var spawnImages_5_embed:Class = Embeds.spawn_a005_png;
      
      public static var spawnImages_5:BitmapData = new Embeds.spawn_a005_png().bitmapData;
      
      public static var spawnImages_6_embed:Class = Embeds.spawn_a006_png;
      
      public static var spawnImages_6:BitmapData = new Embeds.spawn_a006_png().bitmapData;
      
      public static var spawnImages_7_embed:Class = Embeds.spawn_a007_png;
      
      public static var spawnImages_7:BitmapData = new Embeds.spawn_a007_png().bitmapData;
      
      public static var spawnImages_8_embed:Class = Embeds.spawn_a008_png;
      
      public static var spawnImages_8:BitmapData = new Embeds.spawn_a008_png().bitmapData;
      
      public static var spawnImages_9_embed:Class = Embeds.spawn_a009_png;
      
      public static var spawnImages_9:BitmapData = new Embeds.spawn_a009_png().bitmapData;
      
      public static var spawnImages_10_embed:Class = Embeds.spawn_a010_png;
      
      public static var spawnImages_10:BitmapData = new Embeds.spawn_a010_png().bitmapData;
      
      public static var spawnImages_11_embed:Class = Embeds.spawn_a011_png;
      
      public static var spawnImages_11:BitmapData = new Embeds.spawn_a011_png().bitmapData;
      
      public static var spawnImages_12_embed:Class = Embeds.spawn_a012_png;
      
      public static var spawnImages_12:BitmapData = new Embeds.spawn_a012_png().bitmapData;
      
      public static var spawnImages_13_embed:Class = Embeds.spawn_a013_png;
      
      public static var spawnImages_13:BitmapData = new Embeds.spawn_a013_png().bitmapData;
      
      public static var spawnImages_14_embed:Class = Embeds.spawn_a014_png;
      
      public static var spawnImages_14:BitmapData = new Embeds.spawn_a014_png().bitmapData;
      
      public static var spawnImages_15_embed:Class = Embeds.spawn_a015_png;
      
      public static var spawnImages_15:BitmapData = new Embeds.spawn_a015_png().bitmapData;
      
      public static var spawnImages_16_embed:Class = Embeds.spawn_a016_png;
      
      public static var spawnImages_16:BitmapData = new Embeds.spawn_a016_png().bitmapData;
      
      public static var spawnImages:Array = [spawnImages_1,spawnImages_2,spawnImages_3,spawnImages_4,spawnImages_5,spawnImages_6,spawnImages_7,spawnImages_8,spawnImages_9,spawnImages_10,spawnImages_11,spawnImages_12,spawnImages_13,spawnImages_14,spawnImages_15,spawnImages_16];
      
      public static var imageSet_1_embed:Class = Embeds.Maggot001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.Maggot001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.Maggot002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.Maggot002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.Maggot003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.Maggot003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.Maggot004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.Maggot004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.Maggot005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.Maggot005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.Maggot006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.Maggot006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.Maggot007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.Maggot007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.Maggot008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.Maggot008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.Maggot009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.Maggot009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.Maggot010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.Maggot010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.Maggot011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.Maggot011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.Maggot012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.Maggot012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.Maggot013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.Maggot013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.Maggot014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.Maggot014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.Maggot015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.Maggot015_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15];
      
      public function Maggot_constructor()
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
         param2.animSpeed = 8.19999981;
         var _loc6_:GameObjectCollision = collision_40;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_40 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Maggot(param2).morph = morph;
         param2.imageSet = morph;
         Maggot(param2).spawnImages = spawnImages;
         param2.imageSet = spawnImages;
         Maggot(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

