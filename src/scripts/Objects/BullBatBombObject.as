package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.EnemyBase;
   import ObjectConstructors.BullBatBombObject_constructor;
   import flash.display.BitmapData;
   
   public class BullBatBombObject extends EnemyBase
   {
      
      public var flyAnim:Array;
      
      public var shadow:BitmapData;
      
      public var released:int = 0;
      
      public var fallTime:int = 70;
      
      public function BullBatBombObject(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,BullBatBombObject_constructor.baseim_embed,BullBatBombObject_constructor.LayerName,param2,param3);
         BullBatBombObject_constructor.setup(param1,this);
         inertia = 1;
         baseHealth *= 1000;
         doCollisions = false;
      }
      
      override public function stunnable() : Boolean
      {
         return false;
      }
      
      override public function collisionWidth() : Number
      {
         return 0;
      }
      
      override public function _update() : void
      {
         super._update();
         var _loc1_:GameObject = helper.conditionallyCreateChild(Embeds.bomber_bomb_shadow_png,"shadow",true,1);
         if(_loc1_)
         {
            _loc1_.changeZOrder("Floor",true);
            _loc1_.basex = basex + 40;
            _loc1_.basey = basey + 40;
         }
         if(released)
         {
            basex += dx;
            basey += dy;
            ++released;
            basex += 40 / fallTime;
            basey += 40 / fallTime;
            if(_loc1_)
            {
               _loc1_.basex -= 40 * (released / fallTime);
               _loc1_.basey -= 40 * (released / fallTime);
            }
            setFrame(released / fallTime * 16);
            if(released > fallTime)
            {
               doSplashDamage(100,1,true,true,true);
               remove();
            }
         }
      }
      
      override public function collisionHeight() : Number
      {
         return 0;
      }
      
      override public function collidesWithAnything() : Boolean
      {
         return false;
      }
   }
}

