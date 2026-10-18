package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.GrenadeBullet;
   import Scenes.MainScene;
   import WeaponPlugin.WeaponPluginSplash;
   
   public class Grenade extends WeaponBase
   {
      
      public static var levelDamage:Array = [10,20,30];
      
      public static var levelRequired:Array = [5,10,15];
      
      public function Grenade()
      {
         super();
         var _loc1_:WeaponPluginSplash = new WeaponPluginSplash();
         _loc1_.isIntrinsic = true;
         addPlugin(_loc1_);
      }
      
      override public function boxDamage() : int
      {
         return 10;
      }
      
      override public function playerMinLevel() : int
      {
         return levelRequired[level] - 1;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.grenade_s_png,Embeds.grenade_m_png,Embeds.grenade_h_png][level];
      }
      
      override public function icon() : Class
      {
         return [Embeds.grenade_png,Embeds.grenade_2_png,Embeds.grenade_3_png][level];
      }
      
      override public function name() : String
      {
         return ["LIGHT GRENADE","MEDIUM GRENADE","HEAVY GRENADE"][level];
      }
      
      override public function _rateOfFire() : int
      {
         switch(level)
         {
            case 0:
               return 60;
            case 1:
               return 70;
            case 2:
               return 80;
            default:
               return 100;
         }
      }
      
      override public function _pointWorth() : int
      {
         return [30,50,70][level];
      }
      
      override public function _damage() : Number
      {
         return levelDamage[level];
      }
      
      override public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:GrenadeBullet = new GrenadeBullet(param1,param2,param3);
         _loc6_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + 90);
         _loc6_.wep = this;
         if(level == 1)
         {
            _loc6_.bounceSet = Embeds.mGrenadeShot;
         }
         else if(level == 2)
         {
            _loc6_.bounceSet = Embeds.hGrenadeShot;
         }
         _loc6_.source = MainScene(param1).player;
         _loc6_.speed *= speedMult();
      }
   }
}

