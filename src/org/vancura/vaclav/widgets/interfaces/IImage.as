package org.vancura.vaclav.widgets.interfaces {
	

	import flash.display.Bitmap;

	
	
	public interface IImage extends IWidget {

		function get skin():IImageSkin;
		function set skin(skin:IImageSkin):void;
		
		function get bitmap():Bitmap;

	}
}
