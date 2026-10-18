package Objects
{
   import GameScene.GameScene;
   import ObjectBase.PulseBase;
   import ObjectConstructors.Pulse_constructor;
   
   public class Pulse extends PulseBase
   {
      
      public function Pulse(param1:GameScene, param2:int, param3:int)
      {
         super(param1,Pulse_constructor.baseim_embed,Pulse_constructor.LayerName,param2,param3);
         Pulse_constructor.setup(param1,this);
      }
   }
}

