package Objects
{
   import Audio.GameSound;
   import GameScene.GameScene;
   import ObjectBase.WalkerTurretBase;
   import ObjectConstructors.WalkerTurret_constructor;
   
   public class WalkerTurret extends WalkerTurretBase
   {
      
      public function WalkerTurret(param1:GameScene, param2:int, param3:int)
      {
         super(param1,WalkerTurret_constructor.baseim_embed,WalkerTurret_constructor.LayerName,param2,param3);
         WalkerTurret_constructor.setup(param1,this);
         organic = false;
      }
      
      override public function killSound() : GameSound
      {
         return Sounds.explosion;
      }
      
      override public function growlSound() : GameSound
      {
         return null;
      }
   }
}

