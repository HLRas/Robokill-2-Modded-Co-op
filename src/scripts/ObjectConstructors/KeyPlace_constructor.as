package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class KeyPlace_constructor
   {
      
      public static var collision_21:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.key1_png;
      
      public static var baseim:BitmapData = new Embeds.key1_png().bitmapData;
      
      public static var child1_embed:Class = Embeds.decal_free_33_png;
      
      public static var child1:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public static var images_1_embed:Class = Embeds.key1_png;
      
      public static var images_1:BitmapData = new Embeds.key1_png().bitmapData;
      
      public static var images_2_embed:Class = Embeds.key2_png;
      
      public static var images_2:BitmapData = new Embeds.key2_png().bitmapData;
      
      public static var images_3_embed:Class = Embeds.key3_png;
      
      public static var images_3:BitmapData = new Embeds.key3_png().bitmapData;
      
      public static var images:Array = [images_1,images_2,images_3];
      
      public function KeyPlace_constructor()
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
         var _loc6_:GameObjectCollision = collision_21;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_21 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         _loc7_ = new GameObject(param1,child1_embed,"Floor",2,-2);
         _loc7_.name = "";
         _loc7_.baseHandleX = 0.5;
         _loc7_.baseHandleY = 0.5;
         _loc7_.basex = 2;
         _loc7_.basey = -2;
         _loc7_.baseScaleX = 1.16999984;
         _loc7_.baseScaleY = 1.16999984;
         _loc7_.additive = true;
         _loc7_.animSpeed = 0;
         _loc8_ = new GameObjectFilterPulse();
         _loc7_.addFilter(_loc8_);
         GameObjectFilterPulse(_loc8_).Speed = 1;
         param2.addChild(_loc7_);
         KeyPlace(param2).images = images;
         param2.imageSet = images;
      }
   }
}

