package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.EggBase;
   import ObjectConstructors.Egg_constructor;
   import Tools.Random;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class Egg extends EggBase
   {
      
      public var spawned:Boolean = false;
      
      public var curFrame:int = Math.random() * 4;
      
      public var frameLimit:int = 4;
      
      public var images:Array;
      
      public var direction:int = 1;
      
      public function Egg(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Egg_constructor.baseim_embed,Egg_constructor.LayerName,param2,param3);
         Egg_constructor.setup(param1,this);
         collidesWithPlayer = true;
         pushWeight = 99999999;
         collisionFudge = 0.3;
         dist *= 0.5;
         collidesWithWalls = false;
      }
      
      override public function collisionHeight() : Number
      {
         return Bitmap(obj).bitmapData.height;
      }
      
      override public function kill() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:BomberBomb = null;
         var _loc4_:Number = NaN;
         var _loc5_:Point = null;
         var _loc6_:Number = NaN;
         var _loc7_:GooBullet = null;
         var _loc8_:BomberSmall = null;
         if(!spawned)
         {
            Sounds.splatter.play();
            spawned = true;
            _loc1_ = Random.randInt(3,4);
            if(animFrame == 0)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _loc3_ = BomberBomb(spawn(BomberBomb,basex,basey,0,true));
                  if(_loc3_)
                  {
                     if(lastHitBullet)
                     {
                        _loc4_ = lastHitBullet.baseRotation + (Math.random() - 0.5) * 90;
                        _loc5_ = helper.vectorForAngle(_loc4_);
                        _loc6_ = 5 + Math.random() * 3;
                        _loc3_.dx = _loc5_.x * _loc6_;
                        _loc3_.dy = _loc5_.y * _loc6_;
                     }
                     else
                     {
                        _loc3_.dx = (Math.random() - 0.5) * 15;
                        _loc3_.dy = (Math.random() - 0.5) * 15;
                     }
                  }
                  _loc2_++;
               }
            }
            else if(animFrame == 1)
            {
               _loc1_ = getGooCount();
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _loc7_ = new GooBullet(null,basex,basey);
                  _loc7_.landingTicks = 10 + Math.random() * 20;
                  _loc7_.baseRotation = Math.random() * 360;
                  _loc7_.angle = _loc7_.baseRotation;
                  _loc2_++;
               }
            }
            else if(animFrame == 2)
            {
               _loc1_ = Math.random() < 0.5 ? 1 : 2;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _loc8_ = BomberSmall(spawn(BomberSmall,basex,basey,0,true));
                  _loc2_++;
               }
            }
         }
         super.kill();
      }
      
      override public function _update() : void
      {
         super._update();
         var _loc1_:Array = Embeds.egg1;
         if(animFrame == 1)
         {
            _loc1_ = Embeds.egg2;
         }
         if(animFrame == 2)
         {
            _loc1_ = Embeds.egg3;
         }
         if(ticks % 10 == 0)
         {
            curFrame += direction;
            if(curFrame >= frameLimit)
            {
               curFrame = frameLimit;
               direction = -1;
            }
            if(curFrame <= 0)
            {
               curFrame = 0;
               direction = 1;
               frameLimit = Math.random() < 0.5 ? 4 : 3;
            }
         }
         helperAnimation.setFrame(_loc1_[curFrame]);
      }
      
      override public function _experience() : int
      {
         if(animFrame == 2)
         {
            return 80;
         }
         return 25;
      }
      
      override public function handlePlayerCollision() : void
      {
         kill();
         remove();
      }
      
      public function getGooCount() : int
      {
         var _loc2_:GameObject = null;
         var _loc1_:int = 0;
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is GooBullet)
            {
               _loc1_++;
            }
         }
         if(_loc1_ < 4)
         {
            return 4;
         }
         if(_loc1_ < 10)
         {
            return 3;
         }
         return 2;
      }
      
      override public function serializeFields() : Array
      {
         return ["basex","basey","health","toughness","animFrame"];
      }
      
      override public function collisionWidth() : Number
      {
         return Bitmap(obj).bitmapData.width;
      }
   }
}

