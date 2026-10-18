package mx.managers
{
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import mx.core.IChildList;
   import mx.core.IFlexModuleFactory;
   
   public interface ISystemManager extends IEventDispatcher, IChildList, IFlexModuleFactory
   {
      
      function get focusPane() : Sprite;
      
      function get loaderInfo() : LoaderInfo;
      
      function get toolTipChildren() : IChildList;
      
      function set focusPane(param1:Sprite) : void;
      
      function isTopLevel() : Boolean;
      
      function get popUpChildren() : IChildList;
      
      function get screen() : Rectangle;
      
      function isFontFaceEmbedded(param1:TextFormat) : Boolean;
      
      function get rawChildren() : IChildList;
      
      function get topLevelSystemManager() : ISystemManager;
      
      function getDefinitionByName(param1:String) : Object;
      
      function activate(param1:IFocusManagerContainer) : void;
      
      function deactivate(param1:IFocusManagerContainer) : void;
      
      function get cursorChildren() : IChildList;
      
      function set document(param1:Object) : void;
      
      function get embeddedFontList() : Object;
      
      function set numModalWindows(param1:int) : void;
      
      function removeFocusManager(param1:IFocusManagerContainer) : void;
      
      function get document() : Object;
      
      function get numModalWindows() : int;
      
      function addFocusManager(param1:IFocusManagerContainer) : void;
      
      function get stage() : Stage;
   }
}

