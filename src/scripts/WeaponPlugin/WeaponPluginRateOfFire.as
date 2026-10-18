package WeaponPlugin
{
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import Tools.Random;
   
   public class WeaponPluginRateOfFire extends WeaponPluginBase
   {
      
      public var percent:Number = Random.randInt(10,20);
      
      public function WeaponPluginRateOfFire()
      {
         super();
      }
      
      override public function attributeText() : String
      {
         return "+" + percent + "% RATE OF FIRE";
      }
      
      override public function hitEnemy(param1:BulletBase, param2:EnemyBase) : void
      {
      }
   }
}

