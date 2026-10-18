package Objects
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import ObjectBase.EnemyBulletBase;
   import ObjectConstructors.HoverTrooper_constructor;
   
   public class HoverTrooper extends EnemyBase
   {
      
      public var slowDown:int = 0;
      
      public var doSpiderShot:Boolean = false;
      
      public var nextSlowDown:int = Math.random() * 300;
      
      public var side:Boolean = false;
      
      public function HoverTrooper(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,HoverTrooper_constructor.baseim_embed,HoverTrooper_constructor.LayerName,param2,param3);
         HoverTrooper_constructor.setup(param1,this);
         baseHealth *= 80;
         extraHealth *= 80;
         inertia = 0.95;
         facePlayer = true;
         addFilter(new GameObjectFilterRotateSlowly(2));
         collidesWithWalls = false;
         doCollisions = false;
         organic = false;
         changeZOrder("AbovePlayer");
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
      
      override public function shrapnelCount() : int
      {
         return 3;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:BulletBase = null;
         var _loc3_:BulletBase = null;
         setFrame(pingPong(randTicks,50,6));
         _loc1_ = helper.conditionallyCreateChild(Embeds.hover_troop_shadow_png,"shadow",!beforeTeleporting(),1,null,baseAlpha * fallingAlpha());
         if(_loc1_)
         {
            _loc1_.basex = basex + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1);
            _loc1_.basey = basey + 40 * (0.9 + sind(ticks * 2 + 342) * 0.1);
            _loc1_.baseRotation = baseRotation;
            _loc1_.changeZOrder("Floor");
         }
         if(blockUpdating())
         {
            super._update();
            return;
         }
         super._update();
         nextSlowDown = nextSlowDown - 1;
         if(nextSlowDown < 0)
         {
            nextSlowDown = 400 + Math.random() * 300;
            slowDown = 1;
            doSpiderShot = Math.random() < 0.5 ? true : false;
         }
         if(slowDown > 0)
         {
            slowDown += 1;
            if(slowDown < 50)
            {
               moveRandomly(0.2 + 2 - 2 * Number(slowDown) / 50,50);
            }
            else if(slowDown > 150)
            {
               moveRandomly(0.2 + 2 * Number(150 - slowDown) / 50,50);
            }
            else
            {
               moveRandomly(0.2,50);
            }
            if(slowDown > 50 && slowDown < 150)
            {
               if(ticks % 10 == 0)
               {
                  side = !side;
                  if(doSpiderShot)
                  {
                     if(ticks % 30 == 0)
                     {
                        _loc2_ = shootMissile(side ? -14 : 14,-18);
                        if(_loc2_)
                        {
                           _loc2_.noCollideTicks = 100;
                           EnemyBulletBase(_loc2_).damageMult = EnemyBulletBase(_loc2_).damageMult * 5;
                        }
                     }
                  }
                  else
                  {
                     _loc3_ = shootBullet(side ? -14 : 14,-18);
                     if(_loc3_)
                     {
                        _loc3_.noCollideTicks = 100;
                     }
                  }
               }
            }
            if(slowDown > 200)
            {
               slowDown = 0;
            }
         }
         else
         {
            moveRandomly(2,50);
         }
      }
      
      override public function _experience() : int
      {
         return 300;
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      public function pingPong(param1:Number, param2:Number, param3:Number) : Number
      {
         param1 %= param2;
         if(param1 < param2 / 2)
         {
            return param3 * (param1 / (param2 / 2));
         }
         return param3 * (1 - (param1 - param2 / 2) / (param2 / 2));
      }
      
      override public function canMoveOnLand() : Boolean
      {
         return true;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.explosion;
      }
      
      override public function getFireSound() : GameSound
      {
         return Sounds.bigHoverFire;
      }
      
      override public function collidesWithAnything() : Boolean
      {
         return false;
      }
   }
}

