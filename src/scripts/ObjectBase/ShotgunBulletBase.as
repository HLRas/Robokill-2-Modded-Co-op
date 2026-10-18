package ObjectBase
{
   import GameScene.GameScene;
   
   public class ShotgunBulletBase extends BulletBase
   {
      
      public function ShotgunBulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function _update() : void
      {
         super._update();
         if(ticks > 80)
         {
            remove();
         }
      }
   }
}

