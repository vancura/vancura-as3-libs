package org.vancura.vaclav.widgets.interfaces {
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	
	
	public interface IAssetSkin {
		
		function getAssetsFromAtlas(source:BitmapData):void;
		
		function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void;

	}
}
