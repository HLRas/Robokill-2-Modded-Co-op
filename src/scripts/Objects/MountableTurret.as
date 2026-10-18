package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.TurretBase;
   import ObjectConstructors.MountableTurret_constructor;
   
   public class MountableTurret extends TurretBase
   {
      
      public function MountableTurret(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,MountableTurret_constructor.baseim_embed,MountableTurret_constructor.LayerName,param2,param3);
         MountableTurret_constructor.setup(param1,this);
         pushable = false;
         baseHealth *= 2.5;
         extraHealth *= 4;
         organic = false;
      }
      
      override public function _update() : void
      {
         super._update();
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.Mountable_Turret_Base_png,"base",true,baseAlpha);
         _loc1_.changeZOrder(zOrderString,true);
      }
      
      override public function _experience() : int
      {
         return 25;
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
   }
}

