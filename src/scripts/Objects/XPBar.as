package Objects
{
   import GameScene.GameScene;
   import ObjectBase.BarBase;
   import ObjectConstructors.XPBar_constructor;
   
   public class XPBar extends BarBase
   {
      
      public function XPBar(param1:GameScene, param2:int, param3:int)
      {
         super(param1,XPBar_constructor.baseim_embed,XPBar_constructor.LayerName,param2,param3);
         XPBar_constructor.setup(param1,this);
      }
   }
}

