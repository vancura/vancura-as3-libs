/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.skin {
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	public class ImageSkin extends Skin implements IImageSkin {


		protected var _paddingTop:Number;
		protected var _paddingLeft:Number;
		protected var _imageBD:BitmapData;

		private var _oldPaddingTop:Number;
		private var _oldPaddingLeft:Number;



		public function ImageSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			_paddingTop = 0;
			_paddingLeft = 0;

			_imageBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			_assetWidth = source.width;
			_assetHeight = source.height;

			_imageBD = source;
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			_getSkinSize(source, (labels[1] === undefined || labels[1] === '') ? 'guide' : labels[1]);

			_imageBD = _getSkinFrame(source, elements, (labels[0] === undefined || labels[0] === '') ? 'image' : labels[0]);
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldPaddingTop = _paddingTop;
			_oldPaddingLeft = _paddingLeft;

			if(source.paddingTop !== undefined) _paddingTop = source.paddingTop;
			if(source.paddingLeft !== undefined) _paddingLeft = source.paddingLeft;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_paddingTop = _oldPaddingTop;
			_paddingLeft = _oldPaddingLeft;
		}



		public function get paddingTop():Number {
			return _paddingTop;
		}



		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		public function set imageBD(source:BitmapData):void {
			_checkSize(source);
			_imageBD = source;
		}



		public function get imageBD():BitmapData {
			return _imageBD;
		}
	}
}
