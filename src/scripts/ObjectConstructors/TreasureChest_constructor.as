package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class TreasureChest_constructor
   {
      
      public static var collision_9:GameObjectCollision;
      
      public static var LayerName:String = "Floor";
      
      public static var baseim_embed:Class = Embeds.treasure_png;
      
      public static var baseim:BitmapData = new Embeds.treasure_png().bitmapData;
      
      public static var child1_embed:Class = Embeds.red_glow_png;
      
      public static var child1:BitmapData = new Embeds.red_glow_png().bitmapData;
      
      public static var child2_embed:Class = Embeds.flare_2_png;
      
      public static var child2:BitmapData = new Embeds.flare_2_png().bitmapData;
      
      public static var open_embed:Class = Embeds.treasure_open_png;
      
      public static var open:BitmapData = new Embeds.treasure_open_png().bitmapData;
      
      public function TreasureChest_constructor()
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
         var _loc6_:GameObjectCollision = collision_9;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_9 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         _loc7_ = new GameObject(param1,child1_embed,"AbovePlayer",1,12);
         _loc7_.name = "";
         _loc7_.baseHandleX = 0.5;
         _loc7_.baseHandleY = 0.5;
         _loc7_.basex = 1;
         _loc7_.basey = 12;
         _loc7_.baseScaleX = 1.63999939;
         _loc7_.baseScaleY = 1.63999939;
         _loc7_.additive = true;
         _loc7_.animSpeed = 0;
         _loc8_ = new GameObjectFilterPulse();
         _loc7_.addFilter(_loc8_);
         GameObjectFilterPulse(_loc8_).Speed = 1;
         param2.addChild(_loc7_);
         _loc7_ = new GameObject(param1,child2_embed,"AbovePlayer",1,18);
         _loc7_.name = "";
         _loc7_.baseHandleX = 0.5;
         _loc7_.baseHandleY = 0.5;
         _loc7_.basex = 1;
         _loc7_.basey = 18;
         _loc7_.additive = true;
         _loc7_.animSpeed = 0;
         _loc8_ = new GameObjectFilterPulse();
         _loc7_.addFilter(_loc8_);
         GameObjectFilterPulse(_loc8_).Speed = 1;
         _loc8_ = new GameObjectFilterRotate();
         _loc7_.addFilter(_loc8_);
         GameObjectFilterRotate(_loc8_).Speed = 0.5;
         param2.addChild(_loc7_);
         TreasureChest(param2).open = open;
      }
   }
}

