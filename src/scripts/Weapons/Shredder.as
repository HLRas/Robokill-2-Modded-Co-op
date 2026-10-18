package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.FastLaserBullet;
   import Scenes.MainScene;
   
   public class Shredder extends WeaponBase
   {
      
      public static var levelDamage:Array = [40,55,70];
      
      public static var levelRequired:Array = [30,35,40];
      
      public function Shredder()
      {
         super();
      }
      
      override public function value() : int
      {
         return [1.4,1.7,2][level] * super.value();
      }
      
      override public function playerMinLevel() : int
      {
         return levelRequired[level] - 1;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.p_lazer_S_png,Embeds.p_lazer_M_png,Embeds.p_lazer_H_png][level];
      }
      
      override public function icon() : Class
      {
         return [Embeds.p_lazer_png,Embeds.p_lazer_2_png,Embeds.p_lazer_3_png][level];
      }
      
      override public function boxDamage() : int
      {
         return 5;
      }
      
      override public function name() : String
      {
         return ["LIGHT SHREDDER","MEDIUM SHREDDER","HEAVY SHREDDER"][level];
      }
      
      override public function _rateOfFire() : int
      {
         return 30;
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
         var _loc6_:FastLaserBullet = null;
         _loc6_ = new FastLaserBullet(param1,param2,param3);
         _loc6_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + shotRotation() + 90);
         _loc6_.additive = true;
         _loc6_.speed = speedMult() * (7 + Math.random());
         _loc6_.endx = param4;
         _loc6_.endy = param5;
         _loc6_.wep = this;
         _loc6_.source = MainScene(param1).player;
         applyLevelToBullet(_loc6_);
      }
   }
}

