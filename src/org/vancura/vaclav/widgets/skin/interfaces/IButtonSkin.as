package org.vancura.vaclav.widgets.skin.interfaces {
	import flash.display.BitmapData;	

	
	
	public interface IButtonSkin extends ISkinnable, IAssetSkin, IConfigSkin {

		function set hoveredInDuration(value:Number):void;
		function get hoveredInDuration():Number;
		function set hoveredOutDuration(value:Number):void;
		function get hoveredOutDuration():Number;
		function set pressedInDuration(value:Number):void;
		function get pressedInDuration():Number;
		function set pressedOutDuration(value:Number):void;
		function get pressedOutDuration():Number;
		function set guideBD(source:BitmapData):void;
		function get guideBD():BitmapData;
		function set backBD(source:BitmapData):void;
		function get backBD():BitmapData;
		function set hoveredBD(source:BitmapData):void;
		function get hoveredBD():BitmapData;
		function set pressedBD(source:BitmapData):void;
		function get pressedBD():BitmapData;

	}
}
