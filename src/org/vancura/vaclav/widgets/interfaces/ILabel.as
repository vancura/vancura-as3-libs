package org.vancura.vaclav.widgets.interfaces {
	

	import flash.text.TextField;

	
	
	public interface ILabel extends IWidget {

		function get text():String;
		function set text(value:String):void;
		
		function get textField():TextField;
		
		function get skin():ILabelSkin;
		function set skin(skin:ILabelSkin):void;
		
		function get isInput():Boolean;
		function set isInput(value:Boolean):void;

	}
}
