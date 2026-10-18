package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.BatNest_constructor;
   import flash.display.BitmapData;
   
   public class BatNest extends EnemyBase
   {
      
      public var idleTicks:int = 0;
      
      public var spawningProgress:int = 0;
      
      public var spawning:Boolean = false;
      
      public var open:Array;
      
      public var creationMask:BitmapData;
      
      public var nextSpawning:int = 100 + Math.random() * 100;
      
      public var idle:Array;
      
      public function BatNest(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BatNest_constructor.baseim_embed,BatNest_constructor.LayerName,param2,param3);
         BatNest_constructor.setup(param1,this);
         baseHealth *= 30;
         pushable = false;
         collidesWithWalls = false;
      }
      
      override public function _experience() : int
      {
         return 100;
      }
      
      public function pingPong(param1:Number, param2:Number, param3:Number) : Number
      {
         param1 %= param2;
         if(param1 < param2 / 2)
         {
            return param3 * (param1 / (param2 / 2));
         }
         return param3 * (1 - (param1 - param2 / 2) / (param2 / 2));
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Wasp = null;
         var _loc7_:int = 0;
         super._update();
         var _loc1_:Boolean = false;
         if(spawning)
         {
            if(spawningProgress > 8 * 4)
            {
               if(spawningProgress < 200)
               {
                  _loc1_ = true;
               }
            }
         }
         _loc2_ = helper.conditionallyCreateChild(Embeds.hive_mask_png,"Mask",_loc1_,1,null,1);
         if(_loc2_)
         {
            _loc2_.changeZOrder("AbovePlayer");
            _loc2_.basex = basex;
            _loc2_.basey = basey;
            _loc2_.baseRotation = helperFilter.getModifiedRotation();
            _loc2_.baseScaleX = baseScaleX;
            _loc2_.baseScaleY = baseScaleY;
            _loc3_ = tintRed();
            _loc4_ = tintGreen();
            _loc5_ = tintBlue();
            if(hitTint())
            {
               _loc3_ += 1;
               _loc4_ += 1;
               _loc5_ += 1;
            }
            _loc2_.tint(_loc3_,_loc4_,_loc5_);
         }
         if(spawning)
         {
            idleTicks = 0;
            ++spawningProgress;
            if(spawningProgress < 8 * 4)
            {
               helperAnimation.setFrame(open[spawningProgress / 4]);
            }
            else if(spawningProgress > 200)
            {
               helperAnimation.setFrame(open[7 - (spawningProgress - 200) / 4]);
               if(spawningProgress >= 200 + 7 * 4)
               {
                  spawning = false;
               }
            }
            else if(spawningProgress % 20 == 0 && spawningProgress < 140)
            {
               _loc6_ = Wasp(spawn(Wasp,basex + (Math.random() - 0.5) * 4,basey,0));
               if(_loc6_)
               {
                  if(ms.currentEpisode >= 9)
                  {
                     if(spawningProgress == 100)
                     {
                        _loc6_.isHero = true;
                     }
                  }
                  _loc6_.baseRotation = 180 + baseRotation;
                  _loc6_.lockRotationRotation = _loc6_.baseRotation;
                  _loc6_.helperFilter.resetRotation();
                  _loc6_.lockRotation = 60;
               }
            }
         }
         else
         {
            ++idleTicks;
            _loc7_ = pingPong(idleTicks,200,idle.length);
            helperAnimation.setFrame(idle[_loc7_]);
            --nextSpawning;
            if(nextSpawning < 0 && _loc7_ == 0)
            {
               if(!tooManyToSpawn(Wasp,6))
               {
                  spawning = true;
                  spawningProgress = 0;
               }
               nextSpawning = 200 + Math.random() * 100;
            }
         }
      }
   }
}

