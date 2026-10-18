package Objects
{
   import GameScene.GameScene;
   import ObjectBase.PickupBase;
   import ObjectConstructors.ShieldLargePickup_constructor;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Tools.Random;
   import flash.display.Bitmap;
   
   public class ShieldLargePickup extends PickupBase
   {
      
      public var randomSet:Array;
      
      public function ShieldLargePickup(param1:GameScene, param2:int, param3:int)
      {
         super(param1,ShieldLargePickup_constructor.baseim_embed,ShieldLargePickup_constructor.LayerName,param2,param3);
         ShieldLargePickup_constructor.setup(param1,this);
         Bitmap(obj).bitmapData = randomSet[Random.randInt(0,randomSet.length - 1)];
      }
      
      override public function pickupName() : String
      {
         return "SHIELD";
      }
      
      override public function pickup() : Boolean
      {
         MainScene(gs).player.shields = Interpolation.lockValue(MainScene(gs).player.shields + 0.5,0,1);
         Sounds.shieldPickup.play();
         return true;
      }
   }
}

