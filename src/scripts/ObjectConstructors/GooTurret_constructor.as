package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class GooTurret_constructor
   {
      
      public static var collision_49:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.snake_emerge001_png;
      
      public static var baseim:BitmapData = new Embeds.snake_emerge001_png().bitmapData;
      
      public static var emerge_1_embed:Class = Embeds.snake_emerge001_png;
      
      public static var emerge_1:BitmapData = new Embeds.snake_emerge001_png().bitmapData;
      
      public static var emerge_2_embed:Class = Embeds.snake_emerge002_png;
      
      public static var emerge_2:BitmapData = new Embeds.snake_emerge002_png().bitmapData;
      
      public static var emerge_3_embed:Class = Embeds.snake_emerge003_png;
      
      public static var emerge_3:BitmapData = new Embeds.snake_emerge003_png().bitmapData;
      
      public static var emerge_4_embed:Class = Embeds.snake_emerge004_png;
      
      public static var emerge_4:BitmapData = new Embeds.snake_emerge004_png().bitmapData;
      
      public static var emerge_5_embed:Class = Embeds.snake_emerge005_png;
      
      public static var emerge_5:BitmapData = new Embeds.snake_emerge005_png().bitmapData;
      
      public static var emerge_6_embed:Class = Embeds.snake_emerge006_png;
      
      public static var emerge_6:BitmapData = new Embeds.snake_emerge006_png().bitmapData;
      
      public static var emerge_7_embed:Class = Embeds.snake_emerge007_png;
      
      public static var emerge_7:BitmapData = new Embeds.snake_emerge007_png().bitmapData;
      
      public static var emerge_8_embed:Class = Embeds.snake_emerge008_png;
      
      public static var emerge_8:BitmapData = new Embeds.snake_emerge008_png().bitmapData;
      
      public static var emerge_9_embed:Class = Embeds.snake_emerge009_png;
      
      public static var emerge_9:BitmapData = new Embeds.snake_emerge009_png().bitmapData;
      
      public static var emerge:Array = [emerge_1,emerge_2,emerge_3,emerge_4,emerge_5,emerge_6,emerge_7,emerge_8,emerge_9];
      
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
      
      public static var shootMask_embed:Class = Embeds.snake_rest_mask_png;
      
      public static var shootMask:BitmapData = new Embeds.snake_rest_mask_png().bitmapData;
      
      public function GooTurret_constructor()
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
         var _loc6_:GameObjectCollision = collision_49;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_49 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         GooTurret(param2).emerge = emerge;
         param2.imageSet = emerge;
         GooTurret(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
         GooTurret(param2).shootMask = shootMask;
      }
   }
}

