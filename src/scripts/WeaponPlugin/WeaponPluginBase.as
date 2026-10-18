package WeaponPlugin
{
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   
   public class WeaponPluginBase
   {
      
      public var isIntrinsic:Boolean = false;
      
      public function WeaponPluginBase()
      {
         super();
      }
      
      public function attributeText() : String
      {
         return "";
      }
      
      public function hitEnemy(param1:BulletBase, param2:EnemyBase) : void
      {
      }
      
      public function isApplicable(param1:Object) : Boolean
      {
         return true;
      }
      
      public function serializeFields() : Array
      {
         return ["isIntrinsic"];
      }
      
      public function pointWorth() : int
      {
         return 10;
      }
   }
}

