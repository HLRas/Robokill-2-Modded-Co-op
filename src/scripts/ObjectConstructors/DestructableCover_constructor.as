package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class DestructableCover_constructor
   {
      
      public static var collision_65:GameObjectCollision;
      
      public static var collision_66:GameObjectCollision;
      
      public static var collision_67:GameObjectCollision;
      
      public static var collision_68:GameObjectCollision;
      
      public static var collision_69:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.destructable_001_png;
      
      public static var baseim:BitmapData = new Embeds.destructable_001_png().bitmapData;
      
      public static var damaged_1_embed:Class = Embeds.destructable_damaged_001_png;
      
      public static var damaged_1:BitmapData = new Embeds.destructable_damaged_001_png().bitmapData;
      
      public static var damaged_2_embed:Class = Embeds.destructable_damaged_002_png;
      
      public static var damaged_2:BitmapData = new Embeds.destructable_damaged_002_png().bitmapData;
      
      public static var damaged_3_embed:Class = Embeds.destructable_damaged_003_png;
      
      public static var damaged_3:BitmapData = new Embeds.destructable_damaged_003_png().bitmapData;
      
      public static var damaged_4_embed:Class = Embeds.destructable_damaged_004_png;
      
      public static var damaged_4:BitmapData = new Embeds.destructable_damaged_004_png().bitmapData;
      
      public static var damaged_5_embed:Class = Embeds.destructable_damaged_005_png;
      
      public static var damaged_5:BitmapData = new Embeds.destructable_damaged_005_png().bitmapData;
      
      public static var damaged_6_embed:Class = Embeds.destructable_damaged_006_png;
      
      public static var damaged_6:BitmapData = new Embeds.destructable_damaged_006_png().bitmapData;
      
      public static var damaged:Array = [damaged_1,damaged_2,damaged_3,damaged_4,damaged_5,damaged_6];
      
      public static var images_1_embed:Class = Embeds.destructable_001_png;
      
      public static var images_1:BitmapData = new Embeds.destructable_001_png().bitmapData;
      
      public static var images_2_embed:Class = Embeds.destructable_002_png;
      
      public static var images_2:BitmapData = new Embeds.destructable_002_png().bitmapData;
      
      public static var images_3_embed:Class = Embeds.destructable_003_png;
      
      public static var images_3:BitmapData = new Embeds.destructable_003_png().bitmapData;
      
      public static var images_4_embed:Class = Embeds.destructable_004_png;
      
      public static var images_4:BitmapData = new Embeds.destructable_004_png().bitmapData;
      
      public static var images:Array = [images_1,images_2,images_3,images_4];
      
      public function DestructableCover_constructor()
      {
         super();
      }
      
      public static function setup(param1:GameScene, param2:GameObject) : void
      {
         var _loc3_:GameObjectFilter = null;
         var _loc4_:ParticleEmitter = null;
         var _loc5_:ParticleFilter = null;
         var _loc6_:GameObjectCollision = null;
         var _loc7_:GameObject = null;
         var _loc8_:GameObjectFilter = null;
         var _loc9_:GameObjectCollisionPoly = null;
         param2.baseHandleX = 0.5;
         param2.baseHandleY = 0.5;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 0;
         _loc6_ = collision_65;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_65 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         _loc6_ = collision_66;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_66 = _loc6_;
         }
         param2.collisions[1] = _loc6_;
         _loc6_ = collision_67;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_67 = _loc6_;
         }
         param2.collisions[2] = _loc6_;
         _loc6_ = collision_68;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_68 = _loc6_;
         }
         param2.collisions[3] = _loc6_;
         _loc6_ = collision_69;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_69 = _loc6_;
         }
         param2.collisions[4] = _loc6_;
         DestructableCover(param2).damaged = damaged;
         param2.imageSet = damaged;
         DestructableCover(param2).images = images;
         param2.imageSet = images;
      }
   }
}

