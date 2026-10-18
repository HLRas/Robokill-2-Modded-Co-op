package SceneConstructors
{
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import flash.display.*;
   import flash.geom.*;
   
   public class MainMenu_constructor
   {
      
      public static var im1_embed:Class = Embeds.menu_jpg;
      
      public static var im1:BitmapData = new Embeds.menu_jpg().bitmapData;
      
      public static var im2_embed:Class = Embeds.menu_sprite_2_png;
      
      public static var im2:BitmapData = new Embeds.menu_sprite_2_png().bitmapData;
      
      public static var im3_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im3:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im4_embed:Class = Embeds.menu_sprite_2_png;
      
      public static var im4:BitmapData = new Embeds.menu_sprite_2_png().bitmapData;
      
      public static var im5_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im5:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im6_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im6:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im7_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im7:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im8_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im8:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im9_embed:Class = Embeds.menu_sprite_2_png;
      
      public static var im9:BitmapData = new Embeds.menu_sprite_2_png().bitmapData;
      
      public static var im10_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im10:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im11_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im11:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im12_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im12:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im13_embed:Class = Embeds.menu_sprite_2_png;
      
      public static var im13:BitmapData = new Embeds.menu_sprite_2_png().bitmapData;
      
      public static var im14_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im14:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im15_embed:Class = Embeds.menu_sprite_2_png;
      
      public static var im15:BitmapData = new Embeds.menu_sprite_2_png().bitmapData;
      
      public static var im16_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im16:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im17_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im17:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im18_embed:Class = Embeds.menu_sprite_3_png;
      
      public static var im18:BitmapData = new Embeds.menu_sprite_3_png().bitmapData;
      
      public static var im19_embed:Class = Embeds.menu_sprite_3_png;
      
      public static var im19:BitmapData = new Embeds.menu_sprite_3_png().bitmapData;
      
      public static var im20_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im20:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im21_embed:Class = Embeds.menu_sprite_3_png;
      
      public static var im21:BitmapData = new Embeds.menu_sprite_3_png().bitmapData;
      
      public static var im22_embed:Class = Embeds.menu_sprite_3_png;
      
      public static var im22:BitmapData = new Embeds.menu_sprite_3_png().bitmapData;
      
      public static var im23_embed:Class = Embeds.red_glow_png;
      
      public static var im23:BitmapData = new Embeds.red_glow_png().bitmapData;
      
      public static var im24_embed:Class = Embeds.menu_sprite_3_png;
      
      public static var im24:BitmapData = new Embeds.menu_sprite_3_png().bitmapData;
      
      public static var im25_embed:Class = Embeds.menu_sprite_1_png;
      
      public static var im25:BitmapData = new Embeds.menu_sprite_1_png().bitmapData;
      
      public static var im26_embed:Class = Embeds.menu_sprite_3_png;
      
      public static var im26:BitmapData = new Embeds.menu_sprite_3_png().bitmapData;
      
      public static var im27_embed:Class = Embeds.logo_glow_png;
      
      public static var im27:BitmapData = new Embeds.logo_glow_png().bitmapData;
      
      public function MainMenu_constructor()
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
         _loc4_ = new GameObject(param1,im2_embed,"",415,40);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.270000696;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 1.05999994;
         _loc4_.baseScaleY = 1.05999994;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.699999988;
         _loc4_ = new GameObject(param1,im3_embed,"",385,42);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.420000553;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.910000086;
         _loc4_.baseScaleY = 0.910000086;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = -0.699999988;
         _loc4_ = new GameObject(param1,im4_embed,"",234,40);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.440000534;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.850000143;
         _loc4_.baseScaleY = 0.850000143;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.850000024;
         _loc4_ = new GameObject(param1,im5_embed,"",484,49);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.310000658;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.840000153;
         _loc4_.baseScaleY = 0.840000153;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = -0.400000006;
         _loc4_ = new GameObject(param1,im6_embed,"",384,40);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.450000525;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 1.07999992;
         _loc4_.baseScaleY = 1.07999992;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = -0.400000006;
         _loc4_ = new GameObject(param1,im7_embed,"",436,46);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.410000563;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.760000229;
         _loc4_.baseScaleY = 0.760000229;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.400000006;
         _loc4_ = new GameObject(param1,im8_embed,"",171,42);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0;
         _loc4_.additive = true;
         _loc4_.tint(0.610000372,0,0);
         _loc4_.baseScaleX = 1.04999995;
         _loc4_.baseScaleY = 1.04999995;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 1;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.5;
         _loc4_ = new GameObject(param1,im9_embed,"",363,43);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.410000563;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.880000114;
         _loc4_.baseScaleY = 0.880000114;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = -0.400000006;
         _loc4_ = new GameObject(param1,im10_embed,"",295,39);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.57000041;
         _loc4_.additive = true;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.699999988;
         _loc4_ = new GameObject(param1,im11_embed,"",264,43);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.610000372;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.680000305;
         _loc4_.baseScaleY = 0.680000305;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = -1;
         _loc4_ = new GameObject(param1,im12_embed,"",575,39);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.429999858;
         _loc4_.additive = true;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = -0.599999964;
         _loc4_ = new GameObject(param1,im13_embed,"",265,40);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0;
         _loc4_.additive = true;
         _loc4_.tint(0.380000591,0,0);
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 1;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = -0.600000024;
         _loc4_ = new GameObject(param1,im14_embed,"",315,40);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.430000544;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.960000038;
         _loc4_.baseScaleY = 0.960000038;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.600000024;
         _loc4_ = new GameObject(param1,im15_embed,"",374,41);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.300000668;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 1.16999984;
         _loc4_.baseScaleY = 1.16999984;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.400000006;
         _loc4_ = new GameObject(param1,im16_embed,"",495,38);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.620000362;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.880000114;
         _loc4_.baseScaleY = 0.880000114;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.600000024;
         _loc4_ = new GameObject(param1,im17_embed,"",437,40);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.450000525;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 1.13999987;
         _loc4_.baseScaleY = 1.13999987;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.75;
         _loc4_ = new GameObject(param1,im18_embed,"",501,45);
         _loc4_.baseRotation = 0;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.820000172;
         _loc4_.baseScaleY = 0.820000172;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 1;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.5;
         _loc4_ = new GameObject(param1,im19_embed,"",567,41);
         _loc4_.baseRotation = 0;
         _loc4_.additive = true;
         _loc4_.tint(0.520000458,0,0);
         _loc4_.baseScaleX = 0.78000021;
         _loc4_.baseScaleY = 0.78000021;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 0.699999988;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.600000024;
         _loc4_ = new GameObject(param1,im20_embed,"",518,40);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.980000019;
         _loc4_.additive = true;
         _loc4_.tint(0.450000525,0,0);
         _loc4_.baseScaleX = 0.940000057;
         _loc4_.baseScaleY = 0.940000057;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 1;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.400000006;
         _loc4_ = new GameObject(param1,im21_embed,"",380,63);
         _loc4_.baseRotation = 0;
         _loc4_.additive = true;
         _loc4_.tint(0.400000572,0,0);
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 0.400000006;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.400000006;
         _loc4_ = new GameObject(param1,im22_embed,"",315,53);
         _loc4_.baseRotation = 0;
         _loc4_.additive = true;
         _loc4_.tint(0.680000305,0,0);
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 0.450000018;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.300000012;
         _loc4_ = new GameObject(param1,im23_embed,"",656,260);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0;
         _loc4_.additive = true;
         _loc4_.tint(0.180000678,0,0);
         _loc4_.baseScaleX = 1.43999958;
         _loc4_.baseScaleY = 1.43999958;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 1;
         _loc4_ = new GameObject(param1,im24_embed,"",197,43);
         _loc4_.baseRotation = 0;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.710000277;
         _loc4_.baseScaleY = 0.710000277;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.400000006;
         _loc4_ = new GameObject(param1,im25_embed,"",251,42);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.35000062;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 1.22999978;
         _loc4_.baseScaleY = 1.22999978;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.699999988;
         _loc4_ = new GameObject(param1,im26_embed,"",575,62);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.600000381;
         _loc4_.additive = true;
         _loc4_.baseScaleX = 0.78000021;
         _loc4_.baseScaleY = 0.78000021;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 0.600000024;
         _loc5_ = new GameObjectFilterRotate();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterRotate(_loc5_).Speed = 0.5;
         _loc4_ = new GameObject(param1,im27_embed,"",396,47);
         _loc4_.baseRotation = 0;
         _loc4_.baseAlpha = 0.310000658;
         _loc4_.additive = true;
         _loc5_ = new GameObjectFilterPulse();
         _loc4_.addFilter(_loc5_);
         GameObjectFilterPulse(_loc5_).Speed = 0.899999976;
         if(!param3)
         {
            param2.addChild(param1.m);
         }
      }
   }
}

