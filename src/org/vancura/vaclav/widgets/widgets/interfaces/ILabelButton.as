package org.vancura.vaclav.widgets.widgets.interfaces {
	import org.vancura.vaclav.widgets.skin.interfaces.ILabelButtonSkin;

	
	
	public interface ILabelButton extends IWidget {

		function forceRelease():void;
		
		function get skin():ILabelButtonSkin;
		function set skin(skin:ILabelButtonSkin):void;
		
		function set areEventsEnabled(value:Boolean):void;
		function get areEventsEnabled():Boolean;
		
		function get isDown():Boolean;
		
		function get isOver():Boolean;
		
		function get text():String;
		function set text(value:String):void;
		
		function get label():ILabel;
		
		function get button():IButton;

	}
}
