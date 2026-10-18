package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class ReboundBot_constructor
   {
      
      public static var collision_62:GameObjectCollision;
      
      public static var LayerName:String = "AbovePlayer";
      
      public static var baseim_embed:Class = Embeds.bot_rebound_png;
      
      public static var baseim:BitmapData = new Embeds.bot_rebound_png().bitmapData;
      
      public function ReboundBot_constructor()
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
         var _loc6_:GameObjectCollision = collision_62;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_62 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
      }
   }
}

