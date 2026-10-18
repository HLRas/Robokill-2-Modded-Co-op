package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.LaserBullet;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import WeaponPlugin.WeaponPluginFlyThrough;
   
   public class Laser extends WeaponBase
   {
      
      public static var levelDamage:Array = [35,45,55];
      
      public static var levelRequired:Array = [16,21,26];
      
      public function Laser()
      {
         super();
         var _loc1_:WeaponPluginFlyThrough = new WeaponPluginFlyThrough();
         _loc1_.isIntrinsic = true;
         addPlugin(_loc1_);
      }
      
      override public function playerMinLevel() : int
      {
         return levelRequired[level] - 1;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.lazer_s_png,Embeds.lazer_m_png,Embeds.lazer_h_png][level];
      }
      
      override public function icon() : Class
      {
         return [Embeds.lazer_png,Embeds.lazer_2_png,Embeds.lazer_3_png][level];
      }
      
      override public function boxDamage() : int
      {
         return 5;
      }
      
      override public function name() : String
      {
         return ["LIGHT LASER","MEDIUM LASER","HEAVY LASER"][level];
      }
      
      override public function _rateOfFire() : int
      {
         switch(level)
         {
            case 0:
               return 80;
            case 1:
               return 80;
            case 2:
               return 80;
            default:
               return 100;
         }
      }
      
      override public function _pointWorth() : int
      {
         return [20,40,60][level];
      }
      
      override public function _damage() : Number
      {
         return levelDamage[level];
      }
      
      override public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc7_:LaserBullet = null;
         var _loc6_:MainScene = MainScene(param1);
         param2 = Interpolation.lockValue(param2,_loc6_.startx,_loc6_.endx);
         param3 = Interpolation.lockValue(param3,_loc6_.starty,_loc6_.endy);
         _loc7_ = new LaserBullet(param1,param2,param3);
         _loc7_.startx = param2;
         _loc7_.starty = param3;
         _loc7_.endx = param4;
         _loc7_.endy = param5;
         _loc7_.wep = this;
         _loc7_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + 90);
         _loc7_.baseScaleX = 2.5;
         _loc7_.baseScaleY = 0;
         applyLevelToBullet(_loc7_);
      }
   }
}

