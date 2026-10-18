package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.TerranTurretBase;
   import ObjectConstructors.ScreamerTurret_constructor;
   
   public class ScreamerTurret extends TerranTurretBase
   {
      
      public function ScreamerTurret(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ScreamerTurret_constructor.baseim_embed,ScreamerTurret_constructor.LayerName,param2,param3);
         ScreamerTurret_constructor.setup(param1,this);
         baseHealth *= 20;
      }
      
      override public function _update() : void
      {
         super._update();
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.screamer_mount_png,"base",true,1);
         if(_loc1_)
         {
            _loc1_.changeZOrder(zOrderString,true);
         }
         if(!target)
         {
            if(randTicks % 200 == 0)
            {
               baseRotation = Math.random() * 360;
            }
         }
      }
      
      override public function handleShooting() : void
      {
         var _loc1_:BulletBase = null;
         if(randTicks % 400 < 40)
         {
            if(randTicks % 10 == 0)
            {
               _loc1_ = shoot(SpiderShot,randTicks % 400 / 10 * 5 - 10,-10,false);
               if(_loc1_)
               {
                  Sounds.rocketShoot.play();
                  _loc1_.angle += (Math.random() - 0.5) * 20;
                  SpiderShot(_loc1_).released = true;
                  SpiderShot(_loc1_).hasTarget = true;
                  SpiderShot(_loc1_).targetX = target.basex + (Math.random() - 0.5) * 30;
                  SpiderShot(_loc1_).targetY = target.basey + (Math.random() - 0.5) * 30;
                  SpiderShot(_loc1_).canHitPlayer = ms.currentLevel.angryTerranTurrets;
               }
            }
         }
      }
   }
}

