package Templates
{
   import GameConfig.GameConfig;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterFadeInOut;
   import GameObject.GameObjectFilterScaleInOut;
   import GameScene.GameScene;
   import Tools.Random;
   
   public class RewardText extends GameObject
   {
      
      public function RewardText(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public static function createRewardText(param1:GameScene, param2:int, param3:int, param4:String = "", param5:String = "TextLayer", param6:int = -1, param7:Number = 1, param8:int = 0, param9:int = 0) : RewardText
      {
         var _loc10_:RewardText = null;
         var _loc11_:GameObjectFilterScaleInOut = null;
         var _loc13_:Array = null;
         if(GameConfig.shortName == "robokill2")
         {
            param3 -= 300 - 160;
         }
         if(param4 == "")
         {
            _loc13_ = ["EXCELLENT!","WELL DONE!","GREAT!"];
            param4 = _loc13_[Random.randInt(0,_loc13_.length - 1)];
         }
         _loc10_ = new RewardText(param1,null,param5,param2,param3);
         _loc10_.setText(param4,36 * param7,param6);
         _loc11_ = new GameObjectFilterScaleInOut();
         _loc11_.ScaleIn = 1;
         _loc11_.ScaleInStartX = 1.5;
         _loc11_.ScaleInStartY = 0;
         _loc11_.ScaleInDelay = param8;
         _loc11_.ScaleInDuration = 25;
         _loc10_.setGlobal(true);
         _loc10_.addFilter(_loc11_);
         var _loc12_:GameObjectFilterFadeInOut = new GameObjectFilterFadeInOut();
         _loc12_.FadeOut = 1;
         _loc12_.FadeOutTime = 100 + param8 + param9;
         _loc12_.FadeOutDuration = 50;
         _loc12_.FadeOutKill = 1;
         _loc10_.addFilter(_loc12_);
         return _loc10_;
      }
   }
}

