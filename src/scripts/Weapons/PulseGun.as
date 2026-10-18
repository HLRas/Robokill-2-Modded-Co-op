package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.PulseBullet;
   import Scenes.MainScene;
   
   public class PulseGun extends WeaponBase
   {
      
      public static var levelDamage:Array = [10,15,20];
      
      public static var levelRequired:Array = [20,25,30];
      
      public function PulseGun()
      {
         super();
      }
      
      override public function boxDamage() : int
      {
         return super.boxDamage() * 4;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.pulsegun_s_png,Embeds.pulsegun_m_png,Embeds.pulsegun_h_png][level];
      }
      
      override public function recoilAmount() : Number
      {
         return 5;
      }
      
      override public function name() : String
      {
         return ["LIGHT PULSE GUN","MEDIUM PULSE GUN","HEAVY PULSE GUN"][level];
      }
      
      override public function _rateOfFire() : int
      {
         return 20;
      }
      
      override public function _damage() : Number
      {
         return levelDamage[level];
      }
      
      override public function value() : int
      {
         return [1.25,1.4,1.6][level] * super.value();
      }
      
      override public function playerMinLevel() : int
      {
         return levelRequired[level] - 1;
      }
      
      override public function shotRotation() : Number
      {
         return (Math.random() - 0.5) * 2;
      }
      
      override public function icon() : Class
      {
         return [Embeds.pulsegun_png,Embeds.pulsegun_2_png,Embeds.pulsegun_3_png][level];
      }
      
      override public function _pointWorth() : int
      {
         return [10,20,40][level];
      }
      
      override public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:PulseBullet = null;
         _loc6_ = new PulseBullet(param1,param2,param3);
         _loc6_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + shotRotation() + 90);
         _loc6_.additive = true;
         _loc6_.speed = speedMult() * (7 + Math.random());
         _loc6_.wep = this;
         _loc6_.source = MainScene(param1).player;
         applyLevelToBullet(_loc6_);
      }
   }
}

