package Items
{
   import GameObject.GameObject;
   import GlobalSetup.Embeds;
   import ObjectBase.EnemyBase;
   import ObjectBase.EnemyBulletBase;
   import ObjectBase.GameObjectBase;
   import ObjectBase.PickupBase;
   import ObjectBase.PlayerBase;
   import Objects.FloorProp;
   import Objects.ProximityMine;
   import Particles.Particle;
   import Weapons.ItemActive;
   
   public class ItemShockwave extends ItemActive
   {
      
      public function ItemShockwave()
      {
         super();
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc3_:GameObject = null;
         var _loc2_:Particle = param1.emitConditionalParticles("Shockwave")[0];
         if(_loc2_)
         {
            _loc2_.lockTo = param1;
         }
         Sounds.shockwave.play();
         for each(_loc3_ in param1.gs.objects)
         {
            if(validForPushing(_loc3_))
            {
               if(param1.distanceToObject(_loc3_) < 200)
               {
                  if(GameObjectBase(_loc3_).shockwaveWeight() > 0.01)
                  {
                     if(_loc3_ is GameObjectBase)
                     {
                        GameObjectBase(_loc3_).hitByShockwave();
                     }
                  }
               }
            }
         }
         rechargeProgress = 0;
      }
      
      override public function attributeCost() : int
      {
         return 60;
      }
      
      override public function priceHigh() : int
      {
         return 4000;
      }
      
      override public function minimumEpisode() : int
      {
         return 2;
      }
      
      override public function units() : String
      {
         return "RECHARGE TIME:";
      }
      
      override public function name() : String
      {
         return "SHOCKWAVE";
      }
      
      override public function description2() : String
      {
         return "CLOSE RANGE ONLY.";
      }
      
      override public function attributeLow() : int
      {
         return 10;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_shockwave_png;
      }
      
      override public function priceLow() : int
      {
         return 500;
      }
      
      public function validForPushing(param1:GameObject) : *
      {
         if(!(param1 is GameObjectBase))
         {
            return;
         }
         if(!GameObjectBase(param1).pushable)
         {
            return false;
         }
         if(param1 is FloorProp)
         {
            if(FloorProp(param1).destructable(param1.animFrame))
            {
               if(!FloorProp(param1).temporary)
               {
                  return true;
               }
            }
         }
         if(param1 is PickupBase)
         {
            return true;
         }
         if(param1 is EnemyBulletBase)
         {
            return true;
         }
         return param1 is EnemyBase || param1 is ProximityMine;
      }
      
      override public function description() : String
      {
         return "DAMAGES ALL ENEMIES WITHIN RANGE.";
      }
      
      override public function attributeHigh() : int
      {
         return 4;
      }
   }
}

