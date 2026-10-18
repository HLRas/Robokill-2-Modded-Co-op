package GameObject
{
   import flash.geom.Point;
   
   public class GameObjectCollisionPoly
   {
      
      public var tformedX:Number;
      
      public var points:Array = new Array();
      
      public var tformedY:Number;
      
      public var approxRadius:Number;
      
      public var tformedY2:Number;
      
      public var tformedX2:Number;
      
      public var approxX:Number;
      
      public var approxY:Number;
      
      public function GameObjectCollisionPoly()
      {
         super();
      }
      
      public function pushPoint(param1:Number, param2:Number) : void
      {
         points.push(new Point(param1,param2));
      }
   }
}

