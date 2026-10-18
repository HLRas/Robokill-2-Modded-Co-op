package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.ClusterGrenade;
   
   public class ChargeGrenades extends WeaponBase
   {
      
      public static var levelDamage:Array = [20,35,60];
      
      public static var levelRequired:Array = [7,14,22];
      
      public function ChargeGrenades()
      {
         super();
      }
      
      override public function boxDamage() : int
      {
         return 5;
      }
      
      override public function playerMinLevel() : int
      {
         return levelRequired[level] - 1;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.c_grenade_S_png,Embeds.c_grenade_M_png,Embeds.c_grenade_H_png][level];
      }
      
      override public function charges() : Boolean
      {
         return true;
      }
      
      override public function value() : int
      {
         return [1.4,1.7,2][level] * super.value();
      }
      
      override public function icon() : Class
      {
         return [Embeds.charge_grenades_1_png,Embeds.charge_grenades_2_png,Embeds.charge_grenades_3_png][level];
      }
      
      override public function name() : String
      {
         return ["LIGHT CLUSTER GRENADE","CLUSTER GRENADE","HEAVY CLUSTER GRENADE"][level];
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
         var _loc6_:ClusterGrenade = null;
         _loc6_ = new ClusterGrenade(param1,param2,param3);
         _loc6_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + shotRotation() + 90);
         _loc6_.speed = speedMult() * 3;
         _loc6_.wep = this;
         _loc6_.destX = param4;
         _loc6_.destY = param5;
         _loc6_.startX = param2;
         _loc6_.startY = param3;
         _loc6_.charge = getPercentageCharge();
         applyLevelToBullet(_loc6_);
         Sounds.chargeGrenade.play();
      }
   }
}

