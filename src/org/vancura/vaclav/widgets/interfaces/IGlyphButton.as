package org.vancura.vaclav.widgets.interfaces {
	

	
	
	public interface IGlyphButton extends IWidget {

		function forceRelease():void;
		
		function get skin():IGlyphButtonSkin;
		function set skin(skin:IGlyphButtonSkin):void;
		
		function set areEventsEnabled(value:Boolean):void;
		function get areEventsEnabled():Boolean;
		
		function get mouseStatus():String;
		
		function get glyph():IImage;
		function get glyphOut():IImage;
		function get glyphHover():IImage;
		function get glyphFocus():IImage;
		
		function get button():IButton;

	}
}
