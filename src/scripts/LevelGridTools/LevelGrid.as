package LevelGridTools
{
   import Levels.*;
   
   public class LevelGrid
   {
      
      public var grid:Array = new Array();
      
      public var data:Object = new Object();
      
      public var startx:int = 0;
      
      public var starty:int = 0;
      
      public function LevelGrid()
      {
         super();
      }
      
      public function getCellData(param1:int, param2:int, param3:String) : Object
      {
         return data[param3 + "," + param1 + "," + param2];
      }
      
      public function pushArr(param1:int, param2:Array) : void
      {
         grid.push(param2);
      }
      
      public function _init(param1:int = 0) : void
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc2_:int = mainGameLevels.maxX(param1) - mainGameLevels.minX(param1) + 1;
         var _loc3_:int = mainGameLevels.maxY(param1) - mainGameLevels.minY(param1) + 1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new Array(_loc2_);
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc7_ = mainGameLevels.init(param1,_loc6_ + mainGameLevels.minX(param1),_loc4_ + mainGameLevels.minY(param1));
               _loc8_ = new Array();
               _loc9_ = 0;
               while(_loc9_ < _loc7_.length)
               {
                  if(_loc7_[_loc9_][0] is propertiesSet)
                  {
                     if(_loc7_[_loc9_][1] == 0)
                     {
                        setCellData(_loc6_,_loc4_,"Start",true);
                     }
                     else if(_loc7_[_loc9_][1] == 1)
                     {
                        setCellData(_loc6_,_loc4_,"Key0",true);
                     }
                     else if(_loc7_[_loc9_][1] == 2)
                     {
                        setCellData(_loc6_,_loc4_,"HasKey0",true);
                     }
                     else if(_loc7_[_loc9_][1] == 3)
                     {
                        setCellData(_loc6_,_loc4_,"Finish",true);
                     }
                     else if(_loc7_[_loc9_][1] == 4)
                     {
                        setCellData(_loc6_,_loc4_,"PartialFinish",true);
                     }
                     else if(_loc7_[_loc9_][1] == 6)
                     {
                        setCellData(_loc6_,_loc4_,"Ambush",true);
                     }
                     else if(_loc7_[_loc9_][1] == 7)
                     {
                        setCellData(_loc6_,_loc4_,"WeaponTreasure",true);
                     }
                     else if(_loc7_[_loc9_][1] == 8)
                     {
                        setCellData(_loc6_,_loc4_,"Reinforcements",true);
                     }
                     else if(_loc7_[_loc9_][1] == 9)
                     {
                        setCellData(_loc6_,_loc4_,"Key1",true);
                     }
                     else if(_loc7_[_loc9_][1] == 10)
                     {
                        setCellData(_loc6_,_loc4_,"Key2",true);
                     }
                     else if(_loc7_[_loc9_][1] == 11)
                     {
                        setCellData(_loc6_,_loc4_,"EdgeWarning",true);
                     }
                     else if(_loc7_[_loc9_][1] == 12)
                     {
                        setCellData(_loc6_,_loc4_,"Secret",true);
                     }
                     else if(_loc7_[_loc9_][1] == 13)
                     {
                        setCellData(_loc6_,_loc4_,"SecretTarget",true);
                     }
                  }
                  else
                  {
                     _loc8_.push(_loc7_[_loc9_]);
                  }
                  _loc9_++;
               }
               _loc5_[_loc6_] = _loc8_.length;
               setCellData(_loc6_,_loc4_,"PredefinedLevel",_loc8_);
               _loc6_++;
            }
            pushArr(_loc4_,_loc5_);
            _loc4_++;
         }
      }
      
      public function init(param1:int = 0) : void
      {
         var _loc3_:int = 0;
         _init(param1);
         var _loc2_:int = 0;
         while(_loc2_ < grid.length)
         {
            _loc3_ = 0;
            while(_loc3_ < grid[_loc2_].length)
            {
               if(getCellData(_loc3_,_loc2_,"Start"))
               {
                  startx = _loc3_;
                  starty = _loc2_;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function setCellData(param1:int, param2:int, param3:String, param4:Object) : void
      {
         data[param3 + "," + param1 + "," + param2] = param4;
      }
      
      public function getCell(param1:int, param2:int) : int
      {
         if(param2 < 0 || param2 >= grid.length)
         {
            return 0;
         }
         var _loc3_:Array = grid[param2];
         if(param1 < 0 || param1 >= _loc3_.length)
         {
            return 0;
         }
         return _loc3_[param1];
      }
   }
}

