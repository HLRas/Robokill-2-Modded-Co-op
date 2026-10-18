package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class BatNest_constructor
   {
      
      public static var collision_87:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.hive_open001_png;
      
      public static var baseim:BitmapData = new Embeds.hive_open001_png().bitmapData;
      
      public static var creationMask_embed:Class = Embeds.hive_mask_png;
      
      public static var creationMask:BitmapData = new Embeds.hive_mask_png().bitmapData;
      
      public static var open_1_embed:Class = Embeds.hive_open001_png;
      
      public static var open_1:BitmapData = new Embeds.hive_open001_png().bitmapData;
      
      public static var open_2_embed:Class = Embeds.hive_open002_png;
      
      public static var open_2:BitmapData = new Embeds.hive_open002_png().bitmapData;
      
      public static var open_3_embed:Class = Embeds.hive_open003_png;
      
      public static var open_3:BitmapData = new Embeds.hive_open003_png().bitmapData;
      
      public static var open_4_embed:Class = Embeds.hive_open004_png;
      
      public static var open_4:BitmapData = new Embeds.hive_open004_png().bitmapData;
      
      public static var open_5_embed:Class = Embeds.hive_open005_png;
      
      public static var open_5:BitmapData = new Embeds.hive_open005_png().bitmapData;
      
      public static var open_6_embed:Class = Embeds.hive_open006_png;
      
      public static var open_6:BitmapData = new Embeds.hive_open006_png().bitmapData;
      
      public static var open_7_embed:Class = Embeds.hive_open007_png;
      
      public static var open_7:BitmapData = new Embeds.hive_open007_png().bitmapData;
      
      public static var open_8_embed:Class = Embeds.hive_open008_png;
      
      public static var open_8:BitmapData = new Embeds.hive_open008_png().bitmapData;
      
      public static var open:Array = [open_1,open_2,open_3,open_4,open_5,open_6,open_7,open_8];
      
      public static var idle_1_embed:Class = Embeds.hive_static001_png;
      
      public static var idle_1:BitmapData = new Embeds.hive_static001_png().bitmapData;
      
      public static var idle_2_embed:Class = Embeds.hive_static002_png;
      
      public static var idle_2:BitmapData = new Embeds.hive_static002_png().bitmapData;
      
      public static var idle_3_embed:Class = Embeds.hive_static003_png;
      
      public static var idle_3:BitmapData = new Embeds.hive_static003_png().bitmapData;
      
      public static var idle_4_embed:Class = Embeds.hive_static004_png;
      
      public static var idle_4:BitmapData = new Embeds.hive_static004_png().bitmapData;
      
      public static var idle_5_embed:Class = Embeds.hive_static005_png;
      
      public static var idle_5:BitmapData = new Embeds.hive_static005_png().bitmapData;
      
      public static var idle_6_embed:Class = Embeds.hive_static006_png;
      
      public static var idle_6:BitmapData = new Embeds.hive_static006_png().bitmapData;
      
      public static var idle_7_embed:Class = Embeds.hive_static007_png;
      
      public static var idle_7:BitmapData = new Embeds.hive_static007_png().bitmapData;
      
      public static var idle_8_embed:Class = Embeds.hive_static008_png;
      
      public static var idle_8:BitmapData = new Embeds.hive_static008_png().bitmapData;
      
      public static var idle:Array = [idle_1,idle_2,idle_3,idle_4,idle_5,idle_6,idle_7,idle_8];
      
      public function BatNest_constructor()
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
         var _loc6_:GameObjectCollision = collision_87;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_87 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         BatNest(param2).creationMask = creationMask;
         BatNest(param2).open = open;
         param2.imageSet = open;
         BatNest(param2).idle = idle;
         param2.imageSet = idle;
      }
   }
}

