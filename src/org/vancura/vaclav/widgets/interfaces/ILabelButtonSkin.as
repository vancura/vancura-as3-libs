package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface ILabelButtonSkin extends ISkinnable, IConfigSkin {
		
		function get buttonSkin():IButtonSkin;
		function set buttonSkin(source:IButtonSkin):void;
		
		function get labelOutSkin():ILabelSkin;
		function set labelOutSkin(source:ILabelSkin):void;
		
		function get labelHoverSkin():ILabelSkin;
		function set labelHoverSkin(source:ILabelSkin):void;
		
		function get labelFocusSkin():ILabelSkin;
		function set labelFocusSkin(source:ILabelSkin):void;
		
	}
}
