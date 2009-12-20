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
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.global.addChildren;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IImage;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	public class Image extends Widget implements IImage {


		protected var _skin:IImageSkin;
		protected var _imageBM:Bitmap;



		public function Image(skin:IImageSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			if(c.width == undefined) {
				c.width = skin.assetWidth;
			}

			if(c.height == undefined) {
				c.height = skin.assetHeight;
			}

			if(skin != null) super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error('No skin defined');

			this.skin = skin;
		}



		override protected function _init():void {
			super._init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		override protected function _addChildren():void {
			super._addChildren();

			_imageBM = new Bitmap();

			addChildren(_contentSpr, _imageBM);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			removeChildren(_contentSpr, _imageBM);
		}



		override public function draw():void {
			super.draw();

			_imageBM.bitmapData = _skin.imageBD;
			_imageBM.smoothing = true;
			_imageBM.x = _skin.paddingLeft;
			_imageBM.y = _skin.paddingTop;
		}



		public function get skin():IImageSkin {
			return _skin;
		}



		public function set skin(skin:IImageSkin):void {
			_skin = skin;

			if(_width == 0) _width = _skin.assetWidth;
			if(_height == 0) _height = _skin.assetHeight;

			draw();
		}



		public function get bitmap():Bitmap {
			return _imageBM;
		}
	}
}
