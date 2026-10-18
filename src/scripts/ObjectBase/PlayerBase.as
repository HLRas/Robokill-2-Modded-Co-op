package ObjectBase
{
   import Audio.GameSoundChannel;
   import GameObject.*;
   import GameScene.*;
   import GlobalSetup.Embeds;
   import InventoryScreen.HUDDisplay;
   import InventoryScreen.Help;
   import InventoryScreen.LevelUp;
   import LevelGridTools.*;
   import Objects.*;
   import Particles.Particle;
   import Scenes.*;
   import Serialization.*;
   import Templates.IconCollection;
   import Templates.RewardText;
   import Tools.*;
   import WeaponPlugin.*;
   import Weapons.*;
   import flash.display.*;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class PlayerBase extends ActorBase
   {
      
      private var _gridx:int = 0;
      
      public var shieldObject:ShieldBar;
      
      public var shotgunThisFrame:Boolean = false;
      
      private var _chargeHelp:Boolean = false;
      
      public var offsetsX:Array = [6,-6,16,-16];
      
      public var offsetsY:Array = [14,14,16,16];
      
      public var legs:LegsBase;
      
      private var _destBaseY:Number;
      
      public var shields:Number = 1;
      
      private var _destBaseX:Number;
      
      public var _inShield:int = 0;
      
      public var queuedLevelUp:Boolean = false;
      
      public var xpObject:XPBar;
      
      public var inLevelUp:int = 0;
      
      public var weaponIcons:Array = new Array(4);
      
      public var killdx:Boolean = false;
      
      public var killdy:Boolean = false;
      
      public var inCombat:int = 0;
      
      public var shredderThisFrame:Boolean = false;
      
      public var doneActiveHelpQuickCheck:Boolean = false;
      
      public var handleMouseX:Number = 0;
      
      public var handleMouseY:Number = 0;
      
      public var extradx:Number = 0;
      
      public var extrady:Number = 0;
      
      public var constricted:int = 0;
      
      private var _mapHelp:Boolean = false;
      
      private var _money:int = 999999999;
      
      private var _inventoryHelp:Boolean = false;
      
      public var lowHealth:GameObject;
      
      public var levelText:GameObject;
      
      public var criticalHealth:GameObject;
      
      public var laserThisFrame:Boolean = false;
      
      public var riotShield:GameObject;
      
      public var cashBacking:GameObject;
      
      public var cashText:GameObject;
      
      public var lastPlayed:int = 0;
      
      private var _teleportHelp:Boolean = false;
      
      public var lastHitRiot:Boolean = false;
      
      private var _edgeWarning:int = 0;
      
      private var _queuedExperience:int = 0;
      
      private var _roomsExplored:int = 0;
      
      private var _shopHelp:Boolean = false;
      
      private var _keyTypes:Array = [0,0,0,0,0,0];
      
      private var _inventory:Array = new Array(28);
      
      private var _activeHelp:Boolean = false;
      
      private var _experience:int = 0;
      
      private var _seekSpawnPoint:Boolean = true;
      
      public var plasmaShotgunThisFrame:Boolean = false;
      
      public var levelBacking:GameObject;
      
      private var _lg:LevelGrid = new LevelGrid();
      
      private var _level:int = 1;
      
      private var _hudKeys:IconCollection;
      
      private var _expediatedDrop:Boolean = false;
      
      private var _seekLift:Boolean = false;
      
      public var lastdx:Number = 0;
      
      public var lastdy:Number = 0;
      
      public var oldWeapons:Array = new Array(4);
      
      public var expSoundChannel:GameSoundChannel;
      
      public var lastMedkit:int = 0;
      
      private var _items:Array = new Array(4);
      
      public var itemIcons:Array = new Array(4);
      
      public var lastLaser:int = 0;
      
      public var pulseThisFrame:Boolean = false;
      
      public var grenadeThisFrame:Boolean = false;
      
      private var _weapons:Array = new Array(4);
      
      private var _keyCount:int = 0;
      
      private var _totalKills:int = 0;
      
      private var _gridy:int = 0;
      
      public var fallingLatch:Boolean = false;
      
      // ---- Co-op: player 2 shares progression (cash, XP, keys, loadout, room) with player 1 ----
      public static var pendingPartner:PlayerBase = null;
      
      public var partner:PlayerBase = null;
      
      public var p2Bar:ShieldBar;
      
      public var p2Label:GameObject;
      
      public var p2Charges:Array = [0,0,0,0];
      
      public function get gridx() : int
      {
         return partner ? partner.gridx : _gridx;
      }
      
      public function set gridx(param1:int) : void
      {
         if(partner)
         {
            partner.gridx = param1;
            return;
         }
         _gridx = param1;
      }
      
      public function get gridy() : int
      {
         return partner ? partner.gridy : _gridy;
      }
      
      public function set gridy(param1:int) : void
      {
         if(partner)
         {
            partner.gridy = param1;
            return;
         }
         _gridy = param1;
      }
      
      public function get chargeHelp() : Boolean
      {
         return partner ? partner.chargeHelp : _chargeHelp;
      }
      
      public function set chargeHelp(param1:Boolean) : void
      {
         if(partner)
         {
            partner.chargeHelp = param1;
            return;
         }
         _chargeHelp = param1;
      }
      
      public function get destBaseY() : Number
      {
         return partner ? partner.destBaseY : _destBaseY;
      }
      
      public function set destBaseY(param1:Number) : void
      {
         if(partner)
         {
            partner.destBaseY = param1;
            return;
         }
         _destBaseY = param1;
      }
      
      public function get destBaseX() : Number
      {
         return partner ? partner.destBaseX : _destBaseX;
      }
      
      public function set destBaseX(param1:Number) : void
      {
         if(partner)
         {
            partner.destBaseX = param1;
            return;
         }
         _destBaseX = param1;
      }
      
      public function get money() : int
      {
         return partner ? partner.money : _money;
      }
      
      public function set money(param1:int) : void
      {
         if(partner)
         {
            partner.money = param1;
            return;
         }
         _money = param1;
      }
      
      public function get inventoryHelp() : Boolean
      {
         return partner ? partner.inventoryHelp : _inventoryHelp;
      }
      
      public function set inventoryHelp(param1:Boolean) : void
      {
         if(partner)
         {
            partner.inventoryHelp = param1;
            return;
         }
         _inventoryHelp = param1;
      }
      
      public function get teleportHelp() : Boolean
      {
         return partner ? partner.teleportHelp : _teleportHelp;
      }
      
      public function set teleportHelp(param1:Boolean) : void
      {
         if(partner)
         {
            partner.teleportHelp = param1;
            return;
         }
         _teleportHelp = param1;
      }
      
      public function get edgeWarning() : int
      {
         return partner ? partner.edgeWarning : _edgeWarning;
      }
      
      public function set edgeWarning(param1:int) : void
      {
         if(partner)
         {
            partner.edgeWarning = param1;
            return;
         }
         _edgeWarning = param1;
      }
      
      public function get queuedExperience() : int
      {
         return partner ? partner.queuedExperience : _queuedExperience;
      }
      
      public function set queuedExperience(param1:int) : void
      {
         if(partner)
         {
            partner.queuedExperience = param1;
            return;
         }
         _queuedExperience = param1;
      }
      
      public function get roomsExplored() : int
      {
         return partner ? partner.roomsExplored : _roomsExplored;
      }
      
      public function set roomsExplored(param1:int) : void
      {
         if(partner)
         {
            partner.roomsExplored = param1;
            return;
         }
         _roomsExplored = param1;
      }
      
      public function get shopHelp() : Boolean
      {
         return partner ? partner.shopHelp : _shopHelp;
      }
      
      public function set shopHelp(param1:Boolean) : void
      {
         if(partner)
         {
            partner.shopHelp = param1;
            return;
         }
         _shopHelp = param1;
      }
      
      public function get keyTypes() : Array
      {
         return partner ? partner.keyTypes : _keyTypes;
      }
      
      public function set keyTypes(param1:Array) : void
      {
         if(partner)
         {
            partner.keyTypes = param1;
            return;
         }
         _keyTypes = param1;
      }
      
      public function get inventory() : Array
      {
         return partner ? partner.inventory : _inventory;
      }
      
      public function set inventory(param1:Array) : void
      {
         if(partner)
         {
            partner.inventory = param1;
            return;
         }
         _inventory = param1;
      }
      
      public function get activeHelp() : Boolean
      {
         return partner ? partner.activeHelp : _activeHelp;
      }
      
      public function set activeHelp(param1:Boolean) : void
      {
         if(partner)
         {
            partner.activeHelp = param1;
            return;
         }
         _activeHelp = param1;
      }
      
      public function get experience() : int
      {
         return partner ? partner.experience : _experience;
      }
      
      public function set experience(param1:int) : void
      {
         if(partner)
         {
            partner.experience = param1;
            return;
         }
         _experience = param1;
      }
      
      public function get seekSpawnPoint() : Boolean
      {
         return partner ? partner.seekSpawnPoint : _seekSpawnPoint;
      }
      
      public function set seekSpawnPoint(param1:Boolean) : void
      {
         if(partner)
         {
            partner.seekSpawnPoint = param1;
            return;
         }
         _seekSpawnPoint = param1;
      }
      
      public function get lg() : LevelGrid
      {
         return partner ? partner.lg : _lg;
      }
      
      public function set lg(param1:LevelGrid) : void
      {
         if(partner)
         {
            partner.lg = param1;
            return;
         }
         _lg = param1;
      }
      
      public function get level() : int
      {
         return partner ? partner.level : _level;
      }
      
      public function set level(param1:int) : void
      {
         if(partner)
         {
            partner.level = param1;
            return;
         }
         _level = param1;
      }
      
      public function get hudKeys() : IconCollection
      {
         return partner ? partner.hudKeys : _hudKeys;
      }
      
      public function set hudKeys(param1:IconCollection) : void
      {
         if(partner)
         {
            partner.hudKeys = param1;
            return;
         }
         _hudKeys = param1;
      }
      
      public function get expediatedDrop() : Boolean
      {
         return partner ? partner.expediatedDrop : _expediatedDrop;
      }
      
      public function set expediatedDrop(param1:Boolean) : void
      {
         if(partner)
         {
            partner.expediatedDrop = param1;
            return;
         }
         _expediatedDrop = param1;
      }
      
      public function get seekLift() : Boolean
      {
         return partner ? partner.seekLift : _seekLift;
      }
      
      public function set seekLift(param1:Boolean) : void
      {
         if(partner)
         {
            partner.seekLift = param1;
            return;
         }
         _seekLift = param1;
      }
      
      public function get items() : Array
      {
         return partner ? partner.items : _items;
      }
      
      public function set items(param1:Array) : void
      {
         if(partner)
         {
            partner.items = param1;
            return;
         }
         _items = param1;
      }
      
      public function get weapons() : Array
      {
         return partner ? partner.weapons : _weapons;
      }
      
      public function set weapons(param1:Array) : void
      {
         if(partner)
         {
            partner.weapons = param1;
            return;
         }
         _weapons = param1;
      }
      
      public function get keyCount() : int
      {
         return partner ? partner.keyCount : _keyCount;
      }
      
      public function set keyCount(param1:int) : void
      {
         if(partner)
         {
            partner.keyCount = param1;
            return;
         }
         _keyCount = param1;
      }
      
      public function get totalKills() : int
      {
         return partner ? partner.totalKills : _totalKills;
      }
      
      public function set totalKills(param1:int) : void
      {
         if(partner)
         {
            partner.totalKills = param1;
            return;
         }
         _totalKills = param1;
      }
      
      public function get mapHelp() : Boolean
      {
         return partner ? partner.mapHelp : _mapHelp;
      }
      
      public function set mapHelp(param1:Boolean) : void
      {
         if(partner)
         {
            partner.mapHelp = param1;
            return;
         }
         _mapHelp = param1;
      }
      
      public function PlayerBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         partner = pendingPartner;
         pendingPartner = null;
         shouldTeleport = true;
         teleportOffset = 80;
         if(!partner)
         {
            lg.init(MainScene(param1).currentEpisode);
            gridx = lg.startx;
            gridy = lg.starty;
         }
         super(param1,param2,param3,param4,param5);
         if(partner)
         {
            legs = new PlayerLegs(param1,4,4);
            legs.tformFromParent = false;
            addChild(legs);
            addFilter(new GameObjectFilterRotateSlowly(10));
            createP2Hud();
            return;
         }
         shieldObject = new ShieldBar(param1,94,0);
         shieldObject.baseHandleX = 0;
         shieldObject.baseHandleY = 0;
         xpObject = new XPBar(param1,561,0);
         xpObject.baseHandleX = 0;
         xpObject.baseHandleY = 0;
         cashBacking = new GameObject(param1,Embeds.hud_cash_png,"TextLayer",0,0);
         cashBacking.baseHandleX = 0;
         cashBacking.baseHandleY = 0;
         levelBacking = new GameObject(param1,Embeds.hud_xp_lev_png,"TextLayer",800,0);
         levelBacking.baseHandleX = 1;
         levelBacking.baseHandleY = 0;
         cashText = new GameObject(param1,null,"TextLayer",0,0);
         cashText.fontName = "Pixelation-34";
         cashText.setText("0",7,16764727);
         cashText.basex = 39;
         cashText.basey = 2;
         cashText.baseHandleX = 0;
         levelText = new GameObject(param1,null,"TextLayer",0,0);
         levelText.fontName = "Pixelation-34";
         levelText.setText("00",7,16764727);
         levelText.basex = 785;
         levelText.basey = 2;
         levelText.baseHandleX = 0;
         hudKeys = new IconCollection(param1,Embeds.key_1_embed,"TextLayer",800 - 4,20,5,8,true);
         legs = new PlayerLegs(param1,4,4);
         legs.tformFromParent = false;
         addChild(legs);
         addFilter(new GameObjectFilterRotateSlowly(10));
         level = int(Profile.defLookup("level"));
         experience = Number(Profile.defLookup("experience"));
         money = int(Profile.defLookup("cash"));
         totalKills = int(Profile.defLookup("totalkills"));
         weapons = Profile.defLookupArray("playerWeapons");
         inventory = Profile.defLookupArray("playerInventory");
         items = Profile.defLookupArray("playerItems");
         expediatedDrop = Boolean(Profile.defLookup("expediateddrop"));
         name = String(Profile.defLookup("name"));
         teleportHelp = Boolean(Profile.defLookup("teleporthelp"));
         mapHelp = Boolean(Profile.defLookup("maphelp"));
         shopHelp = Boolean(Profile.defLookup("shophelp"));
         inventoryHelp = Boolean(Profile.defLookup("inventoryhelp"));
         chargeHelp = Boolean(Profile.defLookup("chargehelp"));
         activeHelp = Boolean(Profile.defLookup("activehelp"));
         edgeWarning = int(Profile.defLookup("edgewarning"));
         if(weapons.length < 4)
         {
            giveDefaultWeapons();
         }
         if(weapons[0] == null && weapons[1] == null && weapons[2] == null && weapons[3] == null)
         {
            giveDefaultWeapons();
         }
         if(items.length != 4)
         {
            items = new Array(4);
         }
         if(inventory.length != 28)
         {
            inventory = new Array(28);
         }
      }
      
      public function isPlayer2() : Boolean
      {
         return partner != null;
      }

      // Where this player is aiming: the mouse (or player 1's pad) for player 1, the right stick for player 2.
      public function aimPointX() : Number
      {
         if(partner)
         {
            return basex + Number(Input.i.p2Pad.aimX) * Input.aimRadius;
         }
         return Input.i.mouseX();
      }

      public function aimPointY() : Number
      {
         if(partner)
         {
            return basey + Number(Input.i.p2Pad.aimY) * Input.aimRadius;
         }
         return Input.i.mouseY();
      }

      public function fireHeld() : Boolean
      {
         if(partner)
         {
            return Boolean(Input.i.p2Pad.fire);
         }
         return Boolean(Input.i.mouseDown());
      }

      public static function hueMatrix(param1:Number) : Array
      {
         var c:Number = Math.cos(param1 * Math.PI / 180);
         var s:Number = Math.sin(param1 * Math.PI / 180);
         return [0.213 + c * 0.787 - s * 0.213,0.715 - c * 0.715 - s * 0.715,0.072 - c * 0.072 + s * 0.928,0.213 - c * 0.213 + s * 0.143,0.715 + c * 0.285 + s * 0.14,0.072 - c * 0.072 - s * 0.283,0.213 - c * 0.213 - s * 0.787,0.715 - c * 0.715 + s * 0.715,0.072 + c * 0.928 + s * 0.072];
      }

      public static function colorFilter(param1:Array) : ColorMatrixFilter
      {
         return new ColorMatrixFilter([param1[0],param1[1],param1[2],0,0,param1[3],param1[4],param1[5],0,0,param1[6],param1[7],param1[8],0,0,0,0,0,1,0]);
      }

      // The game's own tint matrix (used for hit flashes and falling) applied on top of the green hue shift.
      public static function p2TintFilter(param1:Number, param2:Number, param3:Number) : ColorMatrixFilter
      {
         var t:Array = [param1,param2,param3,param3,param1,param2,param2,param3,param1];
         var h:Array = hueMatrix(75);
         var m:Array = new Array(9);
         var r:int = 0;
         var k:int = 0;
         while(r < 3)
         {
            k = 0;
            while(k < 3)
            {
               m[r * 3 + k] = t[r * 3] * h[k] + t[r * 3 + 1] * h[3 + k] + t[r * 3 + 2] * h[6 + k];
               k++;
            }
            r++;
         }
         return colorFilter(m);
      }

      override public function tintClip(param1:DisplayObject, param2:Number, param3:Number, param4:Number) : void
      {
         if(!partner)
         {
            super.tintClip(param1,param2,param3,param4);
            return;
         }
         param1.filters = [p2TintFilter(param2,param3,param4)];
      }

      public function createP2Hud() : void
      {
         var _loc1_:GameObject = null;
         p2Label = new GameObject(gs,null,"TextLayer",0,0);
         p2Label.fontName = "Pixelation-34";
         p2Label.setText("P2",7,Input.P2_COLOR);
         p2Label.basex = 313;
         p2Label.basey = 2;
         p2Label.baseHandleX = 0;
         p2Bar = new ShieldBar(gs,330,0);
         p2Bar.baseHandleX = 0;
         p2Bar.baseHandleY = 0;
         p2Bar.obj.filters = [colorFilter(hueMatrix(-85))];
         _loc1_ = p2Bar.findChildrenByName("full")[0];
         if(_loc1_)
         {
            _loc1_.obj.filters = [colorFilter(hueMatrix(-85))];
         }
      }

      public function removeP2Hud() : void
      {
         if(p2Bar)
         {
            p2Bar.remove();
            p2Bar = null;
         }
         if(p2Label)
         {
            p2Label.remove();
            p2Label = null;
         }
      }

      // Player 2 uses the shared active items with LB / X (slot 1) and RB (slot 2).
      public function useP2Items() : void
      {
         var _loc1_:Boolean = Input.i.padHit(Input.i.p2Pad,Input.PAD_LB);
         _loc1_ = Input.i.padHit(Input.i.p2Pad,Input.PAD_X) || _loc1_;
         var _loc2_:Boolean = Input.i.padHit(Input.i.p2Pad,Input.PAD_RB);
         if(beforeTeleporting() || falling)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 2)
         {
            if((_loc3_ == 0 ? _loc1_ : _loc2_) && items[_loc3_])
            {
               if(items[_loc3_].rechargeProgress / items[_loc3_].rechargeTime >= 1)
               {
                  items[_loc3_].useOn(this);
                  Sounds.useItem.play();
               }
            }
            _loc3_++;
         }
      }

      // Both players fire the same weapon objects, so player 2 keeps its own charge levels.
      public function swapP2Charges(param1:Array) : Array
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            param1 = new Array();
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               if(weapons[_loc3_])
               {
                  param1.push([weapons[_loc3_],_loc3_,weapons[_loc3_].charge]);
                  weapons[_loc3_].charge = p2Charges[_loc3_];
               }
               _loc3_++;
            }
            return param1;
         }
         var _loc2_:Array = null;
         for each(_loc2_ in param1)
         {
            p2Charges[_loc2_[1]] = _loc2_[0].charge;
            _loc2_[0].charge = _loc2_[2];
         }
         return null;
      }

      public function getClosestEnemyToMouse() : EnemyBase
      {
         var _loc1_:EnemyBase = null;
         var _loc2_:Number = NaN;
         var _loc5_:GameObject = null;
         var _loc6_:Number = NaN;
         var _loc3_:Number = aimPointX();
         var _loc4_:Number = aimPointY();
         for each(_loc5_ in gs.objects)
         {
            if(_loc5_ is EnemyBase)
            {
               _loc6_ = EnemyBase(_loc5_).distanceToPoint(_loc3_,_loc4_);
               if(_loc6_ < _loc2_ || _loc1_ == null)
               {
                  _loc1_ = EnemyBase(_loc5_);
                  _loc2_ = _loc6_;
               }
            }
         }
         return _loc1_;
      }
      
      public function updateLowHealth() : void
      {
         var _loc1_:Boolean = shields < 0.2;
         var _loc2_:Boolean = shields < 0.5;
         if(falling)
         {
            _loc2_ = false;
            _loc1_ = false;
         }
         if(MainScene(gs).lazyEnemiesCount == 0)
         {
            _loc1_ = false;
            _loc2_ = false;
         }
         if(_loc1_)
         {
            if(!criticalHealth)
            {
               criticalHealth = new GameObject(gs,null,"AbovePlayer",0,0);
               criticalHealth.fontName = "Pixelation-34";
               criticalHealth.setText("SHIELDS CRITICAL!",7,16730174);
            }
         }
         if(!_loc1_)
         {
            if(criticalHealth)
            {
               criticalHealth.remove();
               criticalHealth = null;
            }
         }
         if(_loc2_)
         {
            if(!lowHealth)
            {
               lowHealth = new GameObject(gs,Embeds.shield_low_png,"BelowPlayer",0,0);
            }
         }
         if(!_loc2_)
         {
            if(lowHealth)
            {
               lowHealth.remove();
               lowHealth = null;
            }
         }
         if(criticalHealth)
         {
            criticalHealth.basex = modifiedx;
            criticalHealth.basey = modifiedy - 32;
            criticalHealth.baseAlpha = 1;
            if(ticks % 60 < 30)
            {
               criticalHealth.baseAlpha = 0;
            }
            criticalHealth.baseAlpha *= modifiedAlpha;
         }
         if(lowHealth)
         {
            lowHealth.basex = modifiedx;
            lowHealth.basey = modifiedy;
            lowHealth.additive = true;
            lowHealth.baseAlpha = 1;
            if(ticks % 60 > 30)
            {
               lowHealth.baseAlpha *= 0.2;
            }
            lowHealth.baseAlpha *= modifiedAlpha;
         }
      }
      
      public function applyOffsetsToWeapons() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < weapons.length)
         {
            if(weapons[_loc2_] is WeaponBase)
            {
               _loc1_.push(weapons[_loc2_]);
            }
            _loc2_++;
         }
         var _loc3_:Array = [0,50,25,75];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc1_[_loc2_].offset = _loc3_[_loc2_];
            _loc2_++;
         }
      }
      
      public function inventoryFull() : Boolean
      {
         return emptyInventorySlot() == -1;
      }
      
      public function updateConstricted() : void
      {
         if(constricted > 0)
         {
            --constricted;
         }
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.goo030_png,"goo",!beforeTeleporting() && constricted > 0,0.05,null,baseAlpha * fallingAlpha());
         if(_loc1_)
         {
            _loc1_.basex = basex;
            _loc1_.basey = basey;
            _loc1_.baseRotation = baseRotation;
         }
      }
      
      public function damageBy(param1:Number) : void
      {
         if(inShield())
         {
            return;
         }
         emitConditionalParticles("Destroy",(Math.random() - 0.5) * 25,(Math.random() - 0.5) * 25);
         shields -= param1 / getShieldsForLevel();
      }
      
      public function doLevelUp() : void
      {
         queuedLevelUp = false;
         HUDDisplay.open(gs,LevelUp);
         inLevelUp = 1;
         Sounds.levelUp.play();
         experience = 0;
         queuedExperience = 0;
         ++level;
      }
      
      public function updateIngameIcons() : void
      {
      }
      
      public function hasKeysFor(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = keyTypeFor(param1,param2);
         if(_loc3_ == -1)
         {
            return true;
         }
         return hasKey(_loc3_);
      }
      
      public function greatestDoorAnimProgress() : int
      {
         var _loc2_:GameObject = null;
         var _loc3_:Door = null;
         var _loc1_:int = 0;
         for each(_loc2_ in gs.objects)
         {
            if(_loc2_ is Door)
            {
               _loc3_ = Door(_loc2_);
               if(_loc3_.openProgress > _loc1_)
               {
                  _loc1_ = _loc3_.openProgress;
               }
            }
         }
         return _loc1_;
      }
      
      public function canCreateTrap() : Boolean
      {
         if(isTeleporting())
         {
            return false;
         }
         if(lg.startx == gridx && lg.starty == gridy)
         {
            return false;
         }
         if(MainScene(gs).spawnPoints.contains(gridx,gridy))
         {
            return false;
         }
         return true;
      }
      
      public function updateIngameIconSet(param1:Array, param2:String, param3:Function) : Array
      {
         var arr:Array = param1;
         var arrName:String = param2;
         var createFunction:Function = param3;
         var icons:Array = helper.mapWhenChanged(arr,arrName,createFunction,function(param1:Object):void
         {
            GameObject(param1).remove();
         });
         var c:int = 0;
         while(c < icons.length)
         {
            if(icons[c])
            {
               helper.positionAsChild(icons[c],offsetsX[c],offsetsY[c] - icons[c].baseHeight / 2);
               arr[c].transformGameObject(icons[c]);
            }
            c++;
         }
         return icons;
      }
      
      public function handleHit(param1:GameObjectBase, param2:Number = 1) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(inShield())
         {
            if(!(param1 is BulletBase))
            {
               return;
            }
            BulletBase(param1).hitByShield();
         }
         if(MainScene(gs).fading)
         {
            return;
         }
         if(lastHit > 9)
         {
            lastHit = 0;
         }
         var _loc3_:Number = shields;
         var _loc4_:Number = getShieldsForLevel();
         var _loc5_:Number = 0;
         if(param1 is EnemyBase)
         {
            _loc5_ = param2 * (_loc4_ / 10 + EnemyBase(param1).health);
         }
         else if(param1 is EnemyBulletBase)
         {
            _loc5_ = EnemyBulletBase(param1).damage() * param2;
         }
         else if(param1 is FloorProp)
         {
            _loc5_ = 20 * param2;
         }
         else if(param1 is HazardBase)
         {
            _loc5_ = param2 * _loc4_ / 5;
         }
         if(MainScene(gs).currentEpisode == 8)
         {
            _loc5_ *= 0.9;
         }
         if(MainScene(gs).currentEpisode == 9)
         {
            _loc5_ *= 0.8;
         }
         if(MainScene(gs).currentEpisode == 10)
         {
            _loc5_ *= 0.7;
         }
         if(MainScene(gs).currentEpisode == 11)
         {
            _loc5_ *= 0.6;
         }
         if(param1 is GooBullet)
         {
            constricted = 100;
         }
         var _loc6_:Number = Interpolation.distanceToAngle(modifiedRotation,angleToObject(param1) - 90);
         lastHitRiot = false;
         if(_loc6_ < 45)
         {
            if(hasRiotShield())
            {
               _loc5_ *= riotShieldMult();
               lastHitRiot = true;
            }
         }
         damageBy(_loc5_);
         if(ticks - lastPlayed > 1000)
         {
            if(shields < 0.2 && _loc3_ > 0.2)
            {
               Sounds.shieldsCritical.play();
               lastPlayed = ticks;
            }
            else if(shields < 0.5 && _loc3_ > 0.5)
            {
               lastPlayed = ticks;
               Sounds.shieldsLow.play();
            }
         }
         if(shields < 0)
         {
            if(hasMedKit())
            {
               shields = 1;
            }
            else
            {
               _loc7_ = 0;
               while(_loc7_ < 10)
               {
                  emitConditionalParticles("Destroy",(Math.random() - 0.5) * 25,(Math.random() - 0.5) * 25);
                  _loc7_++;
               }
               emitConditionalParticles("GasTankDestroy");
               _loc8_ = 0;
               while(_loc8_ < 4)
               {
                  if(weaponIcons[_loc8_])
                  {
                     weaponIcons[_loc8_].remove();
                  }
                  _loc8_++;
               }
               kill();
            }
         }
      }
      
      public function getShieldsForLevel() : int
      {
         return 100 + 10 * level;
      }
      
      public function doRecharge() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Array = null;
         var _loc3_:ItemBase = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(isTeleporting())
         {
            inCombat = 0;
         }
         if(MainScene(gs).lazyEnemiesCount > 0)
         {
            ++inCombat;
         }
         else
         {
            --inCombat;
         }
         inCombat = Interpolation.lockValueInt(inCombat,0,100);
         if(MainScene(gs).lazyEnemiesCount == 0)
         {
            if(inCombat == 10)
            {
               _loc1_ = false;
               _loc2_ = new Array();
               for each(_loc3_ in items)
               {
                  if(_loc3_ is ItemRecharge)
                  {
                     _loc2_.push(_loc3_);
                     _loc1_ = true;
                  }
               }
               _loc2_.sortOn("attribute",2);
               _loc4_ = [1,1,1,1];
               _loc5_ = 0;
               while(_loc5_ < _loc2_.length)
               {
                  shields += _loc4_[_loc5_] * (_loc2_[_loc5_].attribute / getShieldsForLevel());
                  if(shields > 1)
                  {
                     shields = 1;
                  }
                  _loc5_++;
               }
               if(_loc1_)
               {
                  medKitParticles();
               }
            }
         }
      }
      
      public function doActiveHelp() : void
      {
         if(doneActiveHelpQuickCheck)
         {
            return;
         }
         doneActiveHelpQuickCheck = true;
         var _loc1_:ControlHelp = new ControlHelp(gs,300 + (234 - 408),500 + (573 - 554));
         var _loc2_:Bitmap = new Embeds.Item_instructions_png();
         _loc1_.helperAnimation.setFrame(_loc2_.bitmapData);
         activeHelp = true;
      }
      
      public function medKitParticles() : void
      {
         var _loc2_:Particle = null;
         var _loc1_:Array = emitConditionalParticles("MedKit");
         for each(_loc2_ in _loc1_)
         {
            _loc2_.lockTo = this;
         }
         Sounds.medkit.play();
      }
      
      public function createHealthBar() : GameObject
      {
         return new EnemyHealthBar(gs,0,0);
      }
      
      public function rotateVector(param1:Number, param2:Number, param3:Number) : Point
      {
         return new Point(cosd(param3) * param1 + sind(-param3) * param2,-sind(-param3) * param1 + cosd(param3) * param2);
      }
      
      public function chanceMult() : Number
      {
         var _loc5_:ItemBase = null;
         var _loc1_:Number = 1;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [1,0.9,0.8,0.7];
         for each(_loc5_ in items)
         {
            if(_loc5_ is ItemMagicFind)
            {
               _loc3_++;
               _loc2_ += ItemMagicFind(_loc5_).attribute;
            }
         }
         if(_loc3_ > 0)
         {
            _loc2_ *= _loc4_[_loc3_ - 1];
            _loc1_ += _loc2_ / 100;
         }
         return _loc1_;
      }
      
      public function padString(param1:String, param2:String, param3:int) : String
      {
         while(param1.length < param3)
         {
            param1 = param2 + param1;
         }
         return param1;
      }
      
      public function updateRiotShield() : void
      {
         if(hasRiotShield())
         {
            if(!riotShield)
            {
               riotShield = new GameObject(gs,Embeds.riotshield_png,"BelowPlayer",0,0);
            }
         }
         if(!hasRiotShield())
         {
            if(riotShield)
            {
               riotShield.remove();
            }
         }
         if(riotShield)
         {
            riotShield.basex = modifiedx;
            riotShield.basey = modifiedy;
            riotShield.baseRotation = modifiedRotation;
            riotShield.baseAlpha = modifiedAlpha;
         }
      }
      
      public function updateEnemyHealthBar() : void
      {
         var _loc2_:EnemyBase = null;
         var _loc1_:Boolean = false;
         _loc2_ = getClosestEnemyToMouse();
         if(_loc2_)
         {
            _loc1_ = _loc2_.distanceToPoint(aimPointX(),aimPointY()) < _loc2_.collisionWidth();
         }
         else
         {
            _loc1_ = false;
         }
         var _loc3_:EnemyHealthBar = EnemyHealthBar(helper.conditionallyCreateChild(createHealthBar,"HealthBar",_loc1_,0.25));
         if(_loc3_)
         {
            if(Boolean(_loc2_) && _loc1_)
            {
               _loc3_.barFallSpeed = 1;
               _loc3_.barRiseSpeed = 1;
               _loc3_.basex = _loc2_.basex;
               _loc3_.basey = _loc2_.basey - Math.max(_loc2_.baseWidth,_loc2_.baseHeight) / 2;
               _loc3_.baseAlpha *= _loc2_.baseAlpha;
               _loc3_.setFull(Number(_loc2_.health) / Number(_loc2_.totalHealth));
            }
         }
      }
      
      public function shootGun(param1:WeaponBase, param2:int) : void
      {
         var _loc9_:Point = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc3_:Number = Number(offsetsX[param2]);
         var _loc4_:Number = Number(offsetsY[param2]);
         var _loc5_:GameObject = weaponIcons[param2];
         var _loc6_:Point = tformed(_loc3_,_loc4_);
         var _loc7_:Point = rotateVector(_loc3_,_loc4_,baseRotation);
         ++param1.shotCount;
         if(MainMenu.levelOfDetail)
         {
            if(param1.shotCount % 4 == 0 || !(param1 is Blaster))
            {
               _loc9_ = rotateVector(sgn(_loc3_) * 4 * (0.8 + Math.random() * 0.2),(Math.random() - 0.5) / 2,baseRotation);
               _loc10_ = emitConditionalParticles("BulletCasing",_loc3_,_loc4_ - 20,false,baseRotation + 180);
               if(_loc10_)
               {
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_.length)
                  {
                     if(_loc10_[_loc11_])
                     {
                        _loc10_[_loc11_].dx = _loc9_.x / 2;
                        _loc10_[_loc11_].dy = _loc9_.y / 2;
                     }
                     _loc11_++;
                  }
               }
            }
         }
         if(param1 is ChargeLaser)
         {
            ChargeLaser(param1).offsetX = _loc3_;
            ChargeLaser(param1).offsetY = _loc4_;
         }
         param1.shoot(gs,_loc6_.x,_loc6_.y,handleMouseX + _loc7_.x,handleMouseY + _loc7_.y);
         var _loc8_:String = "Shoot";
         if(param1 is Laser)
         {
            _loc8_ = "LaserShoot";
         }
         if(param1 is PulseGun)
         {
            _loc8_ = "PulseShoot";
         }
         emitConditionalParticles(_loc8_,_loc3_,_loc4_,false,baseRotation + 180);
         doSound(param1);
         _loc5_.addFilter(new GameObjectFilterRecoil(param1.recoilTime(),param1.recoilAmount()));
      }
      
      public function sgn(param1:Number) : Number
      {
         if(param1 < 0)
         {
            return -1;
         }
         if(param1 > 0)
         {
            return 1;
         }
         return 0;
      }
      
      public function hasMedKit() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < items.length)
         {
            if(items[_loc1_] is ItemMedkit)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function canMoveX() : Boolean
      {
         if(greatestDoorAnimProgress() < 100)
         {
            return false;
         }
         if(!MainScene(gs).canMoveRooms())
         {
            return false;
         }
         if(basex < 400)
         {
            return canMove(-1,0) && hasKeysFor(gridx - 1,gridy);
         }
         return canMove(1,0) && hasKeysFor(gridx + 1,gridy);
      }
      
      public function canMoveY() : Boolean
      {
         if(greatestDoorAnimProgress() < 100)
         {
            return false;
         }
         if(!MainScene(gs).canMoveRooms())
         {
            return false;
         }
         if(basey < 300)
         {
            return canMove(0,-1) && hasKeysFor(gridx,gridy - 1);
         }
         return canMove(0,1) && hasKeysFor(gridx,gridy + 1);
      }
      
      public function countGuns() : int
      {
         var _loc2_:InventoryItem = null;
         var _loc1_:int = 0;
         for each(_loc2_ in weapons)
         {
            if(_loc2_ is WeaponBase)
            {
               _loc1_++;
            }
         }
         for each(_loc2_ in inventory)
         {
            if(_loc2_ is WeaponBase)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function inShield() : Boolean
      {
         return _inShield > 0;
      }
      
      override public function collisionHeight() : Number
      {
         return baseHeight * 0.6;
      }
      
      public function inLevelEnd() : Boolean
      {
         return lg.getCellData(gridx,gridy,"Finish") != null;
      }
      
      public function doShopHelp() : void
      {
         var _loc1_:String = "Remember you can teleport back to the shop\nfrom any room by clicking on the shop icon\non the map display.";
         _loc1_ = _loc1_.toUpperCase();
         Help.helpText = _loc1_;
         HUDDisplay.open(gs,Help);
         shopHelp = true;
      }
      
      public function cashMult() : Number
      {
         var _loc2_:ItemBase = null;
         var _loc1_:Number = 1;
         for each(_loc2_ in items)
         {
            if(_loc2_ is ItemMoreGold)
            {
               _loc1_ += ItemMoreGold(_loc2_).attribute / 100;
            }
         }
         return _loc1_;
      }
      
      public function doChargeHelp() : void
      {
         var _loc1_:String = "The cluster grenade charges up.\nHold down the fire button to charge, and release to fire.\nThe longer the charge time, the more damage it will do.";
         _loc1_ = _loc1_.toUpperCase();
         Help.helpText = _loc1_;
         HUDDisplay.open(gs,Help);
         chargeHelp = true;
      }
      
      public function triggerHelp() : void
      {
         ++roomsExplored;
         if(!inventoryHelp)
         {
            if(roomsExplored > 10)
            {
               if(countInventoryGuns() > 0)
               {
                  doInventoryHelp();
                  return;
               }
            }
         }
         if(!mapHelp)
         {
            if(roomsExplored > 5)
            {
               doMapHelp();
               return;
            }
         }
         if(!shopHelp)
         {
            if(money > 500)
            {
               doShopHelp();
               return;
            }
         }
         if(!chargeHelp)
         {
            if(hasChargeWeapon())
            {
               doChargeHelp();
               return;
            }
         }
      }
      
      public function hasRiotShield() : Boolean
      {
         var _loc2_:ItemBase = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in items)
         {
            if(_loc2_ is ItemShield)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function emptyInventorySlot() : int
      {
         var _loc1_:int = 0;
         while(_loc1_ < inventory.length)
         {
            if(!inventory[_loc1_])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function setHud() : void
      {
         cashText.setText(String(money));
         shieldObject.setFull(shields);
         xpObject.setFull(Number(experience) / Number(experienceForLevel()));
         levelText.setText(padString(String(level + 1),"0",2));
         hudKeys.setValue(keyCount);
         var _loc1_:int = 0;
         while(_loc1_ < keyCount)
         {
            hudKeys.sprites[_loc1_].obj.bitmapData = Embeds.key[keyTypes[_loc1_]];
            _loc1_++;
         }
      }
      
      public function removeKey(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Array = new Array();
         var _loc5_:* = int(keyCount - 1);
         while(_loc5_ >= 0)
         {
            if(!_loc3_ && keyTypes[_loc5_] == param1)
            {
               _loc2_ = _loc5_;
               _loc3_ = true;
            }
            else
            {
               _loc4_.push(keyTypes[_loc5_]);
            }
            _loc5_--;
         }
         _loc4_.reverse();
         keyTypes = _loc4_;
         --keyCount;
         hudKeys.setValue(keyCount);
         return _loc2_;
      }
      
      public function help() : void
      {
      }
      
      public function doSound(param1:WeaponBase) : void
      {
         if(param1 is Blaster)
         {
            if(ticks - lastLaser >= 10)
            {
               Sounds.shoot.play();
               lastLaser = ticks;
            }
         }
         else if(param1 is Laser)
         {
            if(!laserThisFrame)
            {
               Sounds.laserShoot.play();
               laserThisFrame = true;
            }
         }
         else if(param1 is Grenade && !grenadeThisFrame)
         {
            grenadeThisFrame = true;
            Sounds.grenadeShoot.play();
         }
         else if(param1 is Shotgun && !shotgunThisFrame)
         {
            Sounds.shotgunShoot.play();
            shotgunThisFrame = true;
         }
         else if(param1 is PulseGun && !pulseThisFrame)
         {
            Sounds.pulseShoot.play();
            pulseThisFrame = true;
         }
         else if(param1 is PlasmaShotgun && !plasmaShotgunThisFrame)
         {
            Sounds.plasmaShotgunFire.play();
            plasmaShotgunThisFrame = true;
         }
         else if(param1 is Shredder && !shredderThisFrame)
         {
            Sounds.shredderFire.play();
            shredderThisFrame = true;
         }
      }
      
      override public function kill() : void
      {
         var _loc2_:int = 0;
         var _loc3_:BitmapData = null;
         if(!falling)
         {
            _loc3_ = Embeds.explosionScar[Random.randInt(0,Embeds.explosionScar.length - 1)];
            MainScene(gs).markFloor(_loc3_,basex - _loc3_.width / 2,basey - _loc3_.height / 2,Math.random(),1,1);
            doShrapnel(20,0.5,0,0.5);
         }
         var _loc1_:MainScene = MainScene(gs);
         if(partner)
         {
            removeP2Hud();
         }
         else
         {
            _loc1_.removeWhenFaded.push(hudKeys,shieldObject,xpObject,cashBacking,levelBacking,cashText,levelText);
         }
         if(lowHealth)
         {
            lowHealth.remove();
         }
         if(criticalHealth)
         {
            criticalHealth.remove();
         }
         if(riotShield)
         {
            riotShield.remove();
         }
         _loc2_ = 0;
         while(_loc2_ < items.length && !partner)
         {
            if(items[_loc2_])
            {
               items[_loc2_].rechargeProgress = 0;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(weaponIcons[_loc2_])
            {
               weaponIcons[_loc2_].remove();
            }
            _loc2_++;
         }
         Sounds.explosion.play();
         super.kill();
      }
      
      public function doRevenge() : void
      {
         var _loc3_:ItemBase = null;
         var _loc4_:GameObject = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < items.length)
         {
            _loc3_ = ItemBase(items[_loc2_]);
            if(_loc3_ is ItemRevenge)
            {
               items[_loc2_] = null;
               _loc1_ = true;
               for each(_loc4_ in gs.objects)
               {
                  if(_loc4_ is EnemyBase)
                  {
                     if(_loc4_.distanceToObject(this) < 200)
                     {
                        EnemyBase(_loc4_).hitBy(null,ItemRevenge(_loc3_).attribute);
                     }
                  }
               }
            }
            _loc2_++;
         }
         if(_loc1_)
         {
            Sounds.explosion.play();
            emitConditionalParticles("Revenge");
         }
      }
      
      public function hasKey(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < keyCount)
         {
            if(keyTypes[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      override public function canFall() : Boolean
      {
         if(Math.abs(lastX - 400) < 24)
         {
            if(basey <= 20 || basey >= 580)
            {
               return false;
            }
         }
         if(Math.abs(lastY - 300) < 24)
         {
            if(basex <= 20 || basex >= 780)
            {
               return false;
            }
         }
         return true;
      }
      
      public function giveExperience(param1:int) : void
      {
         var _loc2_:int = (MainScene(gs).currentEpisode + MainScene(gs).completedProgress) * 3;
         ++totalKills;
         var _loc3_:Number = 1;
         if(level > _loc2_)
         {
            _loc3_ = 1 / Math.pow(2,level - _loc2_);
         }
         else if(level < _loc2_)
         {
            _loc3_ = 1 + (_loc2_ - level) / 10;
            if(_loc3_ > 1.5)
            {
               _loc3_ = 1.5;
            }
         }
         param1 *= _loc3_;
         trace(_loc3_);
         queuedExperience += param1;
      }
      
      public function save() : void
      {
         Profile.defStoreArray("playerWeapons",weapons);
         Profile.defStoreArray("playerInventory",inventory);
         Profile.defStoreArray("playerItems",items);
         Profile.defStore("expediateddrop",expediatedDrop);
         Profile.defStore("level",level);
         Profile.defStore("experience",experience);
         Profile.defStore("cash",money);
         Profile.defStore("totalkills",totalKills);
         Profile.defStore("teleporthelp",teleportHelp);
         Profile.defStore("maphelp",mapHelp);
         Profile.defStore("shophelp",shopHelp);
         Profile.defStore("chargehelp",chargeHelp);
         Profile.defStore("activehelp",activeHelp);
         Profile.defStore("inventoryhelp",inventoryHelp);
         Profile.defStore("edgewarning",edgeWarning);
      }
      
      public function unlockPath(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            lg.setCellData(param1,param2,"Key" + _loc3_,false);
            _loc3_++;
         }
      }
      
      public function updateShield() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:BitmapData = null;
         if(_inShield > 0)
         {
            --_inShield;
         }
         _loc1_ = helper.conditionallyCreateChild(Embeds.trooper_shield001_png,"shield",inShield());
         if(_loc1_)
         {
            _loc1_.basex = basex;
            _loc1_.basey = basey;
            _loc1_.additive = true;
            _loc2_ = Embeds.enemyShield[ticks / 8 % 16];
            if(_loc2_)
            {
               _loc1_.helperAnimation.setFrame(_loc2_);
            }
            if(_inShield < 100 && _inShield > 0)
            {
               _loc1_.baseAlpha = _inShield % 33 < 16 ? 1 : 0.5;
            }
         }
      }
      
      public function pathLocked(param1:int, param2:int) : Boolean
      {
         return keyTypeFor(param1,param2) != -1;
      }
      
      public function doMapHelp() : void
      {
         var _loc1_:String = "Click the map button (bottom right) or press\nthe \'M\' key to access the map display.";
         _loc1_ = _loc1_.toUpperCase();
         Help.helpText = _loc1_;
         HUDDisplay.open(gs,Help);
         mapHelp = true;
      }
      
      override public function collisionWidth() : Number
      {
         return baseWidth * 0.6;
      }
      
      public function riotShieldMult() : Number
      {
         var _loc2_:ItemBase = null;
         var _loc1_:Number = 1;
         for each(_loc2_ in items)
         {
            if(_loc2_ is ItemShield)
            {
               _loc1_ -= ItemShield(_loc2_).attribute / 100;
            }
         }
         return _loc1_;
      }
      
      public function hasActiveItem() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < items.length)
         {
            if(items[_loc1_])
            {
               if(items[_loc1_] is ItemActive)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function handleFiring() : void
      {
         var _loc2_:int = 0;
         if(partner)
         {
            Input.i.setP2Aim(aimPointX(),aimPointY());
         }
         else
         {
            Input.i.setAimOrigin(basex,basey);
         }
         if(beforeTeleporting() || falling)
         {
            _loc2_ = 0;
            while(_loc2_ < weapons.length)
            {
               if(weapons[_loc2_])
               {
                  weapons[_loc2_].charge = 0;
               }
               _loc2_++;
            }
            return;
         }
         grenadeThisFrame = false;
         shotgunThisFrame = false;
         laserThisFrame = false;
         pulseThisFrame = false;
         plasmaShotgunThisFrame = false;
         shredderThisFrame = false;
         handleMouseX = aimPointX();
         handleMouseY = aimPointY();
         var _loc1_:Boolean = true;
         if(distanceToPoint(handleMouseX,handleMouseY) < 32)
         {
            _loc1_ = false;
         }
         baseRotation = Math.atan2(handleMouseY - basey,handleMouseX - basex) / Math.PI * 180 - 90;
         if(!partner && (MainScene(gs).mapButton.mOver() || MainScene(gs).menuButton.mOver() || MainScene(gs).inventoryButton.mOver()))
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            shootGuns();
         }
         applyOffsetsToWeapons();
      }
      
      public function canMove(param1:int, param2:int) : Boolean
      {
         return lg.getCell(gridx + param1,gridy + param2) > 0 && lg.getCellData(gridx + param1,gridy + param2,"Key0") != true;
      }
      
      public function hasChargeWeapon() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < weapons.length)
         {
            if(weapons[_loc1_])
            {
               if(weapons[_loc1_] is ChargeGrenades || weapons[_loc1_] is ChargeLaser || weapons[_loc1_] is ChargeRockets)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function experienceForLevel() : int
      {
         var _loc1_:int = level + 1;
         return 1000 * int(Number(_loc1_ * _loc1_) / 2 + Number(_loc1_) / 2);
      }
      
      public function handleCollisions() : void
      {
         var _loc1_:GameObject = null;
         if(!falling)
         {
            for each(_loc1_ in gs.objects)
            {
               if(_loc1_ != this)
               {
                  if(_loc1_ is GameObjectBase)
                  {
                     if(!(_loc1_ is EnemyBase))
                     {
                        if(!(_loc1_ is EnemyLaserBase) || _loc1_ is StaticLaserBase)
                        {
                           if(GameObjectBase(_loc1_).spriteCollidesWith(this,GameObjectBase(_loc1_).collisionFudge))
                           {
                              GameObjectBase(_loc1_).handlePlayerCollision();
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function addToInventory(param1:InventoryItem) : Boolean
      {
         if(inventoryFull())
         {
            return false;
         }
         inventory[emptyInventorySlot()] = param1;
         return true;
      }
      
      public function keyTypeFor(param1:int, param2:int) : int
      {
         if(lg.getCellData(param1,param2,"Key0") == true)
         {
            return 0;
         }
         if(lg.getCellData(param1,param2,"Key1") == true)
         {
            return 1;
         }
         if(lg.getCellData(param1,param2,"Key2") == true)
         {
            return 2;
         }
         return -1;
      }
      
      public function getDamageForLevel() : Number
      {
         return 1 + 0.05 * level;
      }
      
      public function _tint(param1:Number, param2:Number, param3:Number) : void
      {
         tint(param1,param2,param3);
         var _loc4_:int = 0;
         if(partner)
         {
            tintClip(legs.obj,param1,param2,param3);
            while(_loc4_ < 4)
            {
               if(weaponIcons[_loc4_])
               {
                  tintClip(weaponIcons[_loc4_].obj,param1,param2,param3);
               }
               _loc4_++;
            }
            return;
         }
         legs.tint(param1,param2,param3);
         while(_loc4_ < 4)
         {
            if(weaponIcons[_loc4_])
            {
               weaponIcons[_loc4_].tint(param1,param2,param3);
            }
            _loc4_++;
         }
      }
      
      public function giveDefaultWeapons() : void
      {
         weapons = new Array(4);
         weapons[0] = new Blaster();
         weapons[0].level = 0;
         weapons[1] = new Blaster();
         weapons[1].level = 0;
      }
      
      public function countInventoryGuns() : int
      {
         var _loc2_:InventoryItem = null;
         var _loc1_:int = 0;
         for each(_loc2_ in inventory)
         {
            if(_loc2_ is WeaponBase)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      override public function _update() : void
      {
         var _loc18_:GameObject = null;
         var _loc19_:int = 0;
         var _loc20_:Number = NaN;
         var _loc21_:Boolean = false;
         var _loc22_:Number = NaN;
         var _loc23_:GameObject = null;
         var _loc24_:Point = null;
         var _loc25_:Array = null;
         if(partner)
         {
            _loc25_ = swapP2Charges(null);
            useP2Items();
            if(p2Bar)
            {
               p2Bar.setFull(shields);
            }
         }
         if(!activeHelp && !partner)
         {
            if(hasActiveItem())
            {
               doActiveHelp();
            }
         }
         queuedLevelUp = false;
         if(teleportInstant())
         {
            for each(_loc18_ in gs.objects)
            {
               if(_loc18_ is FloorProp)
               {
                  if(distanceToObject(_loc18_) < 10)
                  {
                     FloorProp(_loc18_).hasBeenHit(_loc18_);
                  }
               }
            }
         }
         var _loc1_:int = 0;
         while(_loc1_ < 4 && !partner)
         {
            if(items[_loc1_])
            {
               items[_loc1_].update(MainScene(gs));
            }
            _loc1_++;
         }
         updateShield();
         updateConstricted();
         var _loc2_:Number = 1;
         if(basex < 16)
         {
            _loc2_ *= Interpolation.fromToLock(basex,0,16);
         }
         if(basey < 16)
         {
            _loc2_ *= Interpolation.fromToLock(basey,0,16);
         }
         if(basex > 800 - 32)
         {
            _loc2_ *= 1 - Interpolation.fromToLock(basex,800 - 32,800 - 16);
         }
         if(basey > 600 - 32)
         {
            _loc2_ *= 1 - Interpolation.fromToLock(basey,600 - 32,600 - 16);
         }
         var _loc3_:GameObject = helper.conditionallyCreateChild(Embeds.player_shadow001_png,"shadow",!beforeTeleporting(),1,null,baseAlpha * fallingAlpha() * _loc2_);
         var _loc4_:int = int(legs.animFrame) % Embeds.playerShadow.length;
         if(_loc3_)
         {
            _loc3_.basex = basex + 16;
            _loc3_.basey = basey + 16;
            _loc3_.helperAnimation.setFrame(Embeds.playerShadow[_loc4_]);
            _loc3_.changeZOrder("Floor",true);
         }
         var _loc5_:GameObject = helper.conditionallyCreateChild(Embeds.player_shadow001_png,"shadow2",!beforeTeleporting(),1,null,baseAlpha * fallingAlpha() * 0.8 * _loc2_);
         if(_loc5_)
         {
            _loc5_.basex = basex + 16;
            _loc5_.basey = basey + 16;
            _loc5_.helperAnimation.setFrame(Embeds.playerShadow[_loc4_]);
            _loc5_.changeZOrder("Floor");
         }
         updateIngameIcons();
         var _loc6_:int = level / 5;
         if(_loc6_ >= 7)
         {
            _loc6_ = 7;
         }
         Bitmap(obj).bitmapData = Embeds.playerHead[_loc6_];
         if(falling)
         {
            queuedLevelUp = false;
         }
         if(falling)
         {
            if(!fallingLatch)
            {
               fallingLatch = true;
               emitConditionalParticles("fall");
               Sounds.trap.play();
               RewardText.createRewardText(gs,400,300,"TAKE CARE AROUND EDGES!","TextLayer",16730174,1,0,200);
            }
         }
         if(beforeTeleporting() && !partner)
         {
            if(money < 500)
            {
               if(countGuns() == 0)
               {
                  money = 0;
                  giveDefaultWeapons();
                  RewardText.createRewardText(gs,400,300,"BACKUP WEAPONS GRANTED");
               }
            }
         }
         doRecharge();
         if(!partner)
         {
            updateEnemyHealthBar();
         }
         updateRiotShield();
         updateLowHealth();
         if(MainScene(gs).hasCommWindow())
         {
            ++teleportOffset;
         }
         legs.basex = -(basex - 400) / 80;
         legs.basey = -(basey - 300) / 60;
         ++lastHit;
         if(shields < 0.1)
         {
            doRevenge();
         }
         if(shields < 0.25)
         {
            useMedkit();
         }
         if(inLevelUp > 0)
         {
            ++inLevelUp;
            if(inLevelUp > 100)
            {
               inLevelUp = 0;
            }
         }
         var _loc7_:Boolean = false;
         if(!falling && !partner)
         {
            if(queuedExperience > 0)
            {
               if(MainScene(gs).countEnemies() == 0)
               {
                  if(inLevelUp == 0)
                  {
                     if(expSoundChannel ? !expSoundChannel.playing() : true)
                     {
                        expSoundChannel = Sounds.experienceTick.play();
                     }
                     _loc19_ = experienceForLevel() / 400;
                     queuedExperience -= _loc19_;
                     experience += _loc19_;
                     _loc7_ = true;
                  }
               }
            }
         }
         if(expSoundChannel)
         {
            if(expSoundChannel.playing())
            {
               if(!_loc7_)
               {
                  expSoundChannel.stop();
               }
            }
         }
         if(experience + queuedExperience > experienceForLevel())
         {
            queuedLevelUp = true;
         }
         if(falling)
         {
            _loc20_ = 1 - fallingProgress / 100;
            _tint(_loc20_,0,0);
            legs.animFreeze = true;
         }
         else
         {
            if(lastHit < 6 && !lastHitRiot)
            {
               _tint(2,1,1);
            }
            else
            {
               _tint(1,0,0);
            }
            if(riotShield)
            {
               riotShield.tint(1,0,0);
               if(lastHit < 6 && lastHitRiot)
               {
                  riotShield.tint(2,1,1);
               }
            }
         }
         var _loc8_:int = 0;
         while(_loc8_ < 4)
         {
            if(!weaponIcons[_loc8_] || weapons[_loc8_] != oldWeapons[_loc8_])
            {
               if(weapons[_loc8_])
               {
                  weapons[_loc8_].charge = 0;
               }
               oldWeapons[_loc8_] = weapons[_loc8_];
               if(weaponIcons[_loc8_])
               {
                  weaponIcons[_loc8_].remove();
                  weaponIcons[_loc8_] = null;
               }
               if(weapons[_loc8_])
               {
                  _loc18_ = weapons[_loc8_].getWeaponObject(gs);
                  if(_loc18_)
                  {
                     _loc18_.basex = offsetsX[_loc8_];
                     _loc18_.basey = offsetsY[_loc8_];
                     weaponIcons[_loc8_] = _loc18_;
                  }
               }
            }
            _loc21_ = false;
            _loc22_ = 0;
            if(weapons[_loc8_])
            {
               if(weapons[_loc8_].charge > 0)
               {
                  _loc21_ = true;
                  _loc22_ = Number(weapons[_loc8_].getPercentageCharge());
               }
            }
            _loc23_ = helper.conditionallyCreateChild(Embeds.red_glow_png,"ChargeGlow" + _loc8_,_loc21_);
            if(_loc23_)
            {
               _loc24_ = tformed(offsetsX[_loc8_],offsetsY[_loc8_]);
               _loc23_.basex = _loc24_.x;
               _loc23_.basey = _loc24_.y;
               _loc23_.additive = true;
               _loc23_.baseAlpha = _loc22_;
               if(_loc22_ >= 1)
               {
                  _loc23_.baseAlpha *= Math.random() * 0.3 + 0.7;
               }
            }
            if(weaponIcons[_loc8_])
            {
               _loc24_ = tformed(offsetsX[_loc8_],offsetsY[_loc8_] - weaponIcons[_loc8_].baseHeight / 2);
               weaponIcons[_loc8_].basex = _loc24_.x;
               weaponIcons[_loc8_].basey = _loc24_.y;
               weaponIcons[_loc8_].baseScaleX = baseScaleX;
               weaponIcons[_loc8_].baseScaleY = baseScaleY;
               if(_loc8_ == 0 || _loc8_ == 2)
               {
                  weaponIcons[_loc8_].baseScaleX *= -1;
               }
               weaponIcons[_loc8_].baseRotation = modifiedRotation;
               weaponIcons[_loc8_].baseAlpha = baseAlpha;
            }
            _loc8_++;
         }
         legs.baseScaleX = baseScaleX;
         legs.baseScaleY = baseScaleY;
         legs.baseAlpha = baseAlpha;
         Bitmap(obj).smoothing = true;
         Bitmap(legs.obj).smoothing = true;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         if(!partner)
         {
            _loc9_ = Input.i.keyDown(39) - Input.i.keyDown(37);
            _loc10_ = Input.i.keyDown(40) - Input.i.keyDown(38);
            _loc9_ += Input.i.keyDown(68) - Input.i.keyDown(65);
            _loc10_ += Input.i.keyDown(83) - Input.i.keyDown(87);
         }
         if(beforeTeleporting())
         {
            _loc9_ = 0;
            _loc10_ = 0;
         }
         if(_loc9_ == -2 || _loc9_ == 2)
         {
            _loc9_ /= 2;
         }
         if(_loc10_ == -2 || _loc10_ == -2)
         {
            _loc10_ /= 2;
         }
         var _loc11_:Number = Math.sqrt(_loc9_ * _loc9_ + _loc10_ * _loc10_);
         if(_loc11_ > 0)
         {
            _loc9_ /= _loc11_;
            _loc10_ /= _loc11_;
         }
         else if(!beforeTeleporting())
         {
            _loc9_ = partner ? Number(Input.i.p2Pad.moveX) : Input.i.padMoveX;
            _loc10_ = partner ? Number(Input.i.p2Pad.moveY) : Input.i.padMoveY;
         }
         dx += _loc9_ * 0.2;
         dy += _loc10_ * 0.2;
         var _loc12_:Number = 0.85;
         if(constricted > 0)
         {
            _loc12_ = 0.7;
         }
         dx *= _loc12_;
         dy *= _loc12_;
         lastdx = dx * 2 + extradx;
         lastdy = dy * 2 + extrady;
         if(killdx)
         {
            dx = 0;
            lastdx = 0;
            killdx = false;
         }
         if(killdy)
         {
            dy = 0;
            lastdy = 0;
            killdy = false;
         }
         basex += lastdx;
         basey += lastdy;
         extradx *= 0.95;
         extrady *= 0.95;
         if((_loc9_ != 0 || _loc10_ != 0) && !falling)
         {
            legs.baseRotation = 180 * Math.atan2(_loc10_,_loc9_) / Math.PI - 90;
            legs.animFreeze = false;
         }
         else
         {
            legs.animFreeze = true;
         }
         handleFiring();
         handleCollisions();
         var _loc13_:MainScene = MainScene(gs);
         var _loc14_:Number = _loc13_.startx + baseWidth / 2 + 5;
         var _loc15_:Number = _loc13_.endx - baseWidth / 2 - 5;
         var _loc16_:Number = _loc13_.starty + baseHeight / 2 + 5;
         var _loc17_:Number = _loc13_.endy - baseHeight / 2 - 5;
         if(Math.abs(lastY - 300) > 18 || !canMoveX())
         {
            basex = Interpolation.lockValue(basex,_loc14_,_loc15_);
         }
         else if(basex - baseWidth / 2 < _loc13_.startx || basex + baseWidth / 2 > _loc13_.endx)
         {
            if(basey < 300 - 18)
            {
               basey = 300 - 18;
            }
            else if(basey > 300 + 18)
            {
               basey = 300 + 18;
            }
         }
         if(Math.abs(lastX - 400) > 18 || !canMoveY())
         {
            basey = Interpolation.lockValue(basey,_loc16_,_loc17_);
         }
         else if(basey - baseHeight / 2 < _loc13_.starty || basey + baseHeight / 2 > _loc13_.endy)
         {
            if(basex < 400 - 18)
            {
               basex = 400 - 18;
            }
            else if(basex > 400 + 18)
            {
               basex = 400 + 18;
            }
         }
         if(partner)
         {
            swapP2Charges(_loc25_);
         }
         super._update();
      }
      
      public function doInventoryHelp() : void
      {
         var _loc1_:String = "Click the INV button (bottom right) or\npress the \'I\' key to access your inventory.";
         _loc1_ = _loc1_.toUpperCase();
         Help.helpText = _loc1_;
         HUDDisplay.open(gs,Help);
         inventoryHelp = true;
      }
      
      public function useMedkit() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < items.length)
         {
            if(items[_loc1_] is ItemMedkit)
            {
               if(ticks - lastMedkit > 100)
               {
                  lastMedkit = ticks;
                  items[_loc1_].useOn(this);
                  items[_loc1_] = null;
               }
            }
            _loc1_++;
         }
      }
      
      public function shootGuns() : void
      {
         var _loc1_:int = 0;
         var _loc2_:WeaponBase = null;
         if(fireHeld())
         {
            _loc1_ = 0;
            while(_loc1_ < weapons.length)
            {
               if(weapons[_loc1_])
               {
                  _loc2_ = WeaponBase(weapons[_loc1_]);
                  if(_loc2_.charges())
                  {
                     _loc2_.increaseCharge();
                  }
                  else if(_loc2_.shooting(ticks))
                  {
                     shootGun(_loc2_,_loc1_);
                  }
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < weapons.length)
            {
               if(weapons[_loc1_])
               {
                  _loc2_ = WeaponBase(weapons[_loc1_]);
                  if(_loc2_.charges())
                  {
                     if(_loc2_.charge > 0)
                     {
                        if(_loc2_.charge > 20)
                        {
                           shootGun(_loc2_,_loc1_);
                        }
                        _loc2_.charge = 0;
                     }
                  }
               }
               _loc1_++;
            }
         }
      }
      
      public function addKey(param1:PickupKey) : void
      {
         keyTypes[keyCount] = int(param1.animFrame);
         ++keyCount;
         hudKeys.setValue(keyCount);
      }
   }
}

