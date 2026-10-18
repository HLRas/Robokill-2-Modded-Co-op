package Objects
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameObject.GameObjectFilterHeight;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.BomberBomb_constructor;
   import flash.display.BitmapData;
   
   public class BomberBomb extends EnemyBase
   {
      
      public var killTime:int = 0;
      
      public var shadow:BitmapData;
      
      public var flyAnim:Array;
      
      public var lastBounced:int = 0;
      
      public var bounceCount:int = 0;
      
      public var height:Number = 15 + Math.random() * 10;
      
      public var killed:Boolean = false;
      
      public var heightFilter:GameObjectFilterHeight;
      
      public function BomberBomb(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BomberBomb_constructor.baseim_embed,BomberBomb_constructor.LayerName,param2,param3);
         BomberBomb_constructor.setup(param1,this);
         heightFilter = new GameObjectFilterHeight(0);
         addFilter(heightFilter);
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(ticks - lastBounced < 10)
         {
            return;
         }
         ++bounceCount;
         if(bounceCount > 1)
         {
            kill();
         }
         lastBounced = ticks;
         if(param2 != 0)
         {
            dx *= -1;
         }
         if(param1 != 0)
         {
            dy *= -1;
         }
      }
      
      override public function _experience() : int
      {
         return 0;
      }
      
      override public function killSound() : GameSound
      {
         return null;
      }
      
      override public function stunnable() : Boolean
      {
         return false;
      }
      
      override public function kill() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:GameSoundChannel = null;
         if(killed)
         {
            return;
         }
         if(ms.squareExists(basex,basey))
         {
            killed = true;
            if(Math.random() < 0.5)
            {
               emitConditionalParticles("DestroyOnly",0,0);
            }
            else
            {
               emitConditionalParticles("Destroy2Only",0,0);
            }
            if(distanceToPlayer() < 100)
            {
               ms.player.handleHit(this);
            }
            for each(_loc1_ in gs.objects)
            {
               if(_loc1_ is EnemyBase)
               {
                  if(!(_loc1_ is Bomber || _loc1_ is BomberBomb || _loc1_ is Egg))
                  {
                     if(distanceToObject(_loc1_) < 40)
                     {
                        EnemyBase(_loc1_).hitBy(null,5);
                     }
                  }
               }
               else if(_loc1_ is FloorProp)
               {
                  if(distanceToObject(_loc1_) < 40)
                  {
                     FloorProp(_loc1_).hasBeenHit(this);
                  }
               }
            }
            _loc2_ = Sounds.explosion.play();
            if(_loc2_)
            {
               _loc2_.setVolume(0.4);
            }
         }
         super.kill();
      }
      
      override public function growlSound() : GameSound
      {
         return null;
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
         heightFilter.height = sind(180 * (ticks / killTime)) * height;
         _loc1_ = helper.conditionallyCreateChild(Embeds.bomber_bomb_shadow_png,"Shadow",true,1);
         if(_loc1_)
         {
            _loc1_.basex = basex + heightFilter.height / 2;
            _loc1_.basey = basey + heightFilter.height / 2;
            _loc1_.changeZOrder("Floor",true);
         }
         var _loc2_:int = flyAnim.length * (1 - heightFilter.height / 20);
         helperAnimation.setFrame(flyAnim[_loc2_]);
         dx *= 0.97;
         dy *= 0.97;
         super._update();
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      override public function _init() : void
      {
         additive = true;
         doCollisions = false;
         baseHealth *= 4;
         bouncesOffSides = true;
         killTime = 100 + Math.random() * 50;
         collidesWithWalls = false;
         changeZOrder("AbovePlayer");
      }
      
      override public function collisionWidth() : Number
      {
         return 0;
      }
      
      override public function collisionHeight() : Number
      {
         return 0;
      }
   }
}

