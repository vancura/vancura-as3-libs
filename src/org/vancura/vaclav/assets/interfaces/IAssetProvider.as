package org.vancura.vaclav.assets.interfaces {
	import org.vancura.vaclav.assets.Asset;

	import flash.events.IEventDispatcher;

	
	
	public interface IAssetProvider extends IEventDispatcher {
		
		function destroy():void;
		
		function getAsset(id:String):Asset;
		
		function toString():String;
		
		function get assetsList():Array;
		
		function get isActive():Boolean;
		
		function get isLoaded():Boolean;
		
		function get isError():Boolean;
		
	}
}
