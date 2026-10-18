package ObjectBase
{
   import GameObject.*;
   import GlobalSetup.Embeds;
   import Layout.Layout;
   import Scenes.MainScene;
   import Tools.*;
   import Weapons.ItemBase;
   import Weapons.WeaponBase;
   import flash.display.BitmapData;
   import flash.display.SimpleButton;
   import flash.geom.Rectangle;
   
   public class HUDBase extends GameObject
   {
      
      public var weaponButtons:Array = new Array();
      
      public function HUDBase()
      {
         super(null,null,"TextLayer",0,0);
      }
      
      override public function _update() : void
      {
         var space:Boolean;
         var shift:Boolean;
         var overlay:Array;
         var overlay2:Array;
         var c:int = 0;
         var wb:WeaponBase = null;
         var go:GameObject = null;
         var create:Boolean = false;
         var createString:String = null;
         var f:GameObjectFilterBlink = null;
         var prog:Number = NaN;
         var bd:BitmapData = null;
         var player:PlayerBase = MainScene(gs).player;
         if(player._removed)
         {
            return;
         }
         if(player.falling)
         {
            return;
         }
         space = Boolean(Input.i.keyHit(32));
         shift = Boolean(Input.i.keyHit(16));
         c = 0;
         while(c < 4)
         {
            go = weaponButtons[c];
            create = false;
            createString = "";
            if(player.items[c])
            {
               if(weaponButtons[c].mOver())
               {
                  create = true;
               }
               createString = ItemBase(player.items[c]).name();
               if(c >= 2)
               {
                  createString += " (PASSIVE)";
               }
            }
            go = helper.conditionallyCreateChild(null,String(c),create,0.5);
            if(go)
            {
               go.setText(createString,16);
               go.basex = weaponButtons[c].basex;
               if(go.basex - go.baseWidth / 2 < 2)
               {
                  go.basex = 2 + go.baseWidth / 2;
               }
               go.basey = weaponButtons[c].basey - weaponButtons[c].baseHeight / 2 - 16;
            }
            c++;
         }
         c = 0;
         while(c < 2)
         {
            go = weaponButtons[c];
            create = false;
            createString = "";
            if(player.items[c])
            {
               if(player.items[c].rechargeProgress >= player.items[c].rechargeTime)
               {
                  createString = "READY";
                  create = true;
               }
            }
            go = helper.conditionallyCreateChild(null,String(c) + "asdf",create,0.5);
            if(go)
            {
               go.fontName = "Pixelation-34";
               go.setText(createString,7,16755200);
               go.changeZOrder(weaponButtons[c].zOrderString);
               go.basex = weaponButtons[c].basex - 2;
               go.basey = weaponButtons[c].basey - weaponButtons[c].baseHeight / 2 - 8;
               if(go.filters.length == 0)
               {
                  f = new GameObjectFilterBlink();
                  go.addFilter(f);
               }
               if(go.ticks >= 400 && MainScene(gs).currentEpisode >= 2)
               {
                  go.hide();
               }
            }
            c++;
         }
         if(!player.beforeTeleporting())
         {
            c = 0;
            while(c < 4)
            {
               go = weaponButtons[c];
               if(!player.items[c] || c >= 2)
               {
                  go.disableButton();
               }
               else
               {
                  go.enableButton();
               }
               if(c < 2)
               {
                  if(player.items[c])
                  {
                     if(Boolean(Input.i.keyHit(49 + c) || c == 0 && space) || Boolean(c == 1 && shift) || go.mHit())
                     {
                        prog = player.items[c].rechargeProgress / player.items[c].rechargeTime;
                        if(prog >= 1)
                        {
                           MainScene(gs).player.items[c].useOn(player);
                           Sounds.useItem.play();
                        }
                     }
                  }
               }
               c++;
            }
         }
         overlay = helper.mapWhenChanged(player.items,"hudItems",function(param1:ItemBase):GameObject
         {
            if(param1)
            {
               return param1.getGameObject("TextLayer");
            }
            return null;
         },function(param1:GameObject):void
         {
            param1.remove();
         });
         overlay2 = helper.mapWhenChanged(player.items,"hudItemsOverlay",function(param1:ItemBase):GameObject
         {
            if(param1)
            {
               return new GameObject(null,GraphicsTools.createFilledSprite(40,40,4278190080,true),"TextLayer",0,0);
            }
            return null;
         },function(param1:GameObject):void
         {
            param1.remove();
         });
         c = 0;
         while(c < 4)
         {
            if(overlay[c])
            {
               weaponButtons[c].helper.positionAsChild(overlay[c]);
            }
            c++;
         }
         c = 0;
         while(c < 4)
         {
            if(player.items[c])
            {
               if(overlay2[c])
               {
                  weaponButtons[c].helper.positionAsChild(overlay2[c]);
                  prog = player.items[c].rechargeProgress / player.items[c].rechargeTime;
                  prog = Interpolation.lockValue(prog,0,1);
                  bd = overlay2[c].obj.bitmapData;
                  if(c >= 2)
                  {
                     bd.fillRect(new Rectangle(0,0,40,40),1711276032);
                  }
                  else
                  {
                     bd.fillRect(new Rectangle(0,0,40,40),2281701376);
                     bd.fillRect(new Rectangle(0,40 * (1 - prog),40,40),0);
                  }
               }
            }
            c++;
         }
      }
      
      override public function _init() : void
      {
         var _loc3_:GameObject = null;
         var _loc4_:Class = null;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc3_ = new GameObject(null,SimpleButton,"TextLayer",0,0);
            _loc4_ = Embeds.weaponslot_png;
            if(_loc1_ == 0)
            {
               _loc4_ = Embeds.weaponslot01_png;
            }
            if(_loc1_ == 1)
            {
               _loc4_ = Embeds.weaponslot02_png;
            }
            _loc3_.setupButton(_loc4_,"WeaponSLot");
            _loc3_.stripText();
            weaponButtons[_loc1_] = _loc3_;
            _loc1_++;
         }
         var _loc2_:Layout = gs.horiz(weaponButtons,8,0,600);
         gs.horiz(weaponButtons,8,4 + _loc2_.width() / 2,600 - _loc2_.height() / 2);
      }
   }
}

