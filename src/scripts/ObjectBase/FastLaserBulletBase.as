package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Objects.FloorProp;
   
   public class FastLaserBulletBase extends BulletBase
   {
      
      public var doneHit:Boolean = false;
      
      public var hitAny:Boolean = false;
      
      public var endx:Number = 0;
      
      public var endy:Number = 0;
      
      public function FastLaserBulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         changeZOrder("AbovePlayer");
      }
      
      override public function hasHit(param1:EnemyBase) : void
      {
         if(!doneHit)
         {
            emitConditionalParticles("FastLaserHit",basex,basey,true);
         }
         super.hasHit(param1);
         remove();
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         super._update();
         if(distanceToPoint(endx,endy) <= speed / 2)
         {
            basex = endx;
            basey = endy;
            doneHit = true;
            for each(_loc1_ in gs.objects)
            {
               // Online, a copy of the guest's shot: the guest decides which enemies it hits (Net).
               if(_loc1_ is EnemyBase && !vars["netShot"])
               {
                  if(_loc1_.distanceToPoint(endx,endy) < 20 + _loc1_.baseWidth)
                  {
                     EnemyBase(_loc1_).hitBy(this);
                     hitAny = true;
                  }
               }
               if(_loc1_ is FloorProp)
               {
                  if(_loc1_.distanceToPoint(endx,endy) < 30)
                  {
                     FloorProp(_loc1_).hasBeenHit(this);
                     hitAny = true;
                  }
               }
            }
            emitConditionalParticles("FastLaserHit",endx,endy,true);
            remove();
         }
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(!doneHit)
         {
            emitConditionalParticles("FastLaserHit",basex,basey,true);
         }
         super.hasHitWall(param1,param2,param3);
         remove();
      }
   }
}

