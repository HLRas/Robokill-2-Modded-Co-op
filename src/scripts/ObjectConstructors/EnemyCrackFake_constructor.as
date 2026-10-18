package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class EnemyCrackFake_constructor
   {
      
      public static var collision_59:GameObjectCollision;
      
      public static var LayerName:String = "BelowFloor";
      
      public static var baseim_embed:Class = Embeds.fake_trap_editor_png;
      
      public static var baseim:BitmapData = new Embeds.fake_trap_editor_png().bitmapData;
      
      public function EnemyCrackFake_constructor()
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
         var _loc6_:GameObjectCollision = collision_59;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_59 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
      }
   }
}

