package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class FastLaserBullet_constructor
   {
      
      public static var collision_14:GameObjectCollision;
      
      public static var LayerName:String = "";
      
      public static var baseim_embed:Class = Embeds.rapidlazer_bullet_S_png;
      
      public static var baseim:BitmapData = new Embeds.rapidlazer_bullet_S_png().bitmapData;
      
      public static var mediumSprite_embed:Class = Embeds.rapidlazer_bullet_M_png;
      
      public static var mediumSprite:BitmapData = new Embeds.rapidlazer_bullet_M_png().bitmapData;
      
      public static var heavySprite_embed:Class = Embeds.rapidlazer_bullet_H_png;
      
      public static var heavySprite:BitmapData = new Embeds.rapidlazer_bullet_H_png().bitmapData;
      
      public function FastLaserBullet_constructor()
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
         var _loc6_:GameObjectCollision = collision_14;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_14 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         FastLaserBullet(param2).mediumSprite = mediumSprite;
         FastLaserBullet(param2).heavySprite = heavySprite;
      }
   }
}

