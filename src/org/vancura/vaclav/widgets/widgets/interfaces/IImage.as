package org.vancura.vaclav.widgets.widgets.interfaces {
	import org.vancura.vaclav.widgets.skin.interfaces.IImageSkin;

	import flash.display.Bitmap;

	
	
	public interface IImage extends IWidget {

		function get skin():IImageSkin;
		function set skin(skin:IImageSkin):void;
		
		function get bitmap():Bitmap;

	}
}
