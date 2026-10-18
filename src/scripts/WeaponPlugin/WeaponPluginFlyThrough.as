package WeaponPlugin
{
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import Weapons.Grenade;
   import Weapons.Laser;
   
   public class WeaponPluginFlyThrough extends WeaponPluginBase
   {
      
      public function WeaponPluginFlyThrough()
      {
         super();
      }
      
      override public function isApplicable(param1:Object) : Boolean
      {
         return !(param1 is Grenade || param1 is Laser);
      }
      
      override public function attributeText() : String
      {
         return "HITS MULTIPLE TARGETS";
      }
      
      override public function hitEnemy(param1:BulletBase, param2:EnemyBase) : void
      {
         param1.keep = true;
      }
   }
}

