package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class ClusterBomb_constructor
   {
      
      public static var collision_101:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.cluster_bomb001_png;
      
      public static var baseim:BitmapData = new Embeds.cluster_bomb001_png().bitmapData;
      
      public static var flyAnim_1_embed:Class = Embeds.cluster_bomb001_png;
      
      public static var flyAnim_1:BitmapData = new Embeds.cluster_bomb001_png().bitmapData;
      
      public static var flyAnim:Array = [flyAnim_1];
      
      public static var shadow_embed:Class = Embeds.bomber_bomb_shadow_png;
      
      public static var shadow:BitmapData = new Embeds.bomber_bomb_shadow_png().bitmapData;
      
      public function ClusterBomb_constructor()
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
         var _loc6_:GameObjectCollision = collision_101;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_101 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         ClusterBomb(param2).flyAnim = flyAnim;
         param2.imageSet = flyAnim;
         ClusterBomb(param2).shadow = shadow;
      }
   }
}

