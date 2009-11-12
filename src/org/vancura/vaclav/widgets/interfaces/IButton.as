package org.vancura.vaclav.widgets.interfaces {
	

	
	
	public interface IButton extends IWidget {

		function forceRelease():void;
		
		function get skin():IButtonSkin;
		function set skin(skin:IButtonSkin):void;
		
		function set areEventsEnabled(value:Boolean):void;
		function get areEventsEnabled():Boolean;
		
		function get isDown():Boolean;
		
		function get isOver():Boolean;

	}
}
