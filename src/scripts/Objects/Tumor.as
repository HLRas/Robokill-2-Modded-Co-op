package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BulletBase;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.Tumor_constructor;
   
   public class Tumor extends EnemyBase
   {
      
      public var hits:int = 0;
      
      public var detached:Boolean = false;
      
      public var lastHitRotation:Number = 0;
      
      public var attachedTo:EnemyBase;
      
      public function Tumor(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Tumor_constructor.baseim_embed,Tumor_constructor.LayerName,param2,param3);
         Tumor_constructor.setup(param1,this);
         pushable = false;
         baseHealth *= 100;
         extraHealth *= 100;
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         super._update();
         basex += dx;
         basey += dy;
         dx *= 0.98;
         dy *= 0.98;
         if(detached)
         {
            if(Math.sqrt(dx * dx + dy * dy) < 0.5)
            {
               emitConditionalParticles("Destroy");
               remove();
               _loc1_ = 0;
               while(_loc1_ < 3)
               {
                  spawn(Maggot,basex,basey,0,true);
                  _loc1_++;
               }
            }
         }
         if(attachedTo)
         {
            if(attachedTo._removed)
            {
               detach();
            }
         }
      }
      
      override public function hitBy(param1:BulletBase, param2:int = -1) : void
      {
         if(param1)
         {
            lastHitRotation = param1.baseRotation;
         }
         else
         {
            lastHitRotation = helper.angleToObject(ms.player) + 270;
         }
         if(totalHealth - health > 20)
         {
            detach();
         }
         super.hitBy(param1,-1);
      }
      
      override public function canFall() : Boolean
      {
         return detached;
      }
      
      public function detach() : void
      {
         if(detached)
         {
            return;
         }
         detached = true;
         attachedTo.hasTumor = false;
         attachedTo.tumorObject = null;
         dx = cosd(lastHitRotation - 90) * 3;
         dy = sind(lastHitRotation - 90) * 3;
      }
   }
}

