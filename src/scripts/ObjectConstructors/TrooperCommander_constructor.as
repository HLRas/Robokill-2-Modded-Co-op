package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class TrooperCommander_constructor
   {
      
      public static var collision_42:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.trooper_com_walk001_png;
      
      public static var baseim:BitmapData = new Embeds.trooper_com_walk001_png().bitmapData;
      
      public static var walk_1_embed:Class = Embeds.trooper_com_walk001_png;
      
      public static var walk_1:BitmapData = new Embeds.trooper_com_walk001_png().bitmapData;
      
      public static var walk_2_embed:Class = Embeds.trooper_com_walk002_png;
      
      public static var walk_2:BitmapData = new Embeds.trooper_com_walk002_png().bitmapData;
      
      public static var walk_3_embed:Class = Embeds.trooper_com_walk003_png;
      
      public static var walk_3:BitmapData = new Embeds.trooper_com_walk003_png().bitmapData;
      
      public static var walk_4_embed:Class = Embeds.trooper_com_walk004_png;
      
      public static var walk_4:BitmapData = new Embeds.trooper_com_walk004_png().bitmapData;
      
      public static var walk_5_embed:Class = Embeds.trooper_com_walk005_png;
      
      public static var walk_5:BitmapData = new Embeds.trooper_com_walk005_png().bitmapData;
      
      public static var walk_6_embed:Class = Embeds.trooper_com_walk006_png;
      
      public static var walk_6:BitmapData = new Embeds.trooper_com_walk006_png().bitmapData;
      
      public static var walk_7_embed:Class = Embeds.trooper_com_walk007_png;
      
      public static var walk_7:BitmapData = new Embeds.trooper_com_walk007_png().bitmapData;
      
      public static var walk_8_embed:Class = Embeds.trooper_com_walk008_png;
      
      public static var walk_8:BitmapData = new Embeds.trooper_com_walk008_png().bitmapData;
      
      public static var walk_9_embed:Class = Embeds.trooper_com_walk009_png;
      
      public static var walk_9:BitmapData = new Embeds.trooper_com_walk009_png().bitmapData;
      
      public static var walk_10_embed:Class = Embeds.trooper_com_walk010_png;
      
      public static var walk_10:BitmapData = new Embeds.trooper_com_walk010_png().bitmapData;
      
      public static var walk_11_embed:Class = Embeds.trooper_com_walk011_png;
      
      public static var walk_11:BitmapData = new Embeds.trooper_com_walk011_png().bitmapData;
      
      public static var walk_12_embed:Class = Embeds.trooper_com_walk012_png;
      
      public static var walk_12:BitmapData = new Embeds.trooper_com_walk012_png().bitmapData;
      
      public static var walk_13_embed:Class = Embeds.trooper_com_walk013_png;
      
      public static var walk_13:BitmapData = new Embeds.trooper_com_walk013_png().bitmapData;
      
      public static var walk_14_embed:Class = Embeds.trooper_com_walk014_png;
      
      public static var walk_14:BitmapData = new Embeds.trooper_com_walk014_png().bitmapData;
      
      public static var walk_15_embed:Class = Embeds.trooper_com_walk015_png;
      
      public static var walk_15:BitmapData = new Embeds.trooper_com_walk015_png().bitmapData;
      
      public static var walk_16_embed:Class = Embeds.trooper_com_walk016_png;
      
      public static var walk_16:BitmapData = new Embeds.trooper_com_walk016_png().bitmapData;
      
      public static var walk_17_embed:Class = Embeds.trooper_com_walk017_png;
      
      public static var walk_17:BitmapData = new Embeds.trooper_com_walk017_png().bitmapData;
      
      public static var walk_18_embed:Class = Embeds.trooper_com_walk018_png;
      
      public static var walk_18:BitmapData = new Embeds.trooper_com_walk018_png().bitmapData;
      
      public static var walk_19_embed:Class = Embeds.trooper_com_walk019_png;
      
      public static var walk_19:BitmapData = new Embeds.trooper_com_walk019_png().bitmapData;
      
      public static var walk_20_embed:Class = Embeds.trooper_com_walk020_png;
      
      public static var walk_20:BitmapData = new Embeds.trooper_com_walk020_png().bitmapData;
      
      public static var walk:Array = [walk_1,walk_2,walk_3,walk_4,walk_5,walk_6,walk_7,walk_8,walk_9,walk_10,walk_11,walk_12,walk_13,walk_14,walk_15,walk_16,walk_17,walk_18,walk_19,walk_20];
      
      public static var aim_1_embed:Class = Embeds.trooper_cover_commander001_png;
      
      public static var aim_1:BitmapData = new Embeds.trooper_cover_commander001_png().bitmapData;
      
      public static var aim_2_embed:Class = Embeds.trooper_cover_commander002_png;
      
      public static var aim_2:BitmapData = new Embeds.trooper_cover_commander002_png().bitmapData;
      
      public static var aim_3_embed:Class = Embeds.trooper_cover_commander003_png;
      
      public static var aim_3:BitmapData = new Embeds.trooper_cover_commander003_png().bitmapData;
      
      public static var aim_4_embed:Class = Embeds.trooper_cover_commander004_png;
      
      public static var aim_4:BitmapData = new Embeds.trooper_cover_commander004_png().bitmapData;
      
      public static var aim_5_embed:Class = Embeds.trooper_cover_commander005_png;
      
      public static var aim_5:BitmapData = new Embeds.trooper_cover_commander005_png().bitmapData;
      
      public static var aim_6_embed:Class = Embeds.trooper_cover_commander006_png;
      
      public static var aim_6:BitmapData = new Embeds.trooper_cover_commander006_png().bitmapData;
      
      public static var aim_7_embed:Class = Embeds.trooper_cover_commander007_png;
      
      public static var aim_7:BitmapData = new Embeds.trooper_cover_commander007_png().bitmapData;
      
      public static var aim_8_embed:Class = Embeds.trooper_cover_commander008_png;
      
      public static var aim_8:BitmapData = new Embeds.trooper_cover_commander008_png().bitmapData;
      
      public static var aim_9_embed:Class = Embeds.trooper_cover_commander009_png;
      
      public static var aim_9:BitmapData = new Embeds.trooper_cover_commander009_png().bitmapData;
      
      public static var aim_10_embed:Class = Embeds.trooper_cover_commander010_png;
      
      public static var aim_10:BitmapData = new Embeds.trooper_cover_commander010_png().bitmapData;
      
      public static var aim_11_embed:Class = Embeds.trooper_cover_commander011_png;
      
      public static var aim_11:BitmapData = new Embeds.trooper_cover_commander011_png().bitmapData;
      
      public static var aim_12_embed:Class = Embeds.trooper_cover_commander012_png;
      
      public static var aim_12:BitmapData = new Embeds.trooper_cover_commander012_png().bitmapData;
      
      public static var aim:Array = [aim_1,aim_2,aim_3,aim_4,aim_5,aim_6,aim_7,aim_8,aim_9,aim_10,aim_11,aim_12];
      
      public static var grenade_1_embed:Class = Embeds.trooper_grenade001_png;
      
      public static var grenade_1:BitmapData = new Embeds.trooper_grenade001_png().bitmapData;
      
      public static var grenade_2_embed:Class = Embeds.trooper_grenade002_png;
      
      public static var grenade_2:BitmapData = new Embeds.trooper_grenade002_png().bitmapData;
      
      public static var grenade_3_embed:Class = Embeds.trooper_grenade003_png;
      
      public static var grenade_3:BitmapData = new Embeds.trooper_grenade003_png().bitmapData;
      
      public static var grenade_4_embed:Class = Embeds.trooper_grenade004_png;
      
      public static var grenade_4:BitmapData = new Embeds.trooper_grenade004_png().bitmapData;
      
      public static var grenade_5_embed:Class = Embeds.trooper_grenade005_png;
      
      public static var grenade_5:BitmapData = new Embeds.trooper_grenade005_png().bitmapData;
      
      public static var grenade_6_embed:Class = Embeds.trooper_grenade006_png;
      
      public static var grenade_6:BitmapData = new Embeds.trooper_grenade006_png().bitmapData;
      
      public static var grenade_7_embed:Class = Embeds.trooper_grenade007_png;
      
      public static var grenade_7:BitmapData = new Embeds.trooper_grenade007_png().bitmapData;
      
      public static var grenade_8_embed:Class = Embeds.trooper_grenade008_png;
      
      public static var grenade_8:BitmapData = new Embeds.trooper_grenade008_png().bitmapData;
      
      public static var grenade_9_embed:Class = Embeds.trooper_grenade009_png;
      
      public static var grenade_9:BitmapData = new Embeds.trooper_grenade009_png().bitmapData;
      
      public static var grenade_10_embed:Class = Embeds.trooper_grenade010_png;
      
      public static var grenade_10:BitmapData = new Embeds.trooper_grenade010_png().bitmapData;
      
      public static var grenade_11_embed:Class = Embeds.trooper_grenade011_png;
      
      public static var grenade_11:BitmapData = new Embeds.trooper_grenade011_png().bitmapData;
      
      public static var grenade_12_embed:Class = Embeds.trooper_grenade012_png;
      
      public static var grenade_12:BitmapData = new Embeds.trooper_grenade012_png().bitmapData;
      
      public static var grenade_13_embed:Class = Embeds.trooper_grenade013_png;
      
      public static var grenade_13:BitmapData = new Embeds.trooper_grenade013_png().bitmapData;
      
      public static var grenade_14_embed:Class = Embeds.trooper_grenade014_png;
      
      public static var grenade_14:BitmapData = new Embeds.trooper_grenade014_png().bitmapData;
      
      public static var grenade_15_embed:Class = Embeds.trooper_grenade015_png;
      
      public static var grenade_15:BitmapData = new Embeds.trooper_grenade015_png().bitmapData;
      
      public static var grenade_16_embed:Class = Embeds.trooper_grenade016_png;
      
      public static var grenade_16:BitmapData = new Embeds.trooper_grenade016_png().bitmapData;
      
      public static var grenade_17_embed:Class = Embeds.trooper_grenade017_png;
      
      public static var grenade_17:BitmapData = new Embeds.trooper_grenade017_png().bitmapData;
      
      public static var grenade_18_embed:Class = Embeds.trooper_grenade018_png;
      
      public static var grenade_18:BitmapData = new Embeds.trooper_grenade018_png().bitmapData;
      
      public static var grenade_19_embed:Class = Embeds.trooper_grenade019_png;
      
      public static var grenade_19:BitmapData = new Embeds.trooper_grenade019_png().bitmapData;
      
      public static var grenade_20_embed:Class = Embeds.trooper_grenade020_png;
      
      public static var grenade_20:BitmapData = new Embeds.trooper_grenade020_png().bitmapData;
      
      public static var grenade:Array = [grenade_1,grenade_2,grenade_3,grenade_4,grenade_5,grenade_6,grenade_7,grenade_8,grenade_9,grenade_10,grenade_11,grenade_12,grenade_13,grenade_14,grenade_15,grenade_16,grenade_17,grenade_18,grenade_19,grenade_20];
      
      public static var fire_1_embed:Class = Embeds.trooper_fire_com001_png;
      
      public static var fire_1:BitmapData = new Embeds.trooper_fire_com001_png().bitmapData;
      
      public static var fire_2_embed:Class = Embeds.trooper_fire_com002_png;
      
      public static var fire_2:BitmapData = new Embeds.trooper_fire_com002_png().bitmapData;
      
      public static var fire_3_embed:Class = Embeds.trooper_fire_com003_png;
      
      public static var fire_3:BitmapData = new Embeds.trooper_fire_com003_png().bitmapData;
      
      public static var fire_4_embed:Class = Embeds.trooper_fire_com004_png;
      
      public static var fire_4:BitmapData = new Embeds.trooper_fire_com004_png().bitmapData;
      
      public static var fire_5_embed:Class = Embeds.trooper_fire_com005_png;
      
      public static var fire_5:BitmapData = new Embeds.trooper_fire_com005_png().bitmapData;
      
      public static var fire_6_embed:Class = Embeds.trooper_fire_com006_png;
      
      public static var fire_6:BitmapData = new Embeds.trooper_fire_com006_png().bitmapData;
      
      public static var fire_7_embed:Class = Embeds.trooper_fire_com007_png;
      
      public static var fire_7:BitmapData = new Embeds.trooper_fire_com007_png().bitmapData;
      
      public static var fire:Array = [fire_1,fire_2,fire_3,fire_4,fire_5,fire_6,fire_7];
      
      public static var riderLegs_1_embed:Class = Embeds.trooper_rider_legs001_png;
      
      public static var riderLegs_1:BitmapData = new Embeds.trooper_rider_legs001_png().bitmapData;
      
      public static var riderLegs_2_embed:Class = Embeds.trooper_rider_legs002_png;
      
      public static var riderLegs_2:BitmapData = new Embeds.trooper_rider_legs002_png().bitmapData;
      
      public static var riderLegs_3_embed:Class = Embeds.trooper_rider_legs003_png;
      
      public static var riderLegs_3:BitmapData = new Embeds.trooper_rider_legs003_png().bitmapData;
      
      public static var riderLegs_4_embed:Class = Embeds.trooper_rider_legs004_png;
      
      public static var riderLegs_4:BitmapData = new Embeds.trooper_rider_legs004_png().bitmapData;
      
      public static var riderLegs_5_embed:Class = Embeds.trooper_rider_legs005_png;
      
      public static var riderLegs_5:BitmapData = new Embeds.trooper_rider_legs005_png().bitmapData;
      
      public static var riderLegs:Array = [riderLegs_1,riderLegs_2,riderLegs_3,riderLegs_4,riderLegs_5];
      
      public static var coverFire_1_embed:Class = Embeds.trooper_commander_cover_fire001_png;
      
      public static var coverFire_1:BitmapData = new Embeds.trooper_commander_cover_fire001_png().bitmapData;
      
      public static var coverFire_2_embed:Class = Embeds.trooper_commander_cover_fire002_png;
      
      public static var coverFire_2:BitmapData = new Embeds.trooper_commander_cover_fire002_png().bitmapData;
      
      public static var coverFire_3_embed:Class = Embeds.trooper_commander_cover_fire003_png;
      
      public static var coverFire_3:BitmapData = new Embeds.trooper_commander_cover_fire003_png().bitmapData;
      
      public static var coverFire_4_embed:Class = Embeds.trooper_commander_cover_fire004_png;
      
      public static var coverFire_4:BitmapData = new Embeds.trooper_commander_cover_fire004_png().bitmapData;
      
      public static var coverFire:Array = [coverFire_1,coverFire_2,coverFire_3,coverFire_4];
      
      public static var shadow_1_embed:Class = Embeds.trooper_shadow001_png;
      
      public static var shadow_1:BitmapData = new Embeds.trooper_shadow001_png().bitmapData;
      
      public static var shadow_2_embed:Class = Embeds.trooper_shadow002_png;
      
      public static var shadow_2:BitmapData = new Embeds.trooper_shadow002_png().bitmapData;
      
      public static var shadow_3_embed:Class = Embeds.trooper_shadow003_png;
      
      public static var shadow_3:BitmapData = new Embeds.trooper_shadow003_png().bitmapData;
      
      public static var shadow_4_embed:Class = Embeds.trooper_shadow004_png;
      
      public static var shadow_4:BitmapData = new Embeds.trooper_shadow004_png().bitmapData;
      
      public static var shadow_5_embed:Class = Embeds.trooper_shadow005_png;
      
      public static var shadow_5:BitmapData = new Embeds.trooper_shadow005_png().bitmapData;
      
      public static var shadow_6_embed:Class = Embeds.trooper_shadow006_png;
      
      public static var shadow_6:BitmapData = new Embeds.trooper_shadow006_png().bitmapData;
      
      public static var shadow_7_embed:Class = Embeds.trooper_shadow007_png;
      
      public static var shadow_7:BitmapData = new Embeds.trooper_shadow007_png().bitmapData;
      
      public static var shadow_8_embed:Class = Embeds.trooper_shadow008_png;
      
      public static var shadow_8:BitmapData = new Embeds.trooper_shadow008_png().bitmapData;
      
      public static var shadow_9_embed:Class = Embeds.trooper_shadow009_png;
      
      public static var shadow_9:BitmapData = new Embeds.trooper_shadow009_png().bitmapData;
      
      public static var shadow_10_embed:Class = Embeds.trooper_shadow010_png;
      
      public static var shadow_10:BitmapData = new Embeds.trooper_shadow010_png().bitmapData;
      
      public static var shadow_11_embed:Class = Embeds.trooper_shadow011_png;
      
      public static var shadow_11:BitmapData = new Embeds.trooper_shadow011_png().bitmapData;
      
      public static var shadow_12_embed:Class = Embeds.trooper_shadow012_png;
      
      public static var shadow_12:BitmapData = new Embeds.trooper_shadow012_png().bitmapData;
      
      public static var shadow_13_embed:Class = Embeds.trooper_shadow013_png;
      
      public static var shadow_13:BitmapData = new Embeds.trooper_shadow013_png().bitmapData;
      
      public static var shadow_14_embed:Class = Embeds.trooper_shadow014_png;
      
      public static var shadow_14:BitmapData = new Embeds.trooper_shadow014_png().bitmapData;
      
      public static var shadow_15_embed:Class = Embeds.trooper_shadow015_png;
      
      public static var shadow_15:BitmapData = new Embeds.trooper_shadow015_png().bitmapData;
      
      public static var shadow_16_embed:Class = Embeds.trooper_shadow016_png;
      
      public static var shadow_16:BitmapData = new Embeds.trooper_shadow016_png().bitmapData;
      
      public static var shadow_17_embed:Class = Embeds.trooper_shadow017_png;
      
      public static var shadow_17:BitmapData = new Embeds.trooper_shadow017_png().bitmapData;
      
      public static var shadow_18_embed:Class = Embeds.trooper_shadow018_png;
      
      public static var shadow_18:BitmapData = new Embeds.trooper_shadow018_png().bitmapData;
      
      public static var shadow_19_embed:Class = Embeds.trooper_shadow019_png;
      
      public static var shadow_19:BitmapData = new Embeds.trooper_shadow019_png().bitmapData;
      
      public static var shadow_20_embed:Class = Embeds.trooper_shadow020_png;
      
      public static var shadow_20:BitmapData = new Embeds.trooper_shadow020_png().bitmapData;
      
      public static var shadow:Array = [shadow_1,shadow_2,shadow_3,shadow_4,shadow_5,shadow_6,shadow_7,shadow_8,shadow_9,shadow_10,shadow_11,shadow_12,shadow_13,shadow_14,shadow_15,shadow_16,shadow_17,shadow_18,shadow_19,shadow_20];
      
      public function TrooperCommander_constructor()
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
         var _loc6_:GameObjectCollision = collision_42;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_42 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         TrooperCommander(param2).walk = walk;
         param2.imageSet = walk;
         TrooperCommander(param2).aim = aim;
         param2.imageSet = aim;
         TrooperCommander(param2).grenade = grenade;
         param2.imageSet = grenade;
         TrooperCommander(param2).fire = fire;
         param2.imageSet = fire;
         TrooperCommander(param2).riderLegs = riderLegs;
         param2.imageSet = riderLegs;
         TrooperCommander(param2).coverFire = coverFire;
         param2.imageSet = coverFire;
         TrooperCommander(param2).shadow = shadow;
         param2.imageSet = shadow;
      }
   }
}

