package ObjectBase
{
   import GameScene.GameScene;
   import Objects.BomberBomb;
   
   public class BomberBase extends EnemyBase
   {
      
      public function BomberBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function createBombs(param1:int, param2:Number = 1) : void
      {
         var _loc4_:BomberBomb = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = BomberBomb(spawn(BomberBomb,basex,basey,0,true));
            if(_loc4_)
            {
               _loc4_.dx = (Math.random() - 0.5) * 15 * param2;
               _loc4_.dy = (Math.random() - 0.5) * 15 * param2;
            }
            _loc3_++;
         }
      }
   }
}

