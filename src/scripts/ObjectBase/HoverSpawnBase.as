package ObjectBase
{
   import GameScene.GameScene;
   import Objects.HoverSwarm;
   
   public class HoverSpawnBase extends SpawnBase
   {
      
      public function HoverSpawnBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         baseHealth *= 10;
         extraHealth *= 10;
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      override public function creationOverride() : Class
      {
         return HoverSwarm;
      }
   }
}

