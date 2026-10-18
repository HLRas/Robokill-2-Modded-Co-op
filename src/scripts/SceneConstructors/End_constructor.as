package SceneConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import flash.display.*;
   import flash.geom.*;
   
   public class End_constructor
   {
      
      public static var im1_embed:Class = Embeds.end_1_jpg;
      
      public static var im1:BitmapData = new Embeds.end_1_jpg().bitmapData;
      
      public static var im2_embed:Class = Embeds.decal_free_33_png;
      
      public static var im2:BitmapData = new Embeds.decal_free_33_png().bitmapData;
      
      public function End_constructor()
      {
         super();
      }
      
      public function register(param1:GameScene, param2:Sprite, param3:Boolean = false) : void
      {
         var _loc4_:GameObject = null;
         var _loc5_:GameObjectFilter = null;
         if(!param3)
         {
            param1.m = new MovieClip();
         }
         _loc4_ = new GameObject(param1,im1_embed,"",400,300);
         _loc4_.baseRotation = 0;
         _loc4_ = new GameObject(param1,im2_embed,"",979,328);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0;
         _loc4_.additive = true;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 0.5;
         if(!param3)
         {
            param2.addChild(param1.m);
         }
      }
   }
}

