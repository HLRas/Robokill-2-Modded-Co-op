package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class BullBat_constructor
   {
      
      public static var collision_90:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.bat_bull001_png;
      
      public static var baseim:BitmapData = new Embeds.bat_bull001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.bat_bull001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.bat_bull001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.bat_bull002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.bat_bull002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.bat_bull003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.bat_bull003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.bat_bull004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.bat_bull004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.bat_bull005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.bat_bull005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.bat_bull006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.bat_bull006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.bat_bull007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.bat_bull007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.bat_bull008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.bat_bull008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.bat_bull009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.bat_bull009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.bat_bull010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.bat_bull010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.bat_bull011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.bat_bull011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.bat_bull012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.bat_bull012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.bat_bull013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.bat_bull013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.bat_bull014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.bat_bull014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.bat_bull015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.bat_bull015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.bat_bull016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.bat_bull016_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16];
      
      public function BullBat_constructor()
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
         var _loc6_:GameObjectCollision = collision_90;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_90 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         BullBat(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

