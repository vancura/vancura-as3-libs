package org.vancura.vaclav.widgets.interfaces {
	import flash.display.BitmapData;	

	
	
	public interface IImageSkin extends ISkinnable, IAssetSkin, IConfigSkin {

		function set imageBD(source:BitmapData):void;
		function get imageBD():BitmapData;
		
		function get paddingTop():Number;
		function set paddingTop(value:Number):void;
			
		function get paddingLeft():Number;
		function set paddingLeft(value:Number):void;	

	}
}
