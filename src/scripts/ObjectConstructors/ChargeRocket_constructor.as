package ObjectConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Objects.*;
   import Particles.*;
   import flash.display.*;
   
   public class ChargeRocket_constructor
   {
      
      public static var collision_98:GameObjectCollision;
      
      public static var LayerName:String = "AbovePlayer";
      
      public static var baseim_embed:Class = Embeds.s_chargerocket_001_png;
      
      public static var baseim:BitmapData = new Embeds.s_chargerocket_001_png().bitmapData;
      
      public static var light_1_embed:Class = Embeds.s_chargerocket_001_png;
      
      public static var light_1:BitmapData = new Embeds.s_chargerocket_001_png().bitmapData;
      
      public static var light_2_embed:Class = Embeds.s_chargerocket_002_png;
      
      public static var light_2:BitmapData = new Embeds.s_chargerocket_002_png().bitmapData;
      
      public static var light_3_embed:Class = Embeds.s_chargerocket_003_png;
      
      public static var light_3:BitmapData = new Embeds.s_chargerocket_003_png().bitmapData;
      
      public static var light_4_embed:Class = Embeds.s_chargerocket_004_png;
      
      public static var light_4:BitmapData = new Embeds.s_chargerocket_004_png().bitmapData;
      
      public static var light:Array = [light_1,light_2,light_3,light_4];
      
      public static var medium_1_embed:Class = Embeds.m_chargerocket_001_png;
      
      public static var medium_1:BitmapData = new Embeds.m_chargerocket_001_png().bitmapData;
      
      public static var medium_2_embed:Class = Embeds.m_chargerocket_002_png;
      
      public static var medium_2:BitmapData = new Embeds.m_chargerocket_002_png().bitmapData;
      
      public static var medium_3_embed:Class = Embeds.m_chargerocket_003_png;
      
      public static var medium_3:BitmapData = new Embeds.m_chargerocket_003_png().bitmapData;
      
      public static var medium_4_embed:Class = Embeds.m_chargerocket_004_png;
      
      public static var medium_4:BitmapData = new Embeds.m_chargerocket_004_png().bitmapData;
      
      public static var medium:Array = [medium_1,medium_2,medium_3,medium_4];
      
      public static var heavy_1_embed:Class = Embeds.h_chargerocket_001_png;
      
      public static var heavy_1:BitmapData = new Embeds.h_chargerocket_001_png().bitmapData;
      
      public static var heavy_2_embed:Class = Embeds.h_chargerocket_002_png;
      
      public static var heavy_2:BitmapData = new Embeds.h_chargerocket_002_png().bitmapData;
      
      public static var heavy_3_embed:Class = Embeds.h_chargerocket_003_png;
      
      public static var heavy_3:BitmapData = new Embeds.h_chargerocket_003_png().bitmapData;
      
      public static var heavy_4_embed:Class = Embeds.h_chargerocket_004_png;
      
      public static var heavy_4:BitmapData = new Embeds.h_chargerocket_004_png().bitmapData;
      
      public static var heavy:Array = [heavy_1,heavy_2,heavy_3,heavy_4];
      
      public function ChargeRocket_constructor()
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
         var _loc6_:GameObjectCollision = collision_98;
         if(!_loc6_)
         {
            _loc6_ = new GameObjectCollision();
            collision_98 = _loc6_;
         }
         param2.collision = _loc6_;
         param2.collisions[0] = _loc6_;
         ChargeRocket(param2).light = light;
         param2.imageSet = light;
         ChargeRocket(param2).medium = medium;
         param2.imageSet = medium;
         ChargeRocket(param2).heavy = heavy;
         param2.imageSet = heavy;
      }
   }
}

