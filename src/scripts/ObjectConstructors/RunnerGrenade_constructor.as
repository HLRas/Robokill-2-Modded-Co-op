package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class RunnerGrenade_constructor
   {
      
      public static var collision_48:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.runner_grenade001_png;
      
      public static var baseim:BitmapData = new Embeds.runner_grenade001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.runner_grenade001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.runner_grenade001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.runner_grenade002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.runner_grenade002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.runner_grenade003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.runner_grenade003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.runner_grenade004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.runner_grenade004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.runner_grenade005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.runner_grenade005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.runner_grenade006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.runner_grenade006_png().bitmapData;
      
      public static var imageSet_7_embed:Class = Embeds.runner_grenade007_png;
      
      public static var imageSet_7:BitmapData = new Embeds.runner_grenade007_png().bitmapData;
      
      public static var imageSet_8_embed:Class = Embeds.runner_grenade008_png;
      
      public static var imageSet_8:BitmapData = new Embeds.runner_grenade008_png().bitmapData;
      
      public static var imageSet_9_embed:Class = Embeds.runner_grenade009_png;
      
      public static var imageSet_9:BitmapData = new Embeds.runner_grenade009_png().bitmapData;
      
      public static var imageSet_10_embed:Class = Embeds.runner_grenade010_png;
      
      public static var imageSet_10:BitmapData = new Embeds.runner_grenade010_png().bitmapData;
      
      public static var imageSet_11_embed:Class = Embeds.runner_grenade011_png;
      
      public static var imageSet_11:BitmapData = new Embeds.runner_grenade011_png().bitmapData;
      
      public static var imageSet_12_embed:Class = Embeds.runner_grenade012_png;
      
      public static var imageSet_12:BitmapData = new Embeds.runner_grenade012_png().bitmapData;
      
      public static var imageSet_13_embed:Class = Embeds.runner_grenade013_png;
      
      public static var imageSet_13:BitmapData = new Embeds.runner_grenade013_png().bitmapData;
      
      public static var imageSet_14_embed:Class = Embeds.runner_grenade014_png;
      
      public static var imageSet_14:BitmapData = new Embeds.runner_grenade014_png().bitmapData;
      
      public static var imageSet_15_embed:Class = Embeds.runner_grenade015_png;
      
      public static var imageSet_15:BitmapData = new Embeds.runner_grenade015_png().bitmapData;
      
      public static var imageSet_16_embed:Class = Embeds.runner_grenade016_png;
      
      public static var imageSet_16:BitmapData = new Embeds.runner_grenade016_png().bitmapData;
      
      public static var imageSet_17_embed:Class = Embeds.runner_grenade017_png;
      
      public static var imageSet_17:BitmapData = new Embeds.runner_grenade017_png().bitmapData;
      
      public static var imageSet_18_embed:Class = Embeds.runner_grenade018_png;
      
      public static var imageSet_18:BitmapData = new Embeds.runner_grenade018_png().bitmapData;
      
      public static var imageSet_19_embed:Class = Embeds.runner_grenade019_png;
      
      public static var imageSet_19:BitmapData = new Embeds.runner_grenade019_png().bitmapData;
      
      public static var imageSet_20_embed:Class = Embeds.runner_grenade020_png;
      
      public static var imageSet_20:BitmapData = new Embeds.runner_grenade020_png().bitmapData;
      
      public static var imageSet_21_embed:Class = Embeds.runner_grenade021_png;
      
      public static var imageSet_21:BitmapData = new Embeds.runner_grenade021_png().bitmapData;
      
      public static var imageSet_22_embed:Class = Embeds.runner_grenade022_png;
      
      public static var imageSet_22:BitmapData = new Embeds.runner_grenade022_png().bitmapData;
      
      public static var imageSet_23_embed:Class = Embeds.runner_grenade023_png;
      
      public static var imageSet_23:BitmapData = new Embeds.runner_grenade023_png().bitmapData;
      
      public static var imageSet_24_embed:Class = Embeds.runner_grenade024_png;
      
      public static var imageSet_24:BitmapData = new Embeds.runner_grenade024_png().bitmapData;
      
      public static var imageSet_25_embed:Class = Embeds.runner_grenade025_png;
      
      public static var imageSet_25:BitmapData = new Embeds.runner_grenade025_png().bitmapData;
      
      public static var imageSet_26_embed:Class = Embeds.runner_grenade026_png;
      
      public static var imageSet_26:BitmapData = new Embeds.runner_grenade026_png().bitmapData;
      
      public static var imageSet_27_embed:Class = Embeds.runner_grenade027_png;
      
      public static var imageSet_27:BitmapData = new Embeds.runner_grenade027_png().bitmapData;
      
      public static var imageSet_28_embed:Class = Embeds.runner_grenade028_png;
      
      public static var imageSet_28:BitmapData = new Embeds.runner_grenade028_png().bitmapData;
      
      public static var imageSet_29_embed:Class = Embeds.runner_grenade029_png;
      
      public static var imageSet_29:BitmapData = new Embeds.runner_grenade029_png().bitmapData;
      
      public static var imageSet_30_embed:Class = Embeds.runner_grenade030_png;
      
      public static var imageSet_30:BitmapData = new Embeds.runner_grenade030_png().bitmapData;
      
      public static var imageSet_31_embed:Class = Embeds.runner_grenade031_png;
      
      public static var imageSet_31:BitmapData = new Embeds.runner_grenade031_png().bitmapData;
      
      public static var imageSet_32_embed:Class = Embeds.runner_grenade032_png;
      
      public static var imageSet_32:BitmapData = new Embeds.runner_grenade032_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6,imageSet_7,imageSet_8,imageSet_9,imageSet_10,imageSet_11,imageSet_12,imageSet_13,imageSet_14,imageSet_15,imageSet_16,imageSet_17,imageSet_18,imageSet_19,imageSet_20,imageSet_21,imageSet_22,imageSet_23,imageSet_24,imageSet_25,imageSet_26,imageSet_27,imageSet_28,imageSet_29,imageSet_30,imageSet_31,imageSet_32];
      
      public function RunnerGrenade_constructor()
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
         param2.additive = true;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 0;
         var _loc6_:GameObjectCollision = collision_48;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_48 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         RunnerGrenade(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

