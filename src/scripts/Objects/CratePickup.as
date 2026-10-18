package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.PickupBase;
   import ObjectConstructors.CratePickup_constructor;
   
   public class CratePickup extends PickupBase
   {
      
      public function CratePickup(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,CratePickup_constructor.baseim_embed,CratePickup_constructor.LayerName,param2,param3);
         CratePickup_constructor.setup(param1,this);
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         super._update();
         _loc1_ = helper.conditionallyCreateChild(Embeds.top_decal_06_png,"topd",true);
         if(_loc1_)
         {
            _loc1_.basex = basex;
            _loc1_.basey = basey - baseHeight / 2;
            _loc1_.baseHandleX = 0;
            _loc1_.baseHandleY = 1;
            _loc1_.changeZOrder("TextLayer");
         }
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
      
      override public function pickupName() : String
      {
         return "SHIP PARTS";
      }
      
      override public function _init() : void
      {
         super._init();
         createPickMeUp();
      }
   }
}

