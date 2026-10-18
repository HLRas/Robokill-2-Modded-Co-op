package
{
   import GameConfig.GameConfig;
   import GameScene.GameSceneStack;
   import Tools.GameTimer;
   import Tools.Input;
   import flash.display.Sprite;
   import flash.text.Font;
   
   public class Main extends Sprite
   {
      
      public static var gss:GameSceneStack = new GameSceneStack();
      
      public var sfci:Class = Main_sfci;
      
      public var mainFont:Class = Main_mainFont;
      
      public var i:Input;
      
      public var gt:GameTimer;
      
      public var pixelation:Class = Main_pixelation;
      
      public function Main()
      {
         super();
         Font.registerFont(mainFont);
         Font.registerFont(pixelation);
         gt = new GameTimer(10,__update);
         gss.mainSprite = this;
         var _loc1_:Class = GameConfig.startClass;
         gss.pushScene(new _loc1_());
      }
      
      public function __update() : void
      {
         gss.update();
      }
   }
}

