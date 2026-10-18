package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectConstructors.DestructableCover_constructor;
   import Scenes.MainScene;
   import Tools.Random;
   
   public class DestructableCover extends FloorProp
   {
      
      public var damaged:Array;
      
      public var destroyed:Boolean = false;
      
      public var alternateCover:int = Random.randInt(0,2);
      
      public var recurse:Boolean = true;
      
      public function DestructableCover(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(null,param2,param3);
         DestructableCover_constructor.setup(param1,this);
         ms = MainScene(param1);
         useAnimFrame = false;
      }
      
      override public function serializeFields() : Array
      {
         var _loc1_:Array = super.serializeFields();
         _loc1_.push("destroyed");
         return _loc1_;
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         super._update();
         if(!destroyed)
         {
            helperAnimation.setFrame(imageSet[int(animFrame)]);
         }
         else
         {
            _loc1_ = int(animFrame);
            if(_loc1_ == 0 || _loc1_ == 3)
            {
               if(alternateCover > 0)
               {
                  _loc1_ = 3 + alternateCover;
               }
            }
            helperAnimation.setFrame(damaged[_loc1_]);
            if(Math.random() < 0.005)
            {
               emitConditionalParticles("EnemyHit").length;
            }
         }
         collidesWithBullets = !destroyed;
      }
      
      override public function hasBeenHit(param1:GameObject, param2:Number = 1) : void
      {
         var _loc3_:GameObject = null;
         if(recurse)
         {
            for each(_loc3_ in gs.objects)
            {
               if(_loc3_ != this)
               {
                  if(_loc3_ is DestructableCover)
                  {
                     if(!(_loc3_.animFrame == 0 || _loc3_.animFrame == 3))
                     {
                        if(distanceToObject(_loc3_) < 58)
                        {
                           DestructableCover(_loc3_).recurse = false;
                           DestructableCover(_loc3_).hasBeenHit(param1,param2);
                           DestructableCover(_loc3_).recurse = true;
                        }
                     }
                  }
               }
            }
         }
         super.hasBeenHit(param1,param2);
      }
      
      override public function _init() : void
      {
         super._init();
         health *= 6;
      }
      
      override public function destructable(param1:int) : Boolean
      {
         return !destroyed;
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
      
      override public function blowUp(param1:GameObject, param2:Boolean = false) : void
      {
         if(!destroyed)
         {
            emitConditionalParticles("Destroy");
            Sounds.gasTankDestroy.play();
            destroyed = true;
         }
      }
   }
}

