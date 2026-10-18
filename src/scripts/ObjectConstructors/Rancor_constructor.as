package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Rancor_constructor
   {
      
      public static var collision_82:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.Beast_torso001_png;
      
      public static var baseim:BitmapData = new Embeds.Beast_torso001_png().bitmapData;
      
      public static var moveAnim_1_embed:Class = Embeds.beast_torso001_png;
      
      public static var moveAnim_1:BitmapData = new Embeds.beast_torso001_png().bitmapData;
      
      public static var moveAnim_2_embed:Class = Embeds.beast_torso002_png;
      
      public static var moveAnim_2:BitmapData = new Embeds.beast_torso002_png().bitmapData;
      
      public static var moveAnim_3_embed:Class = Embeds.beast_torso003_png;
      
      public static var moveAnim_3:BitmapData = new Embeds.beast_torso003_png().bitmapData;
      
      public static var moveAnim_4_embed:Class = Embeds.beast_torso004_png;
      
      public static var moveAnim_4:BitmapData = new Embeds.beast_torso004_png().bitmapData;
      
      public static var moveAnim_5_embed:Class = Embeds.beast_torso005_png;
      
      public static var moveAnim_5:BitmapData = new Embeds.beast_torso005_png().bitmapData;
      
      public static var moveAnim_6_embed:Class = Embeds.beast_torso006_png;
      
      public static var moveAnim_6:BitmapData = new Embeds.beast_torso006_png().bitmapData;
      
      public static var moveAnim_7_embed:Class = Embeds.beast_torso007_png;
      
      public static var moveAnim_7:BitmapData = new Embeds.beast_torso007_png().bitmapData;
      
      public static var moveAnim_8_embed:Class = Embeds.beast_torso008_png;
      
      public static var moveAnim_8:BitmapData = new Embeds.beast_torso008_png().bitmapData;
      
      public static var moveAnim_9_embed:Class = Embeds.beast_torso009_png;
      
      public static var moveAnim_9:BitmapData = new Embeds.beast_torso009_png().bitmapData;
      
      public static var moveAnim_10_embed:Class = Embeds.beast_torso010_png;
      
      public static var moveAnim_10:BitmapData = new Embeds.beast_torso010_png().bitmapData;
      
      public static var moveAnim_11_embed:Class = Embeds.beast_torso011_png;
      
      public static var moveAnim_11:BitmapData = new Embeds.beast_torso011_png().bitmapData;
      
      public static var moveAnim_12_embed:Class = Embeds.beast_torso012_png;
      
      public static var moveAnim_12:BitmapData = new Embeds.beast_torso012_png().bitmapData;
      
      public static var moveAnim_13_embed:Class = Embeds.beast_torso013_png;
      
      public static var moveAnim_13:BitmapData = new Embeds.beast_torso013_png().bitmapData;
      
      public static var moveAnim_14_embed:Class = Embeds.beast_torso014_png;
      
      public static var moveAnim_14:BitmapData = new Embeds.beast_torso014_png().bitmapData;
      
      public static var moveAnim_15_embed:Class = Embeds.beast_torso015_png;
      
      public static var moveAnim_15:BitmapData = new Embeds.beast_torso015_png().bitmapData;
      
      public static var moveAnim_16_embed:Class = Embeds.beast_torso016_png;
      
      public static var moveAnim_16:BitmapData = new Embeds.beast_torso016_png().bitmapData;
      
      public static var moveAnim_17_embed:Class = Embeds.beast_torso017_png;
      
      public static var moveAnim_17:BitmapData = new Embeds.beast_torso017_png().bitmapData;
      
      public static var moveAnim_18_embed:Class = Embeds.beast_torso018_png;
      
      public static var moveAnim_18:BitmapData = new Embeds.beast_torso018_png().bitmapData;
      
      public static var moveAnim_19_embed:Class = Embeds.beast_torso019_png;
      
      public static var moveAnim_19:BitmapData = new Embeds.beast_torso019_png().bitmapData;
      
      public static var moveAnim_20_embed:Class = Embeds.beast_torso020_png;
      
      public static var moveAnim_20:BitmapData = new Embeds.beast_torso020_png().bitmapData;
      
      public static var moveAnim:Array = [moveAnim_1,moveAnim_2,moveAnim_3,moveAnim_4,moveAnim_5,moveAnim_6,moveAnim_7,moveAnim_8,moveAnim_9,moveAnim_10,moveAnim_11,moveAnim_12,moveAnim_13,moveAnim_14,moveAnim_15,moveAnim_16,moveAnim_17,moveAnim_18,moveAnim_19,moveAnim_20];
      
      public static var fire_1_embed:Class = Embeds.Beast_fire001_png;
      
      public static var fire_1:BitmapData = new Embeds.Beast_fire001_png().bitmapData;
      
      public static var fire_2_embed:Class = Embeds.Beast_fire002_png;
      
      public static var fire_2:BitmapData = new Embeds.Beast_fire002_png().bitmapData;
      
      public static var fire_3_embed:Class = Embeds.Beast_fire003_png;
      
      public static var fire_3:BitmapData = new Embeds.Beast_fire003_png().bitmapData;
      
      public static var fire_4_embed:Class = Embeds.Beast_fire004_png;
      
      public static var fire_4:BitmapData = new Embeds.Beast_fire004_png().bitmapData;
      
      public static var fire_5_embed:Class = Embeds.Beast_fire005_png;
      
      public static var fire_5:BitmapData = new Embeds.Beast_fire005_png().bitmapData;
      
      public static var fire_6_embed:Class = Embeds.Beast_fire006_png;
      
      public static var fire_6:BitmapData = new Embeds.Beast_fire006_png().bitmapData;
      
      public static var fire_7_embed:Class = Embeds.Beast_fire007_png;
      
      public static var fire_7:BitmapData = new Embeds.Beast_fire007_png().bitmapData;
      
      public static var fire_8_embed:Class = Embeds.Beast_fire008_png;
      
      public static var fire_8:BitmapData = new Embeds.Beast_fire008_png().bitmapData;
      
      public static var fire:Array = [fire_1,fire_2,fire_3,fire_4,fire_5,fire_6,fire_7,fire_8];
      
      public static var shout_1_embed:Class = Embeds.Beast_shout001_png;
      
      public static var shout_1:BitmapData = new Embeds.Beast_shout001_png().bitmapData;
      
      public static var shout_2_embed:Class = Embeds.Beast_shout002_png;
      
      public static var shout_2:BitmapData = new Embeds.Beast_shout002_png().bitmapData;
      
      public static var shout_3_embed:Class = Embeds.Beast_shout003_png;
      
      public static var shout_3:BitmapData = new Embeds.Beast_shout003_png().bitmapData;
      
      public static var shout_4_embed:Class = Embeds.Beast_shout004_png;
      
      public static var shout_4:BitmapData = new Embeds.Beast_shout004_png().bitmapData;
      
      public static var shout_5_embed:Class = Embeds.Beast_shout005_png;
      
      public static var shout_5:BitmapData = new Embeds.Beast_shout005_png().bitmapData;
      
      public static var shout_6_embed:Class = Embeds.Beast_shout006_png;
      
      public static var shout_6:BitmapData = new Embeds.Beast_shout006_png().bitmapData;
      
      public static var shout_7_embed:Class = Embeds.Beast_shout007_png;
      
      public static var shout_7:BitmapData = new Embeds.Beast_shout007_png().bitmapData;
      
      public static var shout_8_embed:Class = Embeds.Beast_shout008_png;
      
      public static var shout_8:BitmapData = new Embeds.Beast_shout008_png().bitmapData;
      
      public static var shout:Array = [shout_1,shout_2,shout_3,shout_4,shout_5,shout_6,shout_7,shout_8];
      
      public function Rancor_constructor()
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
         var _loc6_:GameObjectCollision = collision_82;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_82 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Rancor(param2).moveAnim = moveAnim;
         param2.imageSet = moveAnim;
         Rancor(param2).fire = fire;
         param2.imageSet = fire;
         Rancor(param2).shout = shout;
         param2.imageSet = shout;
      }
   }
}

