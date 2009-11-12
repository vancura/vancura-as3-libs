package org.vancura.vaclav.widgets.interfaces {

	
	
	public interface ISkinnable {

		function get id():String;
		
		function get type():String;
		
		function get assetWidth():Number;
		function get assetHeight():Number;
		
		function get data():Object;
		function set data(value:Object):void;

	}
}
