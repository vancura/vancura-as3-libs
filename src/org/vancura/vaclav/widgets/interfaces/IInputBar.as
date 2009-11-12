package org.vancura.vaclav.widgets.interfaces {
	

	
	
	public interface IInputBar extends IWidget {

		function get text():String;
		function set text(value:String):void;
		
		function get skin():IInputBarSkin;
		function set skin(skin:IInputBarSkin):void;
		
		function get label():ILabel;
		
		function get bar():IBar;

	}
}
