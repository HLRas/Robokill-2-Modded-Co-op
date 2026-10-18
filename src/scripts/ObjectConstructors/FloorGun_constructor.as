package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class FloorGun_constructor
   {
      
      public static var collision_83:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.floor_gun_turret_png;
      
      public static var baseim:BitmapData = new Embeds.floor_gun_turret_png().bitmapData;
      
      public static var baseFrames_1_embed:Class = Embeds.floor_gun001_png;
      
      public static var baseFrames_1:BitmapData = new Embeds.floor_gun001_png().bitmapData;
      
      public static var baseFrames_2_embed:Class = Embeds.floor_gun002_png;
      
      public static var baseFrames_2:BitmapData = new Embeds.floor_gun002_png().bitmapData;
      
      public static var baseFrames_3_embed:Class = Embeds.floor_gun003_png;
      
      public static var baseFrames_3:BitmapData = new Embeds.floor_gun003_png().bitmapData;
      
      public static var baseFrames_4_embed:Class = Embeds.floor_gun004_png;
      
      public static var baseFrames_4:BitmapData = new Embeds.floor_gun004_png().bitmapData;
      
      public static var baseFrames_5_embed:Class = Embeds.floor_gun005_png;
      
      public static var baseFrames_5:BitmapData = new Embeds.floor_gun005_png().bitmapData;
      
      public static var baseFrames_6_embed:Class = Embeds.floor_gun006_png;
      
      public static var baseFrames_6:BitmapData = new Embeds.floor_gun006_png().bitmapData;
      
      public static var baseFrames_7_embed:Class = Embeds.floor_gun007_png;
      
      public static var baseFrames_7:BitmapData = new Embeds.floor_gun007_png().bitmapData;
      
      public static var baseFrames_8_embed:Class = Embeds.floor_gun008_png;
      
      public static var baseFrames_8:BitmapData = new Embeds.floor_gun008_png().bitmapData;
      
      public static var baseFrames_9_embed:Class = Embeds.floor_gun009_png;
      
      public static var baseFrames_9:BitmapData = new Embeds.floor_gun009_png().bitmapData;
      
      public static var baseFrames_10_embed:Class = Embeds.floor_gun010_png;
      
      public static var baseFrames_10:BitmapData = new Embeds.floor_gun010_png().bitmapData;
      
      public static var baseFrames_11_embed:Class = Embeds.floor_gun011_png;
      
      public static var baseFrames_11:BitmapData = new Embeds.floor_gun011_png().bitmapData;
      
      public static var baseFrames_12_embed:Class = Embeds.floor_gun012_png;
      
      public static var baseFrames_12:BitmapData = new Embeds.floor_gun012_png().bitmapData;
      
      public static var baseFrames_13_embed:Class = Embeds.floor_gun013_png;
      
      public static var baseFrames_13:BitmapData = new Embeds.floor_gun013_png().bitmapData;
      
      public static var baseFrames_14_embed:Class = Embeds.floor_gun014_png;
      
      public static var baseFrames_14:BitmapData = new Embeds.floor_gun014_png().bitmapData;
      
      public static var baseFrames_15_embed:Class = Embeds.floor_gun015_png;
      
      public static var baseFrames_15:BitmapData = new Embeds.floor_gun015_png().bitmapData;
      
      public static var baseFrames_16_embed:Class = Embeds.floor_gun016_png;
      
      public static var baseFrames_16:BitmapData = new Embeds.floor_gun016_png().bitmapData;
      
      public static var baseFrames_17_embed:Class = Embeds.floor_gun017_png;
      
      public static var baseFrames_17:BitmapData = new Embeds.floor_gun017_png().bitmapData;
      
      public static var baseFrames:Array = [baseFrames_1,baseFrames_2,baseFrames_3,baseFrames_4,baseFrames_5,baseFrames_6,baseFrames_7,baseFrames_8,baseFrames_9,baseFrames_10,baseFrames_11,baseFrames_12,baseFrames_13,baseFrames_14,baseFrames_15,baseFrames_16,baseFrames_17];
      
      public function FloorGun_constructor()
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
         var _loc6_:GameObjectCollision = collision_83;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_83 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         FloorGun(param2).baseFrames = baseFrames;
         param2.imageSet = baseFrames;
      }
   }
}

