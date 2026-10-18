package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class GrenadeBullet_constructor
   {
      
      public static var collision_7:GameObjectCollision;
      
      public static var LayerName:String = "";
      
      public static var baseim_embed:Class = Embeds.sgrenadeshot001_png;
      
      public static var baseim:BitmapData = new Embeds.sgrenadeshot001_png().bitmapData;
      
      public static var bounceSet_1_embed:Class = Embeds.sgrenadeshot001_png;
      
      public static var bounceSet_1:BitmapData = new Embeds.sgrenadeshot001_png().bitmapData;
      
      public static var bounceSet_2_embed:Class = Embeds.sgrenadeshot002_png;
      
      public static var bounceSet_2:BitmapData = new Embeds.sgrenadeshot002_png().bitmapData;
      
      public static var bounceSet_3_embed:Class = Embeds.sgrenadeshot003_png;
      
      public static var bounceSet_3:BitmapData = new Embeds.sgrenadeshot003_png().bitmapData;
      
      public static var bounceSet_4_embed:Class = Embeds.sgrenadeshot004_png;
      
      public static var bounceSet_4:BitmapData = new Embeds.sgrenadeshot004_png().bitmapData;
      
      public static var bounceSet:Array = [bounceSet_1,bounceSet_2,bounceSet_3,bounceSet_4];
      
      public function GrenadeBullet_constructor()
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
         param2.baseHandleY = 0;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 4;
         var _loc6_:GameObjectCollision = collision_7;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_7 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         GrenadeBullet(param2).bounceSet = bounceSet;
         param2.imageSet = bounceSet;
      }
   }
}

