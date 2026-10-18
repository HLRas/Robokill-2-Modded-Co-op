package GameObject
{
   import Tools.ShapeContact;
   
   public class GameObjectCollision
   {
      
      public static var sc:ShapeContact = new ShapeContact();
      
      public var children:Array = new Array();
      
      public var lastMiniSync:int = 0;
      
      public var lastSynchronized:int = 0;
      
      public var approxRadius:Number;
      
      public var approxX:Number;
      
      public var type:int = 0;
      
      public var disabled:Boolean = false;
      
      public var approxY:Number;
      
      public function GameObjectCollision()
      {
         super();
      }
      
      public function pushPolygon(param1:GameObjectCollisionPoly) : void
      {
         children.push(param1);
      }
      
      public function collidesWith(param1:GameObjectCollision, param2:GameObject, param3:GameObject) : Boolean
      {
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         if(disabled || param1.disabled)
         {
            return false;
         }
         var _loc4_:Number = param2.basex - param3.basex;
         var _loc5_:Number = param2.basey - param3.basey;
         var _loc6_:Number = (param2.baseWidth + param3.baseWidth + param2.baseHeight + param3.baseHeight) * 0.7;
         if(_loc4_ < -_loc6_ || _loc4_ > _loc6_ || _loc5_ < -_loc6_ || _loc5_ > _loc6_)
         {
            return false;
         }
         miniSync(param2);
         param1.miniSync(param3,true);
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         loop0:
         while(_loc8_ < children.length)
         {
            _loc9_ = 0;
            while(true)
            {
               if(_loc9_ >= param1.children.length)
               {
                  _loc8_++;
                  continue loop0;
               }
               _loc10_ = children[_loc8_].tformedX - param1.children[_loc9_].tformedX2;
               _loc11_ = children[_loc8_].tformedY - param1.children[_loc9_].tformedY2;
               _loc12_ = _loc10_ * _loc10_ + _loc11_ * _loc11_;
               _loc13_ = children[_loc8_].approxRadius + param1.children[_loc9_].approxRadius;
               _loc14_ = false;
               if(_loc12_ < _loc13_ * _loc13_)
               {
                  _loc14_ = true;
               }
               if(_loc14_)
               {
                  if(sc.test(children[_loc8_].points,param2.basex,param2.basey,param2.baseScaleX,param2.baseScaleY,Math.PI * param2.baseRotation / 180,param1.children[_loc9_].points,param3.basex,param3.basey,param3.baseScaleX,param3.baseScaleY,Math.PI * param3.baseRotation / 180))
                  {
                     break;
                  }
               }
               _loc9_++;
            }
            return true;
         }
         return false;
      }
      
      public function miniSync(param1:GameObject, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Number = param1.baseRotation / 180 * Math.PI;
         if(param2)
         {
            _loc4_ = 0;
            while(_loc4_ < children.length)
            {
               children[_loc4_].tformedX2 = Math.cos(-_loc3_) * children[_loc4_].approxX + Math.sin(-_loc3_) * children[_loc4_].approxY + param1.basex;
               children[_loc4_].tformedY2 = -Math.sin(-_loc3_) * children[_loc4_].approxX + Math.cos(-_loc3_) * children[_loc4_].approxY + param1.basey;
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < children.length)
            {
               children[_loc4_].tformedX = Math.cos(-_loc3_) * children[_loc4_].approxX + Math.sin(-_loc3_) * children[_loc4_].approxY + param1.basex;
               children[_loc4_].tformedY = -Math.sin(-_loc3_) * children[_loc4_].approxX + Math.cos(-_loc3_) * children[_loc4_].approxY + param1.basey;
               _loc4_++;
            }
         }
      }
   }
}

