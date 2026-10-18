package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class BomberBomb_constructor
   {
      
      public static var collision_52:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.bomber_bomb001_png;
      
      public static var baseim:BitmapData = new Embeds.bomber_bomb001_png().bitmapData;
      
      public static var flyAnim_1_embed:Class = Embeds.bomber_bomb001_png;
      
      public static var flyAnim_1:BitmapData = new Embeds.bomber_bomb001_png().bitmapData;
      
      public static var flyAnim_2_embed:Class = Embeds.bomber_bomb002_png;
      
      public static var flyAnim_2:BitmapData = new Embeds.bomber_bomb002_png().bitmapData;
      
      public static var flyAnim_3_embed:Class = Embeds.bomber_bomb003_png;
      
      public static var flyAnim_3:BitmapData = new Embeds.bomber_bomb003_png().bitmapData;
      
      public static var flyAnim_4_embed:Class = Embeds.bomber_bomb004_png;
      
      public static var flyAnim_4:BitmapData = new Embeds.bomber_bomb004_png().bitmapData;
      
      public static var flyAnim_5_embed:Class = Embeds.bomber_bomb005_png;
      
      public static var flyAnim_5:BitmapData = new Embeds.bomber_bomb005_png().bitmapData;
      
      public static var flyAnim_6_embed:Class = Embeds.bomber_bomb006_png;
      
      public static var flyAnim_6:BitmapData = new Embeds.bomber_bomb006_png().bitmapData;
      
      public static var flyAnim_7_embed:Class = Embeds.bomber_bomb007_png;
      
      public static var flyAnim_7:BitmapData = new Embeds.bomber_bomb007_png().bitmapData;
      
      public static var flyAnim_8_embed:Class = Embeds.bomber_bomb008_png;
      
      public static var flyAnim_8:BitmapData = new Embeds.bomber_bomb008_png().bitmapData;
      
      public static var flyAnim_9_embed:Class = Embeds.bomber_bomb009_png;
      
      public static var flyAnim_9:BitmapData = new Embeds.bomber_bomb009_png().bitmapData;
      
      public static var flyAnim_10_embed:Class = Embeds.bomber_bomb010_png;
      
      public static var flyAnim_10:BitmapData = new Embeds.bomber_bomb010_png().bitmapData;
      
      public static var flyAnim_11_embed:Class = Embeds.bomber_bomb011_png;
      
      public static var flyAnim_11:BitmapData = new Embeds.bomber_bomb011_png().bitmapData;
      
      public static var flyAnim_12_embed:Class = Embeds.bomber_bomb012_png;
      
      public static var flyAnim_12:BitmapData = new Embeds.bomber_bomb012_png().bitmapData;
      
      public static var flyAnim_13_embed:Class = Embeds.bomber_bomb013_png;
      
      public static var flyAnim_13:BitmapData = new Embeds.bomber_bomb013_png().bitmapData;
      
      public static var flyAnim_14_embed:Class = Embeds.bomber_bomb014_png;
      
      public static var flyAnim_14:BitmapData = new Embeds.bomber_bomb014_png().bitmapData;
      
      public static var flyAnim_15_embed:Class = Embeds.bomber_bomb015_png;
      
      public static var flyAnim_15:BitmapData = new Embeds.bomber_bomb015_png().bitmapData;
      
      public static var flyAnim_16_embed:Class = Embeds.bomber_bomb016_png;
      
      public static var flyAnim_16:BitmapData = new Embeds.bomber_bomb016_png().bitmapData;
      
      public static var flyAnim:Array = [flyAnim_1,flyAnim_2,flyAnim_3,flyAnim_4,flyAnim_5,flyAnim_6,flyAnim_7,flyAnim_8,flyAnim_9,flyAnim_10,flyAnim_11,flyAnim_12,flyAnim_13,flyAnim_14,flyAnim_15,flyAnim_16];
      
      public static var shadow_embed:Class = Embeds.bomber_bomb_shadow_png;
      
      public static var shadow:BitmapData = new Embeds.bomber_bomb_shadow_png().bitmapData;
      
      public function BomberBomb_constructor()
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
         var _loc6_:GameObjectCollision = collision_52;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_52 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         BomberBomb(param2).flyAnim = flyAnim;
         param2.imageSet = flyAnim;
         BomberBomb(param2).shadow = shadow;
      }
   }
}

