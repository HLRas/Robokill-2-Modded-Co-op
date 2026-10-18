package GameObject
{
   public class GameObjectHelperButton
   {
      
      public var go:GameObject;
      
      public function GameObjectHelperButton(param1:GameObject)
      {
         super();
         go = param1;
      }
      
      public function setupRadioButtons(param1:Array, param2:Boolean = true) : void
      {
         var _loc3_:GameObject = null;
         for each(_loc3_ in param1)
         {
            _loc3_.vars["radioButtons"] = param1;
         }
         if(param2)
         {
            go.vars["selected"] = true;
            go.setButtonOn(true);
         }
      }
      
      public function mHit() : void
      {
         var _loc1_:GameObject = null;
         if(go.vars["radioButtons"])
         {
            for each(_loc1_ in go.vars["radioButtons"])
            {
               _loc1_.setButtonOn(false);
               _loc1_.vars["selected"] = false;
            }
            go.setButtonOn(true);
            go.vars["selected"] = true;
         }
      }
      
      public function update() : void
      {
      }
      
      public function updatePrevNext(param1:GameObject, param2:GameObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(go.vars["radioButtons"])
         {
            param1.enableButton();
            param2.enableButton();
            _loc3_ = -1;
            _loc4_ = 0;
            while(_loc4_ < go.vars["radioButtons"].length)
            {
               if(go.vars["radioButtons"][_loc4_].helperButton.go.vars["selected"])
               {
                  go.vars["selected"] = _loc4_;
               }
               _loc4_++;
            }
            if(go.vars["selected"] == 0)
            {
               param1.disableButton();
            }
            if(go.vars["selected"] == go.vars["radioButtons"].length - 1)
            {
               param2.disableButton();
            }
            if(param1.mHit())
            {
               if(go.vars["selected"] == -1)
               {
                  go.vars["radioButtons"][0]._mHit(null);
               }
               else if(go.vars["selected"] > 0)
               {
                  go.vars["radioButtons"][go.vars["selected"] - 1]._mHit(null);
               }
            }
            if(param2.mHit())
            {
               if(go.vars["selected"] == -1)
               {
                  go.vars["radioButtons"][0]._mHit(null);
               }
               else if(go.vars["selected"] < go.vars["radioButtons"].length - 1)
               {
                  go.vars["radioButtons"][go.vars["selected"] + 1]._mHit(null);
               }
            }
         }
      }
   }
}

