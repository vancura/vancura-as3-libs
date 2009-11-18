package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface IGlyphButtonSkin extends ISkinnable, IConfigSkin {
		
		function get buttonSkin():IButtonSkin;
		function set buttonSkin(source:IButtonSkin):void;
		
		function get glyphsSkin():IGlyphsSkin;
		function set glyphsSkin(source:IGlyphsSkin):void;
		
	}
}
