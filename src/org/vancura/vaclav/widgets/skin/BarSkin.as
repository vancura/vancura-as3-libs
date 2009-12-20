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

	import org.vancura.vaclav.core.display.BitmapUtil;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;

	public class BarSkin extends Skin implements IBarSkin {


		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;
		protected var _guideBD:BitmapData;
		protected var _backBD:BitmapData;

		private var _oldPaddingTop:Number;
		private var _oldPaddingBottom:Number;
		private var _oldPaddingLeft:Number;
		private var _oldPaddingRight:Number;



		public function BarSkin(id:String = null) {
			super(SkinType.BAR, id);

			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;

			_guideBD = new BitmapData(1, 1, true, 0x00000000);
			_backBD = new BitmapData(1, 1, true, 0x00000000);
		}



		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 2 !== 0) throw new Error('Width has to be multiple of 2');

			_assetWidth = source.width / 2;
			_assetHeight = source.height;

			_guideBD = BitmapUtil.crop(source, 0, 0, _assetWidth, _assetHeight);
			_backBD = BitmapUtil.crop(source, _assetWidth, 0, _assetWidth, _assetHeight);
		}



		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			_getSkinSize(source, (labels[1] === undefined || labels[1] === '') ? 'guide' : labels[1]);

			_backBD = _getSkinFrame(source, elements, (labels[0] === undefined || labels[0] === '') ? 'back' : labels[0]);
			_guideBD = _getSkinFrame(source, elements, (labels[1] === undefined || labels[1] === '') ? 'guide' : labels[1]);
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldPaddingTop = _paddingTop;
			_oldPaddingBottom = _paddingBottom;
			_oldPaddingLeft = _paddingLeft;
			_oldPaddingRight = _paddingRight;

			if(source.paddingTop !== undefined) _paddingTop = source.paddingTop;
			if(source.paddingBottom !== undefined) _paddingBottom = source.paddingBottom;
			if(source.paddingLeft !== undefined) _paddingLeft = source.paddingLeft;
			if(source.paddingRight !== undefined) _paddingRight = source.paddingRight;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_paddingTop = _oldPaddingTop;
			_paddingBottom = _oldPaddingBottom;
			_paddingLeft = _oldPaddingLeft;
			_paddingRight = _oldPaddingRight;
		}



		public function get paddingTop():Number {
			return _paddingTop;
		}



		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		public function get paddingBottom():Number {
			return _paddingBottom;
		}



		public function set paddingBottom(value:Number):void {
			_paddingBottom = value;
		}



		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		public function get paddingRight():Number {
			return _paddingRight;
		}



		public function set paddingRight(value:Number):void {
			_paddingRight = value;
		}



		public function set guideBD(source:BitmapData):void {
			_checkSize(source);
			_guideBD = source;
		}



		public function get guideBD():BitmapData {
			return _guideBD;
		}



		public function set backBD(source:BitmapData):void {
			_checkSize(source);
			_backBD = source;
		}



		public function get backBD():BitmapData {
			return _backBD;
		}
	}
}
