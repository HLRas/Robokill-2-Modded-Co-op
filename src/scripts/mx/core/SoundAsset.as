package mx.core
{
   import flash.media.Sound;
   
   use namespace mx_internal;
   
   public class SoundAsset extends Sound implements IFlexAsset
   {
      
      mx_internal static const VERSION:String = "3.0.0.0";
      
      public function SoundAsset()
      {
         super();
      }
   }
}

