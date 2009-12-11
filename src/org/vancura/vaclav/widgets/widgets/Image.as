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

package org.vancura.vaclav.widgets.widgets {
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.addChildren;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IImage;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	public class Image extends Widget implements IImage {


		protected var $skin:IImageSkin;
		protected var $imageBM:Bitmap;



		public function Image(skin:IImageSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {

			if(config == null) {
				config = new Object();
			}

			if(config.width == undefined) {
				config.width = skin.assetWidth;
			}

			if(config.height == undefined) {
				config.height = skin.assetHeight;
			}

			if(skin == null) {
				throw new Error('No skin defined');
			}
			else {
				super(config, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			}

			this.skin = skin;
		}



		override protected function $init():void {
			super.$init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		override protected function $addChildren():void {
			super.$addChildren();

			$imageBM = new Bitmap();

			addChildren($contentSpr, $imageBM);
		}



		override protected function $removeChildren():void {
			super.$removeChildren();

			removeChildren($contentSpr, $imageBM);
		}



		override public function draw():void {
			super.draw();

			$imageBM.bitmapData = $skin.imageBD;
			$imageBM.smoothing = true;
			$imageBM.x = $skin.paddingLeft;
			$imageBM.y = $skin.paddingTop;
		}



		public function get skin():IImageSkin {
			return $skin;
		}



		public function set skin(skin:IImageSkin):void {
			$skin = skin;

			if($width == 0) {
				$width = $skin.assetWidth;
			}

			if($height == 0) {
				$height = $skin.assetHeight;
			}

			draw();
		}



		public function get bitmap():Bitmap {
			return $imageBM;
		}
	}
}
