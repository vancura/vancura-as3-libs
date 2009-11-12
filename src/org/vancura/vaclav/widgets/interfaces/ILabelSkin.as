package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface ILabelSkin extends ISkinnable, IConfigSkin {

		function get font():String;
		function set font(value:String):void;
				
		function get size():Number;
		function set size(value:Number):void;
		
		function get color():uint;
		function set color(value:uint):void;
		
		function get alpha():Number;
		function set alpha(value:Number):void;
		
		function get hAlign():String;
		function set hAlign(value:String):void;
		
		function get vAlign():String;
		function set vAlign(value:String):void;
		
		function get filters():Array;
		function set filters(value:Array):void;
		
		function get sharpness():Number;
		function set sharpness(value:Number):void;
		
		function get thickness():Number;
		function set thickness(value:Number):void;
		
		function get paddingTop():Number;
		function set paddingTop(value:Number):void;
		
		function get paddingBottom():Number;
		function set paddingBottom(value:Number):void;
		
		function get paddingLeft():Number;
		function set paddingLeft(value:Number):void;
		
		function get paddingRight():Number;
		function set paddingRight(value:Number):void;
		
	}
}
