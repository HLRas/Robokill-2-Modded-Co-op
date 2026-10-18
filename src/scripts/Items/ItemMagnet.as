package Items
{
   import GameObject.GameObject;
   import GlobalSetup.Embeds;
   import ObjectBase.PickupBase;
   import ObjectBase.PlayerBase;
   import Particles.Particle;
   import Weapons.ItemActive;
   
   public class ItemMagnet extends ItemActive
   {
      
      public function ItemMagnet()
      {
         super();
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc3_:GameObject = null;
         var _loc2_:Particle = param1.emitConditionalParticles("ShockwaveMagnet")[0];
         if(_loc2_)
         {
            _loc2_.lockTo = param1;
         }
         Sounds.shockwave.play();
         for each(_loc3_ in param1.gs.objects)
         {
            if(_loc3_ is PickupBase)
            {
               PickupBase(_loc3_).drawnToPlayer = true;
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
         return 3000;
      }
      
      override public function minimumEpisode() : int
      {
         return 4;
      }
      
      override public function units() : String
      {
         return "RECHARGE TIME:";
      }
      
      override public function name() : String
      {
         return "MATTER MAGNET";
      }
      
      override public function description2() : String
      {
         return "CASH TO YOUR LOCATION";
      }
      
      override public function attributeLow() : int
      {
         return 5;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_magnetcollector_png;
      }
      
      override public function priceLow() : int
      {
         return 250;
      }
      
      override public function description() : String
      {
         return "ATTRACTS ALL ITEMS, WEAPONS AND";
      }
      
      override public function attributeHigh() : int
      {
         return 2;
      }
   }
}

