package Objects
{
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterHeight;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.ClusterBomb_constructor;
   import flash.display.BitmapData;
   
   public class ClusterBomb extends BulletBase
   {
      
      public var flyAnim:Array;
      
      public var shadow:BitmapData;
      
      public var killTime:int = 0;
      
      public var heightFilter:GameObjectFilterHeight;
      
      public function ClusterBomb(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,ClusterBomb_constructor.baseim_embed,ClusterBomb_constructor.LayerName,param2,param3);
         ClusterBomb_constructor.setup(param1,this);
         collidesWithWalls = false;
         additive = true;
      }
      
      override public function kill() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:GameSoundChannel = null;
         if(ms.squareExists(basex,basey))
         {
            if(Math.random() < 0.5)
            {
               emitConditionalParticles("DestroyOnly");
            }
            else
            {
               emitConditionalParticles("Destroy2Only");
            }
            for each(_loc1_ in gs.objects)
            {
               if(_loc1_ is EnemyBase)
               {
                  // (Online, a copy of the guest's bomblet: the guest decides which enemies it hits; Net.)
                  if(distanceToObject(_loc1_) < 60 && !vars["netShot"])
                  {
                     EnemyBase(_loc1_).hitBy(null,wep.damage());
                  }
               }
               else if(_loc1_ is FloorProp)
               {
                  if(distanceToObject(_loc1_) < 60)
                  {
                     FloorProp(_loc1_).hasBeenHit(this);
                  }
               }
            }
            _loc2_ = Sounds.explosion.play();
            if(_loc2_)
            {
               _loc2_.setVolume(0.2);
            }
         }
         super.kill();
      }
      
      override public function _init() : void
      {
         heightFilter = new GameObjectFilterHeight(0);
         addFilter(heightFilter);
         doCollisions = false;
         killTime = 30 + Math.random() * 30;
         if(vars["netKillTime"])
         {
            killTime = vars["netKillTime"];
         }
         super._init();
      }
      
      override public function collisionWidth() : Number
      {
         return 0;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         if(!falling)
         {
            if(ticks > killTime)
            {
               kill();
            }
         }
         basex += dx;
         basey += dy;
         heightFilter.height = sind(180 * (ticks / killTime)) * 20;
         _loc1_ = helper.conditionallyCreateChild(Embeds.bomber_bomb_shadow_png,"Shadow",true,1);
         if(_loc1_)
         {
            _loc1_.basex = basex + heightFilter.height / 2;
            _loc1_.basey = basey + heightFilter.height / 2;
            _loc1_.changeZOrder("Floor",true);
         }
         var _loc2_:int = flyAnim.length * (1 - heightFilter.height / 20);
         helperAnimation.setFrame(flyAnim[0]);
         dx *= 0.97;
         dy *= 0.97;
      }
      
      override public function collisionHeight() : Number
      {
         return 0;
      }
   }
}

