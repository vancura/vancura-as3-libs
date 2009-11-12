package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface IWidget {
		
		function draw():void;
		
		function set debugLevel(value:String):void;
		function get debugLevel():String;
		
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		function get width():Number;
		function set width(value:Number):void;
		
		function get height():Number;
		function set height(value:Number):void;
		
	}
}
