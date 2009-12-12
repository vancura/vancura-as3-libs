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
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	import org.bytearray.display.ScaleBitmap;
	import org.vancura.vaclav.core.GraphicsUtil;
	import org.vancura.vaclav.core.addChildren;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class ScaleButton extends ButtonCore implements IWidget, IButton {


		private var _outSBM:ScaleBitmap;
		private var _hoverSBM:ScaleBitmap;
		private var _focusSBM:ScaleBitmap;



		public function ScaleButton(skin:IButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			if(config == null) {
				config = new Object();
			}

			super(skin, config, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
		}



		override protected function $init():void {
			super.$init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function $addChildren():void {
			super.$addChildren();

			_outSBM = new ScaleBitmap();
			_hoverSBM = new ScaleBitmap();
			_focusSBM = new ScaleBitmap();

			_hoverSBM.alpha = 0;
			_focusSBM.alpha = 0;

			addChildren($contentSpr, _outSBM, _hoverSBM, _focusSBM);
		}



		override protected function $removeChildren():void {
			super.$removeChildren();

			removeChildren($contentSpr, _outSBM, _hoverSBM, _focusSBM);
		}



		override public function draw():void {
			super.draw();

			_outSBM.bitmapData = $skin.outBD;
			_hoverSBM.bitmapData = $skin.hoverBD;
			_focusSBM.bitmapData = $skin.focusBD;

			var rect:Rectangle = $skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false);
			_outSBM.scale9Grid = rect;
			_hoverSBM.scale9Grid = rect;
			_focusSBM.scale9Grid = rect;

			if($width != 0) {
				_outSBM.width = $width;
				_hoverSBM.width = $width;
				_focusSBM.width = $width;
			}
			if($height != 0) {
				_outSBM.height = $height;
				_hoverSBM.height = $height;
				_focusSBM.height = $height;
			}

			$activeSpr.graphics.clear();
			GraphicsUtil.drawRect($activeSpr, 0, 0, $width, $height);
		}



		override protected function $hoverInTween():void {
			new TweenMax(_outSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.$hoverInTween();
		}



		override protected function $hoverOutTween():void {
			new TweenMax(_outSBM, $skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverSBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusSBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super.$hoverOutTween();
		}



		override protected function $focusInTween():void {
			new TweenMax(_outSBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusSBM, $skin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			super.$focusInTween();
		}



		override protected function $dragConfirmedTween():void {
			new TweenMax(_outSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.$dragConfirmedTween();
		}



		override protected function $releasedInsideTween():void {
			new TweenMax(_outSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.$releasedInsideTween();
		}



		override protected function $releasedOutsideTween():void {
			new TweenMax(_outSBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.$releasedOutsideTween();
		}
	}
}
