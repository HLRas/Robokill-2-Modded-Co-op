package WeaponPlugin
{
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import Weapons.Grenade;
   
   public class WeaponPluginFreeze extends WeaponPluginBase
   {
      
      public function WeaponPluginFreeze()
      {
         super();
      }
      
      override public function isApplicable(param1:Object) : Boolean
      {
         return !(param1 is Grenade);
      }
      
      override public function attributeText() : String
      {
         return "FREEZE";
      }
      
      override public function hitEnemy(param1:BulletBase, param2:EnemyBase) : void
      {
         if(param2.canBeFrozen())
         {
            if(!param2.hasBeenFrozen)
            {
               param2.frozen = 100;
               param2.hasBeenFrozen = true;
            }
         }
      }
   }
}

