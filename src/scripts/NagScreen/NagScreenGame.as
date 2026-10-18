package NagScreen
{
   import GameConfig.*;
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Layout.Layout;
   import Tools.SafeImageRequest;
   import flash.display.*;
   
   public class NagScreenGame
   {
      
      public var cached:Boolean = false;
      
      public var shortName:String;
      
      public var name:String;
      
      public var gs:GameScene;
      
      public var baseURL:String;
      
      public function NagScreenGame()
      {
         super();
      }
      
      public static function create(param1:String) : NagScreenGame
      {
         var _loc6_:NagScreenGame = null;
         var _loc2_:Array = param1.split(",",3);
         var _loc3_:String = _loc2_[0];
         var _loc4_:int = int(_loc2_[1]);
         var _loc5_:String = _loc2_[2];
         if(_loc3_ != GameConfig.shortName)
         {
            _loc6_ = new NagScreenGame();
            _loc6_.shortName = _loc3_;
            _loc6_.name = _loc5_;
            return _loc6_;
         }
         return null;
      }
      
      public function cache() : void
      {
         if(cached)
         {
            return;
         }
         cached = true;
         var _loc1_:SafeImageRequest = new SafeImageRequest(baseURL + shortName + "/headersmall.png");
         var _loc2_:SafeImageRequest = new SafeImageRequest(baseURL + shortName + "/nagshot1.jpg");
         var _loc3_:SafeImageRequest = new SafeImageRequest(baseURL + shortName + "/nagshot2.jpg");
      }
      
      public function getGameObjects(param1:GameScene) : Layout
      {
         var _loc2_:GameObject = new GameObject(param1,SimpleButton,"TextLayer",400,300);
         _loc2_.helper.lazyLoad(baseURL + shortName + "/headersmall.png");
         _loc2_.baseWidth = 400;
         _loc2_.baseHeight = 83;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < 2)
         {
            _loc3_[_loc4_] = new GameObject(param1,SimpleButton,"TextLayer",400,300);
            _loc3_[_loc4_].helper.lazyLoad(baseURL + shortName + "/nagshot" + (_loc4_ + 1) + ".jpg");
            _loc3_[_loc4_].baseWidth = 200;
            _loc3_[_loc4_].baseHeight = 150;
            _loc4_++;
         }
         return param1.vert([_loc2_,param1.horiz(_loc3_)],4);
      }
   }
}

