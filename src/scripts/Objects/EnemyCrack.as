package Objects
{
   import Audio.GameSound;
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.EnemyCrack_constructor;
   import Scenes.MainScene;
   import Tools.PathfindSquare;
   
   public class EnemyCrack extends EnemyBase
   {
      
      public var spawnProgress:int = 0;
      
      public var spawnGoo:Class = null;
      
      public var canCrack:Boolean = true;
      
      public var cracked:Boolean = false;
      
      public var collisionProp:FloorProp = null;
      
      public function EnemyCrack(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,EnemyCrack_constructor.baseim_embed,EnemyCrack_constructor.LayerName,param2,param3);
         EnemyCrack_constructor.setup(param1,this);
         pushable = false;
         collidesWithWalls = false;
         tintBasedOnPosition = true;
         setsImpassable = true;
      }
      
      override public function serializeFields() : Array
      {
         return ["basex","basey","health","toughness","cracked","spawnProgress","spawnGoo"];
      }
      
      public function crack(param1:Boolean = false) : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(MainScene(gs).hasCommWindow())
         {
            return;
         }
         if(ms.player.isTeleporting())
         {
            return;
         }
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is FloorProp)
            {
               if(distanceToObject(_loc2_) < 12)
               {
                  if(!_loc2_._removed)
                  {
                     return;
                  }
               }
            }
         }
         _loc3_ = logicalSquareX();
         _loc4_ = logicalSquareY();
         if(!(ms.logicalSquarePassable(_loc3_ - 1,_loc4_) || ms.logicalSquarePassable(_loc3_ + 1,_loc4_) || ms.logicalSquarePassable(_loc3_,_loc4_ - 1) || ms.logicalSquarePassable(_loc3_,_loc4_ + 1)))
         {
            return;
         }
         canCrack = true;
         if(!cracked)
         {
            if(MainScene(gs).currentLevel.ambushRoom)
            {
               if(!MainScene(gs).currentLevel.expediateAmbush())
               {
                  return;
               }
               param1 = true;
            }
            cracked = true;
            Sounds.crumble.play();
            ms.getSquare(basex,basey).passable = false;
            ms.currentLevel.enragedBugs = true;
         }
      }
      
      override public function hitBy(param1:BulletBase, param2:int = 0) : void
      {
         crack();
      }
      
      override public function stunnable() : Boolean
      {
         return false;
      }
      
      override public function tintGreen() : Number
      {
         return tintPositionG;
      }
      
      override public function tintRed() : Number
      {
         return tintPositionR;
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
      
      override public function killSound() : GameSound
      {
         return null;
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:GooTurret = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:EnemyBase = null;
         var _loc13_:PathfindSquare = null;
         if(ticks == 1)
         {
            for each(_loc2_ in gs.objects)
            {
               if(_loc2_ is GooTurret)
               {
                  if(distanceToObject(_loc2_) < 20)
                  {
                     if(_loc2_ is GooTurretSpawn)
                     {
                        spawnGoo = GooTurretSpawn;
                     }
                     else
                     {
                        spawnGoo = GooTurret;
                     }
                     _loc2_.remove();
                  }
               }
            }
         }
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.floor_burst_edge_png,"burst",cracked,0.05);
         if(_loc1_)
         {
            _loc1_.basex = basex;
            _loc1_.basey = basey;
         }
         if(canCrack)
         {
            if(spawnProgress > 0 && !collisionProp)
            {
               collisionProp = new FloorProp(gs,basex,basey);
               collisionProp.baseAlpha = 0;
               collisionProp.animFrame = 5;
               collisionProp.setFrame(5);
               collisionProp.collidesWithBullets = false;
               collisionProp.temporary = true;
               MainScene(gs).setPassable(logicalSquareX(),logicalSquareY(),false);
            }
         }
         if(!cracked)
         {
            if(canCrack)
            {
               if(distanceToPlayer() < 150)
               {
                  crack();
               }
            }
         }
         else
         {
            _loc3_ = 4 + 2 * MainScene(gs).currentEpisode;
            _loc4_ = 0;
            while(_loc3_ > 8)
            {
               _loc3_ /= 2;
               _loc4_++;
            }
            setFrame(spawnProgress / 5);
            ++spawnProgress;
            if(spawnProgress == 50)
            {
               trapEffect();
            }
            if(spawnProgress == 100)
            {
               if(spawnGoo)
               {
                  _loc5_ = GooTurret(spawn(spawnGoo,basex,basey,0));
                  if(_loc5_)
                  {
                     _loc5_.growlSound().play();
                  }
                  spawnGoo = null;
               }
            }
            if(spawnProgress >= 100 && spawnProgress <= 100 + 10 * _loc3_ && spawnProgress % 10 == 0)
            {
               _loc6_ = basex;
               _loc7_ = basey;
               _loc8_ = 0;
               _loc9_ = 0;
               _loc10_ = 0;
               _loc11_ = 0;
               while(_loc11_ < 100)
               {
                  if(Math.random() < 0.5)
                  {
                     _loc9_ = 0;
                     _loc10_ = Math.random() < 0.5 ? -1 : 1;
                  }
                  else
                  {
                     _loc9_ = Math.random() < 0.5 ? -1 : 1;
                     _loc10_ = 0;
                  }
                  _loc13_ = ms.toPlayer.getField(logicalSquareX() + _loc9_,logicalSquareY() + _loc10_);
                  if(_loc13_)
                  {
                     if(!(_loc13_.dirx == 0 && _loc13_.diry == 0))
                     {
                        if(ms.logicalSquarePassable(logicalSquareX() + _loc9_,logicalSquareY() + _loc10_))
                        {
                           break;
                        }
                     }
                  }
                  _loc11_++;
               }
               if(_loc9_ == 0)
               {
                  _loc6_ += (Math.random() - 0.5) * 52 * 0.8;
                  if(_loc10_ == -1)
                  {
                     _loc7_ += -26;
                     _loc8_ = 0;
                  }
                  else
                  {
                     _loc7_ += 26;
                     _loc8_ = 180;
                  }
               }
               else
               {
                  _loc7_ += (Math.random() - 0.5) * 52 * 0.8;
                  if(_loc9_ == -1)
                  {
                     _loc6_ += -26;
                     _loc8_ = 270;
                  }
                  else
                  {
                     _loc6_ += 26;
                     _loc8_ = 90;
                  }
               }
               _loc12_ = spawn(Critter,_loc6_,_loc7_,_loc4_);
               if(_loc12_)
               {
                  Critter(_loc12_).rotationLock = _loc8_;
                  Critter(_loc12_).outOfTrap = true;
               }
            }
         }
         super._update();
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      override public function _init() : void
      {
         doCollisions = false;
         super._init();
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
      
      override public function collisionWidth() : Number
      {
         return 0;
      }
      
      override public function collisionHeight() : Number
      {
         return 0;
      }
      
      override public function tintBlue() : Number
      {
         return tintPositionB;
      }
   }
}

