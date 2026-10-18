package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class Hulk_constructor
   {
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.hulk_head001_png;
      
      public static var baseim:BitmapData = new Embeds.hulk_head001_png().bitmapData;
      
      public static var guns_1_embed:Class = Embeds.hulk_head001_png;
      
      public static var guns_1:BitmapData = new Embeds.hulk_head001_png().bitmapData;
      
      public static var guns_2_embed:Class = Embeds.hulk_head002_png;
      
      public static var guns_2:BitmapData = new Embeds.hulk_head002_png().bitmapData;
      
      public static var guns_3_embed:Class = Embeds.hulk_head003_png;
      
      public static var guns_3:BitmapData = new Embeds.hulk_head003_png().bitmapData;
      
      public static var guns_4_embed:Class = Embeds.hulk_head004_png;
      
      public static var guns_4:BitmapData = new Embeds.hulk_head004_png().bitmapData;
      
      public static var guns:Array = [guns_1,guns_2,guns_3,guns_4];
      
      public function Hulk_constructor()
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
         param2.animSpeed = 4;
         Hulk(param2).guns = guns;
         param2.imageSet = guns;
      }
   }
}

