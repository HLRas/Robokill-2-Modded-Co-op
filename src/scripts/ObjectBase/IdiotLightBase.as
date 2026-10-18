package ObjectBase
{
   import GameScene.GameScene;
   import Scenes.MainMenu;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Tools.Random;
   
   public class IdiotLightBase extends GameObjectBase
   {
      
      public var enabledTicks:int = 0;
      
      public var images:Array;
      
      public var cutoff:int = Random.randInt(2,9);
      
      public function IdiotLightBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         additive = true;
      }
      
      override public function _update() : void
      {
         if(!MainMenu.levelOfDetail)
         {
            remove();
         }
         if(enabledTicks == 0)
         {
            if(ticks > 4)
            {
               if(MainScene(gs).lazyEnemiesCount < cutoff)
               {
                  enabledTicks = 1;
               }
            }
         }
         hidden = enabledTicks == 0;
         if(enabledTicks > 0)
         {
            ++enabledTicks;
            baseAlpha = Interpolation.linearInterpolateLock(0,1,Interpolation.fromTo(enabledTicks,0,100));
         }
      }
   }
}

