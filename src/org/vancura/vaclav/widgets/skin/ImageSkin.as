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


		protected var $paddingTop:Number;
		protected var $paddingLeft:Number;
		protected var $imageBD:BitmapData;

		private var _oldPaddingTop:Number;
		private var _oldPaddingLeft:Number;



		public function ImageSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			$paddingTop = 0;
			$paddingLeft = 0;

			$imageBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			$assetWidth = source.width;
			$assetHeight = source.height;

			$imageBD = source;
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			$getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);

			$imageBD = $getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'image' : labels[0]);
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldPaddingTop = $paddingTop;
			_oldPaddingLeft = $paddingLeft;

			if(source.paddingTop != undefined) {
				$paddingTop = source.paddingTop;
			}

			if(source.paddingLeft != undefined) {
				$paddingLeft = source.paddingLeft;
			}
		}



		override public function revertConfig():void {
			super.revertConfig();

			$paddingTop = _oldPaddingTop;
			$paddingLeft = _oldPaddingLeft;
		}



		public function get paddingTop():Number {
			return $paddingTop;
		}



		public function set paddingTop(value:Number):void {
			$paddingTop = value;
		}



		public function get paddingLeft():Number {
			return $paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			$paddingLeft = value;
		}



		public function set imageBD(source:BitmapData):void {
			$checkSize(source);
			$imageBD = source;
		}



		public function get imageBD():BitmapData {
			return $imageBD;
		}
	}
}
