package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Wasp_constructor
   {
      
      public static var collision_89:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.wasp001_png;
      
      public static var baseim:BitmapData = new Embeds.wasp001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.wasp001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.wasp001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.wasp002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.wasp002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.wasp003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.wasp003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.wasp004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.wasp004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.wasp005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.wasp005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.wasp006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.wasp006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.wasp007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.wasp007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.wasp008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.wasp008_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8];
      
      public static var creationFrame_embed:Class = Embeds.wasp_creation_png;
      
      public static var creationFrame:BitmapData = new Embeds.wasp_creation_png().bitmapData;
      
      public function Wasp_constructor()
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
         param2.animSpeed = 8.39999962;
         var _loc6_:GameObjectCollision = collision_89;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_89 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Wasp(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
         Wasp(param2).creationFrame = creationFrame;
      }
   }
}

