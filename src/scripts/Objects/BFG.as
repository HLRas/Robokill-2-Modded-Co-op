package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.TurretBase;
   import ObjectConstructors.BFG_constructor;
   
   public class BFG extends TurretBase
   {
      
      public function BFG(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BFG_constructor.baseim_embed,BFG_constructor.LayerName,param2,param3);
         BFG_constructor.setup(param1,this);
         baseHealth *= 40;
         extraHealth *= 40;
         organic = false;
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         _loc1_ = helper.conditionallyCreateChild(Embeds.bfg_base_png,"base",1);
         _loc1_.basex = basex;
         _loc1_.basey = basey;
         _loc1_.changeZOrder(zOrderString,true);
         super._update();
      }
      
      override public function _experience() : int
      {
         return 400;
      }
      
      override public function offsetX() : int
      {
         return 14;
      }
      
      override public function bulletSpeed() : Number
      {
         return super.bulletSpeed() * 1.5;
      }
      
      override public function offsetY() : int
      {
         return 18;
      }
   }
}

