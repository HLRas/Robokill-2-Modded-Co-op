package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class PulseBullet_constructor
   {
      
      public static var LayerName:String = "";
      
      public static var baseim_embed:Class = Embeds.pulsebullet_S_png;
      
      public static var baseim:BitmapData = new Embeds.pulsebullet_S_png().bitmapData;
      
      public static var mediumSprite_embed:Class = Embeds.pulsebullet_M_png;
      
      public static var mediumSprite:BitmapData = new Embeds.pulsebullet_M_png().bitmapData;
      
      public static var heavySprite_embed:Class = Embeds.pulsebullet_H_png;
      
      public static var heavySprite:BitmapData = new Embeds.pulsebullet_H_png().bitmapData;
      
      public function PulseBullet_constructor()
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
         PulseBullet(param2).mediumSprite = mediumSprite;
         PulseBullet(param2).heavySprite = heavySprite;
      }
   }
}

