package Weapons
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import Scenes.MainScene;
   import Tools.HumanReadable;
   import Tools.Random;
   import WeaponPlugin.WeaponPluginBase;
   import WeaponPlugin.WeaponPluginRateOfFire;
   import WeaponPlugin.WeaponPluginSpeed;
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class WeaponBase extends InventoryItem
   {
      
      public var level:int = Random.randInt(0,2);
      
      public var offset:int = Random.randInt(0,100);
      
      public var image:Class;
      
      public var plugins:Array = new Array();
      
      public var shotCount:int = Random.randInt(0,10);
      
      public var maxCharge:int = 300;
      
      public var charge:int = 0;
      
      public function WeaponBase()
      {
         super();
      }
      
      public function rofString() : String
      {
         var _loc1_:Number = 100 / rateOfFire();
         var _loc2_:String = HumanReadable.truncateFloat(_loc1_);
         return _loc2_ + " PER SECOND";
      }
      
      public function shooting(param1:int) : Boolean
      {
         return (param1 + offset) % rateOfFire() == 0;
      }
      
      public function pickupImage() : Class
      {
         if(level == 0)
         {
            return Embeds.wep_L_png;
         }
         if(level == 1)
         {
            return Embeds.wep_M_png;
         }
         return Embeds.wep_H_png;
      }
      
      override public function getGameObject(param1:String = "AfterTextLayer") : GameObject
      {
         var _loc3_:Bitmap = null;
         var _loc2_:Bitmap = new (icon())();
         if(properPluginCount() == 1)
         {
            _loc3_ = new Embeds.uncommon_png();
         }
         else if(properPluginCount() > 1)
         {
            _loc3_ = new Embeds.rare_png();
         }
         if(_loc3_ != null)
         {
            _loc3_.x = _loc2_.width - _loc3_.width;
            _loc2_.bitmapData.draw(_loc3_,_loc3_.transform.matrix);
         }
         if(playerMinLevel() > MainScene(GameScene.current()).player.level)
         {
            _loc2_.bitmapData.colorTransform(new Rectangle(0,0,_loc2_.width,_loc2_.height),new ColorTransform(0.6,0.6,0.6));
         }
         return new GameObject(null,_loc2_,param1,0,0);
      }
      
      override public function properties() : String
      {
         var _loc2_:WeaponPluginBase = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in plugins)
         {
            if(!_loc2_.isIntrinsic)
            {
               _loc1_.push(_loc2_.attributeText());
            }
         }
         return HumanReadable.combineSentences(_loc1_);
      }
      
      public function playerMinLevelForShop() : int
      {
         return playerMinLevel() + properPluginCount();
      }
      
      public function _damage() : Number
      {
         return 1;
      }
      
      public function icon() : Class
      {
         return null;
      }
      
      public function handleHit(param1:BulletBase, param2:EnemyBase) : void
      {
         var _loc3_:WeaponPluginBase = null;
         if(plugins.length == 0)
         {
            return;
         }
         for each(_loc3_ in plugins)
         {
            _loc3_.hitEnemy(param1,param2);
         }
      }
      
      public function increaseCharge() : void
      {
         ++charge;
         if(charge > maxCharge)
         {
            charge = maxCharge;
         }
      }
      
      public function speedMult() : Number
      {
         var _loc2_:WeaponPluginBase = null;
         var _loc1_:Number = 1;
         for each(_loc2_ in plugins)
         {
            if(_loc2_ is WeaponPluginSpeed)
            {
               _loc1_ += WeaponPluginSpeed(_loc2_).percent / 100;
            }
         }
         return _loc1_;
      }
      
      public function shotRotation() : Number
      {
         return 0;
      }
      
      public function boxDamage() : int
      {
         return 1;
      }
      
      public function pointWorth() : int
      {
         var _loc2_:WeaponPluginBase = null;
         var _loc1_:int = _pointWorth();
         for each(_loc2_ in plugins)
         {
            _loc1_ += _loc2_.pointWorth();
         }
         return _loc1_;
      }
      
      public function shoot(param1:GameScene, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
      }
      
      override public function getText() : Array
      {
         var _loc1_:String = properties();
         var _loc2_:Boolean = properPluginCount() > 0;
         if(_loc1_ == "")
         {
            _loc1_ = "NO SPECIAL ABILITIES.";
         }
         var _loc3_:Array = HumanReadable.splitIntoLines(_loc1_,", ",40,2);
         if(_loc2_)
         {
            _loc3_[0] = "<ORANGE>" + _loc3_[0];
            _loc3_[1] = "<ORANGE>" + _loc3_[1];
         }
         var _loc4_:Array = ["REQUIRED LEVEL",playerMinLevel() + 1];
         if(MainScene(GameScene.current()).player.level < playerMinLevel())
         {
            _loc4_[0] = "<RED>" + _loc4_[0];
            _loc4_[1] = "<RED>" + _loc4_[1];
         }
         return [["<ORANGE>WEAPON: ","<ORANGE>" + name()],[_loc3_[0],""],[_loc3_[1],""],["DAMAGE: ",damage()],["RATE OF FIRE: ",rofString()],["<ORANGE>VALUE: ","<ORANGE>$" + value()],_loc4_];
      }
      
      public function getPercentageCharge() : Number
      {
         return charge / maxCharge;
      }
      
      public function _inGameImage() : Class
      {
         return null;
      }
      
      override public function inGameImage() : Class
      {
         return _inGameImage();
      }
      
      public function properPluginCount() : int
      {
         var _loc2_:WeaponPluginBase = null;
         var _loc1_:int = 0;
         for each(_loc2_ in plugins)
         {
            if(!_loc2_.isIntrinsic)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function rateOfFire() : int
      {
         var _loc2_:WeaponPluginBase = null;
         var _loc1_:int = _rateOfFire();
         for each(_loc2_ in plugins)
         {
            if(_loc2_ is WeaponPluginRateOfFire)
            {
               _loc1_ = _loc1_ * (100 - WeaponPluginRateOfFire(_loc2_).percent) / 100;
            }
         }
         return _loc1_;
      }
      
      public function _rateOfFire() : int
      {
         return 10;
      }
      
      public function recoilTime() : Number
      {
         return 30;
      }
      
      public function getWeaponObject(param1:GameScene) : GameObject
      {
         if(inGameImage())
         {
            return new GameObject(param1,inGameImage(),"Player",0,0);
         }
         return null;
      }
      
      override public function _value() : int
      {
         return 100 * ((playerMinLevel() + 1) * (1 + 0.5 * properPluginCount()));
      }
      
      public function applyLevelToBullet(param1:BulletBase) : *
      {
         if(level == 1)
         {
            Bitmap(param1.obj).bitmapData = param1.mediumSprite;
         }
         else if(level == 2)
         {
            Bitmap(param1.obj).bitmapData = param1.heavySprite;
         }
      }
      
      public function addPlugin(param1:WeaponPluginBase) : void
      {
         if(param1.isApplicable(this))
         {
            plugins.push(param1);
         }
      }
      
      public function serializeFields() : Array
      {
         return ["level","plugins"];
      }
      
      public function recoilAmount() : Number
      {
         return 10;
      }
      
      public function _pointWorth() : int
      {
         return 0;
      }
      
      public function damage() : Number
      {
         return _damage();
      }
      
      public function charges() : Boolean
      {
         return false;
      }
   }
}

