package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BulletBase;
   import ObjectConstructors.ClusterGrenade_constructor;
   
   public class ClusterGrenade extends BulletBase
   {
      
      public var lastProg:Number = 0;
      
      public var charge:Number = 0;
      
      public var startX:Number = 0;
      
      public var destY:Number = 0;
      
      public var destX:Number = 0;
      
      public var startY:Number = 0;
      
      public function ClusterGrenade(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ClusterGrenade_constructor.baseim_embed,ClusterGrenade_constructor.LayerName,param2,param3);
         ClusterGrenade_constructor.setup(param1,this);
         collidesWithWalls = false;
         changeZOrder("AbovePlayer");
      }
      
      override public function kill() : void
      {
         var _loc2_:ClusterBomb = null;
         emitConditionalParticles("GasTankDestroy");
         Sounds.gasTankDestroy.play();
         var _loc1_:int = 0;
         // Online, a copy of the guest's grenade: the guest's bomblets (drift and fuse), which don't hit enemies
         // themselves (Net).
         var _loc3_:Array = vars["netBombs"];
         while(_loc3_ ? _loc1_ < _loc3_.length : _loc1_ < 10 * charge)
         {
            _loc2_ = new ClusterBomb(null,basex,basey);
            _loc2_.dx = (Math.random() - 0.5) * 2 * speed;
            _loc2_.dy = (Math.random() - 0.5) * 2 * speed;
            _loc2_.wep = wep;
            if(_loc3_)
            {
               _loc2_.dx = _loc3_[_loc1_][0];
               _loc2_.dy = _loc3_[_loc1_][1];
               _loc2_.killTime = _loc3_[_loc1_][2];
               _loc2_.vars["netKillTime"] = _loc3_[_loc1_][2];
               _loc2_.vars["netShot"] = true;
            }
            _loc1_++;
         }
         super.kill();
      }
      
      override public function _update() : void
      {
         super._update();
         var _loc1_:Number = destX - startX;
         var _loc2_:Number = destY - startY;
         var _loc3_:Number = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
         var _loc4_:Number = 1 - distanceToPoint(destX,destY) / _loc3_;
         if(lastProg > _loc4_)
         {
            kill();
         }
         lastProg = _loc4_;
         setFrame(_loc4_ * imageSet.length);
      }
      
      override public function collisionHeight() : Number
      {
         return 0;
      }
      
      override public function collisionWidth() : Number
      {
         return 0;
      }
   }
}

