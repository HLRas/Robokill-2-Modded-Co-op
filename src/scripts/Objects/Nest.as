package Objects
{
   import Audio.GameSound;
   import GameScene.GameScene;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.Nest_constructor;
   
   public class Nest extends EnemyBase
   {
      
      public var lastCreated:int = 0;
      
      public var count:int = 0;
      
      public var createdKillSwarm:Boolean = false;
      
      public var nextCreation:int = 100 + Math.random() * 50;
      
      public function Nest(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Nest_constructor.baseim_embed,Nest_constructor.LayerName,param2,param3);
         Nest_constructor.setup(param1,this);
         pushable = false;
         baseHealth *= 8;
      }
      
      public function createSwarm(param1:Boolean = false) : void
      {
         ++count;
         if(!param1)
         {
            if(count > 16)
            {
               return;
            }
         }
         var _loc2_:Class = Swarm;
         if(param1)
         {
            _loc2_ = Maggot;
         }
         var _loc3_:EnemyBase = EnemyBase(spawn(_loc2_,basex,basey,toughness,true));
         if(_loc3_)
         {
            _loc3_.changeZOrder(_loc3_.zOrderString,true);
         }
      }
      
      override public function kill() : void
      {
         var _loc1_:int = 0;
         if(!createdKillSwarm)
         {
            createdKillSwarm = true;
            _loc1_ = 0;
            while(_loc1_ < 5)
            {
               createSwarm(true);
               _loc1_++;
            }
         }
         super.kill();
      }
      
      override public function _update() : void
      {
         --nextCreation;
         if(nextCreation <= 0)
         {
            createSwarm();
            nextCreation = 140 + count * 5 + ms.countEnemies() * 10;
         }
         super._update();
      }
      
      override public function _experience() : int
      {
         return 30;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.nestDie;
      }
      
      override public function tintBlue() : Number
      {
         if(frozen > 0)
         {
            return 0.6;
         }
         return 0;
      }
      
      override public function tintRed() : Number
      {
         if(frozen > 0)
         {
            return 0.4;
         }
         return 1;
      }
      
      override public function tintGreen() : Number
      {
         if(frozen > 0)
         {
            return 1;
         }
         return 0;
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
   }
}

