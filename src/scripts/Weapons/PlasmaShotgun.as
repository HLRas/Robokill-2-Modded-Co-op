package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.PulseShotgunBullet;
   import Scenes.MainScene;
   
   public class PlasmaShotgun extends WeaponBase
   {
      
      public static var levelDamage:Array = [13,18,24];
      
      public static var levelRequired:Array = [27,32,37];
      
      public function PlasmaShotgun()
      {
         super();
      }
      
      override public function boxDamage() : int
      {
         return super.boxDamage() * 4;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.knockback_S_png,Embeds.knockback_M_png,Embeds.knockback_H_png][level];
      }
      
      override public function recoilAmount() : Number
      {
         return 5;
      }
      
      override public function name() : String
      {
         return ["LIGHT PULSE SHOTGUN","MEDIUM PULSE SHOTGUN","HEAVY PULSE SHOTGUN"][level];
      }
      
      override public function _rateOfFire() : int
      {
         return 50;
      }
      
      override public function _damage() : Number
      {
         return levelDamage[level];
      }
      
      override public function value() : int
      {
         return [1.3,1.5,1.7][level] * super.value();
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
         return [Embeds.knockback_png,Embeds.knockback_2_png,Embeds.knockback_3_png][level];
      }
      
      override public function _pointWorth() : int
      {
         return [15,25,35][level];
      }
      
      override public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc7_:PulseShotgunBullet = null;
         var _loc6_:int = 0;
         while(_loc6_ < 4)
         {
            _loc7_ = new PulseShotgunBullet(param1,param2,param3);
            _loc7_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + shotRotation() + (_loc6_ - 1.5) * 5 + 90);
            _loc7_.additive = true;
            _loc7_.speed = speedMult() * (7 + Math.random());
            _loc7_.wep = this;
            _loc7_.bounceCount = 1;
            _loc7_.source = MainScene(param1).player;
            applyLevelToBullet(_loc7_);
            _loc6_++;
         }
      }
   }
}

