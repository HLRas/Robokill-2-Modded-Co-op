package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class WalkerTurret_constructor
   {
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.walkerturretfront_png;
      
      public static var baseim:BitmapData = new Embeds.walkerturretfront_png().bitmapData;
      
      public static var medium_embed:Class = Embeds.turretmedium_png;
      
      public static var medium:BitmapData = new Embeds.turretmedium_png().bitmapData;
      
      public function WalkerTurret_constructor()
      {
         super();
      }
      
      public static function setup(param1:GameScene, param2:GameObject) : void
      {
         var _loc3_:GameObjectFilter = null;
         var _loc4_:ParticleEmitter = null;
         var _loc5_:ParticleFilter = null;
         var _loc6_:GameObject = null;
         var _loc7_:GameObjectFilter = null;
         param2.baseHandleX = 0.5;
         param2.baseHandleY = 0.5;
         param2.addConditionalParticleArray(globalParticles.getParticles());
         param2.animSpeed = 0;
         WalkerTurret(param2).medium = medium;
      }
   }
}

