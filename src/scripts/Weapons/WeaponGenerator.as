package Weapons
{
   import GameScene.GameScene;
   import Items.ItemActiveShield;
   import Items.ItemEMP;
   import Items.ItemKamikaziBot;
   import Items.ItemMagnet;
   import Items.ItemMinelayer;
   import Items.ItemReboundBot;
   import Items.ItemShockwave;
   import Items.ItemShootingBot;
   import Items.ItemSonicPulse;
   import Scenes.MainScene;
   import Tools.Random;
   import WeaponPlugin.WeaponPluginBase;
   import WeaponPlugin.WeaponPluginFlyThrough;
   import WeaponPlugin.WeaponPluginFreeze;
   import WeaponPlugin.WeaponPluginKnockback;
   import WeaponPlugin.WeaponPluginRateOfFire;
   import WeaponPlugin.WeaponPluginSpeed;
   import flash.utils.getDefinitionByName;
   
   public class WeaponGenerator
   {
      
      public static var weaponClasses:Array = [Laser,Blaster,Grenade,Shotgun,PulseGun,Shredder,PlasmaShotgun,ChargeGrenades,ChargeRockets,ChargeLaser];
      
      public function WeaponGenerator()
      {
         super();
      }
      
      public static function generateWeapon(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false) : WeaponBase
      {
         var newLevel:*;
         var possibilities:Array;
         var variance:*;
         var c:int = 0;
         var wb:WeaponBase = null;
         var minLevel:int = 0;
         var maxLevel:* = undefined;
         var b:Blaster = null;
         var level:int = param1;
         var playerLevel:int = param2;
         var forceRare:Boolean = param3;
         var forShop:Boolean = param4;
         var ms:MainScene = MainScene(GameScene.current());
         level = 10 + 7 * ms.currentEpisode;
         if(level < 0)
         {
            level = 20;
         }
         if(level > 65)
         {
            level = 65;
         }
         newLevel = dodgyPoisson(level);
         possibilities = new Array();
         variance = 0;
         while(variance < 10)
         {
            c = 0;
            while(c < weaponClasses.length)
            {
               level = 0;
               for(; level < 3; level++)
               {
                  if(forceRare)
                  {
                     if(weaponClasses[c] == Blaster || weaponClasses[c] == Shotgun)
                     {
                        continue;
                     }
                  }
                  if(!forShop)
                  {
                     if(weaponClasses[c] == PulseGun)
                     {
                        if(variance % 5 != 0)
                        {
                           continue;
                        }
                     }
                  }
                  wb = new weaponClasses[c]();
                  addPlugins(wb);
                  if(forceRare)
                  {
                     while(wb.properPluginCount() < 2)
                     {
                        addPlugins(wb);
                     }
                     wb.level = 2;
                  }
                  possibilities.push(wb);
               }
               c++;
            }
            variance++;
         }
         if(!forceRare)
         {
            if(forShop)
            {
               minLevel = playerLevel + 1 + 3;
               if(playerLevel > 8)
               {
                  minLevel = playerLevel + 1 + 3;
               }
               else if(playerLevel > 5)
               {
                  minLevel = playerLevel + 1 + 2;
               }
               else if(playerLevel > 3)
               {
                  minLevel = playerLevel + 1 + 1;
               }
               else
               {
                  minLevel = playerLevel + 1;
               }
               possibilities = possibilities.filter(function(param1:Object, param2:int, param3:Array):Boolean
               {
                  return WeaponBase(param1).playerMinLevelForShop() <= minLevel;
               });
               possibilities = possibilities.filter(function(param1:Object, param2:int, param3:Array):Boolean
               {
                  return WeaponBase(param1).playerMinLevelForShop() >= playerLevel - 5 || param1 is PulseGun;
               });
            }
            else
            {
               maxLevel = playerLevel;
               if(maxLevel > 3)
               {
                  maxLevel--;
               }
               else if(maxLevel > 6)
               {
                  maxLevel -= 2;
               }
               else if(maxLevel > 12)
               {
                  maxLevel -= 3;
               }
               possibilities = possibilities.filter(function(param1:Object, param2:int, param3:Array):Boolean
               {
                  return WeaponBase(param1).playerMinLevelForShop() <= maxLevel;
               });
            }
            if(ms.currentEpisode == 0)
            {
               possibilities = possibilities.filter(function(param1:Object, param2:int, param3:Array):Boolean
               {
                  return WeaponBase(param1).properPluginCount() == 0;
               });
            }
            if(ms.currentEpisode == 1)
            {
               possibilities = possibilities.filter(function(param1:Object, param2:int, param3:Array):Boolean
               {
                  return WeaponBase(param1).properPluginCount() <= 1;
               });
            }
         }
         if(possibilities.length >= 1)
         {
            return possibilities[Random.randInt(0,possibilities.length - 1)];
         }
         trace(" NO POSSIBILITY");
         b = new Blaster();
         b.level = 0;
         return b;
      }
      
      public static function generateItem(param1:int = 40, param2:Boolean = false) : ItemBase
      {
         var _loc5_:ItemBase = null;
         var _loc6_:Boolean = false;
         var _loc3_:Array = [ItemMagicFind,ItemMedkit,ItemMoreGold,ItemRecharge,ItemRevenge,ItemShield,ItemShootingBot,ItemEMP,ItemSonicPulse,ItemActiveShield,ItemMagnet,ItemMinelayer,ItemShockwave,ItemReboundBot,ItemKamikaziBot];
         var _loc4_:int = 0;
         while(_loc4_ < 1000)
         {
            _loc5_ = new _loc3_[Random.randInt(0,_loc3_.length - 1)]();
            _loc6_ = false;
            if(_loc5_.minimumEpisode() <= MainScene(GameScene.current()).currentEpisode)
            {
               _loc6_ = true;
            }
            if(param2)
            {
               if(_loc5_.displayLevel() < _loc5_.maxLevelCurrently() - 1)
               {
                  _loc6_ = false;
               }
            }
            if(_loc6_)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function dodgyPoisson(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1 * 2)
         {
            if(Math.random() < 0.5)
            {
               _loc2_ += 1;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function addPlugins(param1:WeaponBase) : void
      {
         var wb:WeaponBase = param1;
         wb.plugins = wb.plugins.filter(function(param1:Object, param2:int, param3:Array):Boolean
         {
            return WeaponPluginBase(param1).isIntrinsic;
         });
         if(Math.random() < 0.1)
         {
            wb.addPlugin(new WeaponPluginFlyThrough());
         }
         if(Math.random() < 0.1)
         {
            wb.addPlugin(new WeaponPluginRateOfFire());
         }
         if(Math.random() < 0.1)
         {
            wb.addPlugin(new WeaponPluginKnockback());
         }
         if(Math.random() < 0.1)
         {
            wb.addPlugin(new WeaponPluginFreeze());
         }
         if(Math.random() < 0.1)
         {
            wb.addPlugin(new WeaponPluginSpeed());
         }
      }
   }
}

