package Objects
{
   import GameScene.GameScene;
   import ObjectBase.PickupBase;
   import ObjectConstructors.ShieldPickup_constructor;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Tools.Random;
   import flash.display.Bitmap;
   
   public class ShieldPickup extends PickupBase
   {
      
      public var randomSet:Array;
      
      public function ShieldPickup(param1:GameScene, param2:int, param3:int)
      {
         super(param1,ShieldPickup_constructor.baseim_embed,ShieldPickup_constructor.LayerName,param2,param3);
         ShieldPickup_constructor.setup(param1,this);
         Bitmap(obj).bitmapData = randomSet[Random.randInt(0,randomSet.length - 1)];
      }
      
      override public function pickupName() : String
      {
         return "SHIELD";
      }
      
      override public function pickup() : Boolean
      {
         MainScene(gs).player.shields = Interpolation.lockValue(MainScene(gs).player.shields + 0.1,0,1);
         Sounds.shieldPickup.play();
         return true;
      }
   }
}

