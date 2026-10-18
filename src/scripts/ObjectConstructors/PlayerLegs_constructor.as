package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class PlayerLegs_constructor
   {
      
      public static var LayerName:String = "BelowPlayer";
      
      public static var baseim_embed:Class = Embeds.player_legs001_png;
      
      public static var baseim:BitmapData = new Embeds.player_legs001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.player_legs001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.player_legs001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.player_legs002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.player_legs002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.player_legs003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.player_legs003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.player_legs004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.player_legs004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.player_legs005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.player_legs005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.player_legs006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.player_legs006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.player_legs007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.player_legs007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.player_legs008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.player_legs008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.player_legs009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.player_legs009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.player_legs010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.player_legs010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.player_legs011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.player_legs011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.player_legs012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.player_legs012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.player_legs013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.player_legs013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.player_legs014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.player_legs014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.player_legs015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.player_legs015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.player_legs016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.player_legs016_png().bitmapData;
      
      public static var imageSet_17_embed:Class = Embeds.player_legs017_png;
      
      public static var imageSet_17:BitmapData = new Embeds.player_legs017_png().bitmapData;
      
      public static var imageSet_18_embed:Class = Embeds.player_legs018_png;
      
      public static var imageSet_18:BitmapData = new Embeds.player_legs018_png().bitmapData;
      
      public static var imageSet_19_embed:Class = Embeds.player_legs019_png;
      
      public static var imageSet_19:BitmapData = new Embeds.player_legs019_png().bitmapData;
      
      public static var imageSet_20_embed:Class = Embeds.player_legs020_png;
      
      public static var imageSet_20:BitmapData = new Embeds.player_legs020_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16,imageSet_17,imageSet_18,imageSet_19,imageSet_20];
      
      public function PlayerLegs_constructor()
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
         param2.animSpeed = 3;
         PlayerLegs(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

