package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class ProximityMine_constructor
   {
      
      public static var collision_60:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.proximity_mine001_png;
      
      public static var baseim:BitmapData = new Embeds.proximity_mine001_png().bitmapData;
      
      public static var imageSet_1_embed:Class = Embeds.proximity_mine001_png;
      
      public static var imageSet_1:BitmapData = new Embeds.proximity_mine001_png().bitmapData;
      
      public static var imageSet_2_embed:Class = Embeds.proximity_mine002_png;
      
      public static var imageSet_2:BitmapData = new Embeds.proximity_mine002_png().bitmapData;
      
      public static var imageSet:Array = [imageSet_1,imageSet_2];
      
      public function ProximityMine_constructor()
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
         param2.animSpeed = 60.5999985;
         var _loc6_:GameObjectCollision = collision_60;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_60 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         ProximityMine(param2).imageSet = imageSet;
         param2.imageSet = imageSet;
      }
   }
}

