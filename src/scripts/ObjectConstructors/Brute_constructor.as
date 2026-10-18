package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Brute_constructor
   {
      
      public static var collision_36:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.brute_torso001_png;
      
      public static var baseim:BitmapData = new Embeds.brute_torso001_png().bitmapData;
      
      public static var walk_1_embed:Class = Embeds.brute_torso001_png;
      
      public static var walk_1:BitmapData = new Embeds.brute_torso001_png().bitmapData;
      
      public static var walk_2_embed:Class = Embeds.brute_torso002_png;
      
      public static var walk_2:BitmapData = new Embeds.brute_torso002_png().bitmapData;
      
      public static var walk_3_embed:Class = Embeds.brute_torso003_png;
      
      public static var walk_3:BitmapData = new Embeds.brute_torso003_png().bitmapData;
      
      public static var walk_4_embed:Class = Embeds.brute_torso004_png;
      
      public static var walk_4:BitmapData = new Embeds.brute_torso004_png().bitmapData;
      
      public static var walk_5_embed:Class = Embeds.brute_torso005_png;
      
      public static var walk_5:BitmapData = new Embeds.brute_torso005_png().bitmapData;
      
      public static var walk_6_embed:Class = Embeds.brute_torso006_png;
      
      public static var walk_6:BitmapData = new Embeds.brute_torso006_png().bitmapData;
      
      public static var walk_7_embed:Class = Embeds.brute_torso007_png;
      
      public static var walk_7:BitmapData = new Embeds.brute_torso007_png().bitmapData;
      
      public static var walk_8_embed:Class = Embeds.brute_torso008_png;
      
      public static var walk_8:BitmapData = new Embeds.brute_torso008_png().bitmapData;
      
      public static var walk_9_embed:Class = Embeds.brute_torso009_png;
      
      public static var walk_9:BitmapData = new Embeds.brute_torso009_png().bitmapData;
      
      public static var walk_10_embed:Class = Embeds.brute_torso010_png;
      
      public static var walk_10:BitmapData = new Embeds.brute_torso010_png().bitmapData;
      
      public static var walk_11_embed:Class = Embeds.brute_torso011_png;
      
      public static var walk_11:BitmapData = new Embeds.brute_torso011_png().bitmapData;
      
      public static var walk_12_embed:Class = Embeds.brute_torso012_png;
      
      public static var walk_12:BitmapData = new Embeds.brute_torso012_png().bitmapData;
      
      public static var walk_13_embed:Class = Embeds.brute_torso013_png;
      
      public static var walk_13:BitmapData = new Embeds.brute_torso013_png().bitmapData;
      
      public static var walk_14_embed:Class = Embeds.brute_torso014_png;
      
      public static var walk_14:BitmapData = new Embeds.brute_torso014_png().bitmapData;
      
      public static var walk_15_embed:Class = Embeds.brute_torso015_png;
      
      public static var walk_15:BitmapData = new Embeds.brute_torso015_png().bitmapData;
      
      public static var walk_16_embed:Class = Embeds.brute_torso016_png;
      
      public static var walk_16:BitmapData = new Embeds.brute_torso016_png().bitmapData;
      
      public static var walk_17_embed:Class = Embeds.brute_torso017_png;
      
      public static var walk_17:BitmapData = new Embeds.brute_torso017_png().bitmapData;
      
      public static var walk_18_embed:Class = Embeds.brute_torso018_png;
      
      public static var walk_18:BitmapData = new Embeds.brute_torso018_png().bitmapData;
      
      public static var walk_19_embed:Class = Embeds.brute_torso019_png;
      
      public static var walk_19:BitmapData = new Embeds.brute_torso019_png().bitmapData;
      
      public static var walk_20_embed:Class = Embeds.brute_torso020_png;
      
      public static var walk_20:BitmapData = new Embeds.brute_torso020_png().bitmapData;
      
      public static var walk:Array = [walk_1,walk_2,walk_3,walk_4,walk_5,walk_6,walk_7,walk_8,walk_9,walk_10,walk_11,walk_12,walk_13,walk_14,walk_15,walk_16,walk_17,walk_18,walk_19,walk_20];
      
      public static var attack_1_embed:Class = Embeds.Brute_attack001_png;
      
      public static var attack_1:BitmapData = new Embeds.Brute_attack001_png().bitmapData;
      
      public static var attack_2_embed:Class = Embeds.Brute_attack002_png;
      
      public static var attack_2:BitmapData = new Embeds.Brute_attack002_png().bitmapData;
      
      public static var attack_3_embed:Class = Embeds.Brute_attack003_png;
      
      public static var attack_3:BitmapData = new Embeds.Brute_attack003_png().bitmapData;
      
      public static var attack_4_embed:Class = Embeds.Brute_attack004_png;
      
      public static var attack_4:BitmapData = new Embeds.Brute_attack004_png().bitmapData;
      
      public static var attack_5_embed:Class = Embeds.Brute_attack005_png;
      
      public static var attack_5:BitmapData = new Embeds.Brute_attack005_png().bitmapData;
      
      public static var attack_6_embed:Class = Embeds.Brute_attack006_png;
      
      public static var attack_6:BitmapData = new Embeds.Brute_attack006_png().bitmapData;
      
      public static var attack_7_embed:Class = Embeds.Brute_attack007_png;
      
      public static var attack_7:BitmapData = new Embeds.Brute_attack007_png().bitmapData;
      
      public static var attack_8_embed:Class = Embeds.Brute_attack008_png;
      
      public static var attack_8:BitmapData = new Embeds.Brute_attack008_png().bitmapData;
      
      public static var attack:Array = [attack_1,attack_2,attack_3,attack_4,attack_5,attack_6,attack_7,attack_8];
      
      public static var shout_1_embed:Class = Embeds.Brute_hit_effect001_png;
      
      public static var shout_1:BitmapData = new Embeds.Brute_hit_effect001_png().bitmapData;
      
      public static var shout_2_embed:Class = Embeds.Brute_hit_effect002_png;
      
      public static var shout_2:BitmapData = new Embeds.Brute_hit_effect002_png().bitmapData;
      
      public static var shout_3_embed:Class = Embeds.Brute_hit_effect003_png;
      
      public static var shout_3:BitmapData = new Embeds.Brute_hit_effect003_png().bitmapData;
      
      public static var shout_4_embed:Class = Embeds.Brute_hit_effect004_png;
      
      public static var shout_4:BitmapData = new Embeds.Brute_hit_effect004_png().bitmapData;
      
      public static var shout_5_embed:Class = Embeds.Brute_hit_effect005_png;
      
      public static var shout_5:BitmapData = new Embeds.Brute_hit_effect005_png().bitmapData;
      
      public static var shout_6_embed:Class = Embeds.Brute_hit_effect006_png;
      
      public static var shout_6:BitmapData = new Embeds.Brute_hit_effect006_png().bitmapData;
      
      public static var shout_7_embed:Class = Embeds.Brute_hit_effect007_png;
      
      public static var shout_7:BitmapData = new Embeds.Brute_hit_effect007_png().bitmapData;
      
      public static var shout_8_embed:Class = Embeds.Brute_hit_effect008_png;
      
      public static var shout_8:BitmapData = new Embeds.Brute_hit_effect008_png().bitmapData;
      
      public static var shout:Array = [shout_1,shout_2,shout_3,shout_4,shout_5,shout_6,shout_7,shout_8];
      
      public static var jump_1_embed:Class = Embeds.Brute_jump001_png;
      
      public static var jump_1:BitmapData = new Embeds.Brute_jump001_png().bitmapData;
      
      public static var jump_2_embed:Class = Embeds.Brute_jump002_png;
      
      public static var jump_2:BitmapData = new Embeds.Brute_jump002_png().bitmapData;
      
      public static var jump_3_embed:Class = Embeds.Brute_jump003_png;
      
      public static var jump_3:BitmapData = new Embeds.Brute_jump003_png().bitmapData;
      
      public static var jump_4_embed:Class = Embeds.Brute_jump004_png;
      
      public static var jump_4:BitmapData = new Embeds.Brute_jump004_png().bitmapData;
      
      public static var jump_5_embed:Class = Embeds.Brute_jump005_png;
      
      public static var jump_5:BitmapData = new Embeds.Brute_jump005_png().bitmapData;
      
      public static var jump_6_embed:Class = Embeds.Brute_jump006_png;
      
      public static var jump_6:BitmapData = new Embeds.Brute_jump006_png().bitmapData;
      
      public static var jump_7_embed:Class = Embeds.Brute_jump007_png;
      
      public static var jump_7:BitmapData = new Embeds.Brute_jump007_png().bitmapData;
      
      public static var jump_8_embed:Class = Embeds.Brute_jump008_png;
      
      public static var jump_8:BitmapData = new Embeds.Brute_jump008_png().bitmapData;
      
      public static var jump_9_embed:Class = Embeds.Brute_jump009_png;
      
      public static var jump_9:BitmapData = new Embeds.Brute_jump009_png().bitmapData;
      
      public static var jump_10_embed:Class = Embeds.Brute_jump010_png;
      
      public static var jump_10:BitmapData = new Embeds.Brute_jump010_png().bitmapData;
      
      public static var jump:Array = [jump_1,jump_2,jump_3,jump_4,jump_5,jump_6,jump_7,jump_8,jump_9,jump_10];
      
      public static var shadow_1_embed:Class = Embeds.Brute_shadow001_png;
      
      public static var shadow_1:BitmapData = new Embeds.Brute_shadow001_png().bitmapData;
      
      public static var shadow_2_embed:Class = Embeds.Brute_shadow002_png;
      
      public static var shadow_2:BitmapData = new Embeds.Brute_shadow002_png().bitmapData;
      
      public static var shadow_3_embed:Class = Embeds.Brute_shadow003_png;
      
      public static var shadow_3:BitmapData = new Embeds.Brute_shadow003_png().bitmapData;
      
      public static var shadow_4_embed:Class = Embeds.Brute_shadow004_png;
      
      public static var shadow_4:BitmapData = new Embeds.Brute_shadow004_png().bitmapData;
      
      public static var shadow_5_embed:Class = Embeds.Brute_shadow005_png;
      
      public static var shadow_5:BitmapData = new Embeds.Brute_shadow005_png().bitmapData;
      
      public static var shadow_6_embed:Class = Embeds.Brute_shadow006_png;
      
      public static var shadow_6:BitmapData = new Embeds.Brute_shadow006_png().bitmapData;
      
      public static var shadow_7_embed:Class = Embeds.Brute_shadow007_png;
      
      public static var shadow_7:BitmapData = new Embeds.Brute_shadow007_png().bitmapData;
      
      public static var shadow_8_embed:Class = Embeds.Brute_shadow008_png;
      
      public static var shadow_8:BitmapData = new Embeds.Brute_shadow008_png().bitmapData;
      
      public static var shadow_9_embed:Class = Embeds.Brute_shadow009_png;
      
      public static var shadow_9:BitmapData = new Embeds.Brute_shadow009_png().bitmapData;
      
      public static var shadow_10_embed:Class = Embeds.Brute_shadow010_png;
      
      public static var shadow_10:BitmapData = new Embeds.Brute_shadow010_png().bitmapData;
      
      public static var shadow_11_embed:Class = Embeds.Brute_shadow011_png;
      
      public static var shadow_11:BitmapData = new Embeds.Brute_shadow011_png().bitmapData;
      
      public static var shadow_12_embed:Class = Embeds.Brute_shadow012_png;
      
      public static var shadow_12:BitmapData = new Embeds.Brute_shadow012_png().bitmapData;
      
      public static var shadow_13_embed:Class = Embeds.Brute_shadow013_png;
      
      public static var shadow_13:BitmapData = new Embeds.Brute_shadow013_png().bitmapData;
      
      public static var shadow_14_embed:Class = Embeds.Brute_shadow014_png;
      
      public static var shadow_14:BitmapData = new Embeds.Brute_shadow014_png().bitmapData;
      
      public static var shadow_15_embed:Class = Embeds.Brute_shadow015_png;
      
      public static var shadow_15:BitmapData = new Embeds.Brute_shadow015_png().bitmapData;
      
      public static var shadow_16_embed:Class = Embeds.Brute_shadow016_png;
      
      public static var shadow_16:BitmapData = new Embeds.Brute_shadow016_png().bitmapData;
      
      public static var shadow_17_embed:Class = Embeds.Brute_shadow017_png;
      
      public static var shadow_17:BitmapData = new Embeds.Brute_shadow017_png().bitmapData;
      
      public static var shadow_18_embed:Class = Embeds.Brute_shadow018_png;
      
      public static var shadow_18:BitmapData = new Embeds.Brute_shadow018_png().bitmapData;
      
      public static var shadow_19_embed:Class = Embeds.Brute_shadow019_png;
      
      public static var shadow_19:BitmapData = new Embeds.Brute_shadow019_png().bitmapData;
      
      public static var shadow_20_embed:Class = Embeds.Brute_shadow020_png;
      
      public static var shadow_20:BitmapData = new Embeds.Brute_shadow020_png().bitmapData;
      
      public static var shadow:Array = [shadow_1,shadow_2,shadow_3,shadow_4,shadow_5,shadow_6,shadow_7,shadow_8,shadow_9,shadow_10,shadow_11,shadow_12,shadow_13,shadow_14,shadow_15,shadow_16,shadow_17,shadow_18,shadow_19,shadow_20];
      
      public static var lift_1_embed:Class = Embeds.Brute_lift001_png;
      
      public static var lift_1:BitmapData = new Embeds.Brute_lift001_png().bitmapData;
      
      public static var lift_2_embed:Class = Embeds.Brute_lift002_png;
      
      public static var lift_2:BitmapData = new Embeds.Brute_lift002_png().bitmapData;
      
      public static var lift_3_embed:Class = Embeds.Brute_lift003_png;
      
      public static var lift_3:BitmapData = new Embeds.Brute_lift003_png().bitmapData;
      
      public static var lift_4_embed:Class = Embeds.Brute_lift004_png;
      
      public static var lift_4:BitmapData = new Embeds.Brute_lift004_png().bitmapData;
      
      public static var lift_5_embed:Class = Embeds.Brute_lift005_png;
      
      public static var lift_5:BitmapData = new Embeds.Brute_lift005_png().bitmapData;
      
      public static var lift_6_embed:Class = Embeds.Brute_lift006_png;
      
      public static var lift_6:BitmapData = new Embeds.Brute_lift006_png().bitmapData;
      
      public static var lift_7_embed:Class = Embeds.Brute_lift007_png;
      
      public static var lift_7:BitmapData = new Embeds.Brute_lift007_png().bitmapData;
      
      public static var lift_8_embed:Class = Embeds.Brute_lift008_png;
      
      public static var lift_8:BitmapData = new Embeds.Brute_lift008_png().bitmapData;
      
      public static var lift:Array = [lift_1,lift_2,lift_3,lift_4,lift_5,lift_6,lift_7,lift_8];
      
      public static var drop_1_embed:Class = Embeds.Brute_rocket_drop001_png;
      
      public static var drop_1:BitmapData = new Embeds.Brute_rocket_drop001_png().bitmapData;
      
      public static var drop_2_embed:Class = Embeds.Brute_rocket_drop002_png;
      
      public static var drop_2:BitmapData = new Embeds.Brute_rocket_drop002_png().bitmapData;
      
      public static var drop_3_embed:Class = Embeds.Brute_rocket_drop003_png;
      
      public static var drop_3:BitmapData = new Embeds.Brute_rocket_drop003_png().bitmapData;
      
      public static var drop_4_embed:Class = Embeds.Brute_rocket_drop004_png;
      
      public static var drop_4:BitmapData = new Embeds.Brute_rocket_drop004_png().bitmapData;
      
      public static var drop_5_embed:Class = Embeds.Brute_rocket_drop005_png;
      
      public static var drop_5:BitmapData = new Embeds.Brute_rocket_drop005_png().bitmapData;
      
      public static var drop_6_embed:Class = Embeds.Brute_rocket_drop006_png;
      
      public static var drop_6:BitmapData = new Embeds.Brute_rocket_drop006_png().bitmapData;
      
      public static var drop_7_embed:Class = Embeds.Brute_rocket_drop007_png;
      
      public static var drop_7:BitmapData = new Embeds.Brute_rocket_drop007_png().bitmapData;
      
      public static var drop_8_embed:Class = Embeds.Brute_rocket_drop008_png;
      
      public static var drop_8:BitmapData = new Embeds.Brute_rocket_drop008_png().bitmapData;
      
      public static var drop:Array = [drop_1,drop_2,drop_3,drop_4,drop_5,drop_6,drop_7,drop_8];
      
      public static var climb_1_embed:Class = Embeds.Brute_climb001_png;
      
      public static var climb_1:BitmapData = new Embeds.Brute_climb001_png().bitmapData;
      
      public static var climb_2_embed:Class = Embeds.Brute_climb002_png;
      
      public static var climb_2:BitmapData = new Embeds.Brute_climb002_png().bitmapData;
      
      public static var climb_3_embed:Class = Embeds.Brute_climb003_png;
      
      public static var climb_3:BitmapData = new Embeds.Brute_climb003_png().bitmapData;
      
      public static var climb_4_embed:Class = Embeds.Brute_climb004_png;
      
      public static var climb_4:BitmapData = new Embeds.Brute_climb004_png().bitmapData;
      
      public static var climb_5_embed:Class = Embeds.Brute_climb005_png;
      
      public static var climb_5:BitmapData = new Embeds.Brute_climb005_png().bitmapData;
      
      public static var climb_6_embed:Class = Embeds.Brute_climb006_png;
      
      public static var climb_6:BitmapData = new Embeds.Brute_climb006_png().bitmapData;
      
      public static var climb_7_embed:Class = Embeds.Brute_climb007_png;
      
      public static var climb_7:BitmapData = new Embeds.Brute_climb007_png().bitmapData;
      
      public static var climb_8_embed:Class = Embeds.Brute_climb008_png;
      
      public static var climb_8:BitmapData = new Embeds.Brute_climb008_png().bitmapData;
      
      public static var climb_9_embed:Class = Embeds.Brute_climb009_png;
      
      public static var climb_9:BitmapData = new Embeds.Brute_climb009_png().bitmapData;
      
      public static var climb_10_embed:Class = Embeds.Brute_climb010_png;
      
      public static var climb_10:BitmapData = new Embeds.Brute_climb010_png().bitmapData;
      
      public static var climb_11_embed:Class = Embeds.Brute_climb011_png;
      
      public static var climb_11:BitmapData = new Embeds.Brute_climb011_png().bitmapData;
      
      public static var climb_12_embed:Class = Embeds.Brute_climb012_png;
      
      public static var climb_12:BitmapData = new Embeds.Brute_climb012_png().bitmapData;
      
      public static var climb_13_embed:Class = Embeds.Brute_climb013_png;
      
      public static var climb_13:BitmapData = new Embeds.Brute_climb013_png().bitmapData;
      
      public static var climb_14_embed:Class = Embeds.Brute_climb014_png;
      
      public static var climb_14:BitmapData = new Embeds.Brute_climb014_png().bitmapData;
      
      public static var climb_15_embed:Class = Embeds.Brute_climb015_png;
      
      public static var climb_15:BitmapData = new Embeds.Brute_climb015_png().bitmapData;
      
      public static var climb_16_embed:Class = Embeds.Brute_climb016_png;
      
      public static var climb_16:BitmapData = new Embeds.Brute_climb016_png().bitmapData;
      
      public static var climb_17_embed:Class = Embeds.Brute_climb017_png;
      
      public static var climb_17:BitmapData = new Embeds.Brute_climb017_png().bitmapData;
      
      public static var climb_18_embed:Class = Embeds.Brute_climb018_png;
      
      public static var climb_18:BitmapData = new Embeds.Brute_climb018_png().bitmapData;
      
      public static var climb_19_embed:Class = Embeds.Brute_climb019_png;
      
      public static var climb_19:BitmapData = new Embeds.Brute_climb019_png().bitmapData;
      
      public static var climb_20_embed:Class = Embeds.Brute_climb020_png;
      
      public static var climb_20:BitmapData = new Embeds.Brute_climb020_png().bitmapData;
      
      public static var climb:Array = [climb_1,climb_2,climb_3,climb_4,climb_5,climb_6,climb_7,climb_8,climb_9,climb_10,climb_11,climb_12,climb_13,climb_14,climb_15,climb_16,climb_17,climb_18,climb_19,climb_20];
      
      public function Brute_constructor()
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
         param2.animSpeed = 4;
         var _loc6_:GameObjectCollision = collision_36;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_36 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Brute(param2).walk = walk;
         param2.imageSet = walk;
         Brute(param2).attack = attack;
         param2.imageSet = attack;
         Brute(param2).shout = shout;
         param2.imageSet = shout;
         Brute(param2).jump = jump;
         param2.imageSet = jump;
         Brute(param2).shadow = shadow;
         param2.imageSet = shadow;
         Brute(param2).lift = lift;
         param2.imageSet = lift;
         Brute(param2).drop = drop;
         param2.imageSet = drop;
         Brute(param2).climb = climb;
         param2.imageSet = climb;
      }
   }
}

