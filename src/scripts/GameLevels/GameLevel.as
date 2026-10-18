package GameLevels
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.*;
   import Misc.EnemyLeveling;
   import ObjectBase.*;
   import Objects.*;
   import Scenes.*;
   import Templates.RewardText;
   import Tools.GraphicsTools;
   import Tools.PathfindSquare;
   import Tools.Random;
   import flash.display.*;
   import flash.filters.*;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class GameLevel
   {
      
      public static var ambientChannel:GameSoundChannel;
      
      public var nofloorstartx:Number = 0;
      
      public var tileCount:int;
      
      public var nofloorstarty:Number = 0;
      
      public var edgeProgress:int = 0;
      
      public var ambushRoom:Boolean = false;
      
      public var horizPhase:Boolean = false;
      
      public var angryTerranTurrets:Boolean = false;
      
      public var possibleGrowlSounds:Array = [Sounds.alienBigGrowl,Sounds.trooperGrowl,Sounds.alienMediumGrowl,Sounds.alienSmallGrowl];
      
      public var triggeredHelp:Boolean = false;
      
      public var doneEdgeWarning:Boolean = false;
      
      public var hadItem:Boolean = false;
      
      public var offsets:Array = [[-1,0],[1,0],[0,-1],[0,1]];
      
      public var enragedBugs:Boolean = false;
      
      public var _chainLength:int = 0;
      
      public var lastTrapTicks:int = 0;
      
      public var startx:Number = 0;
      
      public var starty:Number = 0;
      
      public var hasHadTrap:Boolean = false;
      
      public var ambushProgress:int = 0;
      
      public var reinforcements:Boolean = false;
      
      public var nofloorendx:Number = 800;
      
      public var nofloorendy:Number = 600;
      
      public var tumorRoom:Boolean = Math.random() < 0.2;
      
      public var growlSounds:Object = new Object();
      
      public var _timedAmbush:int = -1;
      
      public var ticks:int = 0;
      
      public var overArrows:Array;
      
      public var doors:Array = new Array();
      
      public var hadWeapon:Boolean = false;
      
      public var overArrowsCreated:Boolean = false;
      
      public var nextGrowl:int = 500;
      
      public var calledForReinforcements:Boolean = false;
      
      public var permanentCollisionMap:Array;
      
      public var decalNum:int = -1;
      
      public var floorBitmapData:BitmapData;
      
      public var floorPos:Array;
      
      public var reinforcementsCreationDelay:int = 100;
      
      public var hasHadTrapText:Boolean = false;
      
      public var angryTerranTurretsTicks:int = 0;
      
      public var soundsToPlay:Array;
      
      public var secretRoom:Boolean;
      
      public var _chainStart:FloorDecal = null;
      
      public var lastGrowl:int = 0;
      
      public var grabReinforcements:Array;
      
      public var _chain:Array = new Array();
      
      public var bridgeLocations:Array;
      
      public var lastRoomProgress:int = 0;
      
      public var gs:GameScene;
      
      public var endx:Number = 800;
      
      public var endy:Number = 600;
      
      public function GameLevel()
      {
         super();
      }
      
      public function isEdgeWarningRoom() : Boolean
      {
         var _loc1_:MainScene = MainScene(gs);
         var _loc2_:PlayerBase = _loc1_.player;
         return _loc2_.lg.getCellData(_loc2_.gridx,_loc2_.gridy,"EdgeWarning") != null;
      }
      
      public function decalZOrderChange(param1:GameObject) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(param1 is FreeFloorDecal)
         {
            _loc2_ = FreeFloorDecal(param1).animFrame >= 74 && FreeFloorDecal(param1).animFrame <= 78;
            _loc3_ = int(FreeFloorDecal(param1).animFrame);
            if(_loc3_ == 55 || _loc3_ == 56)
            {
               return true;
            }
            if(FreeFloorDecal(param1).animFrame == 58)
            {
               _loc2_ = true;
            }
            if(FreeFloorDecal(param1).animFrame == 1)
            {
               _loc2_ = true;
            }
            if(param1.animFrame == 87 || param1.animFrame == 88)
            {
               _loc2_ = true;
            }
            if(param1.animFrame == 86)
            {
               _loc2_ = true;
            }
            if(param1.animFrame == 41)
            {
               _loc2_ = true;
            }
            return _loc2_;
         }
         return false;
      }
      
      public function updateBridges() : void
      {
         var _loc2_:GameObject = null;
         var _loc3_:MainScene = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:FallingTileBase = null;
         bridgeLocations = new Array(20);
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            bridgeLocations[_loc1_] = new Array(20);
            _loc1_++;
         }
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is FallingTileBase)
            {
               bridgeLocations[MainScene(gs)._getLogicalSquareX(_loc2_.basex) + 1][MainScene(gs)._getLogicalSquareY(_loc2_.basey) + 1] = _loc2_;
               FallingTile(_loc2_).marked = false;
            }
         }
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is FallingTileBase)
            {
               _loc3_ = MainScene(gs);
               _loc4_ = MainScene(gs)._getLogicalSquareX(_loc2_.basex);
               _loc5_ = MainScene(gs)._getLogicalSquareY(_loc2_.basey);
               _loc6_ = _loc4_ + 1;
               _loc7_ = _loc5_ + 1;
               _loc8_ = false;
               _loc9_ = 0;
               while(_loc9_ < 4)
               {
                  if(_loc3_.logicalSquareExists(_loc4_ + offsets[_loc9_][0],_loc5_ + offsets[_loc9_][1]))
                  {
                     if(!bridgeLocations[_loc6_ + offsets[_loc9_][0]][_loc7_ + offsets[_loc9_][1]])
                     {
                        FallingTileBase(_loc2_).mark(bridgeLocations);
                     }
                  }
                  _loc9_++;
               }
            }
         }
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is FallingTileBase)
            {
               if(!FallingTileBase(_loc2_).marked)
               {
                  _loc9_ = 0;
                  while(_loc9_ < 4)
                  {
                     _loc6_ = FallingTile(_loc2_).logicalSquareX() + 1;
                     _loc7_ = FallingTile(_loc2_).logicalSquareY() + 1;
                     _loc10_ = bridgeLocations[_loc6_ + offsets[_loc9_][0]][_loc7_ + offsets[_loc9_][1]];
                     if(_loc10_)
                     {
                        if(_loc10_.crumbling > 20)
                        {
                           FallingTileBase(_loc2_).crumble();
                        }
                     }
                     _loc9_++;
                  }
               }
            }
         }
      }
      
      public function chainStart() : void
      {
         _chainLength = 0;
         _chainStart = null;
         _chain = new Array();
      }
      
      public function getGrowlSounds(param1:Boolean = false) : Array
      {
         var _loc4_:GameSound = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Object = getEnemyGrowls(param1);
         var _loc3_:Array = new Array();
         for each(_loc4_ in possibleGrowlSounds)
         {
            if(_loc2_[_loc4_.id])
            {
               _loc5_ = int(_loc2_[_loc4_.id]);
               if(_loc5_ > 5)
               {
                  _loc5_ = 2;
               }
               else
               {
                  _loc5_ = 1;
               }
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc3_.push([_loc4_,int(5 + Math.random() * 100)]);
                  _loc6_++;
               }
            }
         }
         return _loc3_;
      }
      
      public function timedAmbush() : Boolean
      {
         var _loc1_:GameObject = null;
         if(_timedAmbush >= 0)
         {
            return _timedAmbush == 1;
         }
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is EnemyBase)
            {
               if(!(_loc1_ is EnemyCrack))
               {
                  _timedAmbush = 1;
                  return true;
               }
            }
         }
         _timedAmbush = 0;
         return false;
      }
      
      public function getEnemyGrowls(param1:Boolean = false) : Object
      {
         var _loc3_:GameObject = null;
         var _loc4_:EnemyBase = null;
         var _loc2_:Object = new Object();
         for each(_loc3_ in gs.objects)
         {
            if(_loc3_ is EnemyBase)
            {
               _loc4_ = EnemyBase(_loc3_);
               if(!(!_loc4_.playGrowlAtStart() && param1))
               {
                  if(_loc4_.growlSound())
                  {
                     if(_loc2_[_loc4_.growlSound().id])
                     {
                        ++_loc2_[_loc4_.growlSound().id];
                     }
                     else
                     {
                        _loc2_[_loc4_.growlSound().id] = 1;
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function updateAmbush() : void
      {
         var _loc1_:GameObject = null;
         if(gs.paused)
         {
            return;
         }
         hasHadTrap = true;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is TreasureChestBase)
            {
               if(!TreasureChestBase(_loc1_).opened)
               {
                  return;
               }
            }
         }
         ++ambushProgress;
         if(timedAmbush())
         {
            if(ambushProgress == 100)
            {
               RewardText.createRewardText(gs,400,300,"AMBUSH!","TextLayer",16730174);
               Sounds.trap.play();
            }
            if(ambushProgress > 150)
            {
               ambushRoom = false;
               _doAmbush();
            }
         }
      }
      
      public function chainEnd() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         if(Boolean(_chainStart) && _chainLength > 1)
         {
            _loc1_ = (_chainLength - 1) * _chainStart.baseHeight;
            if(horizPhase)
            {
               _chainStart.baseWidth *= _chainLength;
               _chainStart.basex += _loc1_ / 2;
            }
            else
            {
               _chainStart.baseHeight *= _chainLength;
               _chainStart.basey += _loc1_ / 2;
            }
            _chainStart.baseRotation = 0;
            _loc2_ = 1;
            while(_loc2_ < _chain.length)
            {
               _chain[_loc2_].remove();
               _loc2_++;
            }
         }
         _chainLength = 0;
         _chainStart = null;
         _chain = new Array();
      }
      
      public function getFloor(param1:Boolean) : BitmapData
      {
         var _loc2_:PlayerBase = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:GameObject = null;
         var _loc11_:Bitmap = null;
         var _loc12_:Bitmap = null;
         var _loc13_:int = 0;
         var _loc14_:BitmapData = null;
         var _loc15_:Bitmap = null;
         var _loc16_:ColorTransform = null;
         var _loc20_:String = null;
         var _loc21_:Array = null;
         var _loc22_:String = null;
         var _loc23_:Array = null;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:Bitmap = null;
         if(Math.random() > 0.95)
         {
            if(MainScene(gs).currentEpisode >= 3)
            {
               if(MainScene(gs).player)
               {
                  if(MainScene(gs).player.obj)
                  {
                     if(MainScene(gs).player.obj.root)
                     {
                        _loc20_ = MainScene(gs).player.obj.root.loaderInfo.url.split("/")[2];
                        _loc21_ = _loc20_.split(".");
                        _loc22_ = _loc21_[_loc21_.length - 2];
                        if(_loc22_ != "rocksolidarcade" && MainScene(gs).player.obj.root.loaderInfo.url != "http://e1.simplecdn.net/rocksolidarcade/robokill2.swf")
                        {
                        }
                     }
                  }
               }
            }
         }
         tileCount = 0;
         _loc2_ = MainScene(gs).player;
         var _loc3_:Array = Array(_loc2_.lg.getCellData(_loc2_.gridx,_loc2_.gridy,"PredefinedLevel"))[0];
         var _loc4_:Array = _loc3_[0];
         var _loc5_:Array = _loc4_[0].init(_loc4_[1],gs);
         var _loc6_:int = 1;
         while(_loc6_ < _loc3_.length)
         {
            if(param1)
            {
               if(isFloorLevel(_loc3_[_loc6_]))
               {
                  _loc23_ = MainScene(gs).initLevel(_loc3_[_loc6_]);
                  for each(_loc10_ in _loc23_)
                  {
                     _loc5_.push(_loc10_);
                  }
               }
            }
            _loc6_++;
         }
         var _loc7_:Array = new Array();
         floorPos = new Array();
         _loc8_ = 0;
         while(_loc8_ < 32)
         {
            floorPos[_loc8_] = new Array();
            _loc7_[_loc8_] = new Array();
            _loc9_ = 0;
            while(_loc9_ < 32)
            {
               floorPos[_loc8_][_loc9_] = -1;
               _loc9_++;
            }
            _loc8_++;
         }
         _loc9_ = 0;
         while(_loc9_ < MainScene(gs).toPlayer.width)
         {
            _loc8_ = 0;
            while(_loc8_ < MainScene(gs).toPlayer.height)
            {
               MainScene(gs).setPassable(_loc9_,_loc8_,false);
               MainScene(gs).setExists(_loc9_,_loc8_,false);
               _loc8_++;
            }
            _loc9_++;
         }
         for each(_loc10_ in gs.objects)
         {
            if(_loc10_ is FloorTile)
            {
               if(!_loc10_._removed)
               {
                  if(_loc10_.obj.width > 52)
                  {
                     _loc10_.basex -= 52;
                  }
                  if(_loc10_.obj.height > 52)
                  {
                     _loc10_.basey -= 52;
                  }
                  _loc24_ = int(_loc10_.basey / 52);
                  _loc25_ = int(_loc10_.basex / 52);
                  _loc7_[_loc24_][_loc25_] = _loc10_.obj;
                  _loc9_ = 0;
                  while(_loc9_ < _loc10_.obj.width / 52)
                  {
                     _loc8_ = 0;
                     while(_loc8_ < _loc10_.obj.height / 52)
                     {
                        floorPos[_loc24_ + _loc8_][_loc25_ + _loc9_] = _loc10_.animFrame;
                        MainScene(gs).setPassable(FloorTile(_loc10_).logicalSquareX() + _loc9_,FloorTile(_loc10_).logicalSquareY() + _loc8_,true);
                        MainScene(gs).setExists(FloorTile(_loc10_).logicalSquareX() + _loc9_,FloorTile(_loc10_).logicalSquareY() + _loc8_,true);
                        _loc8_++;
                     }
                     _loc9_++;
                  }
                  _loc10_.remove();
                  ++tileCount;
               }
            }
         }
         for each(_loc10_ in _loc5_)
         {
            if(_loc10_ is FloorProp)
            {
               if(!param1)
               {
                  _loc10_.remove();
               }
            }
         }
         _loc11_ = GraphicsTools.createFilledSprite(800,600,4294967295);
         _loc12_ = new Embeds.floor_base_jpg();
         floorBitmapData = _loc12_.bitmapData;
         _loc13_ = MainScene(gs).currentEpisode;
         _loc14_ = Embeds.walls[(_loc13_ - _loc13_ % 4) / 4];
         _loc15_ = new Embeds.floor_tile_edge_png();
         if(MainScene(gs).currentEpisode == 0)
         {
            _loc16_ = new ColorTransform(0.92,1,1.4);
         }
         else if(MainScene(gs).currentEpisode == 1)
         {
            _loc16_ = new ColorTransform(1,0.96,1.05);
         }
         else if(MainScene(gs).currentEpisode == 2)
         {
            _loc16_ = new ColorTransform(0.9,1.05,1.3);
         }
         else if(MainScene(gs).currentEpisode == 3)
         {
            _loc16_ = new ColorTransform(1.05,0.92,1.05);
         }
         else if(MainScene(gs).currentEpisode == 4)
         {
            _loc16_ = new ColorTransform(1.3,1.15,1.4);
         }
         else if(MainScene(gs).currentEpisode == 5)
         {
            _loc16_ = new ColorTransform(0.92,1,1.4);
         }
         else if(MainScene(gs).currentEpisode == 6)
         {
            _loc16_ = new ColorTransform(1,0.96,1.05);
         }
         else if(MainScene(gs).currentEpisode == 7)
         {
            _loc16_ = new ColorTransform(0.9,1.09,1.25);
         }
         else if(MainScene(gs).currentEpisode == 8)
         {
            _loc16_ = new ColorTransform(1.3,1.15,1.4);
         }
         else if(MainScene(gs).currentEpisode == 9)
         {
            _loc16_ = new ColorTransform(0.92,1,1.4);
         }
         else if(MainScene(gs).currentEpisode == 10)
         {
            _loc16_ = new ColorTransform(1,0.96,1.05);
         }
         else if(MainScene(gs).currentEpisode == 11)
         {
            _loc16_ = new ColorTransform(0.9,1.05,1.3);
         }
         if(secretRoom)
         {
            _loc16_ = new ColorTransform(0.95,0.75,0.75);
         }
         _loc9_ = 0;
         while(_loc9_ < 800 / 52)
         {
            _loc8_ = 0;
            while(_loc8_ < 800 / 52)
            {
               if(floorPos[_loc8_][_loc9_] >= 0)
               {
                  if(_loc7_[_loc8_][_loc9_])
                  {
                     _loc26_ = _loc7_[_loc8_][_loc9_];
                     _loc26_.x = _loc9_ * 52 + 10;
                     _loc26_.y = _loc8_ * 52 + 14;
                     _loc11_.bitmapData.draw(_loc26_,_loc26_.transform.matrix);
                  }
               }
               _loc8_++;
            }
            _loc9_++;
         }
         _loc11_.bitmapData.draw(_loc12_,null,_loc16_,BlendMode.MULTIPLY);
         var _loc17_:Array = [0,0,0,0,1,1,1,1,2,2,2,2];
         var _loc18_:Bitmap = new Bitmap(Embeds.pit[_loc17_[MainScene(gs).currentEpisode]]);
         _loc9_ = 0;
         while(_loc9_ < 800 / 52)
         {
            _loc8_ = 0;
            while(_loc8_ < 800 / 52)
            {
               if(floorPos[_loc8_][_loc9_] == -1)
               {
                  _loc11_.bitmapData.draw(_loc18_,null,null,null,new Rectangle(_loc9_ * 52 + 10,_loc8_ * 52 + 14,52,52));
               }
               _loc8_++;
            }
            _loc9_++;
         }
         for each(_loc10_ in gs.objects)
         {
            if(_loc10_ is FloorDecalBase && !(_loc10_ is FreeFloorDecal) || decalZOrderChange(_loc10_))
            {
               _loc10_.syncObj(true);
               if(Bitmap(_loc10_.obj).bitmapData)
               {
                  _loc11_.bitmapData.draw(Bitmap(_loc10_.obj).bitmapData,_loc10_.obj.transform.matrix,new ColorTransform(_loc10_.baseBrightness,_loc10_.baseBrightness,_loc10_.baseBrightness,_loc10_.baseAlpha),_loc10_.additive ? BlendMode.ADD : BlendMode.NORMAL,null,true);
               }
               if(_loc10_.animFrame == 11 || _loc10_.animFrame == 12 || _loc10_.animFrame >= 26 && _loc10_.animFrame <= 29 || _loc10_.animFrame >= 56 && _loc10_.animFrame <= 62 && _loc10_.animFrame != 58 || _loc10_.animFrame == 73 || _loc10_.animFrame >= 79 && _loc10_.animFrame <= 86 && _loc10_.animFrame != 80 && _loc10_.animFrame != 86 && _loc10_.animFrame != 83 && _loc10_.animFrame != 82)
               {
                  _loc10_.hide();
               }
               else
               {
                  _loc10_.remove();
               }
               if(_loc10_ is FreeFloorDecal)
               {
                  _loc10_.remove();
               }
            }
         }
         _loc10_ = new GameObject(null,Bitmap,"BelowPlayer",0,0);
         _loc10_.helperAnimation.setFrame(_loc14_);
         _loc9_ = 0;
         while(_loc9_ <= 1)
         {
            _loc8_ = 0;
            while(_loc8_ <= 1)
            {
               _loc10_.basex = _loc9_ * 800;
               _loc10_.basey = _loc8_ * 600;
               _loc10_.baseScaleX = _loc9_ == 0 ? 1 : -1;
               _loc10_.baseScaleY = _loc8_ == 0 ? 1 : -1;
               _loc10_.baseHandleX = 0;
               _loc10_.baseHandleY = 0;
               _loc10_.syncObj(true);
               _loc11_.bitmapData.draw(_loc14_,_loc10_.obj.transform.matrix);
               _loc8_++;
            }
            _loc9_++;
         }
         _loc10_.remove();
         _loc2_ = MainScene(gs).player;
         var _loc19_:int = 256;
         _loc11_.bitmapData.draw(_loc18_,null,null,null,new Rectangle(0,0,startx,600));
         _loc11_.bitmapData.draw(_loc18_,null,null,null,new Rectangle(endx,0,_loc19_,600));
         _loc11_.bitmapData.draw(_loc18_,null,null,null,new Rectangle(0,0,800,starty));
         _loc11_.bitmapData.draw(_loc18_,null,null,null,new Rectangle(0,endy,800,_loc19_));
         nofloorstartx = startx;
         nofloorstarty = starty;
         nofloorendx = endx;
         nofloorendy = endy;
         startx = 0;
         endx = 800;
         starty = 0;
         endy = 600;
         createDoors();
         for each(_loc10_ in gs.objects)
         {
            if(_loc10_ is FreeFloorDecal && !decalZOrderChange(_loc10_))
            {
               _loc10_.syncObj(true);
               if(Bitmap(_loc10_.obj).bitmapData)
               {
                  _loc11_.bitmapData.draw(Bitmap(_loc10_.obj).bitmapData,_loc10_.obj.transform.matrix,new ColorTransform(_loc10_.baseBrightness,_loc10_.baseBrightness,_loc10_.baseBrightness,_loc10_.baseAlpha),_loc10_.additive ? BlendMode.ADD : BlendMode.NORMAL,null,true);
               }
               _loc10_.remove();
            }
         }
         return _loc11_.bitmapData;
      }
      
      public function expediateAmbush() : Boolean
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is TreasureChestBase)
            {
               if(!TreasureChestBase(_loc1_).opened)
               {
                  return false;
               }
            }
         }
         if(ambushRoom)
         {
            ambushRoom = false;
            doAmbush();
            return true;
         }
         return false;
      }
      
      public function updateLastRoom() : void
      {
         var _loc3_:EnemyBase = null;
         var _loc4_:int = 0;
      }
      
      public function chainPush(param1:FloorDecal) : void
      {
         if(param1)
         {
            if(param1._removed)
            {
               chainEnd();
               return;
            }
         }
         if(param1 ? param1.baseWidth == 52 && param1.baseHeight == 52 : false)
         {
            if(!_chainStart)
            {
               _chainStart = param1;
               _chainLength = 1;
            }
            else
            {
               ++_chainLength;
            }
            _chain.push(param1);
         }
         else
         {
            chainEnd();
         }
      }
      
      public function doAmbush() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is EnemyBase)
            {
               EnemyBase(_loc1_).expediateTeleport();
            }
         }
         if(ambushProgress < 100 || !timedAmbush())
         {
            RewardText.createRewardText(gs,400,300,"AMBUSH!","TextLayer",16730174);
            Sounds.trap.play();
         }
         _doAmbush();
         ambushRoom = false;
      }
      
      public function rotationTargetX(param1:int) : int
      {
         var _loc2_:PlayerBase = MainScene(gs).player;
         if(param1 == 1)
         {
            return _loc2_.gridx + 1;
         }
         if(param1 == 3)
         {
            return _loc2_.gridx - 1;
         }
         return _loc2_.gridx;
      }
      
      public function updateReinforcements() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:EnemyLeveling = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:PathfindSquare = null;
         if(reinforcements)
         {
            if(!grabReinforcements)
            {
               grabReinforcements = new Array();
               for each(_loc1_ in gs.objects)
               {
                  if(_loc1_ is EnemyBase)
                  {
                     grabReinforcements.push([Object(_loc1_).constructor,EnemyBase(_loc1_).toughness]);
                  }
               }
            }
            else if(MainScene(gs).lazyEnemiesCount == 1)
            {
               for each(_loc1_ in gs.objects)
               {
                  if(_loc1_ is TreasureChestBase)
                  {
                     if(!TreasureChestBase(_loc1_).opened)
                     {
                        return;
                     }
                  }
               }
               --reinforcementsCreationDelay;
               if(reinforcementsCreationDelay > 0)
               {
                  return;
               }
               if(reinforcementsCreationDelay == 0)
               {
                  RewardText.createRewardText(gs,400,300,"ENEMY REINFORCEMENTS!","TextLayer",16730174);
                  Sounds.trap.play();
               }
               reinforcements = false;
               _loc2_ = false;
               _loc3_ = 0;
               while(_loc3_ < 3)
               {
                  if(MainScene(gs).currentEpisode >= 4)
                  {
                     grabReinforcements = [[Trooper,0],[Brute,0],[RocketBrute,0],[MinigunBrute,0]];
                  }
                  else if(MainScene(gs).currentEpisode >= 2)
                  {
                     grabReinforcements = [[Trooper,0],[Brute,0],[RocketBrute,0]];
                  }
                  else if(_loc2_ || MainScene(gs).currentEpisode == 0)
                  {
                     grabReinforcements = [[Trooper,0]];
                  }
                  else
                  {
                     grabReinforcements = [[Trooper,0],[Brute,0]];
                  }
                  _loc4_ = grabReinforcements[Random.randInt(0,grabReinforcements.length - 1)];
                  _loc1_ = new _loc4_[0](gs,0,0);
                  _loc1_.baseAlpha = 0;
                  _loc1_.obj.alpha = 0;
                  _loc1_.obj.visible = false;
                  _loc1_.obj.x = -1000;
                  Bitmap(_loc1_.obj).bitmapData = null;
                  EnemyBase(_loc1_).legs.hide();
                  EnemyBase(_loc1_).legs.obj.alpha = 0;
                  EnemyBase(_loc1_).legs.obj.visible = false;
                  _loc5_ = MainScene(gs).el;
                  _loc5_.levelEnemies([_loc1_],MainScene(gs).currentEpisode);
                  EnemyBase(_loc1_).hide();
                  EnemyBase(_loc1_).legs.syncObj(true);
                  EnemyBase(_loc1_).syncObj(true);
                  if(_loc1_ is Brute)
                  {
                     _loc2_ = true;
                  }
                  while(true)
                  {
                     _loc1_.basex = Math.random() * 700 + 50;
                     _loc1_.basey = Math.random() * 500 + 50;
                     if(_loc1_.distanceToObject(MainScene(gs).player) >= 100)
                     {
                        _loc6_ = false;
                        _loc7_ = -1;
                        while(_loc7_ <= 1)
                        {
                           _loc8_ = -1;
                           while(_loc8_ <= 1)
                           {
                              _loc9_ = _loc1_.basex + _loc7_ * 48;
                              _loc10_ = _loc1_.basey + _loc8_ * 48;
                              if(!MainScene(gs).squareExists(_loc9_,_loc10_))
                              {
                                 _loc6_ = true;
                              }
                              _loc11_ = MainScene(gs).getSquare(_loc9_,_loc10_);
                              if(_loc11_)
                              {
                                 if(!_loc11_.passable)
                                 {
                                    _loc6_ = true;
                                 }
                              }
                              _loc8_ += 1;
                           }
                           _loc7_ += 1;
                        }
                        EnemyBase(_loc1_).shouldTeleport = true;
                        EnemyBase(_loc1_).teleportOffset = 50 + Math.random() * 100;
                        if(!_loc6_)
                        {
                           break;
                        }
                     }
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      public function rotationTargetY(param1:int) : int
      {
         var _loc2_:PlayerBase = MainScene(gs).player;
         if(param1 == 0)
         {
            return _loc2_.gridy - 1;
         }
         if(param1 == 2)
         {
            return _loc2_.gridy + 1;
         }
         return _loc2_.gridy;
      }
      
      public function createOverArrows() : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:Boolean = false;
         var _loc5_:GameObject = null;
         var _loc1_:PlayerBase = MainScene(gs).player;
         if(_loc1_.inLevelEnd())
         {
            return;
         }
         overArrowsCreated = true;
         overArrows = new Array(4);
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(validRoom(_loc2_))
            {
               _loc4_ = false;
               if(MainScene(gs).player.pathLocked(rotationTargetX(_loc2_),rotationTargetY(_loc2_)))
               {
                  _loc3_ = Embeds.keyRequired[MainScene(gs).player.keyTypeFor(rotationTargetX(_loc2_),rotationTargetY(_loc2_))];
                  _loc4_ = true;
                  _loc5_ = new GameObjectBase(gs,Bitmap,"TextLayer",400,300);
                  _loc5_.hide();
                  _loc5_.helperAnimation.setFrame(_loc3_);
                  _loc5_.basex += _loc1_.cosd(_loc2_ * 90 - 90) * 350;
                  _loc5_.basey += _loc1_.sind(_loc2_ * 90 - 90) * 250;
                  GameObjectBase(_loc5_)._canFall = false;
                  GameObjectBase(_loc5_).collidesWithWalls = false;
                  if(!_loc4_)
                  {
                     _loc5_.baseRotation = _loc2_ * 90;
                  }
                  doors[_loc2_].lockedSprite = _loc5_;
                  overArrows[_loc2_] = _loc5_;
               }
            }
            _loc2_++;
         }
      }
      
      public function isFloorLevel(param1:Array) : Boolean
      {
         var _loc2_:Array = param1[0].getClasses(param1[1]);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] != FloorProp)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function mergeRails() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GameObject = null;
         var _loc4_:int = 0;
         var _loc1_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < 15)
         {
            _loc1_[_loc2_] = new Array(13);
            _loc2_++;
         }
         for each(_loc3_ in gs.objects)
         {
            if(_loc3_ is FloorDecal)
            {
               _loc2_ = MainScene(gs)._getLogicalSquareX(_loc3_.basex);
               _loc4_ = MainScene(gs)._getLogicalSquareY(_loc3_.basey);
               if(!_loc1_[_loc2_][_loc4_])
               {
                  _loc3_.hide();
                  _loc3_.baseAlpha = 0;
                  _loc1_[_loc2_][_loc4_] = _loc3_;
               }
               else
               {
                  _loc3_.remove();
               }
            }
         }
         permanentCollisionMap = _loc1_;
         horizPhase = false;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            chainStart();
            _loc4_ = 0;
            while(_loc4_ < _loc1_[_loc2_].length)
            {
               chainPush(_loc1_[_loc2_][_loc4_]);
               _loc4_++;
            }
            chainEnd();
            _loc2_++;
         }
         horizPhase = true;
         _loc4_ = 0;
         while(_loc4_ < _loc1_[0].length)
         {
            chainStart();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               chainPush(_loc1_[_loc2_][_loc4_]);
               _loc2_++;
            }
            chainEnd();
            _loc4_++;
         }
      }
      
      public function rotationTargetFloorTileX(param1:int) : int
      {
         if(param1 == 1)
         {
            return 14;
         }
         if(param1 == 3)
         {
            return 0;
         }
         return 7;
      }
      
      public function rotationPointsToGrid(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:PlayerBase = MainScene(gs).player;
         if(param1 == 0)
         {
            return param2 == _loc4_.gridx && param3 == _loc4_.gridy - 1;
         }
         if(param1 == 1)
         {
            return param2 == _loc4_.gridx + 1 && param3 == _loc4_.gridy;
         }
         if(param1 == 2)
         {
            return param2 == _loc4_.gridx && param3 == _loc4_.gridy + 1;
         }
         return param2 == _loc4_.gridx - 1 && param3 == _loc4_.gridy;
      }
      
      public function isLastRoom() : Boolean
      {
         return false;
      }
      
      public function lastRoomCanEnd() : Boolean
      {
         if(!isLastRoom())
         {
            return true;
         }
         return lastRoomProgress > 1000;
      }
      
      public function rotationTargetFloorTileY(param1:int) : int
      {
         if(param1 == 0)
         {
            return 0;
         }
         if(param1 == 2)
         {
            return 10;
         }
         return 5;
      }
      
      public function pickupValid(param1:PickupBase) : Boolean
      {
         if(hadWeapon && param1 is PickupWeapon)
         {
            return false;
         }
         if(hadItem && param1 is PickupItem)
         {
            return false;
         }
         if(param1 is PickupWeapon)
         {
            hadWeapon = true;
         }
         if(param1 is PickupItem)
         {
            hadItem = true;
         }
         return true;
      }
      
      public function update() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         updateBridges();
         if(angryTerranTurrets)
         {
            ++angryTerranTurretsTicks;
            if(angryTerranTurretsTicks > 500)
            {
               angryTerranTurrets = false;
            }
         }
         if(ticks == 2)
         {
            mergeRails();
         }
         if(lastGrowl > nextGrowl)
         {
            lastGrowl = 0;
            nextGrowl = Math.random() * 200 + 250;
            if(!ambushRoom)
            {
               _loc1_ = getEnemyGrowls();
               _loc2_ = 0;
               while(_loc2_ < 4)
               {
                  if(_loc1_[possibleGrowlSounds[_loc2_].id])
                  {
                     if(Math.random() < 0.7)
                     {
                        possibleGrowlSounds[_loc2_].play();
                        break;
                     }
                  }
                  _loc2_++;
               }
            }
         }
         if(!MainScene(gs)._paused)
         {
            ++ticks;
            ++lastGrowl;
         }
         if(ticks == 2)
         {
            soundsToPlay = getGrowlSounds(true);
         }
         if(soundsToPlay)
         {
            _loc3_ = false;
            _loc2_ = 0;
            while(_loc2_ < soundsToPlay.length)
            {
               _loc4_ = soundsToPlay[_loc2_];
               if(_loc4_[1] > ticks)
               {
                  _loc3_ = true;
               }
               else if(_loc4_[1] == ticks)
               {
                  _loc4_[0].play();
               }
               _loc2_++;
            }
            if(!_loc3_)
            {
               soundsToPlay = null;
            }
         }
         if(!doneEdgeWarning)
         {
            if(!MainScene(gs).player.edgeWarning)
            {
               if(isEdgeWarningRoom())
               {
                  ++edgeProgress;
                  if(edgeProgress > 50)
                  {
                     MainScene(gs).player.edgeWarning = 1;
                     doneEdgeWarning = true;
                     RewardText.createRewardText(gs,400,300,"WARNING: TAKE CARE AROUND EDGES","TextLayer",16730174,1,0,200);
                  }
               }
            }
         }
         if(reinforcements)
         {
            updateReinforcements();
         }
         updateLastRoom();
         if(ambushRoom)
         {
            updateAmbush();
         }
         if(tileCount < 100)
         {
            if(!ambientChannel)
            {
               ambientChannel = Sounds.cavern.play(true,0,100);
            }
         }
         else if(ambientChannel)
         {
            ambientChannel.stop(100);
            ambientChannel = null;
         }
         if(overArrowsCreated)
         {
            if(MainScene(gs).countEnemies() != 0)
            {
               for each(_loc5_ in overArrows)
               {
                  _loc5_.remove();
               }
               overArrows = null;
               overArrowsCreated = false;
            }
         }
      }
      
      public function _doAmbush() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in gs.objects)
         {
            if(_loc1_ is EnemyCrack)
            {
               EnemyCrack(_loc1_).crack(true);
            }
         }
      }
      
      public function createDoors() : void
      {
         var _loc3_:Door = null;
         var _loc1_:PlayerBase = MainScene(gs).player;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(validRoom(_loc2_))
            {
               _loc3_ = new Door(gs,400,300);
               _loc3_.basex += _loc3_.cosd(_loc2_ * 90 - 90) * (400 - _loc3_.baseHeight / 2);
               _loc3_.basey += _loc3_.sind(_loc2_ * 90 - 90) * (300 - _loc3_.baseHeight / 2);
               if(_loc3_.basex > 600)
               {
                  _loc3_.basex += 1;
               }
               if(_loc3_.basey > 500)
               {
                  _loc3_.basey += 1;
               }
               _loc3_.baseRotation = _loc2_ * 90;
               _loc3_.targetGridX = rotationTargetX(_loc2_);
               _loc3_.targetGridY = rotationTargetY(_loc2_);
               _loc3_.floorTileX = rotationTargetFloorTileX(_loc2_);
               _loc3_.floorTileY = rotationTargetFloorTileY(_loc2_);
               _loc3_.rotationCount = _loc2_;
               if(MainScene(gs).player.pathLocked(_loc3_.targetGridX,_loc3_.targetGridY))
               {
                  _loc3_.setOpen(false);
               }
               else if(MainScene(gs).countEnemies() == 0)
               {
                  _loc3_.setOpen(true);
               }
               else if(rotationPointsToGrid(_loc2_,MainScene(gs).oldGridX,MainScene(gs).oldGridY))
               {
                  _loc3_.setOpen(true);
                  Sounds.doorClose.play();
               }
               else
               {
                  _loc3_.setOpen(false);
               }
               doors[_loc2_] = _loc3_;
            }
            _loc2_++;
         }
      }
      
      public function validRoom(param1:int) : Boolean
      {
         var _loc2_:PlayerBase = MainScene(gs).player;
         var _loc3_:Boolean = false;
         if(param1 == 0)
         {
            _loc3_ = _loc2_.lg.getCell(_loc2_.gridx,_loc2_.gridy - 1) > 0;
         }
         else if(param1 == 1)
         {
            _loc3_ = _loc2_.lg.getCell(_loc2_.gridx + 1,_loc2_.gridy) > 0;
         }
         else if(param1 == 2)
         {
            _loc3_ = _loc2_.lg.getCell(_loc2_.gridx,_loc2_.gridy + 1) > 0;
         }
         else if(param1 == 3)
         {
            _loc3_ = _loc2_.lg.getCell(_loc2_.gridx - 1,_loc2_.gridy) > 0;
         }
         return _loc3_;
      }
   }
}

