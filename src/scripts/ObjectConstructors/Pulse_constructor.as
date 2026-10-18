package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Pulse_constructor
   {
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.pulse_01_png;
      
      public static var baseim:BitmapData = new Embeds.pulse_01_png().bitmapData;
      
      public static var images_1_embed:Class = Embeds.pulse_01_png;
      
      public static var images_1:BitmapData = new Embeds.pulse_01_png().bitmapData;
      
      public static var images_2_embed:Class = Embeds.pulse_02_png;
      
      public static var images_2:BitmapData = new Embeds.pulse_02_png().bitmapData;
      
      public static var images_3_embed:Class = Embeds.pulse_03_png;
      
      public static var images_3:BitmapData = new Embeds.pulse_03_png().bitmapData;
      
      public static var images_4_embed:Class = Embeds.pulse_04_png;
      
      public static var images_4:BitmapData = new Embeds.pulse_04_png().bitmapData;
      
      public static var images_5_embed:Class = Embeds.pulse_05_png;
      
      public static var images_5:BitmapData = new Embeds.pulse_05_png().bitmapData;
      
      public static var images_6_embed:Class = Embeds.pulse_06_png;
      
      public static var images_6:BitmapData = new Embeds.pulse_06_png().bitmapData;
      
      public static var images_7_embed:Class = Embeds.pulse_07_png;
      
      public static var images_7:BitmapData = new Embeds.pulse_07_png().bitmapData;
      
      public static var images_8_embed:Class = Embeds.pulse_08_png;
      
      public static var images_8:BitmapData = new Embeds.pulse_08_png().bitmapData;
      
      public static var images_9_embed:Class = Embeds.pulse_09_png;
      
      public static var images_9:BitmapData = new Embeds.pulse_09_png().bitmapData;
      
      public static var images_10_embed:Class = Embeds.pulse_10_png;
      
      public static var images_10:BitmapData = new Embeds.pulse_10_png().bitmapData;
      
      public static var images_11_embed:Class = Embeds.pulse_11_png;
      
      public static var images_11:BitmapData = new Embeds.pulse_11_png().bitmapData;
      
      public static var images_12_embed:Class = Embeds.pulse_12_png;
      
      public static var images_12:BitmapData = new Embeds.pulse_12_png().bitmapData;
      
      public static var images_13_embed:Class = Embeds.pulse_13_png;
      
      public static var images_13:BitmapData = new Embeds.pulse_13_png().bitmapData;
      
      public static var images_14_embed:Class = Embeds.pulse_14_png;
      
      public static var images_14:BitmapData = new Embeds.pulse_14_png().bitmapData;
      
      public static var images_15_embed:Class = Embeds.pulse_15_png;
      
      public static var images_15:BitmapData = new Embeds.pulse_15_png().bitmapData;
      
      public static var images:Array = [images_1,images_2,images_3,images_4,images_5,images_6,images_7,images_8,images_9,images_10,images_11,images_12,images_13,images_14,images_15];
      
      public function Pulse_constructor()
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
         Pulse(param2).images = images;
         param2.imageSet = images;
      }
   }
}

