package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.ChargeLaserBullet;
   import Scenes.MainScene;
   
   public class ChargeLaser extends WeaponBase
   {
      
      public static var levelDamage:Array = [40,55,70];
      
      public static var levelRequired:Array = [34,39,44];
      
      public var offsetX:Number = 0;
      
      public var offsetY:Number = 0;
      
      public function ChargeLaser()
      {
         super();
      }
      
      override public function name() : String
      {
         return ["LIGHT DEVASTATOR","MEDIUM DEVASTATOR","HEAVY DEVASTATOR"][level];
      }
      
      override public function _rateOfFire() : int
      {
         return 30;
      }
      
      override public function _damage() : Number
      {
         return levelDamage[level];
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
         return [Embeds.c_lazer_S_png,Embeds.c_lazer_M_png,Embeds.c_lazer_H_png][level];
      }
      
      override public function charges() : Boolean
      {
         return true;
      }
      
      override public function icon() : Class
      {
         return [Embeds.charge_laser_1_png,Embeds.charge_laser_2_png,Embeds.charge_laser_3_png][level];
      }
      
      override public function boxDamage() : int
      {
         return 5;
      }
      
      override public function _pointWorth() : int
      {
         return [20,40,60][level];
      }
      
      override public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:ChargeLaserBullet = null;
         _loc6_ = new ChargeLaserBullet();
         _loc6_.startx = param2;
         _loc6_.starty = param3;
         _loc6_.endx = param4;
         _loc6_.endy = param5;
         _loc6_.charge = getPercentageCharge();
         _loc6_.offsetX = offsetX;
         _loc6_.offsetY = offsetY;
         _loc6_.changeZOrder("AbovePlayer");
         _loc6_.wep = this;
         _loc6_.owner = MainScene(param1).player;
         _loc6_._update();
         applyLevelToBullet(_loc6_);
      }
   }
}

