package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectConstructors.ControlHelp_constructor;
   
   public class ControlHelp extends GameObject
   {
      
      public var rc:int = 0;
      
      public function ControlHelp(param1:GameScene, param2:int, param3:int)
      {
         super(param1,ControlHelp_constructor.baseim_embed,ControlHelp_constructor.LayerName,param2,param3);
         ControlHelp_constructor.setup(param1,this);
      }
      
      public function roomChange() : void
      {
         ++rc;
         if(rc >= 2)
         {
            remove();
         }
      }
      
      override public function _init() : void
      {
         basex -= 400;
         helper.slideTo(basex + 400,basey,false,80);
      }
   }
}

