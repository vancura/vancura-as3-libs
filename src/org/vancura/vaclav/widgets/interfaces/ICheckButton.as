package org.vancura.vaclav.widgets.interfaces {
	

	
	
	public interface ICheckButton extends IWidget {

		function forceRelease():void;
		
		function get skin():ICheckButtonSkin;
		function set skin(skin:ICheckButtonSkin):void;
		
		function set areEventsEnabled(value:Boolean):void;
		function get areEventsEnabled():Boolean;
		
		function get isDown():Boolean;
		
		function get isOver():Boolean;
		
		function get isChecked():Boolean;
		function set isChecked(value:Boolean):void;
		
		function get button():IButton;
		
		function get buttonOff():IButton;
		
		function get buttonOn():IButton;

	}
}
