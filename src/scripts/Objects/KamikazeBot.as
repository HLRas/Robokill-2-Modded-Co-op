package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectBase.EnemyBase;
   import ObjectBase.FlyingBotBase;
   import ObjectBase.TerranTurretBase;
   import ObjectConstructors.KamikazeBot_constructor;
   import flash.geom.Point;
   
   public class KamikazeBot extends FlyingBotBase
   {
      
      public function KamikazeBot(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,KamikazeBot_constructor.baseim_embed,KamikazeBot_constructor.LayerName,param2,param3);
         KamikazeBot_constructor.setup(param1,this);
      }
      
      override public function _update() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         super._update();
         if(target)
         {
            baseRotation = helper.angleToObject(target) + 90;
            _loc1_ = helper.vectorToObject(target);
            dx += _loc1_.x / 5;
            dy += _loc1_.y / 5;
            if(distanceToObject(target) < 10)
            {
               doSplashDamage(100);
               Sounds.gasTankDestroy.play();
               remove();
            }
         }
         else
         {
            _loc2_ = sind(randTicks / 2) * 100;
            _loc3_ = sind(randTicks / 2 + 135) * 100;
            hoverAroundPlayer(_loc2_,_loc3_);
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
            if(_loc3_ is EnemyBase)
            {
               if(_loc3_.ticks >= 20)
               {
                  if(!EnemyBase(_loc3_).isTeleporting())
                  {
                     if(!EnemyBase(_loc3_).falling)
                     {
                        if(!(_loc3_ is EnemyCrack))
                        {
                           if(!(_loc3_ is TerranTurretBase))
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
         return _loc2_;
      }
   }
}

