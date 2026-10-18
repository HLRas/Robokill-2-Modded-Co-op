package SceneConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import flash.display.*;
   import flash.geom.*;
   
   public class Story_constructor
   {
      
      public static var im1_embed:Class = Embeds.intro_background_1_jpg;
      
      public static var im1:BitmapData = new Embeds.intro_background_1_jpg().bitmapData;
      
      public function Story_constructor()
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
         if(!param3)
         {
            param2.addChild(param1.m);
         }
      }
   }
}

