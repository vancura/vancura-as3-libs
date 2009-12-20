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

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;

	import org.bytearray.display.ScaleBitmap;
	import org.vancura.vaclav.core.global.addChildren;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IBar;
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;

	public class Bar extends Widget implements IBar {


		protected var _skin:IBarSkin;
		protected var _bodySBM:ScaleBitmap;



		public function Bar(skin:IBarSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config === null) c = new Object();
			else c = config;

			if(c.width === undefined) c.width = skin.assetWidth;
			if(c.height === undefined) c.height = skin.assetHeight;

			if(skin !== null) super(c, parent, (debugLevel === null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error('No skin defined');

			this.skin = skin;
		}



		override protected function _init():void {
			super._init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function _addChildren():void {
			super._addChildren();

			_bodySBM = new ScaleBitmap();

			addChildren(_contentSpr, _bodySBM);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			removeChildren(_contentSpr, _bodySBM);
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function draw():void {
			super.draw();

			_bodySBM.bitmapData = _skin.backBD;
			_bodySBM.scale9Grid = _skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false);

			if(_width !== 0 && !isNaN(_width)) {
				_bodySBM.width = _width - _skin.paddingLeft - _skin.paddingRight;
				_bodySBM.x = _skin.paddingLeft;
			}
			if(_height !== 0 && !isNaN(_height)) {
				_bodySBM.height = _height - _skin.paddingTop - _skin.paddingBottom;
				_bodySBM.y = _skin.paddingTop;
			}
		}



		public function get skin():IBarSkin {
			return _skin;
		}



		public function set skin(skin:IBarSkin):void {
			_skin = skin;

			if(_width === 0) _width = _skin.assetWidth;
			if(_height === 0) _height = _skin.assetHeight;

			draw();
		}



		override public function get width():Number {
			return _width + _skin.paddingLeft + _skin.paddingRight;
		}



		override public function get height():Number {
			return _height + _skin.paddingTop + _skin.paddingBottom;
		}
	}
}
