package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface ILabelButtonSkin extends ISkinnable, IConfigSkin {
		
		function get buttonSkin():IButtonSkin;
		function set buttonSkin(source:IButtonSkin):void;
		
		function get labelSkin():ILabelSkin;
		function set labelSkin(source:ILabelSkin):void;
		
	}
}
