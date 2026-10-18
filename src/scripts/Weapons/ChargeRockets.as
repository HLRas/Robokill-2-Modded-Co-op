package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.ChargeRocket;
   import Scenes.MainScene;
   import WeaponPlugin.WeaponPluginSplash;
   
   public class ChargeRockets extends WeaponBase
   {
      
      public static var levelDamage:Array = [40,55,70];
      
      public static var levelRequired:Array = [24,29,36];
      
      public function ChargeRockets()
      {
         super();
         var _loc1_:WeaponPluginSplash = new WeaponPluginSplash();
         _loc1_.isIntrinsic = true;
         addPlugin(_loc1_);
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
         return [Embeds.c_missile_S_png,Embeds.c_missile_M_png,Embeds.c_missile_H_png][level];
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
         return [Embeds.charge_rockets_1_png,Embeds.charge_rockets_2_png,Embeds.charge_rockets_3_png][level];
      }
      
      override public function name() : String
      {
         return ["LIGHT BURST MISSILES","MEDIUM BURST MISSILES","HEAVY BURST MISSILES"][level];
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
         var _loc8_:ChargeRocket = null;
         var _loc9_:Number = NaN;
         var _loc6_:int = getPercentageCharge() * 10;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = new ChargeRocket(param1,param2,param3);
            _loc9_ = Math.random() * 20;
            if(_loc7_ <= _loc6_ / 2)
            {
               _loc9_ *= -1;
            }
            _loc8_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + 90 + _loc9_);
            _loc8_.wep = this;
            _loc8_.delay = 30 * (_loc7_ / _loc6_);
            if(level == 1)
            {
               _loc8_.imageSet = _loc8_.medium;
            }
            else if(level == 2)
            {
               _loc8_.imageSet = _loc8_.heavy;
            }
            else
            {
               _loc8_.imageSet = _loc8_.light;
            }
            _loc8_.source = MainScene(param1).player;
            _loc8_.speed *= speedMult() * 0.8;
            _loc7_++;
         }
         Sounds.chargeMissiles.play();
      }
   }
}

