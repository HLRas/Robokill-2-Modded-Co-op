package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class SpiderShot_constructor
   {
      
      public static var LayerName:String = "Player";
      
      public static var baseim_embed:Class = Embeds.spider_shot_png;
      
      public static var baseim:BitmapData = new Embeds.spider_shot_png().bitmapData;
      
      public static var shotTail_1_embed:Class = Embeds.spider_shot001_png;
      
      public static var shotTail_1:BitmapData = new Embeds.spider_shot001_png().bitmapData;
      
      public static var shotTail_2_embed:Class = Embeds.spider_shot002_png;
      
      public static var shotTail_2:BitmapData = new Embeds.spider_shot002_png().bitmapData;
      
      public static var shotTail_3_embed:Class = Embeds.spider_shot003_png;
      
      public static var shotTail_3:BitmapData = new Embeds.spider_shot003_png().bitmapData;
      
      public static var shotTail_4_embed:Class = Embeds.spider_shot004_png;
      
      public static var shotTail_4:BitmapData = new Embeds.spider_shot004_png().bitmapData;
      
      public static var shotTail:Array = [shotTail_1,shotTail_2,shotTail_3,shotTail_4];
      
      public function SpiderShot_constructor()
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
         SpiderShot(param2).shotTail = shotTail;
         param2.imageSet = shotTail;
      }
   }
}

