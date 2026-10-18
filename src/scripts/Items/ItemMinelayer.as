package Items
{
   import GameObject.GameObject;
   import GlobalSetup.Embeds;
   import ObjectBase.PlayerBase;
   import ObjectBase.ProximityMineBase;
   import Objects.ProximityMine;
   import Scenes.MainScene;
   import Weapons.ItemActive;
   
   public class ItemMinelayer extends ItemActive
   {
      
      public var _rechargeSpeed:Number = 1;
      
      public function ItemMinelayer()
      {
         super();
         rechargeTime *= 0.15;
      }
      
      override public function rechargeSpeed() : Number
      {
         return _rechargeSpeed;
      }
      
      override public function useOn(param1:PlayerBase) : void
      {
         var _loc2_:ProximityMine = new ProximityMine(param1.gs,param1.basex,param1.basey);
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
         return 1;
      }
      
      override public function units() : String
      {
         return "RECHARGE TIME:";
      }
      
      override public function update(param1:MainScene) : void
      {
         var _loc2_:GameObject = null;
         super.update(param1);
         _rechargeSpeed = 1;
         for each(_loc2_ in param1.objects)
         {
            if(_loc2_ is ProximityMineBase)
            {
               _rechargeSpeed *= 0.7;
            }
         }
      }
      
      override public function name() : String
      {
         return "STEALTH MINE";
      }
      
      override public function description2() : String
      {
         return "ACTIVATED BY ENEMY PRESENCE";
      }
      
      override public function attributeLow() : int
      {
         return 20;
      }
      
      override public function icon() : Class
      {
         return Embeds.icon_proximitymines_png;
      }
      
      override public function priceLow() : int
      {
         return 150;
      }
      
      override public function description() : String
      {
         return "INVISIBLE TO ENEMIES.";
      }
      
      override public function attributeHigh() : int
      {
         return 8;
      }
   }
}

