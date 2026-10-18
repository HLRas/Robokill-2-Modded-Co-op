package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Door_constructor
   {
      
      public static var collision_19:GameObjectCollision;
      
      public static var LayerName:String = "Background";
      
      public static var baseim_embed:Class = Embeds.door001_png;
      
      public static var baseim:BitmapData = new Embeds.door001_png().bitmapData;
      
      public static var openAnim_1_embed:Class = Embeds.door001_png;
      
      public static var openAnim_1:BitmapData = new Embeds.door001_png().bitmapData;
      
      public static var openAnim_2_embed:Class = Embeds.door002_png;
      
      public static var openAnim_2:BitmapData = new Embeds.door002_png().bitmapData;
      
      public static var openAnim_3_embed:Class = Embeds.door003_png;
      
      public static var openAnim_3:BitmapData = new Embeds.door003_png().bitmapData;
      
      public static var openAnim_4_embed:Class = Embeds.door004_png;
      
      public static var openAnim_4:BitmapData = new Embeds.door004_png().bitmapData;
      
      public static var openAnim_5_embed:Class = Embeds.door005_png;
      
      public static var openAnim_5:BitmapData = new Embeds.door005_png().bitmapData;
      
      public static var openAnim_6_embed:Class = Embeds.door006_png;
      
      public static var openAnim_6:BitmapData = new Embeds.door006_png().bitmapData;
      
      public static var openAnim_7_embed:Class = Embeds.door007_png;
      
      public static var openAnim_7:BitmapData = new Embeds.door007_png().bitmapData;
      
      public static var openAnim_8_embed:Class = Embeds.door008_png;
      
      public static var openAnim_8:BitmapData = new Embeds.door008_png().bitmapData;
      
      public static var openAnim_9_embed:Class = Embeds.door009_png;
      
      public static var openAnim_9:BitmapData = new Embeds.door009_png().bitmapData;
      
      public static var openAnim_10_embed:Class = Embeds.door010_png;
      
      public static var openAnim_10:BitmapData = new Embeds.door010_png().bitmapData;
      
      public static var openAnim:Array = [openAnim_1,openAnim_2,openAnim_3,openAnim_4,openAnim_5,openAnim_6,openAnim_7,openAnim_8,openAnim_9,openAnim_10];
      
      public static var openAnim2_1_embed:Class = Embeds.door_b001_png;
      
      public static var openAnim2_1:BitmapData = new Embeds.door_b001_png().bitmapData;
      
      public static var openAnim2_2_embed:Class = Embeds.door_b002_png;
      
      public static var openAnim2_2:BitmapData = new Embeds.door_b002_png().bitmapData;
      
      public static var openAnim2_3_embed:Class = Embeds.door_b003_png;
      
      public static var openAnim2_3:BitmapData = new Embeds.door_b003_png().bitmapData;
      
      public static var openAnim2_4_embed:Class = Embeds.door_b004_png;
      
      public static var openAnim2_4:BitmapData = new Embeds.door_b004_png().bitmapData;
      
      public static var openAnim2_5_embed:Class = Embeds.door_b005_png;
      
      public static var openAnim2_5:BitmapData = new Embeds.door_b005_png().bitmapData;
      
      public static var openAnim2_6_embed:Class = Embeds.door_b006_png;
      
      public static var openAnim2_6:BitmapData = new Embeds.door_b006_png().bitmapData;
      
      public static var openAnim2_7_embed:Class = Embeds.door_b007_png;
      
      public static var openAnim2_7:BitmapData = new Embeds.door_b007_png().bitmapData;
      
      public static var openAnim2_8_embed:Class = Embeds.door_b008_png;
      
      public static var openAnim2_8:BitmapData = new Embeds.door_b008_png().bitmapData;
      
      public static var openAnim2_9_embed:Class = Embeds.door_b009_png;
      
      public static var openAnim2_9:BitmapData = new Embeds.door_b009_png().bitmapData;
      
      public static var openAnim2_10_embed:Class = Embeds.door_b010_png;
      
      public static var openAnim2_10:BitmapData = new Embeds.door_b010_png().bitmapData;
      
      public static var openAnim2:Array = [openAnim2_1,openAnim2_2,openAnim2_3,openAnim2_4,openAnim2_5,openAnim2_6,openAnim2_7,openAnim2_8,openAnim2_9,openAnim2_10];
      
      public static var openAnim3_1_embed:Class = Embeds.door_b001_png;
      
      public static var openAnim3_1:BitmapData = new Embeds.door_b001_png().bitmapData;
      
      public static var openAnim3_2_embed:Class = Embeds.door_b002_png;
      
      public static var openAnim3_2:BitmapData = new Embeds.door_b002_png().bitmapData;
      
      public static var openAnim3_3_embed:Class = Embeds.door_b003_png;
      
      public static var openAnim3_3:BitmapData = new Embeds.door_b003_png().bitmapData;
      
      public static var openAnim3_4_embed:Class = Embeds.door_b004_png;
      
      public static var openAnim3_4:BitmapData = new Embeds.door_b004_png().bitmapData;
      
      public static var openAnim3_5_embed:Class = Embeds.door_b005_png;
      
      public static var openAnim3_5:BitmapData = new Embeds.door_b005_png().bitmapData;
      
      public static var openAnim3_6_embed:Class = Embeds.door_b006_png;
      
      public static var openAnim3_6:BitmapData = new Embeds.door_b006_png().bitmapData;
      
      public static var openAnim3_7_embed:Class = Embeds.door_b007_png;
      
      public static var openAnim3_7:BitmapData = new Embeds.door_b007_png().bitmapData;
      
      public static var openAnim3_8_embed:Class = Embeds.door_b008_png;
      
      public static var openAnim3_8:BitmapData = new Embeds.door_b008_png().bitmapData;
      
      public static var openAnim3_9_embed:Class = Embeds.door_b009_png;
      
      public static var openAnim3_9:BitmapData = new Embeds.door_b009_png().bitmapData;
      
      public static var openAnim3_10_embed:Class = Embeds.door_b010_png;
      
      public static var openAnim3_10:BitmapData = new Embeds.door_b010_png().bitmapData;
      
      public static var openAnim3:Array = [openAnim3_1,openAnim3_2,openAnim3_3,openAnim3_4,openAnim3_5,openAnim3_6,openAnim3_7,openAnim3_8,openAnim3_9,openAnim3_10];
      
      public function Door_constructor()
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
         var _loc6_:GameObjectCollision = collision_19;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_19 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Door(param2).openAnim = openAnim;
         param2.imageSet = openAnim;
         Door(param2).openAnim2 = openAnim2;
         param2.imageSet = openAnim2;
         Door(param2).openAnim3 = openAnim3;
         param2.imageSet = openAnim3;
      }
   }
}

