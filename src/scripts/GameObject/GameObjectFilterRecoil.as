package GameObject
{
   public class GameObjectFilterRecoil extends GameObjectFilter
   {
      
      public var magnitude:Number;
      
      public var dead:Boolean = false;
      
      public var time:Number;
      
      public function GameObjectFilterRecoil(param1:Number, param2:Number)
      {
         super();
         this.time = param1;
         this.magnitude = param2;
      }
      
      override public function update(param1:GameObject) : void
      {
         if(dead)
         {
            return;
         }
         var _loc2_:Number = Number(ticks) / time * 5;
         var _loc3_:Number = Math.pow(_loc2_,0.25) * (_loc2_ - 5) / 4;
         var _loc4_:Number = cosd(param1.modifiedRotation + 90) * _loc3_ * magnitude;
         var _loc5_:Number = sind(param1.modifiedRotation + 90) * _loc3_ * magnitude;
         param1.modifiedx += _loc4_;
         param1.modifiedy += _loc5_;
         ++ticks;
         if(ticks > time)
         {
            removeFilter = true;
         }
      }
      
      internal function sind(param1:Number) : Number
      {
         return Math.sin(param1 * Math.PI / 180);
      }
      
      internal function cosd(param1:Number) : Number
      {
         return Math.cos(param1 * Math.PI / 180);
      }
   }
}

