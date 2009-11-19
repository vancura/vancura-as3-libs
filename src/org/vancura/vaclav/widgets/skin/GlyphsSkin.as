package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.core.BitmapUtil;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IGlyphsSkin;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	import flash.display.BitmapData;
	import flash.display.MovieClip;

	
	
	public class GlyphsSkin extends Skin implements IGlyphsSkin {

		
		
		protected var $glyphOutSkin:IImageSkin;

		
		
		public function GlyphsSkin(id:String = null) {
			super(SkinType.GLYPHS, id);
			
			$glyphOutSkin = new ImageSkin(id + '#glyphOut');
		}
		
		
		
		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 3 != 0) {
				throw new Error('Width has to be multiple of 3');
			}
			
			$assetWidth = source.width / 3;
			$assetHeight = source.height;
			
			$glyphOutSkin.getAssetsFromAtlas(BitmapUtil.crop(source, 0, 0, $assetWidth, $assetHeight));
		}
		
		
		
		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ...labels:Array):void {
			$getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);
			
			$glyphOutSkin.getAssetsFromMovieClip(source, elements, 'out');
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$glyphOutSkin.revertConfig();
		}

		
		
		public function get glyphOutSkin():IImageSkin {
			return $glyphOutSkin;
		}

		
		
		public function set glyphOutSkin(source:IImageSkin):void {
			$glyphOutSkin = source;
		}

		
		
		public function get glyphHoverSkin():IImageSkin {
			return $glyphHoverSkin;
		}

		
		
		public function set glyphHoverSkin(source:IImageSkin):void {
			$glyphHoverSkin = source;
		}

		
		
		public function get glyphFocusSkin():IImageSkin {
			return $glyphFocusSkin;
		}

		
		
		public function set glyphFocusSkin(source:IImageSkin):void {
			$glyphFocusSkin = source;
		}
	}
}