package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class LaserBullet_constructor
   {
      
      public static var collision_6:GameObjectCollision;
      
      public static var LayerName:String = "AbovePlayer";
      
      public static var baseim_embed:Class = Embeds.laser_s_png;
      
      public static var baseim:BitmapData = new Embeds.laser_s_png().bitmapData;
      
      public static var mediumSprite_embed:Class = Embeds.laser_m_png;
      
      public static var mediumSprite:BitmapData = new Embeds.laser_m_png().bitmapData;
      
      public static var heavySprite_embed:Class = Embeds.laser_h_png;
      
      public static var heavySprite:BitmapData = new Embeds.laser_h_png().bitmapData;
      
      public function LaserBullet_constructor()
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
         var _loc6_:GameObjectCollision = collision_6;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_6 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         LaserBullet(param2).mediumSprite = mediumSprite;
         LaserBullet(param2).heavySprite = heavySprite;
      }
   }
}

