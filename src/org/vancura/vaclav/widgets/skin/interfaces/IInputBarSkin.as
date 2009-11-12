package org.vancura.vaclav.widgets.skin.interfaces {

	
	
	public interface IInputBarSkin extends ISkinnable, IConfigSkin {
		
		function get barSkin():IBarSkin;
		function set barSkin(source:IBarSkin):void;
		
		function get labelSkin():ILabelSkin;
		function set labelSkin(source:ILabelSkin):void;
		
	}
}
