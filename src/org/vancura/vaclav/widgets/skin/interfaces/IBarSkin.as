package org.vancura.vaclav.widgets.skin.interfaces {
	import flash.display.BitmapData;

	
	
	public interface IBarSkin extends ISkinnable, IAssetSkin, IConfigSkin {

		function set guideBD(source:BitmapData):void;
		function get guideBD():BitmapData;
		
		function set backBD(source:BitmapData):void;
		function get backBD():BitmapData;
		
		function get paddingTop():Number;
		function set paddingTop(value:Number):void;
			
		function get paddingBottom():Number;
		function set paddingBottom(value:Number):void;
			
		function get paddingLeft():Number;
		function set paddingLeft(value:Number):void;
			
		function get paddingRight():Number;
		function set paddingRight(value:Number):void;

	}
}
