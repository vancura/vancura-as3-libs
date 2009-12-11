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
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;

	public class ButtonSkin extends Skin implements IButtonSkin {


		protected var $hoverInDuration:Number;
		protected var $hoverOutDuration:Number;
		protected var $focusInDuration:Number;
		protected var $focusOutDuration:Number;
		protected var $guideBD:BitmapData;
		protected var $outBD:BitmapData;
		protected var $hoverBD:BitmapData;
		protected var $focusBD:BitmapData;

		private var _oldHoverInDuration:Number;
		private var _oldHoverOutDuration:Number;
		private var _oldFocusInDuration:Number;
		private var _oldFocusOutDuration:Number;



		public function ButtonSkin(id:String = null) {
			super(SkinType.BUTTON, id);

			$hoverInDuration = 0;
			$hoverOutDuration = 0.15;
			$focusInDuration = 0;
			$focusOutDuration = 0.1;

			$guideBD = new BitmapData(1, 1, true, 0x00000000);
			$outBD = new BitmapData(1, 1, true, 0x00000000);
			$hoverBD = new BitmapData(1, 1, true, 0x00000000);
			$focusBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 4 != 0) {
				throw new Error('Width has to be multiple of 4');
			}

			$assetWidth = source.width / 4;
			$assetHeight = source.height;

			$guideBD = BitmapUtil.crop(source, 0, 0, $assetWidth, $assetHeight);
			$outBD = BitmapUtil.crop(source, $assetWidth, 0, $assetWidth, $assetHeight);
			$hoverBD = BitmapUtil.crop(source, $assetWidth * 2, 0, $assetWidth, $assetHeight);
			$focusBD = BitmapUtil.crop(source, $assetWidth * 3, 0, $assetWidth, $assetHeight);
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			$getSkinSize(source, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);

			$outBD = $getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'out' : labels[0]);
			$hoverBD = $getSkinFrame(source, elements, (labels[1] == undefined || labels[1] == '') ? 'hover' : labels[1]);
			$focusBD = $getSkinFrame(source, elements, (labels[2] == undefined || labels[2] == '') ? 'focus' : labels[2]);
			$guideBD = $getSkinFrame(source, elements, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);
		}



		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldHoverInDuration = $hoverInDuration;
			_oldHoverOutDuration = $hoverOutDuration;
			_oldFocusInDuration = $focusInDuration;
			_oldFocusOutDuration = $focusOutDuration;

			if(source.hoverInDuration != undefined) {
				$hoverInDuration = source.hoverInDuration;
			}

			if(source.hoverOutDuration != undefined) {
				$hoverOutDuration = source.hoverOutDuration;
			}

			if(source.pressInDuration != undefined) {
				$focusInDuration = source.pressInDuration;
			}

			if(source.pressOutDuration != undefined) {
				$focusOutDuration = source.pressOutDuration;
			}
		}



		override public function revertConfig():void {
			super.revertConfig();

			$hoverInDuration = _oldHoverInDuration;
			$hoverOutDuration = _oldHoverOutDuration;
			$focusInDuration = _oldFocusInDuration;
			$focusOutDuration = _oldFocusOutDuration;
		}



		public function set hoverInDuration(value:Number):void {
			$hoverInDuration = value;
		}



		public function get hoverInDuration():Number {
			return $hoverInDuration;
		}



		public function set hoverOutDuration(value:Number):void {
			$hoverOutDuration = value;
		}



		public function get hoverOutDuration():Number {
			return $hoverOutDuration;
		}



		public function set focusInDuration(value:Number):void {
			$focusInDuration = value;
		}



		public function get focusInDuration():Number {
			return $focusInDuration;
		}



		public function set focusOutDuration(value:Number):void {
			$focusOutDuration = value;
		}



		public function get focusOutDuration():Number {
			return $focusOutDuration;
		}



		public function set outBD(source:BitmapData):void {
			$checkSize(source);
			$outBD = source;
		}



		public function get outBD():BitmapData {
			return $outBD;
		}



		public function set hoverBD(source:BitmapData):void {
			$checkSize(source);
			$hoverBD = source;
		}



		public function get hoverBD():BitmapData {
			return $hoverBD;
		}



		public function set focusBD(source:BitmapData):void {
			$checkSize(source);
			$focusBD = source;
		}



		public function get focusBD():BitmapData {
			return $focusBD;
		}



		public function set guideBD(source:BitmapData):void {
			$checkSize(source);
			$guideBD = source;
		}



		public function get guideBD():BitmapData {
			return $guideBD;
		}
	}
}
