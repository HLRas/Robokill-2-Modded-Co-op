package Weapons
{
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.Bullet;
   import Scenes.MainScene;
   
   public class Blaster extends WeaponBase
   {
      
      public static var levelDamage:Array = [1,2,3];
      
      public static var levelRequired:Array = [1,3,8];
      
      public var overrideDamage:int = -1;
      
      public function Blaster()
      {
         super();
      }
      
      override public function recoilAmount() : Number
      {
         return 3;
      }
      
      override public function _inGameImage() : Class
      {
         return [Embeds.blaster_s_png,Embeds.blaster_m_png,Embeds.blaster_h_png][level];
      }
      
      override public function name() : String
      {
         return ["LIGHT BLASTER","MEDIUM BLASTER","HEAVY BLASTER"][level];
      }
      
      override public function _rateOfFire() : int
      {
         return 20 - 3 * level;
      }
      
      override public function _damage() : Number
      {
         if(overrideDamage > 0)
         {
            return overrideDamage;
         }
         return levelDamage[level];
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
         return [Embeds.blaster_png,Embeds.blaster_2_png,Embeds.blaster_3_png][level];
      }
      
      override public function _pointWorth() : int
      {
         return [10,20,40][level];
      }
      
      override public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Bullet = null;
         _loc6_ = new Bullet(param1,param2,param3);
         _loc6_.setAngle(90 + Math.atan2(param5 - param3,param4 - param2) * 180 / Math.PI + shotRotation());
         _loc6_.additive = true;
         _loc6_.speed = speedMult() * (7 + Math.random());
         _loc6_.wep = this;
         _loc6_.source = MainScene(param1).player;
         applyLevelToBullet(_loc6_);
      }
   }
}

