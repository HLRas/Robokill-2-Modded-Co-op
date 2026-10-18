package Scenes
{
   import Audio.*;
   import GameLevels.*;
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import InventoryScreen.*;
   import Layout.*;
   import LevelGridTools.LevelGrid;
   import Levels.*;
   import MapDisplay.*;
   import Misc.EnemyLeveling;
   import Misc.SortFloorProps;
   import Misc.SpawnPoints;
   import ObjectBase.*;
   import ObjectConstructors.*;
   import Objects.*;
   import Particles.*;
   import SceneConstructors.*;
   import Serialization.Profile;
   import Serialization.SerializedObject;
   import Templates.RewardText;
   import Tools.*;
   import flash.display.*;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.utils.*;
   
   public class MainScene extends GameScene
   {
      
      public static var doorWidth:int = 30;
      
      public static var edge:int = 0;
      
      public var nofloorstartx:int;
      
      public var _setFinishSequence:Boolean = false;
      
      public var nofloorstarty:int;
      
      public var floor:GameObject;
      
      public var memoizeCountKeysTicks:int = -1;
      
      public var lazyEnemiesCount:int = 0;
      
      public var fadingLevelComplete:Boolean = false;
      
      public var removeWhenFaded:Array = new Array();
      
      public var fadeOverlay:GameObject;
      
      public var fading:int = 0;
      
      public var toPlayer:PathfindToPoint = new PathfindToPoint(20,15);
      
      public var memoizedEnemyCountTicks:int = -1;
      
      public var spawnPoints:SpawnPoints = new SpawnPoints();
      
      public var currentEpisode:int = 0;
      
      public var messageQueue:Array = null;
      
      public var deathSequence:int = 0;
      
      public var startx:int;
      
      public var starty:int;
      
      public var globalSpeed:Number = 0;
      
      public var nofloorendx:int;
      
      public var fadeTime:int = 15;
      
      public var nofloorendy:int;
      
      public var menuButton:GameObject;
      
      public var currentLevel:GameLevel;
      
      public var fadingLatch:Boolean = false;
      
      public var completedProgress:Number = 0;
      
      public var floorMarks:Array = new Array();
      
      public var wallstartx:int = 32;
      
      public var wallstarty:int = 32;
      
      public var el:EnemyLeveling = new EnemyLeveling();
      
      public var mapButton:GameObject;
      
      public var inventoryButton:GameObject;
      
      public var wallendx:int = 768;
      
      public var wallendy:int = 568;
      
      public var memoizedEnemyCount:int = 0;
      
      public var queuedCost:int = 0;
      
      public var memoizeCountKeys:int = 0;
      
      public var lastShieldLargeDrop:int = 0;
      
      public var oldGridY:int;
      
      public var player:PlayerBase;

      // Co-op player 2 (null until someone joins on a controller).
      public var player2:PlayerBase;

      public var primaryPlayer:PlayerBase;

      public var p2Hint:GameObject;

      public var p2HintText:String = "";

      public var p2DownShown:Boolean = false;

      public var p2DownTicks:int = 0;

      public var p1DownShown:Boolean = false;

      public var p1DownTicks:int = 0;
      
      public var oldGridX:int;
      
      public var oldlx:int = 0;
      
      public var oldly:int = 0;
      
      public var hud:HUDBase;
      
      public var partialFinishCount:int = 0;
      
      public var endx:int;
      
      public var endy:int;
      
      public function MainScene()
      {
         super();
         floor = new GameObject(this,Embeds.floor_base_jpg,"",400,300);
      }
      
      public static function getSquareX(param1:int) : Number
      {
         return param1 * 52 + 10 + 26;
      }
      
      public static function getSquareY(param1:int) : Number
      {
         return param1 * 52 + 14 + 26;
      }
      
      public static function getLogicalSquareX(param1:Number) : int
      {
         var _loc2_:Number = param1 - 10;
         var _loc3_:int = int(Math.floor(_loc2_ / 52));
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 800 / 52)
         {
            _loc3_ = 800 / 52;
         }
         return _loc3_;
      }
      
      public static function getLogicalSquareY(param1:Number) : int
      {
         var _loc2_:Number = param1 - 14;
         var _loc3_:int = int(Math.floor(_loc2_ / 52));
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 600 / 52)
         {
            _loc3_ = 600 / 52;
         }
         return _loc3_;
      }
      
      public function applyToFloor(param1:Array) : *
      {
         var _loc3_:Array = null;
         floorMarks = param1[0];
         var _loc2_:int = 0;
         while(_loc2_ < floorMarks.length)
         {
            _loc3_ = floorMarks[_loc2_];
            floor.drawToImage(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],BlendMode.NORMAL,new Rectangle(nofloorstartx,nofloorstarty,nofloorendx - nofloorstartx,nofloorendy - nofloorstarty),[_loc3_[6],_loc3_[7],_loc3_[8],1]);
            _loc2_++;
         }
      }
      
      override public function particleKilledCallback(param1:Particle) : void
      {
         if(param1.StayAfterDeath)
         {
            markFloor(param1.b.bitmapData,param1.b.x,param1.b.y,param1.Rotation,param1.xscale,param1.yscale,param1.red,param1.green,param1.blue);
         }
      }
      
      public function _getLogicalSquareY(param1:Number) : int
      {
         var _loc2_:Number = param1 - 14;
         var _loc3_:int = int(Math.floor(_loc2_ / 52));
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 600 / 52)
         {
            _loc3_ = 600 / 52;
         }
         return _loc3_;
      }
      
      public function regenerateGrid(param1:int, param2:int) : void
      {
         player.lg.setCellData(param1,param2,"Explored",null);
         player.lg.setCellData(param1,param2,"Regenerate",true);
         if(spawnPoints.contains(param1,param2))
         {
            spawnPoints.removePoint(param1,param2);
         }
      }
      
      public function setGlow(param1:GameObject, param2:Boolean = false) : void
      {
         if(param2)
         {
            if(param1.obj.filters.length < 1)
            {
               param1.obj.filters = [new GlowFilter(16777215)];
            }
         }
         else if(param1.obj.filters.length > 0)
         {
            param1.obj.filters = [];
         }
      }
      
      public function resetPlayer() : void
      {
         var _loc1_:LevelGrid = player.lg;
         var _loc2_:PlayerBase = player;
         player = new Player(this,400,300);
         player.lg = _loc1_;
         player.keyCount = _loc2_.keyCount;
         player.keyTypes = _loc2_.keyTypes;
         player.level = _loc2_.level;
         player.experience = _loc2_.experience;
         player.money = _loc2_.money;
         player.totalKills = _loc2_.totalKills;
         player.weapons = _loc2_.weapons;
         player.inventory = _loc2_.inventory;
         player.items = _loc2_.items;
         player.chargeHelp = _loc2_.chargeHelp;
         player.activeHelp = _loc2_.activeHelp;
         player.shopHelp = _loc2_.shopHelp;
         player.mapHelp = _loc2_.mapHelp;
         player.inventoryHelp = _loc2_.inventoryHelp;
         player.roomsExplored = _loc2_.roomsExplored;
         player.expediatedDrop = _loc2_.expediatedDrop;
         if(player2)
         {
            player2.partner = player;
         }
      }

      // While an object updates, "player" is the living player nearest to it, so enemies,
      // bullets and pickups deal with whichever robot is closest. Outside the object loop it is player 1.
      override public function beginObjectUpdates() : void
      {
         primaryPlayer = player;
      }

      override public function objectUpdating(param1:GameObject) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!primaryPlayer)
         {
            return;
         }
         if(param1 is PlayerBase)
         {
            player = PlayerBase(param1);
            return;
         }
         player = primaryPlayer;
         if(param1 is GameObjectBase && player2 && !player2._removed)
         {
            if(primaryPlayer._removed)
            {
               player = player2;
               return;
            }
            _loc2_ = (param1.basex - primaryPlayer.basex) * (param1.basex - primaryPlayer.basex) + (param1.basey - primaryPlayer.basey) * (param1.basey - primaryPlayer.basey);
            _loc3_ = (param1.basex - player2.basex) * (param1.basex - player2.basex) + (param1.basey - player2.basey) * (param1.basey - player2.basey);
            if(_loc3_ < _loc2_)
            {
               player = player2;
            }
         }
      }

      override public function endObjectUpdates() : void
      {
         if(primaryPlayer)
         {
            player = primaryPlayer;
            primaryPlayer = null;
         }
      }

      public function enemyTouchesPlayer(param1:EnemyBase, param2:PlayerBase) : void
      {
         var _loc3_:PlayerBase = player;
         player = param2;
         param1.handlePlayerCollision();
         player = _loc3_;
      }

      public function spawnPlayer2() : void
      {
         PlayerBase.pendingPartner = player;
         player2 = new Player(this,player.basex,player.basey);
         placePlayer2();
         p2DownShown = false;
         Input.i.coopEnabled = true;
         Input.i.p2Present = true;
         RewardText.createRewardText(this,400,300,"PLAYER 2 JOINED","TextLayer",Input.P2_COLOR,1,0,100);
      }

      // Puts player 2 just inside the room, next to player 1.
      public function placePlayer2() : void
      {
         if(!player2 || player2._removed)
         {
            return;
         }
         player2.partner = player;
         var _loc1_:Number = player.basex;
         var _loc2_:Number = player.basey;
         if(_loc2_ <= 80)
         {
            _loc2_ += 45;
         }
         else if(_loc2_ >= 520)
         {
            _loc2_ -= 45;
         }
         else if(_loc1_ >= 720)
         {
            _loc1_ -= 45;
         }
         else
         {
            _loc1_ += 45;
         }
         _loc1_ = Interpolation.lockValue(_loc1_,60,740);
         _loc2_ = Interpolation.lockValue(_loc2_,60,540);
         if(!spotIsSafe(_loc1_,_loc2_))
         {
            moveToSafeSpot(player2,player);
            return;
         }
         setPlayerPos(player2,_loc1_,_loc2_);
      }

      public function setPlayerPos(param1:PlayerBase, param2:Number, param3:Number) : void
      {
         param1.basex = param2;
         param1.basey = param3;
         param1.lastX = param2;
         param1.lastY = param3;
         param1.dx = 0;
         param1.dy = 0;
         param1.extradx = 0;
         param1.extrady = 0;
      }

      // A robot-sized spot whose floor exists everywhere under it, with nothing in the way.
      public function spotIsSafe(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PathfindSquare = null;
         var _loc6_:GameObject = null;
         if(param1 < startx + 40 || param1 > endx - 40 || param2 < starty + 40 || param2 > endy - 40)
         {
            return false;
         }
         _loc3_ = -1;
         while(_loc3_ <= 1)
         {
            _loc4_ = -1;
            while(_loc4_ <= 1)
            {
               _loc5_ = toPlayer.getField(_getLogicalSquareX(param1 + _loc3_ * 20),_getLogicalSquareY(param2 + _loc4_ * 20));
               if(!_loc5_ || !_loc5_.exists || !_loc5_.passable)
               {
                  return false;
               }
               _loc4_ += 1;
            }
            _loc3_ += 1;
         }
         for each(_loc6_ in objects)
         {
            if(_loc6_ is FallingTileBase || _loc6_ is HazardBase)
            {
               if(Math.abs(_loc6_.basex - param1) < 52 && Math.abs(_loc6_.basey - param2) < 52)
               {
                  return false;
               }
            }
         }
         return true;
      }

      // Puts a robot on the nearest safe spot around another one (or on top of it if nothing else fits).
      public function moveToSafeSpot(param1:PlayerBase, param2:PlayerBase) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Array = [45,60,80,105,135,170,210,260,320];
         _loc3_ = 0;
         while(_loc3_ < _loc7_.length)
         {
            _loc4_ = 0;
            while(_loc4_ < 16)
            {
               _loc5_ = param2.basex + Math.cos(_loc4_ * Math.PI / 8) * _loc7_[_loc3_];
               _loc6_ = param2.basey + Math.sin(_loc4_ * Math.PI / 8) * _loc7_[_loc3_];
               if(spotIsSafe(_loc5_,_loc6_))
               {
                  setPlayerPos(param1,_loc5_,_loc6_);
                  return;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         setPlayerPos(param1,param2.basex,param2.basey);
      }

      // Player 2 comes back (no button needed) next to player 1.
      public function revivePlayer2() : void
      {
         PlayerBase.pendingPartner = player;
         player2 = new Player(this,player.basex,player.basey);
         placePlayer2();
         p2DownShown = false;
         p2DownTicks = 0;
      }

      // Player 1 comes back next to player 2 without the usual death penalty or checkpoint reset.
      public function revivePlayer1() : void
      {
         var _loc1_:PlayerBase = player;
         var _loc2_:GameObject = null;
         for each(_loc2_ in [_loc1_.hudKeys,_loc1_.shieldObject,_loc1_.xpObject,_loc1_.cashBacking,_loc1_.levelBacking,_loc1_.cashText,_loc1_.levelText])
         {
            if(_loc2_)
            {
               if(removeWhenFaded.indexOf(_loc2_) >= 0)
               {
                  removeWhenFaded.splice(removeWhenFaded.indexOf(_loc2_),1);
               }
               _loc2_.remove();
            }
         }
         resetPlayer();
         player.gridx = _loc1_.gridx;
         player.gridy = _loc1_.gridy;
         player.queuedExperience = _loc1_.queuedExperience;
         player.teleportHelp = _loc1_.teleportHelp;
         player.edgeWarning = _loc1_.edgeWarning;
         player.destBaseX = _loc1_.destBaseX;
         player.destBaseY = _loc1_.destBaseY;
         player.seekSpawnPoint = false;
         player.seekLift = false;
         moveToSafeSpot(player,player2);
         p1DownShown = false;
         p1DownTicks = 0;
      }

      // Player 2 held START to leave: back to single player (a lone controller goes back to player 1).
      public function removePlayer2() : void
      {
         if(!player2._removed)
         {
            player2.leaveGame();
         }
         player2 = null;
         p2DownShown = false;
         Input.i.coopEnabled = false;
         Input.i.p2Present = false;
         Input.i.p2Active = false;
         RewardText.createRewardText(this,400,300,"PLAYER 2 LEFT - CO-OP OFF","TextLayer",Input.P2_COLOR,1,0,100);
      }

      public function roomClearForRespawn() : Boolean
      {
         return countEnemies() == 0 && fading == 0 && !_setFinishSequence;
      }

      public function updatePlayer2() : void
      {
         var _loc4_:Number = NaN;
         if(Input.i.p2LeaveHit() && player2)
         {
            removePlayer2();
         }
         var _loc1_:Boolean = Boolean(player2) && !player2._removed;
         Input.i.p2Active = _loc1_;
         Input.i.p2Present = player2 != null;
         if(player2 && player2._removed)
         {
            if(!p2DownShown)
            {
               p2DownShown = true;
               p2DownTicks = 0;
               if(!player._removed)
               {
                  RewardText.createRewardText(this,400,300,"PLAYER 2 DOWN - BACK WHEN THE ROOM IS CLEAR","TextLayer",Input.P2_COLOR,1,0,150);
               }
            }
            ++p2DownTicks;
            if(!player._removed && p2DownTicks > 60 && roomClearForRespawn())
            {
               revivePlayer2();
               _loc1_ = true;
            }
         }
         if(player._removed && _loc1_)
         {
            if(!p1DownShown)
            {
               p1DownShown = true;
               p1DownTicks = 0;
               RewardText.createRewardText(this,400,300,"PLAYER 1 DOWN - BACK WHEN THE ROOM IS CLEAR","TextLayer",-1,1,0,150);
            }
            ++p1DownTicks;
            if(p1DownTicks > 60 && roomClearForRespawn())
            {
               revivePlayer1();
            }
         }
         else if(!player._removed)
         {
            p1DownShown = false;
         }
         var _loc2_:Boolean = Input.i.hasJoinPad() && !player2 && !player._removed && !_setFinishSequence && !hasCommWindow();
         if(Input.i.p2JoinHit() && _loc2_ && fading == 0)
         {
            spawnPlayer2();
            _loc2_ = false;
         }
         // With two controllers, remind player 2 how to join; with one, the controller just plays player 1.
         var _loc3_:String = _loc2_ && Input.i.padCount() >= 2 ? "P2: HOLD START TO JOIN" : "";
         _loc4_ = Input.i.holdProgress();
         if(_loc4_ > 0.1 && (Input.i.holdAction() == "leave" ? Boolean(player2) : _loc2_))
         {
            _loc3_ = (Input.i.holdAction() == "leave" ? "HOLD START: LEAVING CO-OP IN " : "HOLD START: CO-OP IN ") + Math.ceil((1 - _loc4_) * Input.holdMs / 1000);
         }
         if(_loc3_ != p2HintText)
         {
            p2HintText = _loc3_;
            if(p2Hint)
            {
               p2Hint.remove();
               p2Hint = null;
            }
            if(_loc3_ != "")
            {
               p2Hint = new GameObject(this,null,"TextLayer",0,0);
               p2Hint.fontName = "Pixelation-34";
               p2Hint.setText(_loc3_,7,Input.P2_COLOR);
               p2Hint.basex = 313;
               p2Hint.basey = 2;
               p2Hint.baseHandleX = 0;
            }
         }
         if(p2Hint)
         {
            p2Hint.baseAlpha = Ticks % 60 < 40 ? 1 : 0.4;
         }
      }
      
      override public function _register(param1:Sprite) : void
      {
         var _loc2_:MainScene_constructor = new MainScene_constructor();
         _loc2_.register(this,param1,true);
      }
      
      public function getSquare(param1:Number, param2:Number) : PathfindSquare
      {
         var _loc3_:int = getLogicalSquareX(param1);
         var _loc4_:int = getLogicalSquareY(param2);
         return toPlayer.getField(_loc3_,_loc4_);
      }
      
      public function countBlockingObjects() : int
      {
         var _loc2_:GameObject = null;
         var _loc1_:int = 0;
         for each(_loc2_ in objects)
         {
            if(_loc2_ is GameObjectBase)
            {
               if(GameObjectBase(_loc2_).preventMissionComplete > 0)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function assignDifficultyToOne(param1:Class, param2:int) : void
      {
         var _loc3_:Array = getGroup(param1);
         if(_loc3_.length > 0)
         {
            _loc3_[Random.randInt(0,_loc3_.length - 1)].setupDifficulty(param2);
         }
      }
      
      public function countEnemies(param1:Boolean = true) : int
      {
         var _loc3_:GameObject = null;
         var _loc2_:int = 0;
         if(memoizedEnemyCountTicks != Ticks)
         {
            for each(_loc3_ in objects)
            {
               if(_loc3_ is EnemyBase)
               {
                  if(_loc3_ is Brute)
                  {
                     if(Brute(_loc3_).state == Brute(_loc3_).stateClimbingWait)
                     {
                        continue;
                     }
                  }
                  if(_loc3_ is EnemyCrack)
                  {
                     if(!(EnemyCrack(_loc3_).cracked && EnemyCrack(_loc3_).spawnProgress < 100))
                     {
                        continue;
                     }
                  }
                  if(_loc3_ is TerranTurretBase)
                  {
                     if(!currentLevel.angryTerranTurrets)
                     {
                        continue;
                     }
                  }
                  if(_loc3_ is Critter)
                  {
                     if(Critter(_loc3_).willClimb)
                     {
                        continue;
                     }
                  }
                  if(!(_loc3_ is Egg || _loc3_ is BomberBomb))
                  {
                     _loc2_++;
                  }
               }
            }
            memoizedEnemyCount = _loc2_;
            memoizedEnemyCountTicks = Ticks;
         }
         else
         {
            _loc2_ = memoizedEnemyCount;
         }
         if(param1)
         {
            if(currentLevel.reinforcements)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      override public function init() : void
      {
         player2 = null;
         Input.i.coopEnabled = false;
         Input.i.p2Present = false;
         player = new Player(this,400,300);
         newLevel();
         inventoryButton = new GameObject(this,SimpleButton,"TextLayer",0,0);
         mapButton = new GameObject(this,SimpleButton,"TextLayer",0,0);
         menuButton = new GameObject(this,SimpleButton,"TextLayer",0,0);
         inventoryButton.setupButton(Embeds.button_inv_png,"");
         mapButton.setupButton(Embeds.button_map_png,"");
         menuButton.setupButton(Embeds.button_menu_png,"");
         var _loc1_:Layout = horiz([inventoryButton,mapButton,menuButton],3);
         horiz([mapButton,inventoryButton,menuButton],3,800 - _loc1_.width() / 2 - 1,600 - _loc1_.height() / 2 + 3);
         var _loc2_:GameSoundScene = GameSoundScene.forName("Main");
         _loc2_.volumeTarget = 0.4;
         hud = new HUDBase();
      }
      
      public function _getLogicalSquareX(param1:Number) : int
      {
         var _loc2_:Number = param1 - 10;
         var _loc3_:int = int(Math.floor(_loc2_ / 52));
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 800 / 52)
         {
            _loc3_ = 800 / 52;
         }
         return _loc3_;
      }
      
      public function spawnPointPresent() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in objects)
         {
            if(_loc1_ is RespawnPoint)
            {
               return true;
            }
         }
         return false;
      }
      
      public function squarePassable(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:PathfindSquare = toPlayer.getField(_getLogicalSquareX(param1),_getLogicalSquareY(param2));
         if(_loc3_)
         {
            return _loc3_.passable;
         }
         return null;
      }
      
      public function goalQuota() : int
      {
         if(currentEpisode == 8)
         {
            return 2;
         }
         if(currentEpisode == 2 || currentEpisode == 7 || currentEpisode == 8)
         {
            return 4;
         }
         return 3;
      }
      
      public function getEnemyDifficulty() : int
      {
         if(currentEpisode == 0)
         {
            return 0;
         }
         if(currentEpisode == 1)
         {
            return Math.random() < 0.1 ? 1 : 0;
         }
         return 0;
      }
      
      public function metaUpdate() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         if(fading == 0)
         {
            if(!hasCrate())
            {
               if(countKeys() == 0)
               {
                  if(countEnemies() == 0)
                  {
                     if(spawnPointPresent())
                     {
                        spawnPoints.setPoint(player.gridx,player.gridy);
                     }
                  }
               }
            }
         }
         if(!player._removed)
         {
            if(fading == 0)
            {
               if(messageQueue)
               {
                  _loc4_ = 0;
                  while(_loc4_ < messageQueue.length)
                  {
                     RewardText.createRewardText(this,400,300 + _loc4_ * 40,messageQueue[_loc4_],"TextLayer",-1,1,_loc4_ * 100,100);
                     _loc4_++;
                  }
                  messageQueue = null;
                  if(queuedCost)
                  {
                     player.money -= queuedCost;
                     queuedCost = 0;
                     if(player.money < 0)
                     {
                        player.money = 0;
                     }
                  }
               }
            }
         }
         if(!player._removed)
         {
            if(countKeys() == 0 && !hasCrate())
            {
               if(countEnemies() == 0 && fading == 0)
               {
                  player.lg.setCellData(player.gridx,player.gridy,"Explored",true);
                  if(player.lg.getCellData(player.gridx,player.gridy,"Finish") != null)
                  {
                     startFinishSequence();
                  }
                  if(player.lg.getCellData(player.gridx,player.gridy,"PartialFinish") != null)
                  {
                     player.lg.setCellData(player.gridx,player.gridy,"PartialFinish",null);
                     player.lg.setCellData(player.gridx,player.gridy,"Complete",true);
                     if(doPartialFinish())
                     {
                        player.lg.setCellData(player.gridx,player.gridy,"Finish",true);
                        startFinishSequence();
                     }
                  }
               }
            }
         }
         if(!paused && player._removed && !_setFinishSequence && !(player2 && !player2._removed))
         {
            ++deathSequence;
            if(deathSequence > 250)
            {
               finishDeath();
               fading = 1;
               deathSequence = 0;
            }
         }
         else
         {
            deathSequence = 0;
         }
         var _loc6_:PlayerBase = player._removed && player2 && !player2._removed ? player2 : player;
         var _loc1_:int = _loc6_.logicalSquareX();
         var _loc2_:int = _loc6_.logicalSquareY();
         var _loc3_:PathfindSquare = toPlayer.getField(_loc1_,_loc2_);
         toPlayer.reconstructGraph(_loc1_,_loc2_);
         toPlayer.lazyUpdate();
         altLevelEndCheck();
         doCollisions();
         if(fading < 3)
         {
            fadingLatch = true;
         }
         if(fading == 3)
         {
            if(fadingLatch)
            {
               fadingLatch = false;
               _loc5_ = false;
               if(player._removed)
               {
                  player.queuedLevelUp = false;
                  player.queuedExperience = 0;
                  _loc5_ = true;
               }
               if(!player._removed)
               {
                  if(player.queuedLevelUp)
                  {
                     player.doLevelUp();
                     _loc5_ = true;
                  }
               }
               if(!_loc5_)
               {
                  player.triggerHelp();
               }
            }
         }
      }
      
      public function moveEnemiesAwayFromPlayer() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:EnemyBase = null;
         var _loc3_:int = 0;
         for each(_loc1_ in objects)
         {
            if(_loc1_ is EnemyBase)
            {
               if(!EnemyBase(_loc1_).setsImpassable)
               {
                  if(!(player.seekSpawnPoint || player.seekLift))
                  {
                     if(player.distanceToObject(_loc1_) < 200)
                     {
                        _loc2_ = EnemyBase(_loc1_);
                        _loc3_ = 0;
                        while(true)
                        {
                           if(_loc3_ >= 20)
                           {
                              break;
                           }
                           _loc1_.basex = -16 + 52 * (Math.random() * 16);
                           _loc1_.basey = -12 + 52 * (Math.random() * 14);
                           if(_loc1_.distanceToObject(player) > 400)
                           {
                              if(!_loc2_.noExistGreedy())
                              {
                                 if(!_loc2_.collidesWithAnything())
                                 {
                                    if(_loc1_.basex > 50 && _loc1_.basex < 750 && _loc1_.basey > 50 && _loc1_.basey < 550)
                                    {
                                       break;
                                    }
                                 }
                              }
                           }
                           if(_loc3_ == 20 - 1)
                           {
                              trace("no fit for enemy: rmeoving");
                              _loc1_.remove();
                           }
                           _loc3_++;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function someOtherCollision() : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:Array = null;
         var _loc4_:GameObject = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:int = 0;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:Boolean = false;
         var _loc27_:GameObjectBase = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in objects)
         {
            if(_loc2_.ticks > 10)
            {
               if(_loc2_ is FloorProp || _loc2_ is TreasureChestBase || _loc2_ is FloorDecalBase || _loc2_ is Vent)
               {
                  if(_loc2_ is GameObjectBase ? GameObjectBase(_loc2_).doCollisions : true)
                  {
                     _loc1_.push(_loc2_);
                  }
               }
            }
         }
         _loc3_ = new Array();
         for each(_loc4_ in objects)
         {
            if(_loc4_ is GameObjectBase && !(_loc4_ is FloorProp || _loc4_ is IdiotLightBase))
            {
               if(!(_loc4_ is RespawnPointBase))
               {
                  if(_loc4_ is EnemyBase ? EnemyBase(_loc4_).pushable : true)
                  {
                     if(GameObjectBase(_loc4_).collidesWithWalls)
                     {
                        if(!(_loc4_ is GrenadeBase))
                        {
                           _loc3_.push(_loc4_);
                        }
                     }
                  }
               }
            }
         }
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = GameObjectBase(_loc4_).collisionWidth();
            _loc6_ = GameObjectBase(_loc4_).collisionHeight();
            for each(_loc2_ in _loc1_)
            {
               _loc7_ = _loc4_.basex - _loc2_.basex;
               _loc8_ = _loc4_.basey - _loc2_.basey;
               if(!(_loc7_ < -(_loc2_.baseWidth + _loc5_) || _loc7_ > _loc2_.baseWidth + _loc5_ || _loc8_ < -(_loc2_.baseHeight + _loc6_) || _loc8_ > _loc2_.baseHeight + _loc6_))
               {
                  if(_loc4_ is GameObjectBase && _loc2_ is GameObjectBase)
                  {
                     if(GameObjectBase(_loc4_).collisionIgnoreObject)
                     {
                        _loc27_ = GameObjectBase(_loc4_).collisionIgnoreObject;
                        if(_loc27_ is FloorProp)
                        {
                           if(_loc2_ is FloorProp)
                           {
                              if(FloorProp(_loc27_).propGroup == FloorProp(_loc2_).propGroup)
                              {
                                 continue;
                              }
                           }
                        }
                     }
                  }
                  if(!(_loc2_ is GameObjectBase))
                  {
                     if(_loc4_ is BulletBase)
                     {
                        continue;
                     }
                  }
                  if(_loc2_ is GameObjectBase)
                  {
                     if(!GameObjectBase(_loc2_).collidesWithBullets)
                     {
                        if(_loc4_ is BulletBase)
                        {
                           continue;
                        }
                     }
                  }
                  _loc9_ = _loc4_.basex - _loc5_ / 2;
                  _loc10_ = _loc4_.basex + _loc5_ / 2;
                  _loc11_ = _loc4_.basey - _loc6_ / 2;
                  _loc12_ = _loc4_.basey + _loc6_ / 2;
                  _loc13_ = _loc4_.lastX - _loc5_ / 2;
                  _loc14_ = _loc4_.lastX + _loc5_ / 2;
                  _loc15_ = _loc4_.lastY - _loc6_ / 2;
                  _loc16_ = _loc4_.lastY + _loc6_ / 2;
                  _loc17_ = _loc16_ > _loc2_.basey - _loc2_.baseHeight / 2 && _loc15_ < _loc2_.basey + _loc2_.baseHeight / 2;
                  _loc18_ = _loc14_ > _loc2_.basex - _loc2_.baseWidth / 2 && _loc13_ < _loc2_.basex + _loc2_.baseWidth / 2;
                  _loc19_ = 1;
                  if(_loc4_ is BulletBase)
                  {
                     _loc19_ = 0;
                  }
                  _loc20_ = _loc13_ >= _loc2_.basex + _loc2_.baseWidth / 2 - _loc19_;
                  _loc21_ = _loc14_ <= _loc2_.basex - _loc2_.baseWidth / 2 + _loc19_;
                  _loc22_ = _loc15_ >= _loc2_.basey + _loc2_.baseHeight / 2 - _loc19_;
                  _loc23_ = _loc16_ <= _loc2_.basey - _loc2_.baseHeight / 2 + _loc19_;
                  _loc24_ = 0;
                  _loc25_ = 0;
                  _loc17_ = _loc12_ > _loc2_.basey - _loc2_.baseHeight / 2 && _loc11_ < _loc2_.basey + _loc2_.baseHeight / 2;
                  _loc18_ = _loc10_ > _loc2_.basex - _loc2_.baseWidth / 2 && _loc9_ < _loc2_.basex + _loc2_.baseWidth / 2;
                  if(_loc4_.ticks <= 1)
                  {
                     _loc20_ = true;
                     _loc21_ = true;
                     _loc22_ = true;
                     _loc23_ = true;
                  }
                  _loc26_ = false;
                  if(_loc17_)
                  {
                     if(_loc9_ < _loc2_.basex + _loc2_.baseWidth / 2 && _loc20_)
                     {
                        if(_loc9_ >= _loc2_.basex)
                        {
                           if(!skipCollisions(_loc1_,_loc2_,_loc4_,1,0))
                           {
                              _loc24_ = 1;
                              if(GameObjectBase(_loc4_).pushedByWalls)
                              {
                                 _loc4_.basex = _loc2_.basex + _loc2_.baseWidth / 2 + _loc5_ / 2;
                              }
                              _loc26_ = true;
                              if(_loc4_ is PlayerBase)
                              {
                                 PlayerBase(_loc4_).killdx = true;
                              }
                           }
                        }
                     }
                     if(_loc10_ > _loc2_.basex - _loc2_.baseWidth / 2 && _loc21_)
                     {
                        if(_loc10_ < _loc2_.basex)
                        {
                           if(!skipCollisions(_loc1_,_loc2_,_loc4_,-1,0))
                           {
                              _loc24_ = -1;
                              if(GameObjectBase(_loc4_).pushedByWalls)
                              {
                                 _loc4_.basex = _loc2_.basex - _loc2_.baseWidth / 2 - _loc5_ / 2;
                              }
                              _loc26_ = true;
                              if(_loc4_ is PlayerBase)
                              {
                                 PlayerBase(_loc4_).killdx = true;
                              }
                           }
                        }
                     }
                  }
                  if(_loc18_)
                  {
                     if(_loc11_ < _loc2_.basey + _loc2_.baseHeight / 2 && _loc22_)
                     {
                        if(_loc11_ >= _loc2_.basey)
                        {
                           if(!skipCollisions(_loc1_,_loc2_,_loc4_,0,1))
                           {
                              _loc25_ = 1;
                              if(GameObjectBase(_loc4_).pushedByWalls)
                              {
                                 _loc4_.basey = _loc2_.basey + _loc2_.baseHeight / 2 + _loc6_ / 2;
                              }
                              _loc26_ = true;
                              if(_loc4_ is PlayerBase)
                              {
                                 PlayerBase(_loc4_).killdy = true;
                              }
                           }
                        }
                     }
                     if(_loc12_ > _loc2_.basey - _loc2_.baseHeight / 2 && _loc23_)
                     {
                        if(_loc12_ < _loc2_.basey)
                        {
                           if(!skipCollisions(_loc1_,_loc2_,_loc4_,0,-1))
                           {
                              _loc25_ = -1;
                              if(GameObjectBase(_loc4_).pushedByWalls)
                              {
                                 _loc4_.basey = _loc2_.basey - _loc2_.baseHeight / 2 - _loc6_ / 2;
                              }
                              _loc26_ = true;
                              if(_loc4_ is PlayerBase)
                              {
                                 PlayerBase(_loc4_).killdy = true;
                              }
                           }
                        }
                     }
                  }
                  if(_loc26_)
                  {
                     if(_loc4_ is GameObjectBase)
                     {
                        if(_loc2_ is FloorProp)
                        {
                           FloorProp(_loc2_).hasBeenHit(_loc4_);
                        }
                        GameObjectBase(_loc4_).hasHitWall(_loc24_,_loc25_);
                        GameObjectBase(_loc4_).wallHitCount = GameObjectBase(_loc4_).wallHitCount + 2;
                     }
                  }
               }
            }
         }
      }
      
      public function markFloor(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 1, param8:Number = 0, param9:Number = 0) : void
      {
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:PathfindSquare = null;
         var _loc17_:GameObject = null;
         if(!param1)
         {
            return;
         }
         var _loc10_:int = 0;
         while(_loc10_ <= 2)
         {
            _loc11_ = 0;
            while(_loc11_ <= 2)
            {
               _loc12_ = param2 + _loc10_ * param1.width / 2;
               _loc13_ = param3 + _loc11_ * param1.height / 2;
               _loc14_ = _getLogicalSquareX(_loc12_);
               _loc15_ = _getLogicalSquareY(_loc13_);
               _loc16_ = toPlayer.getField(_loc14_,_loc15_);
               for each(_loc17_ in objects)
               {
                  if(_loc17_ is FallingTileBase)
                  {
                     if(_getLogicalSquareX(_loc17_.basex) == _loc14_)
                     {
                        if(_getLogicalSquareY(_loc17_.basey) == _loc15_)
                        {
                           return;
                        }
                     }
                  }
               }
               if(_loc16_ ? !_loc16_.exists : true)
               {
                  return;
               }
               _loc11_++;
            }
            _loc10_++;
         }
         floor.drawToImage(param1,param2,param3,param4,param5,param6,BlendMode.NORMAL,new Rectangle(nofloorstartx,nofloorstarty,nofloorendx - nofloorstartx,nofloorendy - nofloorstarty),[param7,param8,param9,1]);
         floorMarks.push([param1,param2,param3,param4,param5,param6,param7,param8,param9]);
      }
      
      public function hasCrate() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in objects)
         {
            if(_loc1_ is CratePickup)
            {
               return true;
            }
         }
         return false;
      }
      
      public function doEnemyDifficulty() : void
      {
         el.levelEnemies(objects,currentEpisode);
      }
      
      public function assignDifficultyToGroup(param1:Class, param2:int, param3:int = -1) : void
      {
         var _loc5_:EnemyBase = null;
         if(param2 == 2 && param3 != -1)
         {
            assignDifficultyToGroup(param1,1);
         }
         var _loc4_:Array = getGroup(param1);
         if(param3 != -1)
         {
            _loc4_ = Random.randArrayElements(_loc4_,param3);
         }
         for each(_loc5_ in _loc4_)
         {
            _loc5_.setupDifficulty(param2);
         }
      }
      
      public function initLevel(param1:Array) : Array
      {
         var go:GameObject = null;
         var ogo:GameObject = null;
         var levelArray:Array = param1;
         var objs:Array = levelArray[0].init(levelArray[1],this);
         for each(go in objs)
         {
            go.basex += 52 * 15 * (levelArray[2] - 0.5);
            go.basey += 52 * 11 * (levelArray[3] - 0.5);
            if(go is GameObjectBase)
            {
               for each(ogo in objects)
               {
                  if(ogo != go)
                  {
                     if(ogo is FloorProp)
                     {
                        if(FloorProp(ogo).logicalSquareX() == GameObjectBase(go).logicalSquareX())
                        {
                           if(FloorProp(ogo).logicalSquareY() == GameObjectBase(go).logicalSquareY())
                           {
                              ogo.remove();
                           }
                        }
                     }
                  }
               }
            }
            if(go is EnemyBase)
            {
               EnemyBase(go).setupDifficulty(0);
            }
         }
         objs = objs.filter(function(param1:Object, param2:int, param3:Array):Boolean
         {
            return !GameObject(param1)._removed;
         });
         return objs;
      }
      
      public function hasCommWindow() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in objects)
         {
            if(_loc1_ is CommWindow)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setExists(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:PathfindSquare = toPlayer.getField(param1,param2);
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.exists == param3)
         {
            return;
         }
         toPlayer.reevaluate = true;
         _loc4_.exists = param3;
      }
      
      public function skipCollisions(param1:Array, param2:GameObject, param3:GameObject, param4:int, param5:int) : Boolean
      {
         if(param3 is BulletBase)
         {
            return false;
         }
         var _loc6_:Number = param2.basex;
         var _loc7_:Number = param2.basey;
         _loc7_ = Math.max(param3.basey,param2.basey - param2.baseHeight / 2 + 5);
         _loc7_ = Math.min(_loc7_,param2.basey + param2.baseHeight / 2 - 5);
         _loc6_ = Math.max(param3.basex,param2.basex - param2.baseWidth / 2 + 5);
         _loc6_ = Math.min(_loc6_,param2.basex + param2.baseWidth / 2 - 5);
         var _loc8_:int = param4;
         var _loc9_:int = param5;
         param4 += _getLogicalSquareX(_loc6_);
         param5 += _getLogicalSquareY(_loc7_);
         if(currentLevel.permanentCollisionMap)
         {
            if(param4 >= 0 && param4 < currentLevel.permanentCollisionMap.length)
            {
               if(param5 >= 0 && param5 < currentLevel.permanentCollisionMap[0].length)
               {
                  if(currentLevel.permanentCollisionMap[param4][param5])
                  {
                     return true;
                  }
               }
            }
         }
         if(logicalSquareExists(param4,param5))
         {
            if(!logicalSquarePassable(param4,param5))
            {
               if(getLogicalSquare(param4,param5).passableObj)
               {
                  if(getLogicalSquare(param4,param5).passableObj is FloorProp)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function getPassable(param1:int, param2:int) : Boolean
      {
         var _loc3_:PathfindSquare = toPlayer.getField(param1,param2);
         if(!_loc3_)
         {
            return false;
         }
         return _loc3_.passable;
      }
      
      public function justFinishedFading() : Boolean
      {
         return fading == fadeTime + 8;
      }
      
      public function countUnopenedChests() : int
      {
         var _loc2_:GameObject = null;
         var _loc1_:int = 0;
         for each(_loc2_ in objects)
         {
            if(_loc2_ is TreasureChestBase)
            {
               if(!TreasureChestBase(_loc2_).opened)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function doCollisions() : void
      {
         var _loc1_:GameObject = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:GameObjectBase = null;
         var _loc7_:GameObjectBase = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc2_:Array = new Array(200);
         var _loc3_:int = 0;
         for each(_loc1_ in objects)
         {
            if(_loc1_ is EnemyBase || _loc1_ is Player)
            {
               if(GameObjectBase(_loc1_).collisionWidth() > 0)
               {
                  if(!GameObjectBase(_loc1_).isTeleporting())
                  {
                     if(GameObjectBase(_loc1_).doCollisions)
                     {
                        _loc2_[_loc3_] = _loc1_;
                        _loc3_++;
                     }
                  }
               }
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = 0;
            for(; _loc5_ < _loc3_; _loc5_++)
            {
               if(_loc4_ != _loc5_)
               {
                  _loc6_ = _loc2_[_loc4_];
                  _loc7_ = _loc2_[_loc5_];
                  _loc8_ = _loc6_.basex - _loc7_.basex;
                  _loc9_ = _loc6_.basey - _loc7_.basey;
                  if(_loc8_ > -40 && _loc8_ < 40)
                  {
                     if(_loc9_ > -40 && _loc9_ < 40)
                     {
                        if(_loc6_.distanceToObject(_loc7_) < _loc6_.dist + _loc7_.dist)
                        {
                           _loc10_ = _loc6_.angleToObject(_loc7_);
                           if(_loc6_ is PlayerBase && !(_loc7_ is PlayerBase))
                           {
                              if(EnemyBase(_loc7_).collidesWithPlayer)
                              {
                                 enemyTouchesPlayer(EnemyBase(_loc7_),PlayerBase(_loc6_));
                                 continue;
                              }
                           }
                           if(_loc7_ is PlayerBase && !(_loc6_ is PlayerBase))
                           {
                              if(EnemyBase(_loc6_).collidesWithPlayer)
                              {
                                 enemyTouchesPlayer(EnemyBase(_loc6_),PlayerBase(_loc7_));
                                 continue;
                              }
                           }
                           if(_loc6_.pushable && _loc7_.pushable)
                           {
                              _loc11_ = (_loc6_.pushWeight + _loc7_.pushWeight) / 2;
                              _loc6_.basex -= Math.cos(_loc10_ * Math.PI / 180) * 0.5 * _loc7_.pushWeight / _loc11_;
                              _loc6_.basey -= Math.sin(_loc10_ * Math.PI / 180) * 0.5 * _loc7_.pushWeight / _loc11_;
                              _loc7_.basex += Math.cos(_loc10_ * Math.PI / 180) * 0.5 * _loc6_.pushWeight / _loc11_;
                              _loc7_.basey += Math.sin(_loc10_ * Math.PI / 180) * 0.5 * _loc6_.pushWeight / _loc11_;
                              _loc6_.enemyHitCount += 2;
                              _loc7_.enemyHitCount += 2;
                              _loc6_.pushing(_loc7_);
                           }
                        }
                     }
                  }
               }
            }
            _loc4_++;
         }
         someOtherCollision();
      }
      
      public function setPassable(param1:int, param2:int, param3:Boolean, param4:Object = null) : void
      {
         var _loc5_:PathfindSquare = toPlayer.getField(param1,param2);
         if(!_loc5_)
         {
            return;
         }
         if(_loc5_.passable == param3)
         {
            return;
         }
         toPlayer.reevaluate = true;
         _loc5_.passable = param3;
         _loc5_.passableObj = param4;
      }
      
      public function startFinishSequence() : void
      {
         if(countBlockingObjects())
         {
            return;
         }
         if(countEnemies() != 0)
         {
            return;
         }
         if(_setFinishSequence)
         {
            return;
         }
         if(countEnemyBullets() != 0)
         {
            return;
         }
         if(countUnopenedChests() != 0)
         {
            return;
         }
         if(!currentLevel.lastRoomCanEnd())
         {
            return;
         }
         _setFinishSequence = true;
         var _loc1_:int = int(Profile.current.lookup("currentmission"));
         if(_loc1_ < currentEpisode + 1)
         {
            _loc1_ = currentEpisode + 1;
            Profile.current.store("currentmission",_loc1_);
         }
         var _loc2_:CommWindow = new CommWindow(this,0,0,true);
      }
      
      public function altLevelEndCheck() : void
      {
         var _loc1_:PlayerBase = null;
         checkRoomExit();
         if(fading == 0 && player2 && !player2._removed && !player._removed)
         {
            _loc1_ = player;
            player = player2;
            checkRoomExit();
            player = _loc1_;
         }
      }

      public function checkRoomExit() : void
      {
         if(!canMoveRooms())
         {
            return;
         }
         oldGridX = player.gridx;
         oldGridY = player.gridy;
         var _loc1_:Boolean = false;
         if((player.basex >= 800 - edge || player.basex <= edge) && (player.basey > 300 - doorWidth && player.basey < 300 + doorWidth))
         {
            if(player.basex > 400)
            {
               if(player.canMove(1,0))
               {
                  if(player.hasKeysFor(player.gridx + 1,player.gridy))
                  {
                     _loc1_ = true;
                     player.destBaseX = 40;
                     player.destBaseY = player.basey;
                     player.gridx += 1;
                  }
               }
            }
            else if(player.canMove(-1,0))
            {
               if(player.hasKeysFor(player.gridx - 1,player.gridy))
               {
                  player.destBaseX = 760;
                  player.destBaseY = player.basey;
                  _loc1_ = true;
                  --player.gridx;
               }
            }
         }
         if((player.basey >= 600 - edge || player.basey <= edge) && (player.basex >= 400 - doorWidth && player.basex <= 400 + doorWidth))
         {
            if(player.basey > 300)
            {
               if(player.canMove(0,1))
               {
                  if(player.hasKeysFor(player.gridx,player.gridy + 1))
                  {
                     _loc1_ = true;
                     player.destBaseX = player.basex;
                     player.destBaseY = 40;
                     player.gridy += 1;
                  }
               }
            }
            else if(player.canMove(0,-1))
            {
               if(player.hasKeysFor(player.gridx,player.gridy - 1))
               {
                  _loc1_ = true;
                  player.destBaseX = player.basex;
                  player.destBaseY = 560;
                  --player.gridy;
               }
            }
         }
         if(_loc1_)
         {
            fading = 1;
         }
      }
      
      public function makeParticlesFall(param1:Array) : void
      {
         var _loc2_:Particle = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PathfindSquare = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_.StayAfterDeath)
            {
               if(_loc2_.x < startx + 16)
               {
                  if(_loc2_.dx < 0)
                  {
                     _loc2_.dx *= -1;
                  }
                  if(_loc2_.dx < 1)
                  {
                     _loc2_.dx = 1;
                  }
               }
               if(_loc2_.x > endx - 16)
               {
                  if(_loc2_.dx > 0)
                  {
                     _loc2_.dx *= -1;
                  }
                  if(_loc2_.dx > -1)
                  {
                     _loc2_.dx = -1;
                  }
               }
               if(_loc2_.y < starty + 16)
               {
                  if(_loc2_.dy < 0)
                  {
                     _loc2_.dy *= -1;
                  }
                  if(_loc2_.dy < 1)
                  {
                     _loc2_.dy = 1;
                  }
               }
               if(_loc2_.y > endy - 16)
               {
                  if(_loc2_.dy > 0)
                  {
                     _loc2_.dy *= -1;
                  }
                  if(_loc2_.dy > -1)
                  {
                     _loc2_.dy = -1;
                  }
               }
            }
            if(_loc2_.identifier == "Fall")
            {
               _loc3_ = getLogicalSquareX(_loc2_.x);
               _loc4_ = getLogicalSquareY(_loc2_.y);
               _loc5_ = toPlayer.getField(_loc3_,_loc4_);
               if(_loc2_.x < 780 && _loc2_.y < 580 && _loc2_.x > 20 && _loc2_.y > 20)
               {
                  if(!_loc5_.exists)
                  {
                     _loc2_.StartAlpha -= 0.01;
                     _loc2_.EndAlpha -= 0.01;
                     if(_loc2_.StartAlpha < 0 && Boolean(_loc2_.EndAlpha))
                     {
                        _loc2_.toKill = true;
                     }
                  }
               }
            }
         }
      }
      
      public function logicalSquareExists(param1:int, param2:int) : Boolean
      {
         var _loc3_:PathfindSquare = toPlayer.getField(param1,param2);
         if(_loc3_)
         {
            return _loc3_.exists;
         }
         return false;
      }
      
      public function removeParticles(param1:Array) : void
      {
         var _loc2_:Particle = null;
         for each(_loc2_ in param1)
         {
            _loc2_.deathCallback = null;
            _loc2_.toKill = true;
         }
      }
      
      public function logicalSquarePassable(param1:int, param2:int) : Boolean
      {
         var _loc3_:PathfindSquare = toPlayer.getField(param1,param2);
         if(_loc3_)
         {
            return _loc3_.passable;
         }
         return false;
      }
      
      public function resistanceForLevel() : Number
      {
         var _loc1_:Number = 1 + 3 * currentEpisode * 0.05;
         if(currentEpisode == 9)
         {
            _loc1_ *= 1.5;
         }
         if(currentEpisode == 10)
         {
            _loc1_ *= 2;
         }
         if(currentEpisode == 11)
         {
            _loc1_ *= 2.5;
         }
         return _loc1_;
      }
      
      public function countKeys() : int
      {
         var _loc2_:GameObject = null;
         if(Ticks == memoizeCountKeysTicks)
         {
            return memoizeCountKeys;
         }
         var _loc1_:int = 0;
         for each(_loc2_ in objects)
         {
            if(_loc2_ is PickupKey)
            {
               _loc1_++;
            }
         }
         memoizeCountKeys = _loc1_;
         memoizeCountKeysTicks = Ticks;
         return _loc1_;
      }
      
      public function finishDeath() : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         if(currentEpisode >= 3)
         {
            if(player)
            {
               if(player.obj)
               {
                  if(player.obj.root)
                  {
                     _loc3_ = player.obj.root.loaderInfo.url.split("/")[2];
                     _loc4_ = _loc3_.split(".");
                     _loc5_ = _loc4_[_loc4_.length - 2];
                     if(_loc5_ != "rocksolidarcade" && player.obj.root.loaderInfo.url != "http://e1.simplecdn.net/rocksolidarcade/robokill2.swf")
                     {
                     }
                  }
               }
            }
         }
         regenerateGrid(player.gridx,player.gridy);
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 2)
         {
            if(regenerateRandomPoint())
            {
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ > 0)
         {
            if(_loc1_ == 1)
            {
               _loc6_ = "THE ENEMY HAVE RECLAIMED 1 ROOM";
            }
            else
            {
               _loc6_ = "THE ENEMY HAVE RECLAIMED " + _loc1_ + " ROOMS";
            }
            _loc7_ = (player.level + 1) * 50;
            if(_loc7_ > player.money * 0.05)
            {
               _loc7_ = player.money * 0.05;
            }
            queuedCost = _loc7_;
            if(_loc7_ > 0)
            {
               messageQueue = [_loc6_,"DEATH TAKES A TOLL OF -$" + _loc7_];
            }
            else
            {
               messageQueue = [_loc6_];
            }
         }
      }
      
      public function doPartialFinish() : Boolean
      {
         ++partialFinishCount;
         if(partialFinishCount < goalQuota())
         {
            RewardText.createRewardText(this,400,300,partialFinishCount + "/" + goalQuota() + " " + goalText(),"TextLayer",-1,1,0,150);
         }
         if(partialFinishCount >= goalQuota())
         {
            partialFinishCount = 0;
            return true;
         }
         return false;
      }
      
      public function levelEndCheck() : void
      {
         var _loc2_:GameObject = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in objects)
         {
            if(_loc2_ is EnemyBase)
            {
               if(EnemyBase(_loc2_).blocksNewLevel)
               {
                  _loc1_ = true;
               }
            }
         }
         if(!_loc1_)
         {
            for each(_loc2_ in objects)
            {
               if(_loc2_ is EnemyBase)
               {
                  _loc2_.remove();
               }
            }
            newLevel();
         }
      }
      
      public function changeLevel(param1:Boolean = true) : void
      {
         var _loc3_:GameObject = null;
         var _loc4_:GameObject = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in objects)
         {
            if(_loc3_ is GameObjectBase)
            {
               if(!_loc3_._removed)
               {
                  if(!(_loc3_ is PlayerBase || _loc3_ is FlyingBotBase))
                  {
                     if(_loc3_ is EnemyBase || _loc3_ is PickupBase || _loc3_ is FloorProp || _loc3_ is RespawnPoint || _loc3_ is ShopTile || _loc3_ is ShuttleBase || _loc3_ is FallingTileBase || _loc3_ is EnemyCrackFake || _loc3_ is HazardBase || _loc3_ is SecretLift || _loc3_ is SecretLiftFloor || _loc3_ is PressurePadActive || _loc3_ is PressurePadDisabled || _loc3_ is Vent)
                     {
                        if(_loc3_ is ShuttleBase ? countEnemies() > 0 : true)
                        {
                           if(_loc3_ is EnemyBase ? EnemyBase(_loc3_).saveBetweenLevels() : true)
                           {
                              if(_loc3_ is FloorProp ? !(FloorProp(_loc3_).temporary || FloorProp(_loc3_).flying || Boolean(FloorProp(_loc3_).throwingProgress) || FloorProp(_loc3_).pickedUp) : true)
                              {
                                 if(!(_loc3_ is BomberBomb))
                                 {
                                    _loc2_.push(SerializedObject.serialize(_loc3_));
                                 }
                              }
                           }
                        }
                     }
                     _loc3_.remove();
                  }
               }
            }
         }
         for each(_loc3_ in objects)
         {
            if(_loc3_ is FloorDecalBase || _loc3_ is TopDecalBase)
            {
               _loc3_.remove();
            }
         }
         if(param1)
         {
            player.lg.setCellData(oldGridX,oldGridY,"Data",_loc2_);
            player.lg.setCellData(oldGridX,oldGridY,"FloorDamage",floorMarks);
            player.lg.setCellData(oldGridX,oldGridY,"GameLevel",currentLevel);
         }
         newLevel();
         objects = SortFloorProps.sortFloorProps(objects);
         for each(_loc3_ in objects)
         {
            if(_loc3_ is PickupBase)
            {
               for each(_loc4_ in objects)
               {
                  if(_loc4_ is FloorProp)
                  {
                     if(FloorProp(_loc4_).logicalSquareX() == GameObjectBase(_loc3_).logicalSquareX())
                     {
                        if(FloorProp(_loc4_).logicalSquareY() == GameObjectBase(_loc3_).logicalSquareY())
                        {
                           _loc3_.remove();
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function canMoveRooms() : Boolean
      {
         if(countEnemies() > 0)
         {
            return false;
         }
         if(fading > 0)
         {
            return false;
         }
         if(player.inLevelEnd())
         {
            return false;
         }
         if(countKeys() > 0)
         {
            return false;
         }
         if(player._removed)
         {
            return false;
         }
         if(hasCrate())
         {
            return false;
         }
         return true;
      }
      
      public function countEnemyBullets() : int
      {
         var _loc2_:GameObject = null;
         var _loc1_:int = 0;
         for each(_loc2_ in objects)
         {
            if(_loc2_ is EnemyBulletBase)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function initCurrentLevel() : void
      {
         currentLevel.overArrowsCreated = false;
         currentLevel.gs = this;
         startx = currentLevel.startx;
         starty = currentLevel.starty;
         endx = currentLevel.endx;
         endy = currentLevel.endy;
         nofloorstartx = currentLevel.nofloorstartx;
         nofloorstarty = currentLevel.nofloorstarty;
         nofloorendx = currentLevel.nofloorendx;
         nofloorendy = currentLevel.nofloorendy;
      }
      
      public function newLevel() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Class = null;
         flushParticles();
         for each(_loc1_ in objects)
         {
            if(_loc1_ is PickupText || _loc1_ is Door || _loc1_ is FloorProp)
            {
               _loc1_.remove();
            }
         }
         syncRemoved();
         toPlayer = new PathfindToPoint(800 / 40,600 / 40);
         if(!player.lg.getCellData(player.gridx,player.gridy,"Data"))
         {
            _loc2_ = Math.abs(player.gridx - player.lg.startx) + Math.abs(player.gridy - player.lg.starty);
            currentLevel = generateLevelBasedOnDistance(_loc2_);
            currentLevel.gs = this;
            Bitmap(floor.obj).bitmapData = currentLevel.getFloor(true);
            initCurrentLevel();
            floorMarks = new Array();
         }
         else
         {
            _loc3_ = Array(player.lg.getCellData(player.gridx,player.gridy,"Data"));
            _loc4_ = 0;
            while(_loc4_ < _loc3_[0].length)
            {
               _loc5_ = getDefinitionByName(_loc3_[0][_loc4_].typeName) as Class;
               _loc1_ = GameObject(new _loc5_(this,0,0));
               _loc3_[0][_loc4_].applyTo(_loc1_);
               if(_loc1_ is EnemyBase)
               {
                  EnemyBase(_loc1_).setupDifficulty(EnemyBase(_loc1_).toughness);
               }
               _loc4_++;
            }
            if(player.lg.getCellData(player.gridx,player.gridy,"Regenerate") == true)
            {
               player.lg.setCellData(player.gridx,player.gridy,"Regenerate",false);
               for each(_loc1_ in objects)
               {
                  if(_loc1_ is EnemyBase)
                  {
                     EnemyBase(_loc1_).remove();
                  }
               }
               update();
               generateLevelBasedOnDistance(1,true);
            }
            currentLevel = GameLevel(player.lg.getCellData(player.gridx,player.gridy,"GameLevel"));
            currentLevel.gs = this;
            Bitmap(floor.obj).bitmapData = currentLevel.getFloor(false);
            initCurrentLevel();
            applyToFloor(Array(player.lg.getCellData(player.gridx,player.gridy,"FloorDamage")));
            player.lg.setCellData(player.gridx,player.gridy,"Data",null);
         }
         currentLevel.ticks = 0;
         if(player.lg.getCellData(player.gridx,player.gridy,"Start"))
         {
            if(currentEpisode == 0)
            {
               new Ship(this,200,300);
            }
            if(player.lg.getCellData(player.gridx,player.gridy,"CommPlayed") != true)
            {
               player.lg.setCellData(player.gridx,player.gridy,"CommPlayed",true);
               new CommWindow(this,400,20);
            }
         }
         if(player.seekSpawnPoint)
         {
            player.basex = 400;
            player.basey = 300;
            for each(_loc1_ in objects)
            {
               if(_loc1_ is RespawnPoint)
               {
                  player.basex = _loc1_.basex;
                  player.basey = _loc1_.basey;
                  player.seekSpawnPoint = false;
               }
            }
         }
         if(player.seekLift)
         {
            for each(_loc1_ in objects)
            {
               if(_loc1_ is SecretLift || _loc1_ is SecretLiftFloor)
               {
                  player.basex = _loc1_.basex;
                  player.basey = _loc1_.basey;
                  player.seekLift = false;
               }
            }
         }
         moveEnemiesAwayFromPlayer();
         lazyEnemiesCount = countEnemies();
      }
      
      public function regenerateRandomPoint() : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < player.lg.grid.length)
         {
            _loc3_ = 0;
            while(_loc3_ < player.lg.grid[_loc2_].length)
            {
               if(player.lg.getCell(_loc3_,_loc2_) > 0)
               {
                  if(_loc3_ != player.lg.startx || _loc2_ != player.lg.starty)
                  {
                     if(player.lg.getCellData(_loc3_,_loc2_,"Complete") == null)
                     {
                        if(player.lg.getCellData(_loc3_,_loc2_,"Explored") == true)
                        {
                           _loc4_ = -1;
                           while(_loc4_ < 2)
                           {
                              _loc5_ = -1;
                              while(_loc5_ < 2)
                              {
                                 if(_loc5_ == 0 || _loc4_ == 0)
                                 {
                                    if(player.lg.getCell(_loc3_ + _loc5_,_loc2_ + _loc4_) > 0)
                                    {
                                       if(player.lg.getCellData(_loc3_ + _loc5_,_loc2_ + _loc4_,"Explored") != true)
                                       {
                                          _loc1_.push([_loc3_,_loc2_]);
                                       }
                                    }
                                 }
                                 _loc5_ += 1;
                              }
                              _loc4_ += 1;
                           }
                        }
                     }
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc1_.length > 0)
         {
            _loc6_ = Random.randInt(0,_loc1_.length - 1);
            regenerateGrid(_loc1_[_loc6_][0],_loc1_[_loc6_][1]);
            return true;
         }
         return false;
      }
      
      public function getGroup(param1:Class) : Array
      {
         var _loc3_:GameObject = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in objects)
         {
            if(_loc3_ is param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getLogicalSquare(param1:int, param2:int) : PathfindSquare
      {
         return toPlayer.getField(param1,param2);
      }
      
      public function squareExists(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = getLogicalSquareX(param1);
         var _loc4_:int = getLogicalSquareY(param2);
         var _loc5_:PathfindSquare = toPlayer.getField(_loc3_,_loc4_);
         if(_loc5_)
         {
            return _loc5_.exists;
         }
         return false;
      }
      
      public function goalText() : String
      {
         if(currentEpisode == 2)
         {
            return "MANUFACTURING UNITS DESTROYED";
         }
         if(currentEpisode == 4)
         {
            return "SHUTTLES RESCUED";
         }
         if(currentEpisode == 7)
         {
            return "ASSASSIN BOTS DESTROYED";
         }
         if(currentEpisode == 8)
         {
            return "DISTRESS BEACONS LOCATED";
         }
         if(currentEpisode == 5)
         {
            return "SHIP PARTS FOUND";
         }
         if(currentEpisode == 6)
         {
            return "BACKUP GENERATORS STARTED";
         }
         if(currentEpisode == 10)
         {
            return "TERMINALS LOCATED";
         }
         return "";
      }
      
      override public function _update() : void
      {
         var _loc4_:GameObject = null;
         var _loc5_:Array = null;
         if(Ticks % 100 == 0)
         {
            completedProgress = getCompletedProgress();
            if(currentEpisode == 0)
            {
               globalSpeed = 0.7 + 0.1 * completedProgress;
            }
            else
            {
               globalSpeed = 0.8 + 0.15 * (Number(currentEpisode - 1) + completedProgress) / 12;
            }
         }
         if(!Input.i.keyDown(84))
         {
         }
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(!player.inventoryHelp)
         {
            _loc2_ = Ticks % 100 > 50;
         }
         else if(!player.mapHelp)
         {
            _loc1_ = Ticks % 100 > 50;
         }
         setGlow(mapButton,_loc1_);
         setGlow(inventoryButton,_loc2_);
         if(player._removed)
         {
            if(player.experience >= player.experienceForLevel())
            {
               player.experience = player.experienceForLevel() - 1;
            }
         }
         if(_paused)
         {
            if(player.expSoundChannel)
            {
               if(player.expSoundChannel.playing())
               {
                  player.expSoundChannel.stop();
               }
            }
         }
         player.setHud();
         if(!fadeOverlay)
         {
            fadeOverlay = new GameObject(this,GraphicsTools.createFilledSprite(800,600,4278190080),"AfterTextLayer",400,300);
            fadeOverlay.hide();
         }
         lazyEnemiesCount = countEnemies();
         var _loc3_:Array = getAllParticles();
         makeParticlesFall(_loc3_);
         if(!HUDDisplay.any())
         {
            if(fading)
            {
               ++fading;
               paused = fading < fadeTime;
               if(fading == fadeTime + 5)
               {
                  removeParticles(_loc3_);
                  for each(_loc4_ in removeWhenFaded)
                  {
                     _loc4_.remove();
                  }
                  for each(_loc4_ in objects)
                  {
                     if(_loc4_ is RewardText)
                     {
                        _loc4_.remove();
                     }
                     if(_loc4_ is ControlHelp)
                     {
                        ControlHelp(_loc4_).roomChange();
                     }
                  }
                  removeWhenFaded = new Array();
                  if(fadingLevelComplete)
                  {
                     ++currentEpisode;
                     spawnPoints = new SpawnPoints();
                     if(player._removed)
                     {
                        resetPlayer();
                     }
                     player.lg = new LevelGrid();
                     player.lg.init(currentEpisode);
                     player.gridx = player.lg.startx;
                     player.gridy = player.lg.starty;
                     player.seekSpawnPoint = true;
                     player.teleporting = 0;
                     player.teleportOffset = 0;
                     player.keyCount = 0;
                     fadingLevelComplete = false;
                     _setFinishSequence = false;
                     changeLevel(false);
                  }
                  else if(player._removed)
                  {
                     oldGridX = player.gridx;
                     oldGridY = player.gridy;
                     resetPlayer();
                     _loc5_ = spawnPoints.getPoint(oldGridX,oldGridY);
                     if(!_loc5_)
                     {
                        _loc5_ = [player.lg.startx,player.lg.starty];
                     }
                     player.gridx = _loc5_[0];
                     player.gridy = _loc5_[1];
                     player.seekSpawnPoint = true;
                     changeLevel();
                  }
                  else
                  {
                     player.basex = player.destBaseX;
                     player.basey = player.destBaseY;
                     for each(_loc4_ in objects)
                     {
                        if(_loc4_ is FlyingBotBase)
                        {
                           _loc4_.basex = player.basex;
                           _loc4_.basey = player.basey;
                        }
                     }
                     changeLevel();
                  }
                  if(player2 && player2._removed)
                  {
                     revivePlayer2();
                  }
                  else
                  {
                     placePlayer2();
                  }
                  player.save();
               }
               if(fading > fadeTime * 3)
               {
                  fading = 0;
               }
               fadeOverlay.updateDespitePaused = true;
               fadeOverlay.show();
               if(fading < fadeTime)
               {
                  fadeOverlay.baseAlpha = Interpolation.linearInterpolate(0,1,Interpolation.fromTo(fading,0,fadeTime));
               }
               else if(fading < fadeTime * 2)
               {
                  fadeOverlay.baseAlpha = 1;
               }
               else
               {
                  fadeOverlay.baseAlpha = Interpolation.linearInterpolate(1,0,Interpolation.fromTo(fading,fadeTime * 2,fadeTime * 3));
               }
            }
            else
            {
               fadeOverlay.hide();
            }
         }
         currentLevel.gs = this;
         currentLevel.update();
         if(currentEpisode == 8)
         {
            if(player.lg.getCellData(player.gridx,player.gridy,"PartialFinish"))
            {
               for each(_loc4_ in objects)
               {
                  if(_loc4_ is TreasureChestBase)
                  {
                     TreasureChestBase(_loc4_).giveWeapon = true;
                  }
               }
            }
         }
         if(countEnemies() == 0 && !currentLevel.overArrowsCreated)
         {
            currentLevel.createOverArrows();
         }
         metaUpdate();
         if(!hasCommWindow())
         {
            if(fading == 0)
            {
               if(Boolean(Input.i.keyHit(73)) || Boolean(Input.i.keyHit(81)) || inventoryButton.mHit())
               {
                  player.inventoryHelp = true;
                  HUDDisplay.open(this,Inventory);
               }
               if(Boolean(Input.i.keyHit(77)) || Boolean(Input.i.keyHit(69)) || mapButton.mHit())
               {
                  player.mapHelp = true;
                  HUDDisplay.open(this,Map);
               }
               if(Boolean(Input.i.keyHit(80)) || Boolean(Input.i.keyHit(27)) || menuButton.mHit())
               {
                  HUDDisplay.open(this,PauseMenu);
               }
            }
         }
         updatePlayer2();
         Input.i.keyHit(73);
         Input.i.keyHit(77);
         Input.i.keyHit(85);
         Input.i.keyHit(80);
         Input.i.keyHit(27);
         Input.i.keyHit(81);
         Input.i.keyHit(69);
      }
      
      public function getCompletedProgress() : Number
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < player.lg.grid.length)
         {
            _loc4_ = 0;
            while(_loc4_ < player.lg.grid[0].length)
            {
               if(player.lg.grid[_loc3_][_loc4_])
               {
                  _loc1_++;
                  if(player.lg.getCellData(_loc4_,_loc3_,"Explored"))
                  {
                     _loc2_++;
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc2_ / _loc1_;
      }
      
      public function generateLevelBasedOnDistance(param1:int, param2:Boolean = false) : GameLevel
      {
         var _loc7_:Array = null;
         var _loc8_:GameObject = null;
         var _loc3_:Array = Array(player.lg.getCellData(player.gridx,player.gridy,"PredefinedLevel"));
         var _loc4_:Array = _loc3_[0];
         var _loc5_:int = 1;
         while(_loc5_ < _loc4_.length)
         {
            _loc7_ = initLevel(_loc4_[_loc5_]);
            for each(_loc8_ in _loc7_)
            {
               if(_loc8_ is PickupBase || _loc8_ is TreasureChestBase)
               {
                  if(param2)
                  {
                     _loc8_.remove();
                  }
               }
            }
            _loc5_++;
         }
         doEnemyDifficulty();
         var _loc6_:GameLevel = new GameLevel();
         _loc6_.secretRoom = player.lg.getCellData(player.gridx,player.gridy,"Secret") == true || player.lg.getCellData(player.gridx,player.gridy,"SecretTarget") == true;
         _loc6_.ambushRoom = player.lg.getCellData(player.gridx,player.gridy,"Ambush") == true;
         _loc6_.reinforcements = player.lg.getCellData(player.gridx,player.gridy,"Reinforcements") == true;
         return _loc6_;
      }
   }
}

