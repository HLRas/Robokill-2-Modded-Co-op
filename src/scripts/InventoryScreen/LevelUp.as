package InventoryScreen
{
   import GameObject.GameObject;
   import GameObject.GameObjectFilter;
   import GameObject.GameObjectFilterFadeInOut;
   import GameObject.GameObjectFilterRotate;
   import GameObject.GameObjectFilterScaleInOut;
   import GameObject.GameObjectFilterSqrtInterpolateIn;
   import GameObject.GameObjectFilterTextType;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import Layout.LayerFilter;
   import ObjectConstructors.LevelUpFrame_constructor;
   import Scenes.MainMenu;
   import Scenes.MainScene;
   import flash.display.Bitmap;
   
   public class LevelUp extends HUDDisplay
   {
      
      public var available:GameObject;
      
      public var starOutline:GameObject;
      
      public var levelText:GameObject;
      
      public var shieldCount:int = 0;
      
      public var damageCount:int = 0;
      
      public var shieldText:GameObject;
      
      public var damageText:GameObject;
      
      public function LevelUp(param1:GameScene)
      {
         var _loc4_:GameObject = null;
         super(param1,Embeds.levelup_frame_png,"TextLayer",400,300);
         addText("Shields",0,1);
         addText("+",1,1);
         shieldText = addText("",2,1,true);
         addText("Damage",3,1);
         addText("+",4,1);
         damageText = addText("",5,1,true);
         var _loc2_:String = String(MainScene(param1).player.level + 2);
         if(_loc2_.length < 2)
         {
            _loc2_ = "0" + _loc2_;
         }
         levelText = addText(_loc2_,6,2,false,true);
         levelText.hide();
         available = addText("",7,3,false,false,true);
         basex = 367;
         basey = 246;
         var _loc3_:Array = new Array();
         for each(_loc4_ in children)
         {
            _loc3_.push(_loc4_);
         }
         LevelUpFrame_constructor.setup(param1,this);
         for each(_loc4_ in param1.objects)
         {
            if(_loc4_.basex == 232 && _loc4_.basey == -1 && _loc4_.additive)
            {
               starOutline = _loc4_;
               starOutline.hide();
            }
         }
         for each(_loc4_ in children)
         {
            if(_loc3_.indexOf(_loc4_) == -1)
            {
               Bitmap(_loc4_.obj).smoothing = true;
               _loc4_.changeZOrder("TextLayer");
               if(_loc4_.helper.containsFilter(GameObjectFilterRotate))
               {
                  _loc4_.remove();
               }
            }
         }
      }
      
      public function addStarPulse(param1:Number, param2:int) : void
      {
         var _loc3_:GameObject = new GameObject(gs,Embeds.levelup_star_png,"TextLayer",608 - 377,-2);
         _loc3_.additive = true;
         var _loc4_:GameObjectFilterFadeInOut = new GameObjectFilterFadeInOut();
         _loc4_.FadeOut = 1;
         _loc4_.FadeOutDuration = param2;
         _loc3_.addFilter(_loc4_);
         var _loc5_:GameObjectFilterScaleInOut = new GameObjectFilterScaleInOut();
         _loc5_.ScaleOut = 1;
         _loc5_.ScaleOutDuration = param2;
         _loc5_.ScaleOutEndX = param1;
         _loc5_.ScaleOutEndY = param1;
         _loc3_.addFilter(_loc5_);
         Bitmap(_loc3_.obj).smoothing = true;
         _loc3_.baseAlpha = 0.5;
         addChild(_loc3_);
      }
      
      public function levelUpText(param1:int) : String
      {
         if(param1 == 1)
         {
            return "Light Blaster";
         }
         if(param1 == 2)
         {
            return "Light Shotgun";
         }
         if(param1 == 3)
         {
            return "Medium Blaster";
         }
         if(param1 == 5)
         {
            return "Light Grenade";
         }
         if(param1 == 6)
         {
            return "Medium Shotgun";
         }
         if(param1 == 7)
         {
            return "Light Cluster Grenade";
         }
         if(param1 == 8)
         {
            return "Heavy Blaster";
         }
         if(param1 == 10)
         {
            return "Medium Grenade";
         }
         if(param1 == 12)
         {
            return "Heavy Shotgun";
         }
         if(param1 == 14)
         {
            return "Medium Cluster Grenade";
         }
         if(param1 == 15)
         {
            return "Heavy Grenade";
         }
         if(param1 == 16)
         {
            return "Light Laser";
         }
         if(param1 == 20)
         {
            return "Light Pulse Gun";
         }
         if(param1 == 21)
         {
            return "Medium Laser";
         }
         if(param1 == 22)
         {
            return "Heavy Cluster Grenade";
         }
         if(param1 == 24)
         {
            return "Light Burst Missiles";
         }
         if(param1 == 25)
         {
            return "Medium Pulse Gun";
         }
         if(param1 == 26)
         {
            return "Heavy Laser";
         }
         if(param1 == 29)
         {
            return "Medium Burst Missiles";
         }
         if(param1 == 30)
         {
            return "Heavy Pulse Gun";
         }
         if(param1 == 36)
         {
            return "Heavy Burst Missiles";
         }
         if(param1 == 34)
         {
            return "Light Devastator";
         }
         if(param1 == 39)
         {
            return "Medium Devastator";
         }
         if(param1 == 44)
         {
            return "Heavy Devastator";
         }
         if(param1 == 27)
         {
            return "Light Pulse Shotgun";
         }
         if(param1 == 32)
         {
            return "Medium Pulse Shotgun";
         }
         if(param1 == 37)
         {
            return "Heavy Pulse Shotgun";
         }
         if(param1 == 31)
         {
            return "Light Shredder";
         }
         if(param1 == 35)
         {
            return "Medium Shredder";
         }
         if(param1 == 40)
         {
            return "Heavy Shredder";
         }
         return "";
      }
      
      override public function createOK() : GameObject
      {
         var _loc1_:GameObject = MainMenu.addNormalStyledButton(gs,"OK",Embeds.levelup_ok_png,Embeds.levelup_ok_over_png,"OK",16 - 35);
         _loc1_.basex = 554 - 33;
         _loc1_.basey = 386 - 54;
         _loc1_.updateDespitePaused = true;
         slide(_loc1_);
         return _loc1_;
      }
      
      override public function kill() : void
      {
         if(killed)
         {
            return;
         }
         reverse(this);
         reverse(ok);
         super.kill();
      }
      
      override public function _remove() : void
      {
         super._remove();
         if(damageText)
         {
            damageText.remove();
         }
         if(shieldText)
         {
            shieldText.remove();
         }
      }
      
      override public function _update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:String = null;
         var _loc3_:GameObjectFilterTextType = null;
         if(_removed || killed)
         {
            return;
         }
         if(ticks == 300)
         {
            starOutline.show();
            levelText.show();
            _loc1_ = 1;
            while(_loc1_ <= 5)
            {
               addStarPulse(Math.sqrt(_loc1_),80);
               _loc1_ += 1;
            }
         }
         if(ticks >= 140)
         {
            available.baseAlpha = 1;
            if(ticks == 140)
            {
               _loc2_ = levelUpText(MainScene(gs).player.level + 1);
               if(_loc2_ != "")
               {
                  _loc3_ = new GameObjectFilterTextType();
                  _loc3_.txt = _loc2_ + " Now Available";
                  _loc3_.speed /= 2;
                  available.addFilter(_loc3_);
               }
            }
         }
         else
         {
            available.baseAlpha = 0;
         }
         if(ticks % 8 == 0)
         {
            if(ticks > 110)
            {
               ++damageCount;
            }
         }
         if(ticks % 7 == 0)
         {
            if(ticks > 30)
            {
               ++shieldCount;
            }
         }
         if(shieldCount > 10)
         {
            shieldCount = 10;
         }
         if(damageCount > 5)
         {
            damageCount = 5;
         }
         if(shieldCount > 0)
         {
            shieldText.setText(String(shieldCount),-1,shieldCount >= 10 ? 16766499 : -1);
         }
         if(damageCount > 0)
         {
            damageText.setText(String(damageCount) + "%",-1,damageCount >= 5 ? 16766499 : -1);
         }
         MainScene(gs).fadeOverlay.hide();
         super._update();
      }
      
      override public function _open(param1:GameScene) : void
      {
      }
      
      public function addText(param1:String, param2:Number, param3:Number, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : GameObject
      {
         var _loc10_:GameObject = null;
         var _loc7_:int = 36;
         if(param3 > 0)
         {
            _loc7_ = 28;
         }
         var _loc8_:Array = [150,230,258,320,400,420,516 + 26,149];
         var _loc9_:Array = [40 + baseHeight / 2 - 1,40 + baseHeight / 2 - 1,-40 + baseHeight / 2 + 15 + 35 + 6,75 + baseHeight / 2 + 8];
         param2 = Number(_loc8_[param2]);
         param3 = Number(_loc9_[param3]);
         if(param6)
         {
            _loc7_ = 24;
         }
         _loc10_ = new GameObject(gs,null,"TextLayer",0,0);
         _loc10_.fontName = "SFC";
         _loc10_.defaultCol = 16755200;
         _loc10_.basex = param2 - baseWidth / 2;
         _loc10_.basey = param3 - baseHeight / 2 - 12;
         _loc10_.baseHandleX = 0;
         _loc10_.baseHandleY = 0;
         _loc10_.setText(param1,_loc7_);
         if(param5)
         {
            _loc10_.baseHandleX = 0.5;
            _loc10_.baseHandleY = 0.5;
            _loc10_.setText(param1,70,16762880);
         }
         _loc10_.updateDespitePaused = true;
         addChild(_loc10_);
         return _loc10_;
      }
      
      override public function slide(param1:Object) : *
      {
         return LayerFilter.applySlideIn(param1,0,-600,0,false,15);
      }
      
      public function reverse(param1:GameObject) : void
      {
         var _loc2_:GameObjectFilter = null;
         var _loc3_:GameObjectFilterSqrtInterpolateIn = null;
         for each(_loc2_ in param1.filters)
         {
            if(_loc2_ is GameObjectFilterSqrtInterpolateIn)
            {
               _loc3_ = GameObjectFilterSqrtInterpolateIn(_loc2_);
               _loc3_.dx *= -1;
            }
         }
      }
      
      override public function _kill() : void
      {
         super._kill();
      }
   }
}

