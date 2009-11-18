package org.vancura.vaclav.widgets.interfaces {
	import flash.display.BitmapData;	

	
	
	public interface IButtonSkin extends ISkinnable, IAssetSkin, IConfigSkin {

		function set hoverInDuration(value:Number):void;
		function get hoverInDuration():Number;
		
		function set hoverOutDuration(value:Number):void;
		function get hoverOutDuration():Number;
		
		function set focusInDuration(value:Number):void;
		function get focusInDuration():Number;
		
		function set focusOutDuration(value:Number):void;
		function get focusOutDuration():Number;
		
		function set guideBD(source:BitmapData):void;
		function get guideBD():BitmapData;
		
		function set outBD(source:BitmapData):void;
		function get outBD():BitmapData;
		
		function set hoverBD(source:BitmapData):void;
		function get hoverBD():BitmapData;
		
		function set focusBD(source:BitmapData):void;
		function get focusBD():BitmapData;

	}
}
