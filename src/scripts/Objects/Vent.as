package Objects
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import GlobalSetup.Embeds;
   import ObjectBase.GameObjectBase;
   import ObjectConstructors.Vent_constructor;
   import Scenes.MainScene;
   import Tools.Random;
   
   public class Vent extends GameObjectBase
   {
      
      public var spawnEnd:int = 0;
      
      public var spawnProgress:int = 0;
      
      public var spawnStart:int = 0;
      
      public var firstSpawned:Boolean = false;
      
      public var masks:Array;
      
      public var images:Array;
      
      public var imageBeenSet:Boolean = false;
      
      public var spawning:Boolean = false;
      
      public function Vent(param1:GameScene = null, param2:int = 0, param3:int = 0)
      {
         if(!param1)
         {
            param1 = GameScene.current();
         }
         super(param1,Vent_constructor.baseim_embed,Vent_constructor.LayerName,param2,param3);
         Vent_constructor.setup(param1,this);
         if(Math.random() > 0.7)
         {
            spawning = true;
         }
         spawnStart = Random.randInt(400,600);
         spawnEnd = Random.randInt(spawnStart + 200,spawnStart + 300);
      }
      
      override public function _update() : void
      {
         var _loc1_:GameObject = null;
         var _loc2_:int = 0;
         var _loc3_:Critter = null;
         _loc1_ = helper.conditionallyCreateChild(Embeds.vent_1_mask_png,"Mask",true,1,createMask);
         if(!imageBeenSet)
         {
            imageBeenSet = true;
            helperAnimation.setFrame(images[animFrame]);
         }
         if(_loc1_)
         {
            _loc1_.basex = basex;
            _loc1_.basey = basey;
            _loc1_.baseRotation = baseRotation;
            _loc1_.baseScaleX = baseScaleX;
            _loc1_.baseScaleY = baseScaleY;
         }
         if(ticks == 20)
         {
            MainScene(gs).setPassable(logicalSquareX(),logicalSquareY(),false,this);
         }
         super._update();
         if(spawning)
         {
            ++spawnProgress;
            if(spawnProgress > spawnStart && spawnProgress < spawnEnd)
            {
               if(spawnProgress % 30 == 0)
               {
                  _loc2_ = 0;
                  if(ms.currentEpisode >= 3)
                  {
                     _loc2_ = 1;
                  }
                  if(ms.currentEpisode >= 7)
                  {
                     _loc2_ = 2;
                  }
                  _loc3_ = Critter(spawn(Critter,basex,basey,_loc2_));
                  if(_loc3_)
                  {
                     _loc3_.rotationLock = -90 + baseRotation;
                     if(animFrame == 1 || animFrame == 3)
                     {
                        _loc3_.rotationLock += 180;
                     }
                     _loc3_.rotationLockTicks = 60;
                  }
                  ms.currentLevel.enragedBugs = true;
                  if(_loc3_)
                  {
                     if(!firstSpawned)
                     {
                        _loc3_.trapEffect();
                        firstSpawned = true;
                     }
                  }
               }
            }
         }
      }
      
      override public function _init() : void
      {
         super._init();
      }
      
      public function serializeFields() : Array
      {
         return ["basex","basey","baseScaleX","baseScaleY","baseRotation","animFrame","spawning","spawnProgress","spawnStart","spawnEnd"];
      }
      
      override public function shockwaveWeight() : Number
      {
         return 0;
      }
      
      public function createMask(param1:GameObject) : void
      {
         param1.helperAnimation.setFrame(masks[animFrame]);
         param1.changeZOrder("AbovePlayer");
      }
   }
}

