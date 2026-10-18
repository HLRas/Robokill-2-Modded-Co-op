package Objects
{
   import GameScene.GameScene;
   import ObjectBase.HulkBulletBase;
   import ObjectConstructors.BigTurretBullet_constructor;
   import flash.display.Bitmap;
   
   public class BigTurretBullet extends HulkBulletBase
   {
      
      public var damageOverride:Number = -1;
      
      public function BigTurretBullet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BigTurretBullet_constructor.baseim_embed,BigTurretBullet_constructor.LayerName,param2,param3);
         BigTurretBullet_constructor.setup(param1,this);
         Bitmap(obj).smoothing = true;
      }
      
      override public function damage() : int
      {
         if(damageOverride < 0)
         {
            return super.damage() * 4;
         }
         return damageOverride;
      }
   }
}

