package Particles
{
   import flash.display.MovieClip;
   
   public class ParticleLayer
   {
      
      public var parent:MovieClip;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var particles:Array = new Array();
      
      public function ParticleLayer()
      {
         super();
      }
      
      public function update() : void
      {
         var _loc1_:Particle = null;
         for each(_loc1_ in particles)
         {
            _loc1_.update();
            if(_loc1_._deleted)
            {
               _loc1_.remove();
               particles.splice(particles.indexOf(_loc1_),1);
            }
         }
      }
      
      public function addParticle(param1:Class) : Particle
      {
         var _loc2_:Particle = new Particle();
         _loc2_.b = new param1();
         _loc2_.b.alpha = 0;
         parent.addChild(_loc2_.b);
         particles.push(_loc2_);
         return _loc2_;
      }
      
      public function remove() : void
      {
         var _loc1_:Particle = null;
         for each(_loc1_ in particles)
         {
            _loc1_.remove();
         }
         particles = new Array();
      }
   }
}

