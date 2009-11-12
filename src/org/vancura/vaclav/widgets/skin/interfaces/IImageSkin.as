package org.vancura.vaclav.widgets.skin.interfaces {
	import flash.display.BitmapData;	

	
	
	public interface IImageSkin extends ISkinnable, IAssetSkin, IConfigSkin {

		function set backBD(source:BitmapData):void;
		function get backBD():BitmapData;
		function get paddingTop():Number;
		function set paddingTop(value:Number):void;	
		function get paddingLeft():Number;
		function set paddingLeft(value:Number):void;	

	}
}
