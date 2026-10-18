package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Egg_constructor
   {
      
      public static var collision_56:GameObjectCollision;
      
      public static var LayerName:String = "BelowPlayer";
      
      public static var baseim_embed:Class = Embeds.egg_1_png;
      
      public static var baseim:BitmapData = new Embeds.egg_1_png().bitmapData;
      
      public static var images_1_embed:Class = Embeds.egg_1_png;
      
      public static var images_1:BitmapData = new Embeds.egg_1_png().bitmapData;
      
      public static var images_2_embed:Class = Embeds.egg_2_png;
      
      public static var images_2:BitmapData = new Embeds.egg_2_png().bitmapData;
      
      public static var images_3_embed:Class = Embeds.egg_3_png;
      
      public static var images_3:BitmapData = new Embeds.egg_3_png().bitmapData;
      
      public static var images:Array = [images_1,images_2,images_3];
      
      public function Egg_constructor()
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
         var _loc6_:GameObjectCollision = collision_56;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_56 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Egg(param2).images = images;
         param2.imageSet = images;
      }
   }
}

