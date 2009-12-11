/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the “Software”), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.skin {
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	import org.vancura.vaclav.core.BitmapUtil;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IGlyphsSkin;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	public class GlyphsSkin extends Skin implements IGlyphsSkin {


		protected var $glyphOutSkin:IImageSkin;
		protected var $glyphHoverSkin:IImageSkin;
		protected var $glyphFocusSkin:IImageSkin;



		public function GlyphsSkin(id:String = null) {
			super(SkinType.GLYPHS, id);

			$glyphOutSkin = new ImageSkin(id + '#glyphOut');
			$glyphHoverSkin = new ImageSkin(id + '#glyphHover');
			$glyphFocusSkin = new ImageSkin(id + '#glyphFocus');
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 3 != 0) {
				throw new Error('Width has to be multiple of 3');
			}

			$assetWidth = source.width / 3;
			$assetHeight = source.height;

			$glyphOutSkin.getAssetsFromAtlas(BitmapUtil.crop(source, 0, 0, $assetWidth, $assetHeight));
			$glyphHoverSkin.getAssetsFromAtlas(BitmapUtil.crop(source, $assetWidth, 0, $assetWidth, $assetHeight));
			$glyphFocusSkin.getAssetsFromAtlas(BitmapUtil.crop(source, $assetWidth * 2, 0, $assetWidth, $assetHeight));
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ...labels:Array):void {
			$getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);

			$glyphOutSkin.getAssetsFromMovieClip(source, elements, 'out');
			$glyphHoverSkin.getAssetsFromMovieClip(source, elements, 'hover');
			$glyphFocusSkin.getAssetsFromMovieClip(source, elements, 'focus');
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
		}



		override public function revertConfig():void {
			super.revertConfig();

			$glyphOutSkin.revertConfig();
			$glyphHoverSkin.revertConfig();
			$glyphFocusSkin.revertConfig();
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
