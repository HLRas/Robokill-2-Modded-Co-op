package Items
{
   import GameObject.GameObject;
   import GlobalSetup.Embeds;
   import ObjectBase.EnemyBase;
   import ObjectBase.PlayerBase;
   import Weapons.ItemActive;
   
   public class ItemEMP extends ItemActive
   {
      
      public function ItemEMP()
      {
         super();
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc2_:GameObject = null;
         param1.emitConditionalParticles("EMP");
         for each(_loc2_ in param1.gs.objects)
         {
            if(_loc2_ is EnemyBase)
            {
               if(!EnemyBase(_loc2_).organic)
               {
                  EnemyBase(_loc2_).stun();
                  _loc2_.emitConditionalParticles("EMPSmall");
               }
            }
         }
         rechargeProgress = 0;
      }
      
      override public function attributeCost() : int
      {
         return 60;
      }
      
      override public function priceLow() : int
      {
         return 300;
      }
      
      override public function minimumEpisode() : int
      {
         return 5;
      }
      
      override public function units() : String
      {
         return "RECHARGE TIME:";
      }
      
      override public function name() : String
      {
         return "EMP";
      }
      
      override public function description2() : String
      {
         return "INCLUDING TURRETS AND GENERATORS.";
      }
      
      override public function attributeLow() : int
      {
         return 30;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_emppulse_png;
      }
      
      override public function priceHigh() : int
      {
         return 4000;
      }
      
      override public function description() : String
      {
         return "DISABLES ALL ENEMY ROBOTICS,";
      }
      
      override public function attributeHigh() : int
      {
         return 15;
      }
   }
}

