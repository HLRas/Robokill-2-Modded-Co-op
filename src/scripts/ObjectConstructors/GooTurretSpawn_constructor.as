package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class GooTurretSpawn_constructor
   {
      
      public static var collision_88:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.snake_b_emerge014_png;
      
      public static var baseim:BitmapData = new Embeds.snake_b_emerge014_png().bitmapData;
      
      public static var emerge_1_embed:Class = Embeds.snake_b_emerge001_png;
      
      public static var emerge_1:BitmapData = new Embeds.snake_b_emerge001_png().bitmapData;
      
      public static var emerge_2_embed:Class = Embeds.snake_b_emerge002_png;
      
      public static var emerge_2:BitmapData = new Embeds.snake_b_emerge002_png().bitmapData;
      
      public static var emerge_3_embed:Class = Embeds.snake_b_emerge003_png;
      
      public static var emerge_3:BitmapData = new Embeds.snake_b_emerge003_png().bitmapData;
      
      public static var emerge_4_embed:Class = Embeds.snake_b_emerge004_png;
      
      public static var emerge_4:BitmapData = new Embeds.snake_b_emerge004_png().bitmapData;
      
      public static var emerge_5_embed:Class = Embeds.snake_b_emerge005_png;
      
      public static var emerge_5:BitmapData = new Embeds.snake_b_emerge005_png().bitmapData;
      
      public static var emerge_6_embed:Class = Embeds.snake_b_emerge006_png;
      
      public static var emerge_6:BitmapData = new Embeds.snake_b_emerge006_png().bitmapData;
      
      public static var emerge_7_embed:Class = Embeds.snake_b_emerge007_png;
      
      public static var emerge_7:BitmapData = new Embeds.snake_b_emerge007_png().bitmapData;
      
      public static var emerge_8_embed:Class = Embeds.snake_b_emerge008_png;
      
      public static var emerge_8:BitmapData = new Embeds.snake_b_emerge008_png().bitmapData;
      
      public static var emerge_9_embed:Class = Embeds.snake_b_emerge009_png;
      
      public static var emerge_9:BitmapData = new Embeds.snake_b_emerge009_png().bitmapData;
      
      public static var emerge_10_embed:Class = Embeds.snake_b_emerge010_png;
      
      public static var emerge_10:BitmapData = new Embeds.snake_b_emerge010_png().bitmapData;
      
      public static var emerge_11_embed:Class = Embeds.snake_b_emerge011_png;
      
      public static var emerge_11:BitmapData = new Embeds.snake_b_emerge011_png().bitmapData;
      
      public static var emerge_12_embed:Class = Embeds.snake_b_emerge012_png;
      
      public static var emerge_12:BitmapData = new Embeds.snake_b_emerge012_png().bitmapData;
      
      public static var emerge_13_embed:Class = Embeds.snake_b_emerge013_png;
      
      public static var emerge_13:BitmapData = new Embeds.snake_b_emerge013_png().bitmapData;
      
      public static var emerge_14_embed:Class = Embeds.snake_b_emerge014_png;
      
      public static var emerge_14:BitmapData = new Embeds.snake_b_emerge014_png().bitmapData;
      
      public static var emerge_15_embed:Class = Embeds.snake_b_emerge015_png;
      
      public static var emerge_15:BitmapData = new Embeds.snake_b_emerge015_png().bitmapData;
      
      public static var emerge_16_embed:Class = Embeds.snake_b_emerge016_png;
      
      public static var emerge_16:BitmapData = new Embeds.snake_b_emerge016_png().bitmapData;
      
      public static var emerge_17_embed:Class = Embeds.snake_b_emerge017_png;
      
      public static var emerge_17:BitmapData = new Embeds.snake_b_emerge017_png().bitmapData;
      
      public static var emerge_18_embed:Class = Embeds.snake_b_emerge018_png;
      
      public static var emerge_18:BitmapData = new Embeds.snake_b_emerge018_png().bitmapData;
      
      public static var emerge_19_embed:Class = Embeds.snake_b_emerge019_png;
      
      public static var emerge_19:BitmapData = new Embeds.snake_b_emerge019_png().bitmapData;
      
      public static var emerge_20_embed:Class = Embeds.snake_b_emerge020_png;
      
      public static var emerge_20:BitmapData = new Embeds.snake_b_emerge020_png().bitmapData;
      
      public static var emerge:Array = [emerge_1,emerge_2,emerge_3,emerge_4,emerge_5,emerge_6,emerge_7,emerge_8,emerge_9,emerge_10,emerge_11,emerge_12,emerge_13,emerge_14,emerge_15,emerge_16,emerge_17,emerge_18,emerge_19,emerge_20];
      
      public static var imageSet_1_embed:Class = Embeds.snake_rest001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.snake_rest001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.snake_rest002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.snake_rest002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.snake_rest003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.snake_rest003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.snake_rest004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.snake_rest004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.snake_rest005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.snake_rest005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.snake_rest006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.snake_rest006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.snake_rest007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.snake_rest007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.snake_rest008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.snake_rest008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.snake_rest009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.snake_rest009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.snake_rest010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.snake_rest010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.snake_rest011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.snake_rest011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.snake_rest012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.snake_rest012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.snake_rest013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.snake_rest013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.snake_rest014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.snake_rest014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.snake_rest015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.snake_rest015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.snake_rest016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.snake_rest016_png().bitmapData;
      
      public static var imageSet_17_embed:Class = Embeds.snake_rest017_png;
      
      public static var imageSet_17:BitmapData = new Embeds.snake_rest017_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16,imageSet_17];
      
      public static var spawnMask_1_embed:Class = Embeds.snake_b_mask_001_png;
      
      public static var spawnMask_1:BitmapData = new Embeds.snake_b_mask_001_png().bitmapData;
      
      public static var spawnMask_2_embed:Class = Embeds.snake_b_mask_002_png;
      
      public static var spawnMask_2:BitmapData = new Embeds.snake_b_mask_002_png().bitmapData;
      
      public static var spawnMask_3_embed:Class = Embeds.snake_b_mask_003_png;
      
      public static var spawnMask_3:BitmapData = new Embeds.snake_b_mask_003_png().bitmapData;
      
      public static var spawnMask_4_embed:Class = Embeds.snake_b_mask_004_png;
      
      public static var spawnMask_4:BitmapData = new Embeds.snake_b_mask_004_png().bitmapData;
      
      public static var spawnMask:Array = [spawnMask_1,spawnMask_2,spawnMask_3,spawnMask_4];
      
      public function GooTurretSpawn_constructor()
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
         var _loc6_:GameObjectCollision = collision_88;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_88 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         GooTurretSpawn(param2).emerge = emerge;
         param2.imageSet = emerge;
         GooTurretSpawn(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
         GooTurretSpawn(param2).spawnMask = spawnMask;
         param2.imageSet = spawnMask;
      }
   }
}

