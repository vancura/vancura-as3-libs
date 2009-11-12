package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface ICheckButtonSkin extends ISkinnable, IConfigSkin {
		
		function get buttonOffSkin():IButtonSkin;
		function set buttonOffSkin(source:IButtonSkin):void;
		
		function get buttonOnSkin():IButtonSkin;
		function set buttonOnSkin(source:IButtonSkin):void;
		
	}
}
