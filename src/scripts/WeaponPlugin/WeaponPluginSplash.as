package WeaponPlugin
{
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   
   public class WeaponPluginSplash extends WeaponPluginBase
   {
      
      public function WeaponPluginSplash()
      {
         super();
      }
      
      override public function attributeText() : String
      {
         return "Splash Damage";
      }
      
      public function WeaponPluginFlyThrough() : *
      {
      }
      
      override public function hitEnemy(param1:BulletBase, param2:EnemyBase) : void
      {
         trace("hit");
         if(Math.random() < 0.5)
         {
            param1.emitConditionalParticles("Destroy");
         }
         else
         {
            param1.emitConditionalParticles("Destroy2");
         }
      }
   }
}

