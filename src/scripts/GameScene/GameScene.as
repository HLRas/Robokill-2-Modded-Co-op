package GameScene
{
   import Audio.*;
   import GameObject.*;
   import GlobalSetup.ZOrder;
   import Layout.Layout;
   import NagScreen.NagScreen;
   import Particles.Particle;
   import Particles.ParticleLayer;
   import Tools.Input;
   import Tools.Random;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.geom.*;
   
   public class GameScene
   {
      
      public static var currentScene:GameScene;
      
      public static var stealFocus:Boolean = true;
      
      public static var currentindex:int = 0;
      
      public var updateWhenRemoving:Boolean = false;
      
      public var gss:GameSceneStack;
      
      public var objects:Array = new Array();
      
      public var parent:Sprite;
      
      public var paused:Boolean = false;
      
      public var defaultTextSize:Number = 24;
      
      public var fadeToBlackTicks:int = 0;
      
      public var fadeToBlack:Boolean = false;
      
      public var _paused:Boolean = false;
      
      public var Ticks:int = 0;
      
      public var camX:Number = 0;
      
      public var _mhit:Boolean;
      
      public var m:MovieClip;
      
      public var cameras:Array = new Array();
      
      public var orphanedParticleLayers:Array = new Array();
      
      public var i:Input;
      
      public var camY:Number = 0;
      
      public var defaultTextLayer:String = "TextLayer";
      
      public var zOrders:Array = new Array();
      
      public function GameScene()
      {
         super();
         currentScene = this;
         NagScreen.preload();
         m = new MovieClip();
         new ZOrder().SetupZOrder(this);
      }
      
      public static function current() : GameScene
      {
         return currentScene;
      }
      
      public function getAllParticles() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Particle = null;
         var _loc4_:ParticleLayer = null;
         var _loc5_:GameSceneZOrder = null;
         var _loc1_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < objects.length)
         {
            if(objects[_loc2_].mainLayer)
            {
               for each(_loc3_ in objects[_loc2_].mainLayer.particles)
               {
                  _loc1_.push(_loc3_);
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < orphanedParticleLayers.length)
         {
            _loc4_ = orphanedParticleLayers[_loc2_];
            for each(_loc3_ in _loc4_.particles)
            {
               _loc1_.push(_loc3_);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < zOrders.length)
         {
            _loc5_ = GameSceneZOrder(zOrders[_loc2_]);
            for each(_loc3_ in _loc5_.pl.particles)
            {
               _loc1_.push(_loc3_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function mousey() : int
      {
         return i.mouseY();
      }
      
      public function flushParticles() : void
      {
         var _loc1_:GameSceneZOrder = null;
         var _loc2_:ParticleLayer = null;
         for each(_loc1_ in zOrders)
         {
            if(_loc1_.pl)
            {
               _loc1_.pl.remove();
            }
         }
         for each(_loc2_ in orphanedParticleLayers)
         {
            _loc2_.remove();
         }
         orphanedParticleLayers = new Array();
      }
      
      public function particleKilledCallback(param1:Particle) : void
      {
      }
      
      public function init() : void
      {
      }
      
      public function _register(param1:Sprite) : void
      {
      }
      
      public function pushScene(param1:GameScene, param2:Boolean = false, param3:int = 0) : void
      {
         gss.pushScene(param1,param2,param3);
      }
      
      public function count(param1:Class) : int
      {
         var _loc3_:GameObject = null;
         var _loc2_:int = 0;
         for each(_loc3_ in objects)
         {
            if(_loc3_ is param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function drawBackground(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:String = GradientType.LINEAR;
         var _loc5_:Array = [param1,param2,param3];
         var _loc6_:Array = [100,100,100];
         var _loc7_:Array = [0,128,255];
         var _loc8_:Matrix = new Matrix();
         _loc8_.createGradientBox(400,600,Math.PI / 2,0,0);
         var _loc9_:String = SpreadMethod.PAD;
         m.graphics.beginGradientFill(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
         m.graphics.drawRect(0,0,800,600);
      }
      
      final public function register(param1:Sprite) : void
      {
         var _loc2_:GameSceneZOrder = null;
         parent = param1;
         --currentindex;
         param1.addChildAt(m,0);
         for each(_loc2_ in zOrders)
         {
            m.addChild(_loc2_.m);
         }
         _register(param1);
      }
      
      public function applyToParticles(param1:Function) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Particle = null;
         var _loc4_:ParticleLayer = null;
         var _loc5_:GameSceneZOrder = null;
         _loc2_ = 0;
         while(_loc2_ < objects.length)
         {
            if(objects[_loc2_].mainLayer)
            {
               for each(_loc3_ in objects[_loc2_].mainLayer.particles)
               {
                  param1(_loc3_);
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < orphanedParticleLayers.length)
         {
            _loc4_ = orphanedParticleLayers[_loc2_];
            for each(_loc3_ in _loc4_.particles)
            {
               param1(_loc3_);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < zOrders.length)
         {
            _loc5_ = GameSceneZOrder(zOrders[_loc2_]);
            for each(_loc3_ in _loc5_.pl.particles)
            {
               param1(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function findRandomObjectByClass(param1:String) : GameObject
      {
         var _loc3_:GameObject = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in objects)
         {
            if(_loc3_.className == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length > 0)
         {
            return _loc2_[Random.randInt(0,_loc2_.length - 1)];
         }
         return null;
      }
      
      public function setCamera(param1:GameSceneCamera) : void
      {
         cameras.push(param1);
      }
      
      public function clipForZOrder(param1:String) : MovieClip
      {
         var _loc2_:GameSceneZOrder = null;
         for each(_loc2_ in zOrders)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_.m;
            }
         }
         trace("Could not find ZOrder: " + param1);
         return m;
      }
      
      public function vert(param1:Array, param2:int = 8, param3:Number = 0, param4:Number = 0) : Layout
      {
         return Layout.Vert(param1,param2,param3,param4);
      }
      
      public function text(param1:String, param2:Number = -1, param3:Number = 0.5, param4:Number = 0.5) : GameObject
      {
         if(param2 < 0)
         {
            param2 = defaultTextSize;
         }
         var _loc5_:String = "TextLayer";
         if(defaultTextLayer != "")
         {
            _loc5_ = defaultTextLayer;
         }
         var _loc6_:GameObject = new GameObject(this,null,_loc5_,0,0);
         _loc6_.setText(param1,param2);
         _loc6_.baseHandleX = param3;
         _loc6_.baseHandleY = param4;
         return _loc6_;
      }
      
      public function horiz(param1:Array, param2:int = 8, param3:Number = 0, param4:Number = 0) : Layout
      {
         return Layout.Horiz(param1,param2,param3,param4);
      }
      
      public function getNearest(param1:Class, param2:Number, param3:Number) : GameObject
      {
         var _loc5_:GameObject = null;
         var _loc6_:GameObject = null;
         var _loc7_:Number = NaN;
         var _loc4_:Number = 999999;
         for each(_loc6_ in objects)
         {
            if(_loc6_ is param1)
            {
               _loc7_ = _loc6_.distanceToPoint(param2,param3);
               if(_loc7_ < _loc4_)
               {
                  _loc4_ = _loc7_;
                  _loc5_ = _loc6_;
               }
            }
         }
         return _loc5_;
      }
      
      public function syncRemoved() : void
      {
         objects = objects.filter(function(param1:GameObject, param2:int, param3:Array):Boolean
         {
            return !param1._removed;
         });
      }
      
      public function update() : void
      {
         var go:GameObject = null;
         var lgo:GameObject = null;
         var gss:GameSceneCameraStack = null;
         var nc:GameSceneCamera = null;
         var zo:GameSceneZOrder = null;
         var pl:ParticleLayer = null;
         _mhit = Input.i.mouseHit();
         if(Input.i.takePadClick())
         {
            clickButtonUnderCursor();
         }
         _paused = paused;
         for each(go in objects)
         {
            if(go.pausesGame)
            {
               _paused = true;
            }
         }
         if(!_paused)
         {
            for each(gss in cameras)
            {
               gss.decay();
            }
         }
         if(cameras.length > 0)
         {
            nc = GameSceneCameraStack.flatten(cameras);
            camX = nc.x;
            camY = nc.y;
         }
         GameSoundScene.updateAll();
         if(!_paused)
         {
            Ticks += 1;
         }
         for each(lgo in objects)
         {
            lgo.lastX = lgo.basex;
            lgo.lastY = lgo.basey;
         }
         beginObjectUpdates();
         for each(lgo in objects)
         {
            if(!_paused || lgo.updateDespitePaused)
            {
               if(lgo.parent == null)
               {
                  if(!lgo._removed)
                  {
                     objectUpdating(lgo);
                     lgo.update();
                  }
               }
            }
         }
         endObjectUpdates();
         for each(lgo in objects)
         {
            if(!_paused || lgo.updateDespitePaused)
            {
               lgo.syncObj();
            }
            else if(lgo.parent)
            {
               if(lgo.parent.updateDespitePaused)
               {
                  lgo.syncObj();
               }
            }
         }
         _update();
         syncRemoved();
         if(!_paused)
         {
            for each(zo in zOrders)
            {
               zo.pl.x = camX;
               zo.pl.y = camY;
               zo.pl.update();
            }
            for each(pl in orphanedParticleLayers)
            {
               pl.x = camX;
               pl.y = camY;
               pl.update();
               if(pl.parent.length == 0)
               {
                  pl.remove();
               }
            }
            orphanedParticleLayers = orphanedParticleLayers.filter(function(param1:ParticleLayer, param2:int, param3:Array):Boolean
            {
               return param1.particles.length != 0;
            });
         }
      }
      
      public function zOrderInt(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < zOrders.length)
         {
            if(zOrders[_loc2_].name == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         trace("Could not find ZOrder: " + param1);
         return -1;
      }
      
      public function pushCamera(param1:GameSceneCamera) : void
      {
         var _loc2_:GameSceneCameraStack = null;
         for each(_loc2_ in cameras)
         {
            if(_loc2_.Camera == param1)
            {
               _loc2_.increment();
               return;
            }
         }
         _loc2_ = new GameSceneCameraStack();
         _loc2_.Camera = param1;
         cameras.push(_loc2_);
      }
      
      public function stackFading() : Boolean
      {
         return GameSceneStack.currentStack.fading != 0;
      }
      
      // Menu buttons are Flash SimpleButtons that only react to real mouse clicks, so a controller
      // click presses the topmost visible button under the (virtual) cursor directly.
      public function clickButtonUnderCursor() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:GameObject = null;
         for each(_loc1_ in objects)
         {
            if(_loc1_.obj is SimpleButton && !_loc1_._removed && !_loc1_.hidden)
            {
               if(_loc1_.obj.visible && _loc1_.obj.stage != null && _loc1_.obj.alpha > 0.1)
               {
                  if(SimpleButton(_loc1_.obj).hasEventListener(MouseEvent.CLICK) && _loc1_.mOver())
                  {
                     _loc2_ = _loc1_;
                  }
               }
            }
         }
         if(_loc2_)
         {
            _loc2_._mHit(null);
         }
      }

      public function mHit() : Boolean
      {
         return _mhit;
      }
      
      public function _update() : void
      {
      }
      
      // Hooks around each top-level object's update (MainScene uses them for co-op targeting).
      public function beginObjectUpdates() : void
      {
      }
      
      public function objectUpdating(param1:GameObject) : void
      {
      }
      
      public function endObjectUpdates() : void
      {
      }
      
      public function getZOrder(param1:String) : GameSceneZOrder
      {
         var _loc2_:GameSceneZOrder = null;
         for each(_loc2_ in zOrders)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         trace("Could not find ZOrder: " + param1);
         return null;
      }
      
      public function mousex() : int
      {
         return i.mouseX();
      }
      
      public function addZOrder(param1:String) : void
      {
         var _loc2_:GameSceneZOrder = new GameSceneZOrder();
         _loc2_.name = param1;
         _loc2_.m = new MovieClip();
         _loc2_.pl = new ParticleLayer();
         _loc2_.pl.parent = _loc2_.m;
         zOrders.push(_loc2_);
      }
      
      public function findObjectByClass(param1:String) : GameObject
      {
         var _loc2_:GameObject = null;
         for each(_loc2_ in objects)
         {
            if(_loc2_.className == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findObjectByName(param1:String) : GameObject
      {
         var _loc2_:GameObject = null;
         for each(_loc2_ in objects)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addOrphanedParticleLayer(param1:ParticleLayer) : void
      {
         orphanedParticleLayers.push(param1);
      }
   }
}

