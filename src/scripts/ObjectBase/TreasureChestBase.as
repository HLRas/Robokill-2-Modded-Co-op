package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Objects.Cash;
   import Objects.PickupText;
   import Scenes.MainScene;
   import Weapons.WeaponGenerator;
   import flash.display.BitmapData;
   
   public class TreasureChestBase extends PickupBase
   {
      
      public var opened:Boolean = false;
      
      public var open:BitmapData;
      
      public var spawnEnemies:Boolean = true;
      
      public var openedTicks:int = 0;
      
      public var giveWeapon:Boolean = false;
      
      public function TreasureChestBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function pickup() : Boolean
      {
         var _loc1_:PickupWeapon = null;
         var _loc2_:* = 0;
         var _loc3_:Cash = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!opened && canOpen())
         {
            new PickupText(gs,basex,basey - 32,"TREASURE!",16764727);
            Sounds.treasureOpen.play();
            opened = true;
            openedTicks = 0;
            if(giveWeapon)
            {
               _loc1_ = new PickupWeapon(gs,basex,basey);
               _loc1_.wep = WeaponGenerator.generateWeapon(100,MainScene(gs).player.level,true);
               _loc1_.dy = 3;
            }
            else
            {
               _loc2_ = 9;
               while(_loc2_ > 0)
               {
                  _loc3_ = new Cash(gs,basex + (_loc2_ - 4.5) * 2,basey + Math.random() * 3);
                  _loc4_ = 90 - (_loc2_ - 4) * 15;
                  _loc5_ = 4 + Math.random() * 2;
                  _loc3_.flyIn = 20 + _loc2_;
                  _loc3_.flyAngle = _loc4_;
                  _loc3_.flySpeed = _loc5_;
                  _loc3_.preventMissionComplete = 500;
                  _loc3_.flyInDelay = _loc2_ * 5;
                  _loc3_.collidesWithWalls = false;
                  _loc2_--;
               }
            }
         }
         return false;
      }
      
      public function canOpen() : Boolean
      {
         if(MainScene(gs).countEnemies(false) == 0)
         {
            return true;
         }
         if(ms.currentLevel.ambushRoom)
         {
            return true;
         }
         return false;
      }
      
      override public function _update() : void
      {
         var lid:GameObject = null;
         var fr:int = 0;
         var locked:Boolean = !opened && !canOpen();
         var child:GameObject = helper.conditionallyCreateChild(Embeds.treasurelocked_png,"locked",locked);
         if(distanceToPlayer() < 52)
         {
            pickup();
         }
         lid = helper.conditionallyCreateChild(Embeds.treasure_lid001_png,"lid",open,1,function create(param1:GameObject):void
         {
            param1.changeZOrder("Player");
         });
         MainScene(gs).setPassable(logicalSquareX(),logicalSquareY(),false);
         if(!(locked || opened))
         {
            helper.fadeChildren(1,100);
         }
         else
         {
            helper.fadeChildren(0,10);
         }
         if(child)
         {
            child.basex = basex;
            child.basey = basey;
            child.baseHandleX = baseHandleX;
            child.baseHandleY = baseHandleY;
            lid.basex = basex;
            lid.basey = basey;
            lid.baseHandleX = baseHandleX;
            lid.baseHandleY = baseHandleY;
         }
         if(opened)
         {
            ++openedTicks;
            fr = openedTicks / 5;
            if(fr >= Embeds.treasureOpen.length)
            {
               fr = Embeds.treasureOpen.length - 1;
            }
            helperAnimation.setFrame(Embeds.treasureOpen[fr]);
            lid.helperAnimation.setFrame(Embeds.treasureLid[fr]);
         }
      }
      
      override public function serializeFields() : Array
      {
         var _loc1_:Array = super.serializeFields();
         _loc1_.push("opened");
         _loc1_.push("spawnEnemies");
         _loc1_.push("openedTicks");
         return _loc1_;
      }
   }
}

