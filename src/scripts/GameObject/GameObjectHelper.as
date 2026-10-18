package GameObject
{
   import Audio.GameSound;
   import Audio.GameSoundChannel;
   import GameConfig.GameConfig;
   import Tools.GraphicsTools;
   import Tools.Interpolation;
   import Tools.SafeImageRequest;
   import flash.display.*;
   import flash.geom.*;
   
   public class GameObjectHelper
   {
      
      public static var radianConst:Number = Math.PI / 180;
      
      public var go:GameObject;
      
      public function GameObjectHelper(param1:GameObject)
      {
         super();
         this.go = param1;
      }
      
      public function lazyLoad(param1:String) : void
      {
         go.vars["lazyLoad"] = new SafeImageRequest(param1);
      }
      
      public function angleToPoint(param1:Number, param2:Number) : Number
      {
         return Math.atan2(param2 - go.globalY(),param1 - go.globalX()) * 180 / Math.PI + 90 + GameConfig.referenceAngle;
      }
      
      public function playAmbient(param1:GameSound, param2:Boolean = false) : GameSoundChannel
      {
         if(!go.vars["ambientsMap"])
         {
            go.vars["ambientsMap"] = new Array();
         }
         if(go.vars["ambientsMap"][param1] is GameSoundChannel)
         {
            if(!param2)
            {
               go.vars["ambientsMap"][param1].stop();
               go.vars["ambientsMap"][param1] = null;
            }
         }
         else if(param2)
         {
            go.vars["ambientsMap"][param1] = param1.play(true);
         }
         return go.vars["ambientsMap"][param1];
      }
      
      public function rotateVector(param1:Number, param2:Number, param3:Number = -9999999) : Point
      {
         if(param3 < -99999)
         {
            param3 = go.baseRotation;
         }
         var _loc4_:Number = param3 * radianConst;
         var _loc5_:Number = Math.cos(-_loc4_) * param1 * go.modifiedScaleX + Math.sin(-_loc4_) * param2 * go.modifiedScaleY;
         var _loc6_:Number = -Math.sin(-_loc4_) * param1 * go.modifiedScaleX + Math.cos(-_loc4_) * param2 * go.modifiedScaleY;
         return new Point(_loc5_,_loc6_);
      }
      
      public function snapTo(param1:int) : void
      {
         go.basex -= go.basex % param1;
         go.basey -= go.basey % param1;
      }
      
      public function pushTowardsObject(param1:GameObject, param2:Number, param3:Number = 0, param4:Boolean = true, param5:Boolean = true) : *
      {
         var _loc6_:Point = vectorToObject(param1);
         if(!param4)
         {
            _loc6_.x = 0;
            if(_loc6_.y > 0)
            {
               _loc6_.y = 1;
            }
            else
            {
               _loc6_.y = -1;
            }
         }
         if(!param5)
         {
            _loc6_.x = 0;
            if(_loc6_.x > 0)
            {
               _loc6_.x = 1;
            }
            else
            {
               _loc6_.x = -1;
            }
         }
         if(param4)
         {
            go["dx"] += _loc6_.x * param2;
         }
         if(param5)
         {
            go["dy"] += _loc6_.y * param2;
         }
      }
      
      public function update() : void
      {
         var gof:GameObjectFilter = null;
         var prog:Number = NaN;
         var c:int = 0;
         if(go.vars["lazyLoad"])
         {
            if(go.vars["lazyLoad"].finished)
            {
               go.setupButton(Bitmap(go.vars["lazyLoad"].ldr.getChildAt(0)).bitmapData,"",null,true);
               go.baseWidth = go.obj.width;
               go.baseHeight = go.obj.height;
               go.vars["lazyLoad"] = null;
            }
         }
         if(go.vars["backing"])
         {
            for each(gof in go.filters)
            {
               if(gof is GameObjectFilterSqrtInterpolateIn)
               {
                  prog = GameObjectFilterSqrtInterpolateIn(gof).progress();
                  prog = (prog - 0.5) * 2;
                  if(prog < 0)
                  {
                     prog = 0;
                  }
                  go.vars["backing"].baseAlpha = prog * 0.4;
               }
            }
         }
         if(go.vars["timeDraws"])
         {
            if(go.vars["timeDraws"].length > 0)
            {
               c = 0;
               while(c < go.vars["timeDraws"].length)
               {
                  go.vars["timeDraws"][c][0] = go.vars["timeDraws"][c][0] - 1;
                  if(go.ticks % 10 == 0)
                  {
                     go.drawToImage(go.vars["timeDraws"][c][1],go.vars["timeDraws"][c][2],go.vars["timeDraws"][c][3],go.vars["timeDraws"][c][4],go.vars["timeDraws"][c][5],go.vars["timeDraws"][c][6]);
                  }
                  c++;
               }
               go.vars["timeDraws"] = go.vars["timeDraws"].filter(function(param1:Array, param2:int, param3:Array):Boolean
               {
                  return param1[0] > 0;
               });
            }
         }
      }
      
      public function blinkHelpText(param1:String, param2:String = "", param3:int = 7) : void
      {
         var _loc4_:GameObject = null;
         _loc4_ = new GameObject(go.gs,null,go.zOrderString,go.baseWidth * (0.5 - go.baseHandleX),-go.baseHeight / 2 - 10 + go.baseHeight * (0.5 - go.baseHandleY));
         if(param2 != "")
         {
            _loc4_.fontName = param2;
         }
         _loc4_.setText(param1,param3);
         _loc4_.addFilter(new GameObjectFilterBlink());
         _loc4_.updateDespitePaused = go.updateDespitePaused;
         go.addChild(_loc4_);
      }
      
      public function slideTo(param1:Number, param2:Number, param3:Boolean = true, param4:int = 100, param5:Function = null) : GameObjectFilterSqrtInterpolateIn
      {
         var _loc10_:GameObjectFilterSqrtInterpolateIn = null;
         var _loc6_:GameObjectFilterSqrtInterpolateIn = new GameObjectFilterSqrtInterpolateIn();
         var _loc7_:Number = go.basex;
         var _loc8_:Number = go.basey;
         var _loc9_:int = 0;
         while(_loc9_ < go.filters.length)
         {
            if(go.filters[_loc9_] is GameObjectFilterSqrtInterpolateIn)
            {
               _loc10_ = GameObjectFilterSqrtInterpolateIn(go.filters[_loc9_]);
               _loc7_ += _loc10_.dx;
               _loc8_ += _loc10_.dy;
            }
            _loc9_++;
         }
         _loc6_.dx = param1 - _loc7_;
         _loc6_.dy = param2 - _loc8_;
         _loc6_.useSquareSquare = true;
         _loc6_.killWhenDone = param3;
         _loc6_.FadeTime = param4;
         _loc6_.killFunction = param5;
         go.addFilter(_loc6_);
         return _loc6_;
      }
      
      public function angleToObject(param1:GameObject) : Number
      {
         return Math.atan2(param1.globalY() - go.globalY(),param1.globalX() - go.globalX()) * 180 / Math.PI + 90 + GameConfig.referenceAngle;
      }
      
      public function vectorToPoint(param1:Number, param2:Number) : Point
      {
         var _loc3_:Number = param1 - go.basex;
         var _loc4_:Number = param2 - go.basey;
         var _loc5_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
         _loc3_ /= _loc5_;
         _loc4_ /= _loc5_;
         return new Point(_loc3_,_loc4_);
      }
      
      public function handleRemove() : void
      {
         var _loc1_:Object = null;
         go.vars["removed"] = true;
         if(go.vars["backing"])
         {
            go.vars["backing"].helperFilter.fadeOff(15);
         }
         if(go.vars["conditionalChildren"])
         {
            for each(_loc1_ in go.vars["conditionalChildren"])
            {
               if(_loc1_ is GameObject)
               {
                  GameObject(_loc1_).remove();
               }
            }
         }
         if(go.vars)
         {
            if(go.vars["ambientsMap"])
            {
               for each(_loc1_ in go.vars["ambientsMap"])
               {
                  if(_loc1_ is GameSoundChannel)
                  {
                     GameSoundChannel(_loc1_).stop();
                  }
               }
            }
         }
      }
      
      public function normalize(param1:Number, param2:Number) : Point
      {
         if(param1 == 0 && param2 == 0)
         {
            return new Point(0,0);
         }
         var _loc3_:Number = Math.sqrt(param1 * param1 + param2 * param2);
         param1 /= _loc3_;
         param2 /= _loc3_;
         return new Point(param1,param2);
      }
      
      public function anySlideFilters() : Boolean
      {
         var _loc1_:GameObjectFilter = null;
         for each(_loc1_ in go.filters)
         {
            if(_loc1_ is GameObjectFilterSqrtInterpolateIn)
            {
               if(!GameObjectFilterSqrtInterpolateIn(_loc1_).done())
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function drawOverTime(param1:Bitmap, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:int) : void
      {
         if(go.vars)
         {
            if(!go.vars["timeDraws"])
            {
               go.vars["timeDraws"] = new Array();
            }
            go.vars["timeDraws"].push([param7,param1,param2,param3,param4,param5,param6]);
         }
      }
      
      public function angleForVector(param1:Number, param2:Number) : Number
      {
         return Math.atan2(param2,param1) * 180 / Math.PI + 90 + GameConfig.referenceAngle;
      }
      
      public function fadeChildren(param1:Number, param2:Number = 100) : void
      {
         var _loc3_:GameObject = null;
         var _loc4_:Number = NaN;
         if(!go.vars["childrenFadeData"])
         {
            go.vars["childrenFadeData"] = new Object();
         }
         for each(_loc3_ in go.children)
         {
            if(go.vars["childrenFadeData"][_loc3_] == null)
            {
               go.vars["childrenFadeData"][_loc3_] = _loc3_.baseAlpha;
            }
            _loc4_ = Number(go.vars["childrenFadeData"][_loc3_]);
            _loc3_.baseAlpha = Interpolation.tendTowards(_loc3_.baseAlpha,param1 * _loc4_,_loc4_ / param2);
            _loc3_.hidden = _loc3_.baseAlpha == 0;
         }
      }
      
      public function showChildren() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in go.children)
         {
            _loc1_.show();
         }
      }
      
      public function getModifiedRotation() : Number
      {
         var _loc1_:GameObjectFilter = null;
         for each(_loc1_ in go.filters)
         {
            if(_loc1_ is GameObjectFilterRotateSlowly)
            {
               return GameObjectFilterRotateSlowly(_loc1_).internalRotation;
            }
         }
         return go.baseRotation;
      }
      
      public function mapWhenChanged(param1:Array, param2:String, param3:Function, param4:Function) : Array
      {
         if(!go.vars["lastInputs"])
         {
            go.vars["lastInputs"] = new Array();
         }
         if(!go.vars["lastOutputs"])
         {
            go.vars["lastOutputs"] = new Array();
         }
         var _loc5_:Array = new Array(param1.length);
         var _loc6_:Array = Array(go.vars["lastInputs"][param2])[0];
         var _loc7_:Array = Array(go.vars["lastOutputs"][param2])[0];
         if(!_loc6_)
         {
            trace("creating new");
            _loc6_ = new Array(param1.length);
            go.vars["lastInputs"][param2] = _loc6_;
            _loc7_ = new Array(param1.length);
            go.vars["lastOutputs"][param2] = _loc7_;
         }
         var _loc8_:int = 0;
         while(_loc8_ < param1.length)
         {
            if(param1[_loc8_] != _loc6_[_loc8_])
            {
               if(_loc7_[_loc8_])
               {
                  param4(_loc7_[_loc8_]);
               }
               _loc5_[_loc8_] = param3(param1[_loc8_]);
            }
            else
            {
               _loc5_[_loc8_] = _loc7_[_loc8_];
            }
            _loc6_[_loc8_] = param1[_loc8_];
            _loc7_[_loc8_] = _loc5_[_loc8_];
            _loc8_++;
         }
         return _loc5_;
      }
      
      public function scaleBitmap(param1:int, param2:int, param3:int = 100, param4:int = 100) : void
      {
         var _loc5_:BitmapData = Bitmap(go.obj).bitmapData;
         var _loc6_:BitmapData = new BitmapData(param1,param2,true);
         _loc6_.copyPixels(_loc5_,new Rectangle(0,0,param3,param4),new Point(0,0));
         _loc6_.copyPixels(_loc5_,new Rectangle(_loc5_.width - param3 - 1,_loc5_.height - param4 - 1,param3,param4),new Point(_loc6_.width - param3,_loc6_.height - param4));
         _loc6_.copyPixels(_loc5_,new Rectangle(0,_loc5_.height - param4 - 1,param3,param4),new Point(0,_loc6_.height - param4));
         _loc6_.copyPixels(_loc5_,new Rectangle(_loc5_.width - param3 - 1,0,param3,param4),new Point(_loc6_.width - param3,0));
         var _loc7_:int = param4;
         while(_loc7_ < _loc6_.height - param4)
         {
            _loc6_.copyPixels(_loc5_,new Rectangle(0,param4 + 1,param3,1),new Point(0,_loc7_));
            _loc6_.copyPixels(_loc5_,new Rectangle(_loc5_.width - param3 - 1,param4 + 1,param3,1),new Point(_loc6_.width - param3,_loc7_));
            _loc7_++;
         }
         var _loc8_:int = param3;
         while(_loc8_ < _loc6_.width - param3)
         {
            _loc6_.copyPixels(_loc5_,new Rectangle(param3 + 1,0,1,param4),new Point(_loc8_,0));
            _loc6_.copyPixels(_loc5_,new Rectangle(param3 + 1,_loc5_.height - param4 - 1,1,param4),new Point(_loc8_,_loc6_.height - param4));
            _loc8_++;
         }
         _loc6_.floodFill(_loc6_.width / 2,_loc6_.height / 2,_loc5_.getPixel32(param3 + 1,param4 + 1));
         Bitmap(go.obj).bitmapData = _loc6_;
         go.baseWidth = _loc6_.width;
         go.baseHeight = _loc6_.height;
      }
      
      public function hideChildren() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in go.children)
         {
            _loc1_.hide();
         }
      }
      
      public function offscreen(param1:int = 0) : Boolean
      {
         if(go.basex < -param1)
         {
            return true;
         }
         if(go.basex > 800 + param1)
         {
            return true;
         }
         if(go.basey < -param1)
         {
            return true;
         }
         if(go.basey > 600 + param1)
         {
            return true;
         }
         return false;
      }
      
      public function blink(param1:Boolean) : void
      {
         if(param1)
         {
            if(!go.vars["blinkFilter"])
            {
               go.vars["blinkFilter"] = new GameObjectFilterBlink();
               go.vars["blinkFilter"].BlinkAlpha = 0.4;
               go.vars["blinkFilter"].Interval = 15;
               go.addFilter(go.vars["blinkFilter"]);
            }
         }
         else if(go.vars["blinkFilter"])
         {
            go.vars["blinkFilter"].removeFilter = true;
            go.vars["blinkFilter"] = null;
         }
      }
      
      public function findNearest(param1:Class, param2:Number = NaN, param3:Number = NaN) : GameObject
      {
         var _loc6_:GameObject = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param2 == NaN)
         {
            param2 = go.basex;
            param3 = go.basey;
         }
         var _loc4_:GameObject = null;
         var _loc5_:Number = 0;
         for each(_loc6_ in go.gs.objects)
         {
            if(_loc6_ is param1)
            {
               if(_loc6_ != go)
               {
                  _loc7_ = param2 - _loc6_.basex;
                  _loc8_ = param3 - _loc6_.basey;
                  _loc9_ = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
                  if(_loc9_ < _loc5_ || _loc4_ == null)
                  {
                     _loc5_ = _loc9_;
                     _loc4_ = _loc6_;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function onScreen(param1:Number = 0) : Boolean
      {
         if(go.basex - go.gs.camX < -go.baseWidth / 2 - param1)
         {
            return false;
         }
         if(go.basex - go.gs.camX > 800 + go.baseWidth / 2 + param1)
         {
            return false;
         }
         if(go.basey - go.gs.camY < -go.baseHeight / 2 - param1)
         {
            return false;
         }
         if(go.basey - go.gs.camY > 600 + go.baseHeight / 2 + param1)
         {
            return false;
         }
         return true;
      }
      
      public function collidesWithRectangle(param1:Number, param2:Number, param3:Number, param4:Number) : *
      {
         if(param1 + param3 < go.basex - go.baseWidth / 2)
         {
            return false;
         }
         if(param1 > go.basex + go.baseWidth / 2)
         {
            return false;
         }
         if(param2 + param4 < go.basey - go.baseHeight / 2)
         {
            return false;
         }
         if(param2 > go.basey + go.baseHeight / 2)
         {
            return false;
         }
         return true;
      }
      
      public function conditionallyCreateChild(param1:Object, param2:String, param3:Boolean, param4:Number = 0.05, param5:Function = null, param6:Number = 1) : GameObject
      {
         var _loc8_:Object = null;
         if(go._removed)
         {
            return null;
         }
         if(!go.vars)
         {
            return null;
         }
         if(go.vars["removed"])
         {
            return null;
         }
         if(!go.vars["conditionalChildren"])
         {
            go.vars["conditionalChildren"] = new Object();
         }
         if(!go.vars["lastAdjustedAlphaTicks"])
         {
            go.vars["lastAdjustedAlphaTicks"] = 0;
         }
         var _loc7_:GameObject = go.vars["conditionalChildren"][param2];
         if(!_loc7_)
         {
            if(param3)
            {
               if(param1 is Class)
               {
                  _loc8_ = new param1();
                  if(_loc8_ is GameObject)
                  {
                     _loc7_ = GameObject(_loc8_);
                  }
                  else
                  {
                     _loc7_ = new GameObject(null,_loc8_,go.zOrderString,go.basex,go.basey);
                  }
               }
               else if(param1 is Function)
               {
                  _loc7_ = GameObject(param1());
               }
               else
               {
                  _loc7_ = new GameObject(go.gs,param1,go.zOrderString,go.basex,go.basey);
               }
               if(Boolean(param5))
               {
                  param5(_loc7_);
               }
               go.vars["conditionalChildren"][param2] = _loc7_;
               _loc7_.baseAlpha = 0;
            }
         }
         if(_loc7_)
         {
            if(go.vars["lastAdjustedAlphaTicks" + param2] != go.ticks)
            {
               if(param3)
               {
                  _loc7_.baseAlpha += param4 * param6;
               }
               else
               {
                  _loc7_.baseAlpha -= param4 * param6;
               }
            }
            go.vars["lastAdjustedAlphaTicks" + param2] = go.ticks;
            _loc7_.baseAlpha = Interpolation.lockValue(_loc7_.baseAlpha,0,param6);
            if(!param3 && _loc7_.baseAlpha == 0)
            {
               _loc7_.remove();
               if(go.vars["conditionalChildren"])
               {
                  go.vars["conditionalChildren"][param2] = null;
               }
            }
         }
         return _loc7_;
      }
      
      public function relativeAngleToObject(param1:GameObject) : Number
      {
         var _loc2_:Number = 0;
         if(go.parent)
         {
            _loc2_ += go.parent.baseRotation;
         }
         return go.helper.angleToObject(param1) - _loc2_;
      }
      
      public function vectorForAngle(param1:Number) : Point
      {
         param1 = param1 + 90 + GameConfig.referenceAngle;
         return new Point(Math.sin(param1 * Math.PI / 180),-Math.cos(param1 * Math.PI / 180));
      }
      
      public function containsFilter(param1:Class) : Boolean
      {
         var _loc2_:GameObjectFilter = null;
         for each(_loc2_ in go.filters)
         {
            if(_loc2_ is param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function positionAsChild(param1:GameObject, param2:Number = 0, param3:Number = 0) : void
      {
         var _loc4_:Point = go.tformed(param2,param3);
         param1.basex = _loc4_.x;
         param1.basey = _loc4_.y;
         param1.baseScaleX = go.baseScaleX;
         param1.baseScaleY = go.baseScaleY;
         param1.baseRotation = go.modifiedRotation;
         param1.baseAlpha = go.baseAlpha;
      }
      
      public function addBacking() : void
      {
         go.vars["backing"] = new GameObject(go.gs,GraphicsTools.createFilledSprite(800,600,4278190080),go.zOrderString,400,300);
         go.vars["backing"].baseAlpha = 0.4;
         go.vars["backing"].helperFilter.fadeIn(15);
         go.vars["backing"].setGlobal(true);
         go.changeZOrder(go.zOrderString);
      }
      
      public function mapChildren(param1:Function) : void
      {
         var _loc2_:GameObject = null;
         for each(_loc2_ in go.children)
         {
            param1(_loc2_);
         }
      }
      
      public function vectorToObject(param1:GameObject) : Point
      {
         var _loc2_:Number = param1.basex - go.basex;
         var _loc3_:Number = param1.basey - go.basey;
         var _loc4_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
         _loc2_ /= _loc4_;
         _loc3_ /= _loc4_;
         return new Point(_loc2_,_loc3_);
      }
      
      public function stripChildren() : void
      {
         var _loc1_:GameObject = null;
         for each(_loc1_ in go.children)
         {
            _loc1_.remove();
         }
      }
   }
}

