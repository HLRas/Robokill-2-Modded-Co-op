package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Objects.FallingTile;
   import Objects.FloorProp;
   import Scenes.MainScene;
   
   public class FallingTileBase extends GameObjectBase
   {
      
      public var offsets:Array = [[-1,0],[1,0],[0,-1],[0,1]];
      
      public var shouldCrumble:Boolean = false;
      
      public var marked:Boolean = false;
      
      public var crumbling:int = 0;
      
      public function FallingTileBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
         changeZOrder("Floor");
         pushable = false;
         collidesWithWalls = false;
         tintBasedOnPosition = true;
      }
      
      override public function _update() : void
      {
         var _loc2_:GameObject = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(ticks == 5)
         {
            _loc4_ = logicalSquareX();
            _loc5_ = logicalSquareY();
            if(!ms.logicalSquarePassable(_loc4_,_loc5_ - 1) && !ms.logicalSquarePassable(_loc4_,_loc5_ + 1))
            {
               baseRotation = 90;
            }
         }
         var _loc1_:Boolean = false;
         for each(_loc2_ in gs.objects)
         {
            if(validCrumbler(_loc2_))
            {
               if(spriteCollidesWith(GameObjectBase(_loc2_),0.8))
               {
                  _loc1_ = true;
               }
            }
         }
         if(_loc1_)
         {
            shouldCrumble = true;
         }
         else if(shouldCrumble)
         {
            crumble();
         }
         if(crumbling)
         {
            ++crumbling;
         }
         var _loc3_:Boolean = false;
         if(crumbling < 36)
         {
            _loc6_ = crumbling / 3 % 8;
            if(_loc6_ > 3)
            {
               _loc6_ = 7 - _loc6_;
            }
            setFrame(_loc6_);
         }
         else if(crumbling < 30 + 24 + 5)
         {
            _loc6_ = (crumbling - 24) / 3;
            if(_loc6_ > 9)
            {
               _loc6_ = 9;
            }
            setFrame(_loc6_);
         }
         else
         {
            _loc6_ = 10 + (crumbling - (30 + 24 + 5)) / 3;
            if(_loc6_ > 31)
            {
               _loc6_ = 31;
               _loc3_ = true;
            }
            setFrame(_loc6_);
         }
         if(!_removed && crumbling < 20)
         {
            MainScene(gs).setExists(logicalSquareX(),logicalSquareY(),true);
            MainScene(gs).setPassable(logicalSquareX(),logicalSquareY(),true);
         }
         else
         {
            MainScene(gs).setExists(logicalSquareX(),logicalSquareY(),false);
            MainScene(gs).setPassable(logicalSquareX(),logicalSquareY(),false);
         }
         if(_loc3_)
         {
            remove();
         }
         super._update();
      }
      
      override public function canFall() : Boolean
      {
         return false;
      }
      
      public function mark(param1:Array) : void
      {
         var _loc5_:FallingTile = null;
         if(crumbling)
         {
            return;
         }
         marked = true;
         var _loc2_:int = logicalSquareX() + 1;
         var _loc3_:int = logicalSquareY() + 1;
         var _loc4_:int = 0;
         while(_loc4_ < 4)
         {
            _loc5_ = param1[_loc2_ + offsets[_loc4_][0]][_loc3_ + offsets[_loc4_][1]];
            if(_loc5_)
            {
               if(!_loc5_.marked)
               {
                  _loc5_.mark(param1);
               }
            }
            _loc4_++;
         }
      }
      
      public function crumble(param1:int = 1) : void
      {
         if(crumbling == 0)
         {
            Sounds.tileFall.play();
            crumbling = param1;
         }
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey"];
      }
      
      public function validCrumbler(param1:GameObject) : Boolean
      {
         if(param1 is FloorProp)
         {
            if(FloorProp(param1).flying)
            {
               return true;
            }
         }
         if(param1 is PlayerBase)
         {
            return true;
         }
         return false;
      }
   }
}

