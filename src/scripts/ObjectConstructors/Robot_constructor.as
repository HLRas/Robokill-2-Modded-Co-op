package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Robot_constructor
   {
      
      public static var LayerName:String = "TextLayer";
      
      public static var baseim_embed:Class = Embeds.droid001_png;
      
      public static var baseim:BitmapData = new Embeds.droid001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.droid001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.droid001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.droid002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.droid002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.droid003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.droid003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.droid004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.droid004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.droid005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.droid005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.droid006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.droid006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.droid007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.droid007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.droid008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.droid008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.droid009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.droid009_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9];
      
      public function Robot_constructor()
      {
         super();
      }
      
      public static function setup(param1:GameScene, param2:GameObject) : void
      {
         var _loc3_:GameObjectFilter = null;
         var _loc4_:ParticleEmitter = null;
         var _loc5_:ParticleFilter = null;
         var _loc6_:GameObject = null;
         var _loc7_:GameObjectFilter = null;
         param2.baseHandleX = 0.5;
         param2.baseHandleY = 0.5;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 0;
         Robot(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

