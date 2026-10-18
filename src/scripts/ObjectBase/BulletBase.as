package ObjectBase
{
   import Audio.GameSoundChannel;
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Scenes.MainMenu;
   import Scenes.MainScene;
   import Tools.Interpolation;
   import Weapons.WeaponBase;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class BulletBase extends GameObjectBase
   {
      
      public var keep:Boolean = false;
      
      public var speed:Number = 7;
      
      public var hitList:Object = new Object();
      
      public var angle:Number;
      
      public var mediumSprite:BitmapData;
      
      public var source:GameObject;
      
      public var bounced:Boolean = false;
      
      public var lastHit:GameObject;
      
      public var wep:WeaponBase;
      
      public var canHitPlayer:Boolean = true;
      
      public var heavySprite:BitmapData;
      
      public var noCollideTicks:int = 0;
      
      public function BulletBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,"Floor",param4,param5);
         Bitmap(obj).smoothing = false;
         obj.cacheAsBitmap = true;
      }
      
      public function hits(param1:EnemyBase) : Boolean
      {
         return Math.abs(basex - param1.basex) < param1.collisionWidth() / 2 && Math.abs(basey - param1.basey) < param1.collisionHeight() / 2;
      }
      
      override public function hasHitWall(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         removeWithEffects();
      }
      
      public function hasHit(param1:EnemyBase) : void
      {
         keep = false;
         if(wep)
         {
            wep.handleHit(this,param1);
         }
         else
         {
            param1.hitBy(null,5);
         }
         if(!keep)
         {
            if(param1.organic)
            {
               Sounds.fleshHit.play();
            }
            else
            {
               Sounds.objectHit.play();
            }
            remove();
         }
      }
      
      public function setAngle(param1:Number) : void
      {
         angle = param1;
         baseRotation = angle;
      }
      
      override public function _update() : void
      {
         var _loc2_:MainScene = null;
         var _loc3_:GameObject = null;
         if(noCollideTicks > 0)
         {
            --noCollideTicks;
            collidesWithWalls = false;
         }
         else
         {
            collidesWithWalls = true;
         }
         super._update();
         var _loc1_:Number = speed;
         if(this is EnemyBulletBase)
         {
            if(_loc2_)
            {
               _loc1_ *= _loc2_.globalSpeed;
            }
         }
         basex += cosd(angle - 90) * _loc1_;
         basey += sind(angle - 90) * _loc1_;
         baseRotation = angle;
         Bitmap(obj).smoothing = true;
         Bitmap(obj).cacheAsBitmap = true;
         _loc2_ = MainScene(gs);
         if(basex < _loc2_.startx + 10)
         {
            hasHitWall(-1,0,true);
         }
         else if(basex > _loc2_.endx - 10)
         {
            hasHitWall(1,0,true);
         }
         else if(basey < _loc2_.starty + 10)
         {
            hasHitWall(0,-1,true);
         }
         else if(basey > _loc2_.endy - 10)
         {
            hasHitWall(0,1,true);
         }
         if(source is PlayerBase || source is TerranTurretBase)
         {
            for each(_loc3_ in gs.objects)
            {
               if(_loc3_ is EnemyBase)
               {
                  if(!(_loc3_ is TerranTurretBase && source is TerranTurretBase))
                  {
                     if(!EnemyBase(_loc3_).falling)
                     {
                        if(!EnemyBase(_loc3_).isTeleporting())
                        {
                           if(hits(EnemyBase(_loc3_)))
                           {
                              lastHit = _loc3_;
                              EnemyBase(_loc3_).hitBy(this);
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      public function damage() : int
      {
         var _loc1_:Number = MainScene(gs).player.getDamageForLevel() / MainScene(gs).resistanceForLevel();
         return wep.damage() * _loc1_;
      }
      
      public function hitByShield() : void
      {
         if(bounced)
         {
            return;
         }
         bounced = true;
         if(Math.random() < 0.5)
         {
            angle += 180 + 20 + Math.random() * 20;
         }
         else
         {
            angle += 180 - 20 - Math.random() * 20;
         }
         baseRotation = angle;
      }
      
      public function removeWithEffects() : void
      {
         var _loc1_:GameSoundChannel = Sounds.wallHit.play();
         if(_loc1_)
         {
            _loc1_.setVolume(Interpolation.linearInterpolateLock(1,0.2,distanceToPlayer() / 800));
         }
         if(!(lastHit is EnemyBase))
         {
            if(MainMenu.levelOfDetail)
            {
               emitConditionalParticles("EnemyHit",basex,basey,true);
            }
         }
         kill();
         remove();
      }
   }
}

