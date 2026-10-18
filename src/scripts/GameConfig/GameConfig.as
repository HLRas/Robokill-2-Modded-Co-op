package GameConfig
{
   import Scenes.Story;
   
   public class GameConfig
   {
      
      public static var startClass:Class = Story;
      
      public static var fontName:String = "SF Chrome Fenders";
      
      public static var fontColor:int = 65021;
      
      public static var inDev:Boolean = false;
      
      public static var shortName:String = "robokill2";
      
      public static var referenceAngle:Number = -90;
      
      public static var width:int = 800;
      
      public static var height:int = 600;
      
      public static var nagEnabled:Boolean = true;
      
      public function GameConfig()
      {
         super();
      }
   }
}

