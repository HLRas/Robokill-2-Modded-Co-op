package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class TopDecal_constructor
   {
      
      public static var collision_57:GameObjectCollision;
      
      public static var LayerName:String = "";
      
      public static var baseim_embed:Class = Embeds.top_decal_01_png;
      
      public static var baseim:BitmapData = new Embeds.top_decal_01_png().bitmapData;
      
      public static var images_1_embed:Class = Embeds.top_decal_01_png;
      
      public static var images_1:BitmapData = new Embeds.top_decal_01_png().bitmapData;
      
      public static var images_2_embed:Class = Embeds.top_decal_02_png;
      
      public static var images_2:BitmapData = new Embeds.top_decal_02_png().bitmapData;
      
      public static var images_3_embed:Class = Embeds.top_decal_03_png;
      
      public static var images_3:BitmapData = new Embeds.top_decal_03_png().bitmapData;
      
      public static var images_4_embed:Class = Embeds.top_decal_04_png;
      
      public static var images_4:BitmapData = new Embeds.top_decal_04_png().bitmapData;
      
      public static var images_5_embed:Class = Embeds.top_decal_05_png;
      
      public static var images_5:BitmapData = new Embeds.top_decal_05_png().bitmapData;
      
      public static var images_6_embed:Class = Embeds.top_decal_06_png;
      
      public static var images_6:BitmapData = new Embeds.top_decal_06_png().bitmapData;
      
      public static var images:Array = [images_1,images_2,images_3,images_4,images_5,images_6];
      
      public function TopDecal_constructor()
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
         var _loc6_:GameObjectCollision = collision_57;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_57 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         TopDecal(param2).images = images;
         param2.imageSet = images;
      }
   }
}

