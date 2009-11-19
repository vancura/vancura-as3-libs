package org.vancura.vaclav.widgets.interfaces {
	

	
	
	public interface ILabelButton extends IWidget {

		function forceRelease():void;
		
		function get skin():ILabelButtonSkin;
		function set skin(skin:ILabelButtonSkin):void;
		
		function set areEventsEnabled(value:Boolean):void;
		function get areEventsEnabled():Boolean;
		
		function get mouseStatus():String;
		function set mouseStatus(value:String):void;
		
		function get text():String;
		function set text(value:String):void;
		
		function get label():ILabel;
		function get labelOut():ILabel;
		function get labelHover():ILabel;
		function get labelFocus():ILabel;
		
		function get button():IButton;

	}
}
