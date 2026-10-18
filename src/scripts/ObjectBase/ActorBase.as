package ObjectBase
{
   import GameScene.GameScene;
   
   public class ActorBase extends GameObjectBase
   {
      
      public var health:int = 4;
      
      public var lastHit:int = 100;
      
      public function ActorBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function checkLineOfSight(param1:GameObjectBase) : Boolean
      {
         null[1];
         return false;
      }
      
      public function tintBlue() : Number
      {
         return 0;
      }
      
      public function tintRed() : Number
      {
         return 1;
      }
      
      public function tintGreen() : Number
      {
         return 0;
      }
      
      public function doTinting(param1:Boolean = false, param2:Number = 1) : void
      {
         var _loc3_:Number = tintRed() * param2;
         var _loc4_:Number = tintGreen() * param2;
         var _loc5_:Number = tintBlue() * param2;
         if(param1)
         {
            _loc3_ += 1;
            _loc4_ += 1;
            _loc5_ += 1;
         }
         if(falling)
         {
            _loc3_ *= 1 - fallingProgress / 100;
            _loc4_ *= 1 - fallingProgress / 100;
            _loc5_ *= 1 - fallingProgress / 100;
         }
         if(this is EnemyBase)
         {
            if(EnemyBase(this).legs)
            {
               EnemyBase(this).legs.tint(_loc3_,_loc4_,_loc5_);
            }
            if(EnemyBase(this).legs2)
            {
               EnemyBase(this).legs2.tint(_loc3_,_loc4_,_loc5_);
            }
         }
         tint(_loc3_,_loc4_,_loc5_);
      }
      
      public function hitTint() : Boolean
      {
         return lastHit < 6;
      }
      
      override public function _update() : void
      {
         super._update();
         ++lastHit;
         if(falling)
         {
            doTinting(false,1 - fallingProgress / 100);
         }
         else if(lastHit < 6)
         {
            doTinting(true);
         }
         else
         {
            doTinting();
         }
      }
   }
}

