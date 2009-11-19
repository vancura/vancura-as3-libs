package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface IGlyphLabelButtonSkin extends ISkinnable, IConfigSkin {
		
		function get buttonSkin():IButtonSkin;
		function set buttonSkin(source:IButtonSkin):void;
		
		function get glyphsSkin():IGlyphsSkin;
		function set glyphsSkin(source:IGlyphsSkin):void;
		
		function get labelOutSkin():ILabelSkin;
		function set labelOutSkin(source:ILabelSkin):void;
		
		function get labelHoverSkin():ILabelSkin;
		function set labelHoverSkin(source:ILabelSkin):void;
		
		function get labelFocusSkin():ILabelSkin;
		function set labelFocusSkin(source:ILabelSkin):void;
		
	}
}
