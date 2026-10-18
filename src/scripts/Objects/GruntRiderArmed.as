package Objects
{
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import flash.display.*;
   
   public class GruntRiderArmed extends GruntRider
   {
      
      public var cannons:Array = new Array();
      
      public function GruntRiderArmed(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,param2,param3);
         GruntRiderArmed_constructor.setup(param1,this);
         baseHealth *= 10;
      }
      
      override public function _update() : void
      {
         var _loc2_:GruntRiderCannon = null;
         super._update();
         var _loc1_:int = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = cannons[_loc1_];
            _loc2_.basex = tformedX(_loc1_ == 0 ? -20 : 20,0);
            _loc2_.basey = tformedY(_loc1_ == 0 ? -20 : 20,0);
            _loc2_.baseRotation = modifiedRotation;
            _loc1_++;
         }
      }
      
      override public function _experience() : int
      {
         return 200;
      }
      
      override public function kill() : void
      {
         var _loc2_:GruntRiderCannon = null;
         super.kill();
         var _loc1_:int = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = cannons[_loc1_];
            if(_loc2_)
            {
               if(!_loc2_._removed)
               {
                  _loc2_.detached = true;
               }
            }
            _loc1_++;
         }
      }
      
      override public function _init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GruntRiderCannon = null;
         super._init();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = new GruntRiderCannon();
            _loc2_.setupDifficulty(0);
            _loc2_.pushable = false;
            cannons[_loc1_] = _loc2_;
            if(_loc1_ == 0)
            {
               _loc2_.helperAnimation.setFrame(new Embeds.Rider_Cannon_Right_png().bitmapData);
            }
            _loc1_++;
         }
      }
   }
}

