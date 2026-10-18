package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class ShieldLargePickup_constructor
   {
      
      public static var collision_70:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.shield_large_pickup_01_png;
      
      public static var baseim:BitmapData = new Embeds.shield_large_pickup_01_png().bitmapData;
      
      public static var child1_embed:Class = Embeds.minelayerglow_png;
      
      public static var child1:BitmapData = new Embeds.minelayerglow_png().bitmapData;
      
      public static var randomSet_1_embed:Class = Embeds.shield_large_pickup_01_png;
      
      public static var randomSet_1:BitmapData = new Embeds.shield_large_pickup_01_png().bitmapData;
      
      public static var randomSet:Array = [randomSet_1];
      
      public function ShieldLargePickup_constructor()
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
         var _loc6_:GameObjectCollision = collision_70;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_70 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         _loc7_ = new GameObject(param1,child1_embed,"Floor",0,2);
         _loc7_.name = "";
         _loc7_.baseHandleX = 0.5;
         _loc7_.baseHandleY = 0.5;
         _loc7_.basex = 0;
         _loc7_.basey = 2;
         _loc7_.baseScaleX = 1.21999979;
         _loc7_.baseScaleY = 1.21999979;
         _loc7_.additive = true;
         _loc7_.animSpeed = 0;
         _loc8_ = new GameObjectFilterPulse();
         _loc7_.addFilter(_loc8_);
         GameObjectFilterPulse(_loc8_).Speed = 4;
         param2.addChild(_loc7_);
         ShieldLargePickup(param2).randomSet = randomSet;
         param2.imageSet = randomSet;
      }
   }
}

