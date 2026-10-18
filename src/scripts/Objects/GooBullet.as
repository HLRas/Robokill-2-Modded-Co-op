package Objects
{
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectBase.EnemyBulletBase;
   import ObjectConstructors.GooBullet_constructor;
   
   public class GooBullet extends EnemyBulletBase
   {
      
      public var startFrame:int = Math.random() * 4;
      
      public var flyingSpeed:Number = 1.5 + Math.random() * 2;
      
      public var landed:int = 0;
      
      public var landingTicks:int = 60 + 90 * Math.random();
      
      public function GooBullet(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,GooBullet_constructor.baseim_embed,GooBullet_constructor.LayerName,param2,param3);
         GooBullet_constructor.setup(param1,this);
         speedMult += Math.random() / 5;
      }
      
      override public function hitByShockwave() : void
      {
         super.hitByShockwave();
         landed = 0;
         ticks = 0;
         landingTicks = 20 + 30 * Math.random();
         changeZOrder("Player");
      }
      
      override public function _update() : void
      {
         var _loc1_:GameSoundChannel = null;
         var _loc2_:GameObject = null;
         var _loc3_:int = 0;
         additive = false;
         if(ticks > landingTicks)
         {
            if(landed == 1)
            {
               changeZOrder("Floor");
               _loc1_ = Sounds.splatter.play();
               if(_loc1_)
               {
                  _loc1_.setVolume(0.4);
               }
               for each(_loc2_ in gs.objects)
               {
                  if(_loc2_ is EnemyCrack)
                  {
                     if(distanceToObject(_loc2_) < 26)
                     {
                        helperFilter.fadeOff(50);
                     }
                  }
               }
            }
            ++landed;
         }
         if(landed)
         {
            speed = 0;
         }
         else
         {
            speed = flyingSpeed;
         }
         if(!landed)
         {
            setFrame(startFrame + ticks / landingTicks * (10 - startFrame));
         }
         else if(landed < 60)
         {
            setFrame(10 + landed / 6);
         }
         else
         {
            _loc3_ = (landed - 60) / 5 % 20;
            if(_loc3_ > 10)
            {
               _loc3_ = 20 - _loc3_;
            }
            setFrame(20 + _loc3_);
         }
         if(landed > 300)
         {
            baseScaleX -= 0.0333;
            baseScaleY -= 0.0333;
         }
         if(landed > 330)
         {
            remove();
         }
         super._update();
      }
      
      override public function canFall() : Boolean
      {
         return landed > 0;
      }
   }
}

