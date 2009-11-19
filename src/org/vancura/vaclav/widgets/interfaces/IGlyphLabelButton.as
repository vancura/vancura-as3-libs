package org.vancura.vaclav.widgets.interfaces {
	

	
	
	public interface IGlyphLabelButton extends IWidget {

		function forceRelease():void;
		
		function get skin():IGlyphLabelButtonSkin;
		function set skin(skin:IGlyphLabelButtonSkin):void;
		
		function set areEventsEnabled(value:Boolean):void;
		function get areEventsEnabled():Boolean;
		
		function get mouseStatus():String;
		
		function get text():String;
		function set text(value:String):void;
		
		function get glyph():IImage;
		function get glyphOut():IImage;
		function get glyphHover():IImage;
		function get glyphFocus():IImage;
		
		function get label():ILabel;
		function get labelOut():ILabel;
		function get labelHover():ILabel;
		function get labelFocus():ILabel;
		
		function get button():IButton;

	}
}
