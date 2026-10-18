package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class LargeFloorTile_constructor
   {
      
      public static var collision_76:GameObjectCollision;
      
      public static var collision_77:GameObjectCollision;
      
      public static var collision_78:GameObjectCollision;
      
      public static var LayerName:String = "";
      
      public static var baseim_embed:Class = Embeds.large_floor_tile_01_png;
      
      public static var baseim:BitmapData = new Embeds.large_floor_tile_01_png().bitmapData;
      
      public static var images_1_embed:Class = Embeds.large_floor_tile_01_png;
      
      public static var images_1:BitmapData = new Embeds.large_floor_tile_01_png().bitmapData;
      
      public static var images_2_embed:Class = Embeds.large_floor_tile_02_png;
      
      public static var images_2:BitmapData = new Embeds.large_floor_tile_02_png().bitmapData;
      
      public static var images:Array = [images_1,images_2];
      
      public function LargeFloorTile_constructor()
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
         _loc6_ = collision_76;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_76 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         _loc6_ = collision_77;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_77 = _loc6_;
         }
         param2.collisions[1] = _loc6_;
         _loc6_ = collision_78;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_78 = _loc6_;
         }
         param2.collisions[2] = _loc6_;
         LargeFloorTile(param2).images = images;
         param2.imageSet = images;
      }
   }
}

