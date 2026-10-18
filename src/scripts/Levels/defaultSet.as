package Levels
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Objects.BFG;
   import Objects.BatNest;
   import Objects.BigSpiderGunner;
   import Objects.Bomber;
   import Objects.BomberSmall;
   import Objects.Brute;
   import Objects.Bull;
   import Objects.BullBat;
   import Objects.BullBatBomb;
   import Objects.BullGunner;
   import Objects.Cash;
   import Objects.CratePickup;
   import Objects.Critter;
   import Objects.CritterClusterGrenade;
   import Objects.CritterJump;
   import Objects.DestructableCover;
   import Objects.Egg;
   import Objects.EnemyCrack;
   import Objects.EnemyCrackFake;
   import Objects.FallingTile;
   import Objects.FireHazard;
   import Objects.FloorDecal;
   import Objects.FloorGun;
   import Objects.FloorProp;
   import Objects.FreeFloorDecal;
   import Objects.GooTurret;
   import Objects.GooTurretSpawn;
   import Objects.Grunt;
   import Objects.GruntRider;
   import Objects.GruntRiderArmed;
   import Objects.HoverSwarm;
   import Objects.HoverTrooper;
   import Objects.KeyPlace;
   import Objects.LargeCritter;
   import Objects.MinigunBrute;
   import Objects.MountableTurret;
   import Objects.Nest;
   import Objects.NestSwarm;
   import Objects.PressurePadActive;
   import Objects.PressurePadDisabled;
   import Objects.Rancor;
   import Objects.RespawnPoint;
   import Objects.RocketBrute;
   import Objects.RocketGrunt;
   import Objects.ScreamerTurret;
   import Objects.SecretLift;
   import Objects.SecretLiftFloor;
   import Objects.ShootingGrunt;
   import Objects.ShopTile;
   import Objects.Spawn;
   import Objects.Spider;
   import Objects.SpiderSpit;
   import Objects.SteamHazard;
   import Objects.Swarm;
   import Objects.TreasureChest;
   import Objects.Trooper;
   import Objects.TrooperCommander;
   import Objects.TrooperJet;
   import Objects.Vent;
   import Objects.Wasp;
   import flash.display.Bitmap;
   import flash.utils.getDefinitionByName;
   
   public class defaultSet
   {
      
      public static var levels:int = 105;
      
      public function defaultSet()
      {
         super();
      }
      
      internal function createLevel91(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,1,1,90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel92(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,2],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel93(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,2,1,-270],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel94(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,3],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel95(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,3,1,-270],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel96(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Spider,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel97(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[LargeCritter,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel10(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[EnemyCrack,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel11(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[RocketBrute,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel12(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[SpiderSpit,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel13(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[GooTurret,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel14(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Bomber,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel15(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[RespawnPoint,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel16(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[KeyPlace,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel17(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[ShopTile,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel18(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,28],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      public function init(param1:int, param2:GameScene) : Array
      {
         var _loc4_:GameObject = null;
         var _loc3_:Array = new Array();
         if(param1 == 0)
         {
            createLevel0(_loc3_,param2);
         }
         if(param1 == 1)
         {
            createLevel1(_loc3_,param2);
         }
         if(param1 == 2)
         {
            createLevel2(_loc3_,param2);
         }
         if(param1 == 3)
         {
            createLevel3(_loc3_,param2);
         }
         if(param1 == 4)
         {
            createLevel4(_loc3_,param2);
         }
         if(param1 == 5)
         {
            createLevel5(_loc3_,param2);
         }
         if(param1 == 6)
         {
            createLevel6(_loc3_,param2);
         }
         if(param1 == 7)
         {
            createLevel7(_loc3_,param2);
         }
         if(param1 == 8)
         {
            createLevel8(_loc3_,param2);
         }
         if(param1 == 9)
         {
            createLevel9(_loc3_,param2);
         }
         if(param1 == 10)
         {
            createLevel10(_loc3_,param2);
         }
         if(param1 == 11)
         {
            createLevel11(_loc3_,param2);
         }
         if(param1 == 12)
         {
            createLevel12(_loc3_,param2);
         }
         if(param1 == 13)
         {
            createLevel13(_loc3_,param2);
         }
         if(param1 == 14)
         {
            createLevel14(_loc3_,param2);
         }
         if(param1 == 15)
         {
            createLevel15(_loc3_,param2);
         }
         if(param1 == 16)
         {
            createLevel16(_loc3_,param2);
         }
         if(param1 == 17)
         {
            createLevel17(_loc3_,param2);
         }
         if(param1 == 18)
         {
            createLevel18(_loc3_,param2);
         }
         if(param1 == 19)
         {
            createLevel19(_loc3_,param2);
         }
         if(param1 == 20)
         {
            createLevel20(_loc3_,param2);
         }
         if(param1 == 21)
         {
            createLevel21(_loc3_,param2);
         }
         if(param1 == 22)
         {
            createLevel22(_loc3_,param2);
         }
         if(param1 == 23)
         {
            createLevel23(_loc3_,param2);
         }
         if(param1 == 24)
         {
            createLevel24(_loc3_,param2);
         }
         if(param1 == 25)
         {
            createLevel25(_loc3_,param2);
         }
         if(param1 == 26)
         {
            createLevel26(_loc3_,param2);
         }
         if(param1 == 27)
         {
            createLevel27(_loc3_,param2);
         }
         if(param1 == 28)
         {
            createLevel28(_loc3_,param2);
         }
         if(param1 == 29)
         {
            createLevel29(_loc3_,param2);
         }
         if(param1 == 30)
         {
            createLevel30(_loc3_,param2);
         }
         if(param1 == 31)
         {
            createLevel31(_loc3_,param2);
         }
         if(param1 == 32)
         {
            createLevel32(_loc3_,param2);
         }
         if(param1 == 33)
         {
            createLevel33(_loc3_,param2);
         }
         if(param1 == 34)
         {
            createLevel34(_loc3_,param2);
         }
         if(param1 == 35)
         {
            createLevel35(_loc3_,param2);
         }
         if(param1 == 36)
         {
            createLevel36(_loc3_,param2);
         }
         if(param1 == 37)
         {
            createLevel37(_loc3_,param2);
         }
         if(param1 == 38)
         {
            createLevel38(_loc3_,param2);
         }
         if(param1 == 39)
         {
            createLevel39(_loc3_,param2);
         }
         if(param1 == 40)
         {
            createLevel40(_loc3_,param2);
         }
         if(param1 == 41)
         {
            createLevel41(_loc3_,param2);
         }
         if(param1 == 42)
         {
            createLevel42(_loc3_,param2);
         }
         if(param1 == 43)
         {
            createLevel43(_loc3_,param2);
         }
         if(param1 == 44)
         {
            createLevel44(_loc3_,param2);
         }
         if(param1 == 45)
         {
            createLevel45(_loc3_,param2);
         }
         if(param1 == 46)
         {
            createLevel46(_loc3_,param2);
         }
         if(param1 == 47)
         {
            createLevel47(_loc3_,param2);
         }
         if(param1 == 48)
         {
            createLevel48(_loc3_,param2);
         }
         if(param1 == 49)
         {
            createLevel49(_loc3_,param2);
         }
         if(param1 == 50)
         {
            createLevel50(_loc3_,param2);
         }
         if(param1 == 51)
         {
            createLevel51(_loc3_,param2);
         }
         if(param1 == 52)
         {
            createLevel52(_loc3_,param2);
         }
         if(param1 == 53)
         {
            createLevel53(_loc3_,param2);
         }
         if(param1 == 54)
         {
            createLevel54(_loc3_,param2);
         }
         if(param1 == 55)
         {
            createLevel55(_loc3_,param2);
         }
         if(param1 == 56)
         {
            createLevel56(_loc3_,param2);
         }
         if(param1 == 57)
         {
            createLevel57(_loc3_,param2);
         }
         if(param1 == 58)
         {
            createLevel58(_loc3_,param2);
         }
         if(param1 == 59)
         {
            createLevel59(_loc3_,param2);
         }
         if(param1 == 60)
         {
            createLevel60(_loc3_,param2);
         }
         if(param1 == 61)
         {
            createLevel61(_loc3_,param2);
         }
         if(param1 == 62)
         {
            createLevel62(_loc3_,param2);
         }
         if(param1 == 63)
         {
            createLevel63(_loc3_,param2);
         }
         if(param1 == 64)
         {
            createLevel64(_loc3_,param2);
         }
         if(param1 == 65)
         {
            createLevel65(_loc3_,param2);
         }
         if(param1 == 66)
         {
            createLevel66(_loc3_,param2);
         }
         if(param1 == 67)
         {
            createLevel67(_loc3_,param2);
         }
         if(param1 == 68)
         {
            createLevel68(_loc3_,param2);
         }
         if(param1 == 69)
         {
            createLevel69(_loc3_,param2);
         }
         if(param1 == 70)
         {
            createLevel70(_loc3_,param2);
         }
         if(param1 == 71)
         {
            createLevel71(_loc3_,param2);
         }
         if(param1 == 72)
         {
            createLevel72(_loc3_,param2);
         }
         if(param1 == 73)
         {
            createLevel73(_loc3_,param2);
         }
         if(param1 == 74)
         {
            createLevel74(_loc3_,param2);
         }
         if(param1 == 75)
         {
            createLevel75(_loc3_,param2);
         }
         if(param1 == 76)
         {
            createLevel76(_loc3_,param2);
         }
         if(param1 == 77)
         {
            createLevel77(_loc3_,param2);
         }
         if(param1 == 78)
         {
            createLevel78(_loc3_,param2);
         }
         if(param1 == 79)
         {
            createLevel79(_loc3_,param2);
         }
         if(param1 == 80)
         {
            createLevel80(_loc3_,param2);
         }
         if(param1 == 81)
         {
            createLevel81(_loc3_,param2);
         }
         if(param1 == 82)
         {
            createLevel82(_loc3_,param2);
         }
         if(param1 == 83)
         {
            createLevel83(_loc3_,param2);
         }
         if(param1 == 84)
         {
            createLevel84(_loc3_,param2);
         }
         if(param1 == 85)
         {
            createLevel85(_loc3_,param2);
         }
         if(param1 == 86)
         {
            createLevel86(_loc3_,param2);
         }
         if(param1 == 87)
         {
            createLevel87(_loc3_,param2);
         }
         if(param1 == 88)
         {
            createLevel88(_loc3_,param2);
         }
         if(param1 == 89)
         {
            createLevel89(_loc3_,param2);
         }
         if(param1 == 90)
         {
            createLevel90(_loc3_,param2);
         }
         if(param1 == 91)
         {
            createLevel91(_loc3_,param2);
         }
         if(param1 == 92)
         {
            createLevel92(_loc3_,param2);
         }
         if(param1 == 93)
         {
            createLevel93(_loc3_,param2);
         }
         if(param1 == 94)
         {
            createLevel94(_loc3_,param2);
         }
         if(param1 == 95)
         {
            createLevel95(_loc3_,param2);
         }
         if(param1 == 96)
         {
            createLevel96(_loc3_,param2);
         }
         if(param1 == 97)
         {
            createLevel97(_loc3_,param2);
         }
         if(param1 == 98)
         {
            createLevel98(_loc3_,param2);
         }
         if(param1 == 99)
         {
            createLevel99(_loc3_,param2);
         }
         if(param1 == 100)
         {
            createLevel100(_loc3_,param2);
         }
         if(param1 == 101)
         {
            createLevel101(_loc3_,param2);
         }
         if(param1 == 102)
         {
            createLevel102(_loc3_,param2);
         }
         if(param1 == 103)
         {
            createLevel103(_loc3_,param2);
         }
         if(param1 == 104)
         {
            createLevel104(_loc3_,param2);
         }
         return _loc3_;
      }
      
      internal function createLevel101(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorDecal,400,300,90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel102(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorDecal,400,300,91],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel103(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorDecal,400,300,92],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel104(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[CratePickup,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel98(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,37],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel19(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[TreasureChest,401,294,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel100(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorDecal,400,300,89],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel99(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,38],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel20(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Cash,400,300,0],[Cash,452,300,0],[Cash,452,248,0],[Cash,348,300,0],[Cash,400,352,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel21(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel22(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,2],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel23(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Bull,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel24(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[ShootingGrunt,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel25(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,31],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel26(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[KeyPlace,400,300,1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel27(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[KeyPlace,400,300,2],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel28(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Spawn,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel29(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BigSpiderGunner,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel30(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FallingTile,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel31(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Egg,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel32(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Egg,400,300,1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel0(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Grunt,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel1(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Trooper,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel2(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel3(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Brute,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel4(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Nest,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel5(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Swarm,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel6(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,4],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel7(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[GruntRider,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel8(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[TrooperCommander,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel9(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[TrooperJet,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel36(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,29,1,-90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel37(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,30],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel38(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,30,1,-90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel39(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,30,1,-180],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel33(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,8],[FreeFloorDecal,423,318,3,0.440000534],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel34(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,9],[FreeFloorDecal,423,318,3,0.530000448],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel35(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,29],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      public function createObject(param1:Array, param2:GameScene) : GameObject
      {
         var _loc3_:GameObject = null;
         if(param1.length > 0)
         {
            _loc3_ = new param1[0](param2,param1[1],param1[2]);
            if(param1[3] != 0)
            {
               if(_loc3_["images"])
               {
                  Bitmap(_loc3_.obj).bitmapData = _loc3_["images"][param1[3]];
                  _loc3_.baseWidth = _loc3_.obj.width;
                  _loc3_.baseHeight = _loc3_.obj.height;
                  _loc3_.animFrame = param1[3];
               }
            }
            if(param1.length > 4)
            {
               _loc3_.baseAlpha = param1[4];
            }
            if(param1.length > 5)
            {
               _loc3_.baseRotation = param1[5];
            }
            if(param1.length > 7)
            {
               _loc3_.baseScaleX = param1[6];
               _loc3_.baseScaleY = param1[7];
            }
            if(param1.length > 8)
            {
               _loc3_.baseBrightness = param1[8];
            }
            if(param1.length > 9)
            {
               _loc3_.additive = true;
            }
            return _loc3_;
         }
         return null;
      }
      
      internal function createLevel40(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,30,1,90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel41(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[EnemyCrackFake,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel42(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[SteamHazard,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel43(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[SteamHazard,400,300,0,1,-90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel44(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[SteamHazard,400,300,0,1,-180],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel45(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[SteamHazard,400,300,0,1,90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel46(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FireHazard,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel47(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FireHazard,400,300,0,1,-90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel48(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FireHazard,400,300,0,1,-180],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel49(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FireHazard,400,300,0,1,90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel50(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Cash,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel51(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Critter,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel52(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[DestructableCover,400,300,1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel53(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[DestructableCover,400,300,2],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel54(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[DestructableCover,400,300,1,1,90,1,-1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel55(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[DestructableCover,400,300,2,1,-270,1,-1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel56(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[SecretLift,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel57(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[SecretLiftFloor,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel58(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[PressurePadActive,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel59(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[PressurePadDisabled,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel60(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[HoverSwarm,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel61(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[DestructableCover,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel62(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[MinigunBrute,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel63(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[GruntRiderArmed,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel64(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[MountableTurret,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel65(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Rancor,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel66(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorGun,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel67(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[ScreamerTurret,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel68(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[DestructableCover,400,300,3],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel69(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,35],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel70(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[RocketGrunt,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel71(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Wasp,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel72(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[GooTurretSpawn,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel73(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BatNest,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel74(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BatNest,400,300,0,1,-90,-1,1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel75(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BatNest,400,300,0,1,-900,-1,1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel76(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BatNest,400,300,0,1,-270],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel77(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BullBat,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel78(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[NestSwarm,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel79(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Egg,400,300,2],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel80(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BomberSmall,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel81(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[CritterJump,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel82(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[FloorProp,400,300,36],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel83(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BFG,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel84(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BullBatBomb,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel85(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[BullGunner,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel86(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[CritterClusterGrenade,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel87(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[HoverTrooper,400,300,0],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel88(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,0,1,-360],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      internal function createLevel89(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,0,1,90],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
      
      public function getClasses(param1:int) : Array
      {
         var _loc2_:Array = new Array();
         if(param1 == 0)
         {
            return [Grunt];
         }
         if(param1 == 1)
         {
            return [Trooper];
         }
         if(param1 == 2)
         {
            return [FloorProp];
         }
         if(param1 == 3)
         {
            return [Brute];
         }
         if(param1 == 4)
         {
            return [Nest];
         }
         if(param1 == 5)
         {
            return [Swarm];
         }
         if(param1 == 6)
         {
            return [FloorProp];
         }
         if(param1 == 7)
         {
            return [GruntRider];
         }
         if(param1 == 8)
         {
            return [TrooperCommander];
         }
         if(param1 == 9)
         {
            return [TrooperJet];
         }
         if(param1 == 10)
         {
            return [EnemyCrack];
         }
         if(param1 == 11)
         {
            return [RocketBrute];
         }
         if(param1 == 12)
         {
            return [SpiderSpit];
         }
         if(param1 == 13)
         {
            return [GooTurret];
         }
         if(param1 == 14)
         {
            return [Bomber];
         }
         if(param1 == 15)
         {
            return [RespawnPoint];
         }
         if(param1 == 16)
         {
            return [KeyPlace];
         }
         if(param1 == 17)
         {
            return [ShopTile];
         }
         if(param1 == 18)
         {
            return [FloorProp];
         }
         if(param1 == 19)
         {
            return [TreasureChest];
         }
         if(param1 == 20)
         {
            return [Cash,Cash,Cash,Cash,Cash];
         }
         if(param1 == 21)
         {
            return [FloorProp];
         }
         if(param1 == 22)
         {
            return [FloorProp];
         }
         if(param1 == 23)
         {
            return [Bull];
         }
         if(param1 == 24)
         {
            return [ShootingGrunt];
         }
         if(param1 == 25)
         {
            return [FloorProp];
         }
         if(param1 == 26)
         {
            return [KeyPlace];
         }
         if(param1 == 27)
         {
            return [KeyPlace];
         }
         if(param1 == 28)
         {
            return [Spawn];
         }
         if(param1 == 29)
         {
            return [BigSpiderGunner];
         }
         if(param1 == 30)
         {
            return [FallingTile];
         }
         if(param1 == 31)
         {
            return [Egg];
         }
         if(param1 == 32)
         {
            return [Egg];
         }
         if(param1 == 33)
         {
            return [FloorProp,FreeFloorDecal];
         }
         if(param1 == 34)
         {
            return [FloorProp,FreeFloorDecal];
         }
         if(param1 == 35)
         {
            return [FloorProp];
         }
         if(param1 == 36)
         {
            return [FloorProp];
         }
         if(param1 == 37)
         {
            return [FloorProp];
         }
         if(param1 == 38)
         {
            return [FloorProp];
         }
         if(param1 == 39)
         {
            return [FloorProp];
         }
         if(param1 == 40)
         {
            return [FloorProp];
         }
         if(param1 == 41)
         {
            return [EnemyCrackFake];
         }
         if(param1 == 42)
         {
            return [SteamHazard];
         }
         if(param1 == 43)
         {
            return [SteamHazard];
         }
         if(param1 == 44)
         {
            return [SteamHazard];
         }
         if(param1 == 45)
         {
            return [SteamHazard];
         }
         if(param1 == 46)
         {
            return [FireHazard];
         }
         if(param1 == 47)
         {
            return [FireHazard];
         }
         if(param1 == 48)
         {
            return [FireHazard];
         }
         if(param1 == 49)
         {
            return [FireHazard];
         }
         if(param1 == 50)
         {
            return [Cash];
         }
         if(param1 == 51)
         {
            return [Critter];
         }
         if(param1 == 52)
         {
            return [DestructableCover];
         }
         if(param1 == 53)
         {
            return [DestructableCover];
         }
         if(param1 == 54)
         {
            return [DestructableCover];
         }
         if(param1 == 55)
         {
            return [DestructableCover];
         }
         if(param1 == 56)
         {
            return [SecretLift];
         }
         if(param1 == 57)
         {
            return [SecretLiftFloor];
         }
         if(param1 == 58)
         {
            return [PressurePadActive];
         }
         if(param1 == 59)
         {
            return [PressurePadDisabled];
         }
         if(param1 == 60)
         {
            return [HoverSwarm];
         }
         if(param1 == 61)
         {
            return [DestructableCover];
         }
         if(param1 == 62)
         {
            return [MinigunBrute];
         }
         if(param1 == 63)
         {
            return [GruntRiderArmed];
         }
         if(param1 == 64)
         {
            return [MountableTurret];
         }
         if(param1 == 65)
         {
            return [Rancor];
         }
         if(param1 == 66)
         {
            return [FloorGun];
         }
         if(param1 == 67)
         {
            return [ScreamerTurret];
         }
         if(param1 == 68)
         {
            return [DestructableCover];
         }
         if(param1 == 69)
         {
            return [FloorProp];
         }
         if(param1 == 70)
         {
            return [RocketGrunt];
         }
         if(param1 == 71)
         {
            return [Wasp];
         }
         if(param1 == 72)
         {
            return [GooTurretSpawn];
         }
         if(param1 == 73)
         {
            return [BatNest];
         }
         if(param1 == 74)
         {
            return [BatNest];
         }
         if(param1 == 75)
         {
            return [BatNest];
         }
         if(param1 == 76)
         {
            return [BatNest];
         }
         if(param1 == 77)
         {
            return [BullBat];
         }
         if(param1 == 78)
         {
            return [NestSwarm];
         }
         if(param1 == 79)
         {
            return [Egg];
         }
         if(param1 == 80)
         {
            return [BomberSmall];
         }
         if(param1 == 81)
         {
            return [CritterJump];
         }
         if(param1 == 82)
         {
            return [FloorProp];
         }
         if(param1 == 83)
         {
            return [BFG];
         }
         if(param1 == 84)
         {
            return [BullBatBomb];
         }
         if(param1 == 85)
         {
            return [BullGunner];
         }
         if(param1 == 86)
         {
            return [CritterClusterGrenade];
         }
         if(param1 == 87)
         {
            return [HoverTrooper];
         }
         if(param1 == 88)
         {
            return [Vent];
         }
         if(param1 == 89)
         {
            return [Vent];
         }
         if(param1 == 90)
         {
            return [Vent];
         }
         if(param1 == 91)
         {
            return [Vent];
         }
         if(param1 == 92)
         {
            return [Vent];
         }
         if(param1 == 93)
         {
            return [Vent];
         }
         if(param1 == 94)
         {
            return [Vent];
         }
         if(param1 == 95)
         {
            return [Vent];
         }
         if(param1 == 96)
         {
            return [Spider];
         }
         if(param1 == 97)
         {
            return [LargeCritter];
         }
         if(param1 == 98)
         {
            return [FloorProp];
         }
         if(param1 == 99)
         {
            return [FloorProp];
         }
         if(param1 == 100)
         {
            return [FloorDecal];
         }
         if(param1 == 101)
         {
            return [FloorDecal];
         }
         if(param1 == 102)
         {
            return [FloorDecal];
         }
         if(param1 == 103)
         {
            return [FloorDecal];
         }
         if(param1 == 104)
         {
            return [CratePickup];
         }
         return _loc2_;
      }
      
      internal function createLevel90(param1:Array, param2:GameScene) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GameObject = null;
         var _loc3_:Array = [[Vent,400,300,1],[]];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createObject(_loc4_,param2);
            if(_loc5_)
            {
               param1.push(_loc5_);
            }
         }
      }
   }
}

