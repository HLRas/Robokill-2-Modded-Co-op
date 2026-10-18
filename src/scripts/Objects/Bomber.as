package Objects
{
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import ObjectBase.BomberBase;
   import ObjectConstructors.Bomber_constructor;
   import Tools.Interpolation;
   
   public class Bomber extends BomberBase
   {
      
      public var firing:int = 0;
      
      public var fire:Array;
      
      public var lastFire:int = 0;
      
      public var killed:Boolean = false;
      
      public function Bomber(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Bomber_constructor.baseim_embed,Bomber_constructor.LayerName,param2,param3);
         Bomber_constructor.setup(param1,this);
         baseHealth *= 9;
         addFilter(new GameObjectFilterRotateSlowly(2));
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:BomberBomb = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         super._update();
         if(blockUpdating())
         {
            return;
         }
         moveTowardsPlayer(1.5);
         if(distanceToPlayer() < 40)
         {
            kill();
         }
         else if(aimingAtPlayer())
         {
            if(Math.random() > 0.9)
            {
               if(!firing)
               {
                  if(ticks - lastFire > 200)
                  {
                     lastFire = ticks;
                     firing = 1;
                  }
               }
            }
         }
         if(firing > 0)
         {
            if(firing == 50)
            {
               _loc2_ = 0;
               while(_loc2_ < 4)
               {
                  _loc3_ = BomberBomb(spawn(BomberBomb,basex,basey,0,true));
                  if(_loc3_)
                  {
                     _loc4_ = angleToObject(ms.player) + 20 * (Math.random() - 0.5);
                     _loc5_ = 5 + Math.random() * 5;
                     _loc3_.dx = Math.cos(_loc4_ * Math.PI / 180) * _loc5_;
                     _loc3_.dy = Math.sin(_loc4_ * Math.PI / 180) * _loc5_;
                  }
                  _loc2_++;
               }
            }
            ++firing;
            _loc1_ = firing / 5;
            if(_loc1_ >= 10)
            {
               _loc1_ = 20 - _loc1_;
            }
            if(_loc1_ >= 10)
            {
               _loc1_ = 9;
            }
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            helperAnimation.setFrame(fire[_loc1_]);
            if(firing > 100)
            {
               firing = 0;
            }
         }
      }
      
      override public function _experience() : int
      {
         return 100;
      }
      
      internal function aimingAtPlayer() : Boolean
      {
         return Interpolation.distanceToAngle(baseRotation - 90,angleToObject(ms.player)) < 5;
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() * 0.5;
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() * 0.5;
      }
      
      override public function kill() : void
      {
         if(killed)
         {
            return;
         }
         killed = true;
         createBombs(8);
         emitConditionalParticles("BruteShock");
         super.kill();
      }
   }
}

