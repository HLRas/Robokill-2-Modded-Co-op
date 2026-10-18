package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SwarmBase;
   import ObjectConstructors.Maggot_constructor;
   import Tools.Interpolation;
   
   public class Maggot extends SwarmBase
   {
      
      public static var reversed:Boolean = false;
      
      public var growOffset:int = 150 + Math.random() * 150;
      
      public var morph:Array;
      
      public var smallGreenColors:Array = [0.21,0.21,0.21];
      
      public var smallBlueColors:Array = [0.79,0.79,0.79];
      
      public var spawnImages:Array;
      
      public var smallRedColors:Array = [1,1,1];
      
      public var growTicks:int = 0;
      
      public var normalGreenColors:Array = [0,-0.54,0.21];
      
      public var normalBlueColors:Array = [0,0.61,0.79];
      
      public var normalRedColors:Array = [1,1.18,0];
      
      public function Maggot(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Maggot_constructor.baseim_embed,Maggot_constructor.LayerName,param2,param3);
         Maggot_constructor.setup(param1,this);
         if(!reversed)
         {
            reversed = true;
            imageSet = imageSet.reverse();
         }
         lastHit = 999;
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth();
      }
      
      override public function handlePlayerCollision() : void
      {
         if(ticks > 150 + growOffset)
         {
            super.handlePlayerCollision();
            return;
         }
         emitConditionalParticles("DestroySmall");
         kill();
      }
      
      override public function doMovement() : void
      {
         if(ticks > 150 + growOffset)
         {
            super.doMovement();
         }
      }
      
      override public function _update() : void
      {
         if(blockUpdating())
         {
            super._update();
            return;
         }
         ++growTicks;
         interpolateArrayLock(redColors,smallRedColors,normalRedColors,Interpolation.fromTo(ticks,100 + growOffset,150 + growOffset));
         interpolateArrayLock(greenColors,smallGreenColors,normalGreenColors,Interpolation.fromTo(ticks,100 + growOffset,150 + growOffset));
         interpolateArrayLock(blueColors,smallBlueColors,normalBlueColors,Interpolation.fromTo(ticks,100 + growOffset,150 + growOffset));
         if(ticks == 150 + growOffset)
         {
            imageSet = spawnImages;
            setFrame(10);
            health *= 2;
         }
         if(ticks > 150 + growOffset)
         {
            imageSet = spawnImages;
         }
         else if(ticks > 100 + growOffset)
         {
            lastHit = 999;
            imageSet = morph;
            setFrame(imageSet.length * (ticks - 100 - growOffset) / 50);
            animFrame = 10;
            _moveTowardsPlayer();
            hasSetupSlowRotation = true;
            doTinting();
         }
         else
         {
            moveRandomly(1.7);
            doTinting();
         }
         if(ticks <= 150 + growOffset)
         {
            basex += extradx;
            basey += extrady;
            extradx *= 0.96;
            extrady *= 0.96;
         }
         super._update();
      }
      
      public function interpolateArrayLock(param1:Array, param2:Array, param3:Array, param4:Number) : void
      {
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            param1[_loc5_] = Interpolation.linearInterpolateLock(param2[_loc5_],param3[_loc5_],param4);
            _loc5_++;
         }
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight();
      }
   }
}

