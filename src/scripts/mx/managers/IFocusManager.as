package mx.managers
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import mx.core.IButton;
   
   public interface IFocusManager
   {
      
      function get focusPane() : Sprite;
      
      function getFocus() : IFocusManagerComponent;
      
      function deactivate() : void;
      
      function set defaultButton(param1:IButton) : void;
      
      function set focusPane(param1:Sprite) : void;
      
      function set showFocusIndicator(param1:Boolean) : void;
      
      function get defaultButtonEnabled() : Boolean;
      
      function findFocusManagerComponent(param1:InteractiveObject) : IFocusManagerComponent;
      
      function get nextTabIndex() : int;
      
      function get defaultButton() : IButton;
      
      function get showFocusIndicator() : Boolean;
      
      function setFocus(param1:IFocusManagerComponent) : void;
      
      function activate() : void;
      
      function showFocus() : void;
      
      function set defaultButtonEnabled(param1:Boolean) : void;
      
      function hideFocus() : void;
      
      function getNextFocusManagerComponent(param1:Boolean = false) : IFocusManagerComponent;
   }
}

