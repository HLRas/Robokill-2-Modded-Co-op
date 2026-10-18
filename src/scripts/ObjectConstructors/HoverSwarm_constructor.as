package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class HoverSwarm_constructor
   {
      
      public static var collision_30:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.bat001_png;
      
      public static var baseim:BitmapData = new Embeds.bat001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.bat001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.bat001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.bat002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.bat002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.bat003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.bat003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.bat004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.bat004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.bat005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.bat005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.bat006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.bat006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.bat007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.bat007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.bat008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.bat008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.bat009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.bat009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.bat010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.bat010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.bat011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.bat011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.bat012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.bat012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.bat013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.bat013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.bat014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.bat014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.bat015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.bat015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.bat016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.bat016_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16];
      
      public function HoverSwarm_constructor()
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
         var _loc6_:GameObjectCollision = collision_30;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_30 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         HoverSwarm(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

