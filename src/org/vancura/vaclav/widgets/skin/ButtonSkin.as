/***********************************************************************************************************************
 * Copyright (c) 2010 Vaclav Vancura.
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

	import org.vancura.vaclav.core.utils.BitmapUtils;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;

	public class ButtonSkin extends Skin implements IButtonSkin {


		protected var _hoverInDuration:Number;
		protected var _hoverOutDuration:Number;
		protected var _focusInDuration:Number;
		protected var _focusOutDuration:Number;
		protected var _guideBD:BitmapData;
		protected var _outBD:BitmapData;
		protected var _hoverBD:BitmapData;
		protected var _focusBD:BitmapData;

		private var _oldHoverInDuration:Number;
		private var _oldHoverOutDuration:Number;
		private var _oldFocusInDuration:Number;
		private var _oldFocusOutDuration:Number;



		public function ButtonSkin(id:String = null) {
			super(SkinType.BUTTON, id);

			_hoverInDuration = 0;
			_hoverOutDuration = 0.15;
			_focusInDuration = 0;
			_focusOutDuration = 0.1;

			_guideBD = new BitmapData(1, 1, true, 0x00000000);
			_outBD = new BitmapData(1, 1, true, 0x00000000);
			_hoverBD = new BitmapData(1, 1, true, 0x00000000);
			_focusBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 4 != 0) throw new Error('Width has to be multiple of 4');

			_assetWidth = source.width / 4;
			_assetHeight = source.height;

			_guideBD = BitmapUtils.crop(source, 0, 0, _assetWidth, _assetHeight);
			_outBD = BitmapUtils.crop(source, _assetWidth, 0, _assetWidth, _assetHeight);
			_hoverBD = BitmapUtils.crop(source, _assetWidth * 2, 0, _assetWidth, _assetHeight);
			_focusBD = BitmapUtils.crop(source, _assetWidth * 3, 0, _assetWidth, _assetHeight);
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			_getSkinSize(source, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);

			_outBD = _getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'out' : labels[0]);
			_hoverBD = _getSkinFrame(source, elements, (labels[1] == undefined || labels[1] == '') ? 'hover' : labels[1]);
			_focusBD = _getSkinFrame(source, elements, (labels[2] == undefined || labels[2] == '') ? 'focus' : labels[2]);
			_guideBD = _getSkinFrame(source, elements, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldHoverInDuration = _hoverInDuration;
			_oldHoverOutDuration = _hoverOutDuration;
			_oldFocusInDuration = _focusInDuration;
			_oldFocusOutDuration = _focusOutDuration;

			if(source.hoverInDuration != undefined) _hoverInDuration = source.hoverInDuration;
			if(source.hoverOutDuration != undefined) _hoverOutDuration = source.hoverOutDuration;
			if(source.pressInDuration != undefined) _focusInDuration = source.pressInDuration;
			if(source.pressOutDuration != undefined) _focusOutDuration = source.pressOutDuration;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_hoverInDuration = _oldHoverInDuration;
			_hoverOutDuration = _oldHoverOutDuration;
			_focusInDuration = _oldFocusInDuration;
			_focusOutDuration = _oldFocusOutDuration;
		}



		public function set hoverInDuration(value:Number):void {
			_hoverInDuration = value;
		}



		public function get hoverInDuration():Number {
			return _hoverInDuration;
		}



		public function set hoverOutDuration(value:Number):void {
			_hoverOutDuration = value;
		}



		public function get hoverOutDuration():Number {
			return _hoverOutDuration;
		}



		public function set focusInDuration(value:Number):void {
			_focusInDuration = value;
		}



		public function get focusInDuration():Number {
			return _focusInDuration;
		}



		public function set focusOutDuration(value:Number):void {
			_focusOutDuration = value;
		}



		public function get focusOutDuration():Number {
			return _focusOutDuration;
		}



		public function set outBD(source:BitmapData):void {
			_checkSize(source);
			_outBD = source;
		}



		public function get outBD():BitmapData {
			return _outBD;
		}



		public function set hoverBD(source:BitmapData):void {
			_checkSize(source);
			_hoverBD = source;
		}



		public function get hoverBD():BitmapData {
			return _hoverBD;
		}



		public function set focusBD(source:BitmapData):void {
			_checkSize(source);
			_focusBD = source;
		}



		public function get focusBD():BitmapData {
			return _focusBD;
		}



		public function set guideBD(source:BitmapData):void {
			_checkSize(source);
			_guideBD = source;
		}



		public function get guideBD():BitmapData {
			return _guideBD;
		}
	}
}
