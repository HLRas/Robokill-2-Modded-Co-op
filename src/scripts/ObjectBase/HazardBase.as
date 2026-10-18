package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Objects.FireHazard;
   
   public class HazardBase extends GameObjectBase
   {
      
      public var groupOffset:int = Math.random() * 1000;
      
      public var lastHit:int = -100;
      
      public var group:int = -1;
      
      public function HazardBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         pushable = false;
         collidesWithWalls = false;
      }
      
      override public function _init() : void
      {
         super._init();
         move(0,-20);
      }
      
      override public function _update() : void
      {
         var _loc4_:GameObject = null;
         var _loc1_:int = (groupOffset + ticks) % 1000;
         var _loc2_:int = 50;
         var _loc3_:int = 300;
         if(this is FireHazard)
         {
            _loc3_ = 1000;
            _loc2_ = 0;
         }
         if(_loc1_ < _loc2_)
         {
            setFrame(_loc1_ / (_loc2_ / 5));
         }
         else if(_loc1_ <= _loc3_ + _loc2_)
         {
            if(ticks % 16 < 8)
            {
               setFrame(2);
            }
            else
            {
               setFrame(3);
            }
            if(ticks - lastHit > 30)
            {
               for each(_loc4_ in gs.objects)
               {
                  if(validTarget(_loc4_))
                  {
                     if(spriteCollidesWith(GameObjectBase(_loc4_),0.5))
                     {
                        lastHit = ticks;
                        if(_loc4_ is PlayerBase)
                        {
                           PlayerBase(_loc4_).handleHit(this);
                        }
                        if(_loc4_ is EnemyBase)
                        {
                           EnemyBase(_loc4_).hitBy(null,5);
                        }
                     }
                  }
               }
            }
         }
         else if(_loc1_ > _loc3_ + _loc2_ && _loc1_ <= _loc3_ + _loc2_ * 2)
         {
            setFrame(5 - (_loc1_ - (_loc3_ + _loc2_)) / (_loc2_ / 5));
         }
         else
         {
            setFrame(0);
         }
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey","baseRotation"];
      }
      
      public function validTarget(param1:GameObject) : Boolean
      {
         return param1 is EnemyBase || param1 is PlayerBase;
      }
   }
}

