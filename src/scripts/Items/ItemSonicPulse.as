package Items
{
   import GameObject.GameObject;
   import GlobalSetup.Embeds;
   import ObjectBase.EnemyBase;
   import ObjectBase.PlayerBase;
   import Particles.Particle;
   import Weapons.ItemActive;
   
   public class ItemSonicPulse extends ItemActive
   {
      
      public function ItemSonicPulse()
      {
         super();
      }
      
      override public function attributeCost() : int
      {
         return 60;
      }
      
      override public function priceHigh() : int
      {
         return 4000;
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
         return Embeds.icon_sonicpulse_png;
      }
      
      override public function name() : String
      {
         return "SONIC PULSE";
      }
      
      override public function priceLow() : int
      {
         return 300;
      }
      
      override public function description() : String
      {
         return "STUNS ENEMIES FOR A SHORT TIME.";
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc3_:GameObject = null;
         var _loc2_:Particle = param1.emitConditionalParticles("ShockwaveStun")[0];
         if(_loc2_)
         {
            _loc2_.lockTo = param1;
         }
         Sounds.shockwave.play();
         for each(_loc3_ in param1.gs.objects)
         {
            if(_loc3_ is EnemyBase)
            {
               if(param1.distanceToObject(_loc3_) < 200)
               {
                  if(EnemyBase(_loc3_).organic)
                  {
                     EnemyBase(_loc3_).stun();
                  }
               }
            }
         }
         rechargeProgress = 0;
      }
      
      override public function attributeHigh() : int
      {
         return 4;
      }
      
      override public function units() : String
      {
         return "RECHARGE TIME:";
      }
   }
}

