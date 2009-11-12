package org.vancura.vaclav.widgets.widgets.interfaces {
	import org.vancura.vaclav.widgets.skin.interfaces.IBarSkin;

	
	
	public interface IBar extends IWidget {

		function get skin():IBarSkin;
		function set skin(skin:IBarSkin):void;

	}
}
