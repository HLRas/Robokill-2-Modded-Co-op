package WeaponPlugin
{
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import Tools.Random;
   import Weapons.Laser;
   
   public class WeaponPluginSpeed extends WeaponPluginBase
   {
      
      public var percent:Number = Random.randInt(20,75);
      
      public function WeaponPluginSpeed()
      {
         super();
      }
      
      override public function isApplicable(param1:Object) : Boolean
      {
         return !(param1 is Laser);
      }
      
      override public function attributeText() : String
      {
         return "+" + percent + "% BULLET SPEED";
      }
      
      override public function hitEnemy(param1:BulletBase, param2:EnemyBase) : void
      {
      }
   }
}

