package Objects
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilterRotateSlowly;
   import GameScene.GameScene;
   import ObjectBase.EnemyBase;
   import ObjectBase.FlyingBotBase;
   import ObjectBase.TerranTurretBase;
   import ObjectConstructors.ReboundBot_constructor;
   import Particles.Particle;
   import flash.geom.Point;
   
   public class ReboundBot extends FlyingBotBase
   {
      
      public var charge:Number = 1;
      
      public function ReboundBot(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ReboundBot_constructor.baseim_embed,ReboundBot_constructor.LayerName,param2,param3);
         ReboundBot_constructor.setup(param1,this);
         addFilter(new GameObjectFilterRotateSlowly(2));
      }
      
      override public function _update() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Particle = null;
         var _loc3_:GameObject = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         super._update();
         charge += 0.01;
         if(target)
         {
            baseRotation = helper.angleToObject(target) + 90;
            _loc1_ = helper.vectorToObject(target);
            dx += _loc1_.x / 10;
            dy += _loc1_.y / 10;
            if(distanceToObject(target) < 50)
            {
               if(charge >= 1)
               {
                  _loc2_ = emitConditionalParticles("ShockwaveStun")[0];
                  if(_loc2_)
                  {
                     _loc2_.lockTo = this;
                  }
                  emitConditionalParticles("Sonic");
                  Sounds.shockwave.play();
                  for each(_loc3_ in gs.objects)
                  {
                     if(_loc3_ is EnemyBase)
                     {
                        if(distanceToObject(_loc3_) < 70)
                        {
                           if(EnemyBase(_loc3_).organic)
                           {
                              EnemyBase(_loc3_).stun();
                           }
                        }
                     }
                  }
                  charge = 0;
               }
               target = getTarget();
            }
         }
         else
         {
            _loc4_ = sind(randTicks / 2) * 100;
            _loc5_ = sind(randTicks / 2 + 135) * 100;
            hoverAroundPlayer(_loc4_,_loc5_);
         }
         dx *= 0.96;
         dy *= 0.96;
         basex += dx;
         basey += dy;
      }
      
      override public function getTarget() : EnemyBase
      {
         var _loc2_:EnemyBase = null;
         var _loc3_:GameObject = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         for each(_loc3_ in gs.objects)
         {
            _loc4_ = 0;
            if(_loc3_ != target)
            {
               if(_loc3_ is EnemyBase)
               {
                  if(_loc3_.ticks >= 20)
                  {
                     if(!(_loc3_ is TerranTurretBase))
                     {
                        if(EnemyBase(_loc3_).organic)
                        {
                           if(!EnemyBase(_loc3_).isTeleporting())
                           {
                              if(!EnemyBase(_loc3_).stunned)
                              {
                                 if(!EnemyBase(_loc3_).falling)
                                 {
                                    if(!(_loc3_ is EnemyCrack))
                                    {
                                       _loc4_ = EnemyBase(_loc3_).health;
                                       if(_loc3_ is Trooper)
                                       {
                                          if(Trooper(_loc3_).state == Trooper(_loc3_).stateInCover)
                                          {
                                             _loc4_ = 999999;
                                          }
                                       }
                                       if(_loc4_ > _loc1_)
                                       {
                                          _loc2_ = EnemyBase(_loc3_);
                                          _loc1_ = _loc4_;
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
   }
}

