package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Nest_constructor
   {
      
      public static var collision_38:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.Nest_spawn001_png;
      
      public static var baseim:BitmapData = new Embeds.Nest_spawn001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.Nest_spawn001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.Nest_spawn001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.Nest_spawn002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.Nest_spawn002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.Nest_spawn003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.Nest_spawn003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.Nest_spawn004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.Nest_spawn004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.Nest_spawn005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.Nest_spawn005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.Nest_spawn006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.Nest_spawn006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.Nest_spawn007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.Nest_spawn007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.Nest_spawn008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.Nest_spawn008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.Nest_spawn009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.Nest_spawn009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.Nest_spawn010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.Nest_spawn010_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10];
      
      public function Nest_constructor()
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
         param2.animSpeed = 10.3000002;
         var _loc6_:GameObjectCollision = collision_38;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_38 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Nest(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

