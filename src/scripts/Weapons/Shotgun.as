package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.ShotgunBullet;
   import Scenes.MainScene;
   
   public class Shotgun extends WeaponBase
   {
      
      public static var levelDamage:Array = [2,3,5];
      
      public static var levelRequired:Array = [2,6,12];
      
      public function Shotgun()
      {
         super();
      }
      
      override public function playerMinLevel() : int
      {
         return levelRequired[level] - 1;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.shotgun_s_png,Embeds.shotgun_m_png,Embeds.shotgun_h_png][level];
      }
      
      override public function icon() : Class
      {
         return [Embeds.shotgun_png,Embeds.shotgun_2_png,Embeds.shotgun_3_png][level];
      }
      
      override public function name() : String
      {
         return ["LIGHT SHOTGUN","MEDIUM SHOTGUN","HEAVY SHOTGUN"][level];
      }
      
      override public function _rateOfFire() : int
      {
         switch(level)
         {
            case 0:
               return 50;
            case 1:
               return 60;
            case 2:
               return 70;
            default:
               return 100;
         }
      }
      
      override public function _pointWorth() : int
      {
         return [10,30,50][level];
      }
      
      override public function _damage() : Number
      {
         return levelDamage[level];
      }
      
      override public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc7_:ShotgunBullet = null;
         var _loc6_:int = 0;
         while(_loc6_ < 4)
         {
            _loc7_ = new ShotgunBullet(param1,param2,param3);
            _loc7_.setAngle(Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + (_loc6_ - 1.5) * 6 + (Math.random() - 0.5) * 2 + 90);
            _loc7_.speed = speedMult() * (6 + Math.random() * 2);
            _loc7_.wep = this;
            _loc7_.source = MainScene(param1).player;
            applyLevelToBullet(_loc7_);
            _loc6_++;
         }
      }
   }
}

