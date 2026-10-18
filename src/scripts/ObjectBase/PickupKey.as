package ObjectBase
{
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Scenes.*;
   import flash.display.Bitmap;
   
   public class PickupKey extends PickupBase
   {
      
      public var created:int = -1000;
      
      public function PickupKey(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Embeds.key_1_embed,"Floor",param2,param3);
      }
      
      override public function handlePlayerCollision() : void
      {
         super.handlePlayerCollision();
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
      
      override public function serializeFields() : Array
      {
         return ["basex","basey","animFrame"];
      }
      
      override public function _remove() : void
      {
         if(pickMeUp)
         {
            pickMeUp.remove();
         }
      }
      
      override public function playSound() : void
      {
         Sounds.pickupKey.play();
      }
      
      override public function pickup() : Boolean
      {
         MainScene(gs).player.addKey(this);
         return true;
      }
      
      override public function pickupName() : String
      {
         if(int(animFrame) == 1)
         {
            return "TREASURE KEY";
         }
         return "KEY";
      }
      
      override public function _update() : void
      {
         var _loc1_:Bitmap = null;
         setFrame(int(animFrame));
         super._update();
         if(ticks == 2)
         {
            if(animFrame > 0)
            {
               _loc1_ = new Embeds.keyglow_yellow_png();
               if(int(animFrame) == 2)
               {
                  _loc1_ = new Embeds.keyglow_red_png();
               }
               children[0].helperAnimation.setFrame(_loc1_.bitmapData);
            }
         }
         if(MainScene(gs).lazyEnemiesCount == 0)
         {
            if(!pickMeUp)
            {
               pickMeUp = new GameObject(gs,null,"AbovePlayer",basex,basey - 20);
               pickMeUp.fontName = "Pixelation-34";
               pickMeUp.setText("PICK ME UP!",7);
               pickMeUp.addFilter(new GameObjectFilterBlink());
            }
         }
      }
   }
}

