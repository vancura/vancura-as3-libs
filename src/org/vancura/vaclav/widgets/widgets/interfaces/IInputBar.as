package org.vancura.vaclav.widgets.widgets.interfaces {
	import org.vancura.vaclav.widgets.skin.interfaces.IInputBarSkin;

	
	
	public interface IInputBar extends IWidget {

		function get text():String;
		function set text(value:String):void;
		
		function get skin():IInputBarSkin;
		function set skin(skin:IInputBarSkin):void;
		
		function get label():ILabel;
		function get bar():IBar;

	}
}
