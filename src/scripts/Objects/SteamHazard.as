package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectBase.HazardBase;
   import ObjectConstructors.SteamHazard_constructor;
   
   public class SteamHazard extends HazardBase
   {
      
      public function SteamHazard(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,SteamHazard_constructor.baseim_embed,SteamHazard_constructor.LayerName,param2,param3);
         SteamHazard_constructor.setup(param1,this);
      }
      
      override public function _update() : void
      {
         super._update();
         if(group == -1)
         {
            setGroup(id,groupOffset);
         }
      }
      
      public function setGroup(param1:int, param2:int = 0) : void
      {
         var _loc3_:GameObject = null;
         group = param1;
         groupOffset = param2;
         for each(_loc3_ in gs.objects)
         {
            if(_loc3_ is SteamHazard)
            {
               if(distanceToObject(_loc3_) <= 100)
               {
                  if(SteamHazard(_loc3_).group == -1)
                  {
                     SteamHazard(_loc3_).setGroup(param1,groupOffset);
                  }
               }
            }
         }
      }
   }
}

