package Objects
{
   import GameScene.GameScene;
   import ObjectBase.GunFighterBase;
   import ObjectConstructors.GunFighter_constructor;
   
   public class GunFighter extends GunFighterBase
   {
      
      public function GunFighter(param1:GameScene, param2:int, param3:int)
      {
         super(param1,GunFighter_constructor.baseim_embed,GunFighter_constructor.LayerName,param2,param3);
         GunFighter_constructor.setup(param1,this);
      }
   }
}

