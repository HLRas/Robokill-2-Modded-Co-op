package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BarBase;
   import ObjectConstructors.ShieldBar_constructor;
   
   public class ShieldBar extends BarBase
   {
      
      public function ShieldBar(param1:GameScene, param2:int, param3:int)
      {
         super(param1,ShieldBar_constructor.baseim_embed,ShieldBar_constructor.LayerName,param2,param3);
         ShieldBar_constructor.setup(param1,this);
      }
   }
}

