package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface IGlyphsSkin extends ISkinnable, IAssetSkin, IConfigSkin {
		
		function get glyphOutSkin():IImageSkin;
		function set glyphOutSkin(source:IImageSkin):void;
		
		function get glyphHoverSkin():IImageSkin;
		function set glyphHoverSkin(source:IImageSkin):void;
		
		function get glyphFocusSkin():IImageSkin;
		function set glyphFocusSkin(source:IImageSkin):void;
		
	}
}
