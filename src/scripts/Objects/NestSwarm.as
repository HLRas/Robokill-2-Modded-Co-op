package Objects
{
   import GameScene.GameScene;
   import ObjectBase.SwarmBase;
   import ObjectConstructors.NestSwarm_constructor;
   
   public class NestSwarm extends SwarmBase
   {
      
      public var killed:Boolean = false;
      
      public var nestCreationTicks:int = 300 + Math.random() * 200;
      
      public function NestSwarm(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,NestSwarm_constructor.baseim_embed,NestSwarm_constructor.LayerName,param2,param3);
         NestSwarm_constructor.setup(param1,this);
         baseHealth *= 7;
      }
      
      override public function _experience() : int
      {
         return 70;
      }
      
      override public function collisionWidth() : Number
      {
         return super.collisionWidth() / 2;
      }
      
      override public function kill() : void
      {
         var _loc3_:GooBullet = null;
         if(killed)
         {
            return;
         }
         killed = true;
         var _loc1_:int = 4;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new GooBullet(null,basex,basey);
            _loc3_.landingTicks = 10 + Math.random() * 20;
            _loc3_.baseRotation = Math.random() * 360;
            _loc3_.angle = _loc3_.baseRotation;
            _loc2_++;
         }
         super.kill();
      }
      
      override public function collisionHeight() : Number
      {
         return super.collisionHeight() / 2;
      }
      
      override public function doMovement() : void
      {
         moveTowardsPlayer(1.5);
      }
   }
}

