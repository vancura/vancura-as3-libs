package org.vancura.vaclav.widgets.widgets.interfaces {
	import org.vancura.vaclav.widgets.skin.interfaces.IButtonSkin;

	
	
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
