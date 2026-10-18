package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Vent_constructor
   {
      
      public static var collision_103:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.vent_1_png;
      
      public static var baseim:BitmapData = new Embeds.vent_1_png().bitmapData;
      
      public static var masks_1_embed:Class = Embeds.vent_1_mask_png;
      
      public static var masks_1:BitmapData = new Embeds.vent_1_mask_png().bitmapData;
      
      public static var masks_2_embed:Class = Embeds.vent_2_mask_png;
      
      public static var masks_2:BitmapData = new Embeds.vent_2_mask_png().bitmapData;
      
      public static var masks_3_embed:Class = Embeds.vent_3_mask_png;
      
      public static var masks_3:BitmapData = new Embeds.vent_3_mask_png().bitmapData;
      
      public static var masks_4_embed:Class = Embeds.vent_4_mask_png;
      
      public static var masks_4:BitmapData = new Embeds.vent_4_mask_png().bitmapData;
      
      public static var masks:Array = [masks_1,masks_2,masks_3,masks_4];
      
      public static var images_1_embed:Class = Embeds.vent_1_png;
      
      public static var images_1:BitmapData = new Embeds.vent_1_png().bitmapData;
      
      public static var images_2_embed:Class = Embeds.vent_2_png;
      
      public static var images_2:BitmapData = new Embeds.vent_2_png().bitmapData;
      
      public static var images_3_embed:Class = Embeds.vent_3_png;
      
      public static var images_3:BitmapData = new Embeds.vent_3_png().bitmapData;
      
      public static var images_4_embed:Class = Embeds.vent_4_png;
      
      public static var images_4:BitmapData = new Embeds.vent_4_png().bitmapData;
      
      public static var images:Array = [images_1,images_2,images_3,images_4];
      
      public function Vent_constructor()
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
         var _loc6_:GameObjectCollision = collision_103;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_103 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         Vent(param2).masks = masks;
         param2.imageSet = masks;
         Vent(param2).images = images;
         param2.imageSet = images;
      }
   }
}

