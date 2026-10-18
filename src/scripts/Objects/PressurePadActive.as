package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.PressurePadActive_constructor;
   
   public class PressurePadActive extends GameObjectBase
   {
      
      public function PressurePadActive(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,PressurePadActive_constructor.baseim_embed,PressurePadActive_constructor.LayerName,param2,param3);
         PressurePadActive_constructor.setup(param1,this);
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         super._update();
         if(!floorPropOn())
         {
            if(ms.countKeys() == 0)
            {
               if(ms.countEnemies() == 0)
               {
                  if(ms.player.spriteCollidesWith(this))
                  {
                     for each(_loc1_ in gs.objects)
                     {
                        if(_loc1_ is SecretLift)
                        {
                           if(!SecretLift(_loc1_).floorPropOn())
                           {
                              SecretLift(_loc1_).open = true;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey"];
      }
   }
}

