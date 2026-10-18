package Particles
{
   import GameObject.GameObject;
   import Tools.Interpolation;
   import Tools.Random;
   import flash.display.Bitmap;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class Particle
   {
      
      public var dRotation:Number = 0;
      
      public var green:Number = 0;
      
      public var lockTo:GameObject;
      
      public var imageSet:Array;
      
      public var lockToTForm:Boolean = false;
      
      public var lockToX:Number = 0;
      
      public var lockToY:Number = 0;
      
      public var randOffset:int = Random.randInt(0,256);
      
      public var Friction:Number = 0;
      
      public var filters:Array = new Array();
      
      public var StartScale:Number = 1;
      
      public var Blend:String = "";
      
      public var ax:Number = 0;
      
      public var ay:Number = 0;
      
      public var TotalLife:Number = 0;
      
      public var Delayed:int = 0;
      
      public var StartAlpha:Number = 1;
      
      public var EndScale:Number = 1;
      
      public var layer:ParticleLayer;
      
      public var animLoop:Boolean = false;
      
      public var StayAfterDeath:Boolean = false;
      
      public var blue:Number = 0;
      
      public var baseHeight:Number = 0;
      
      public var b:Bitmap;
      
      public var EndAlpha:Number = 1;
      
      public var frame:int = 0;
      
      public var yscale:Number = 1;
      
      public var baseWidth:Number = 0;
      
      public var ticks:int = 0;
      
      public var x:Number = 0;
      
      public var toKill:Boolean = false;
      
      public var baseScaleX:Number = 1;
      
      public var Plugins:Array = new Array();
      
      public var baseScaleY:Number = 1;
      
      public var red:Number = 1;
      
      public var dx:Number = 0;
      
      public var dy:Number = 0;
      
      public var lastframe:int = 0;
      
      public var y:Number = 0;
      
      public var Rotation:Number = 0;
      
      public var identifier:String;
      
      public var animSpeed:Number = 1;
      
      public var RenderWhileDelayed:int = 0;
      
      public var xscale:Number = 1;
      
      public var deathCallback:Function = null;
      
      public var _deleted:Boolean = false;
      
      public var CurrentLife:Number = 0;
      
      public var killatanimend:Boolean = false;
      
      public var aRotation:Number = 0;
      
      public function Particle()
      {
         super();
      }
      
      public function addFilter(param1:ParticleFilter) : void
      {
         filters.push(param1);
      }
      
      public function remove() : void
      {
         b.parent.removeChild(b);
      }
      
      public function update() : void
      {
         var _loc1_:ParticleFilter = null;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         if(Delayed)
         {
            --Delayed;
            if(Delayed > 0)
            {
               if(!RenderWhileDelayed)
               {
                  b.visible = false;
               }
               return;
            }
            b.visible = true;
         }
         if(Blend != "")
         {
            b.blendMode = Blend;
         }
         ++ticks;
         dx += ax;
         dy += ay;
         if(Friction > 0)
         {
            dx *= 1 - Friction;
            dy *= 1 - Friction;
         }
         x += dx;
         y += dy;
         if(imageSet != null)
         {
            ++frame;
            _loc3_ = frame / animSpeed;
            if(_loc3_ > lastframe)
            {
               if(killatanimend)
               {
                  toKill = true;
               }
            }
            if(animLoop)
            {
               _loc3_ = (randOffset + _loc3_) % lastframe;
            }
            if(_loc3_ >= lastframe)
            {
               _loc3_ = lastframe;
            }
            b.bitmapData = imageSet[_loc3_];
         }
         if(lockTo)
         {
            if(lockToTForm)
            {
               _loc4_ = lockTo.tformed(lockToX,lockToY);
               x = _loc4_.x;
               x = _loc4_.x;
               y = _loc4_.y;
            }
            else
            {
               x = lockTo.basex + lockToX;
               y = lockTo.basey + lockToY;
            }
         }
         if(StartScale != 1 || EndScale != 1 || Math.abs(Rotation) > 4)
         {
            b.smoothing = true;
         }
         CurrentLife += 1;
         baseScaleX = Interpolation.linearInterpolateLock(StartScale,EndScale,Interpolation.fromTo(CurrentLife,0,TotalLife));
         baseScaleY = baseScaleX;
         for each(_loc1_ in filters)
         {
            _loc1_.update(this);
         }
         b.alpha = Interpolation.linearInterpolateLock(StartAlpha,EndAlpha,Interpolation.fromTo(CurrentLife,0,TotalLife));
         b.scaleX = baseScaleX;
         b.scaleY = baseScaleY;
         Rotation += dRotation;
         dRotation += aRotation;
         b.rotation = Rotation;
         _loc2_ = Rotation * (Math.PI / 180);
         b.x = x - (Math.cos(-_loc2_) * (baseWidth * 0.5 * baseScaleY) + Math.sin(-_loc2_) * (baseHeight * 0.5 * baseScaleX)) - layer.x;
         b.y = y - (-Math.sin(-_loc2_) * (baseWidth * 0.5 * baseScaleX) + Math.cos(-_loc2_) * (baseHeight * 0.5 * baseScaleY)) - layer.y;
         if(CurrentLife > TotalLife || toKill)
         {
            if(Boolean(deathCallback))
            {
               deathCallback(this);
            }
            _deleted = true;
         }
      }
      
      public function tint(param1:Number, param2:Number, param3:Number) : void
      {
         red = param1;
         green = param2;
         blue = param3;
         var _loc4_:Array = new Array();
         _loc4_ = _loc4_.concat([param1,param2,param3,0,0]);
         _loc4_ = _loc4_.concat([param3,param1,param2,0,0]);
         _loc4_ = _loc4_.concat([param2,param3,param1,0,0]);
         _loc4_ = _loc4_.concat([0,0,0,1,0]);
         var _loc5_:BitmapFilter = new ColorMatrixFilter(_loc4_);
         this.b.filters = new Array(_loc5_);
      }
   }
}

