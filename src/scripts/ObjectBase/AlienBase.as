package ObjectBase
{
   import GameObject.GameObject;
   import GameScene.GameScene;
   import Tools.Random;
   
   public class AlienBase extends GameObject
   {
      
      public var blinkRange:int = 200;
      
      public var isTalking:Boolean = false;
      
      public var framelimit:int = 5;
      
      public var talkDirection:int = 1;
      
      public var talk:int = 0;
      
      public var blink:int = 0;
      
      public function AlienBase(param1:GameScene, param2:Class, param3:String, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function _update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(ticks % 2 == 0 && Math.random() < 0.8)
         {
            talk += talkDirection;
            if(talk >= framelimit)
            {
               talkDirection = -1;
            }
            if(talk <= 0)
            {
               if(isTalking)
               {
                  talkDirection = 1;
                  framelimit = Random.randInt(3,5);
               }
               else
               {
                  talkDirection = 0;
               }
            }
         }
         setFrame(talk);
         if(!isTalking)
         {
            if(talk == 0)
            {
               ++blink;
               if(blink > blinkRange)
               {
                  blink = 0;
                  blinkRange = Random.randInt(150,250);
               }
               else if(blink >= blinkRange - 20)
               {
                  _loc1_ = blinkRange - blink;
                  _loc2_ = Math.abs(10 - _loc1_) / 4;
                  setFrame(5 + (3 - _loc2_));
               }
            }
         }
         super._update();
      }
   }
}

