package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class HoverTrooper_constructor
   {
      
      public static var collision_102:GameObjectCollision;
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.hover_troop001_png;
      
      public static var baseim:BitmapData = new Embeds.hover_troop001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.hover_troop001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.hover_troop001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.hover_troop002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.hover_troop002_png().bitmapData;
      
      public static var imageSet_3_embed:Class = Embeds.hover_troop003_png;
      
      public static var imageSet_3:BitmapData = new Embeds.hover_troop003_png().bitmapData;
      
      public static var imageSet_4_embed:Class = Embeds.hover_troop004_png;
      
      public static var imageSet_4:BitmapData = new Embeds.hover_troop004_png().bitmapData;
      
      public static var imageSet_5_embed:Class = Embeds.hover_troop005_png;
      
      public static var imageSet_5:BitmapData = new Embeds.hover_troop005_png().bitmapData;
      
      public static var imageSet_6_embed:Class = Embeds.hover_troop006_png;
      
      public static var imageSet_6:BitmapData = new Embeds.hover_troop006_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2,imageSet_3,imageSet_4,imageSet_5,imageSet_6];
      
      public function HoverTrooper_constructor()
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
         var _loc6_:GameObjectCollision = collision_102;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_102 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         HoverTrooper(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

