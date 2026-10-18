package Objects
{
   import GameObject.*;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import Scenes.MainScene;
   import flash.display.*;
   
   public class SpiderShot extends EnemyBulletBase
   {
      
      public var distanceToTravel:Number = 0;
      
      public var hasTarget:Boolean = false;
      
      public var bigFrame:Boolean = false;
      
      public var _killed:Boolean = false;
      
      public var heavyDamage:Boolean = false;
      
      public var fr1:BitmapData = new Embeds.spider_shot001_png().bitmapData;
      
      public var bigFrameBitmapData:BitmapData = new Embeds.spider2_shot_png().bitmapData;
      
      public var targetX:Number = 0;
      
      public var targetY:Number = 0;
      
      public var shotTail:Array;
      
      public var fr2:BitmapData = new Embeds.spider_shot002_png().bitmapData;
      
      public var startX:Number = 0;
      
      public var startY:Number = 0;
      
      public var releasedTicks:int = 0;
      
      public var released:Boolean = false;
      
      public function SpiderShot(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(param1 == null)
         {
            param1 = GameScene.current();
         }
         super(param1,SpiderShot_constructor.baseim_embed,SpiderShot_constructor.LayerName,param2,param3);
         SpiderShot_constructor.setup(param1,this);
         Bitmap(obj).smoothing = true;
         ms = MainScene(param1);
         baseHandleY = 0;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:Array = null;
         super._update();
         additive = released;
         if(released)
         {
            speed += 0.05;
         }
         if(!bigFrame)
         {
            if(releasedTicks > 30)
            {
               if(releasedTicks % 15 > 7)
               {
                  Bitmap(obj).bitmapData = shotTail[shotTail.length - 2];
               }
               else
               {
                  Bitmap(obj).bitmapData = shotTail[shotTail.length - 1];
               }
            }
            else
            {
               setFrameFromRange(releasedTicks,30,shotTail);
            }
         }
         else
         {
            helperAnimation.setFrame(bigFrameBitmapData);
            _loc1_ = helper.conditionallyCreateChild(Embeds.spider2_shot001_png,"Spider2",releasedTicks > 0,1);
            if(_loc1_)
            {
               _loc1_.basex = tformedX(0,32);
               _loc1_.basey = tformedY(0,32);
               _loc1_.baseHandleY = 0;
               _loc1_.baseRotation = baseRotation;
               _loc1_.additive = true;
               _loc2_ = Embeds.spider2shot;
               if(releasedTicks % 15 > 7)
               {
                  _loc1_.helperAnimation.setFrame(fr1);
               }
               else
               {
                  _loc1_.helperAnimation.setFrame(fr2);
               }
               _loc1_.baseHeight = Bitmap(_loc1_.obj).height;
            }
         }
         if(released)
         {
            ++releasedTicks;
         }
         if(distanceToTravel > 0)
         {
            if(distanceToPoint(startX,startY) > distanceToTravel)
            {
               kill();
            }
         }
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(released)
         {
            super.hasHitWall(param1,param2);
         }
      }
      
      override public function kill() : void
      {
         if(_killed)
         {
            return;
         }
         _killed = true;
         if(hasTarget || bigFrame)
         {
            doSplashDamage(100,1,false,true,canHitPlayer);
         }
         Sounds.rocketHit.play();
         emitConditionalParticles("RocketExplosion");
         super.kill();
      }
      
      override public function hitByShield() : void
      {
         kill();
      }
      
      override public function damage() : int
      {
         if(heavyDamage)
         {
            return super.damage() * 4;
         }
         return super.damage() * 2;
      }
   }
}

