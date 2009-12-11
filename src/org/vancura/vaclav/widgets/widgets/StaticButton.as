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
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.GraphicsUtil;
	import org.vancura.vaclav.core.QBitmap;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class StaticButton extends ButtonCore implements IWidget, IButton {


		private var _outBM:QBitmap;
		private var _hoverBM:QBitmap;
		private var _focusBM:QBitmap;



		public function StaticButton(skin:IButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                             debugLevel:String = null) {

			if(config == null) config = new Object();

			super(skin, config, parent, (debugLevel != null) ? debugLevel : SkinManager.debugLevel);
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

			_outBM = new QBitmap({}, $contentSpr);
			_hoverBM = new QBitmap({alpha:0}, $contentSpr);
			_focusBM = new QBitmap({alpha:0}, $contentSpr);
		}



		override protected function $removeChildren():void {
			super.$removeChildren();

			removeChildren($contentSpr, _outBM, _hoverBM, _focusBM);
		}



		override public function draw():void {
			super.draw();

			_outBM.bitmapData = $skin.outBD;
			_hoverBM.bitmapData = $skin.hoverBD;
			_focusBM.bitmapData = $skin.focusBD;

			$activeSpr.graphics.clear();
			GraphicsUtil.drawRect($activeSpr, 0, 0, $skin.assetWidth, $skin.assetHeight);
		}



		override protected function $hoverInTween():void {
			new TweenMax(_outBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.$hoverInTween();
		}



		override protected function $hoverOutTween():void {
			new TweenMax(_outBM, $skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super.$hoverOutTween();
		}



		override protected function $focusInTween():void {
			new TweenMax(_outBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusBM, $skin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			super.$focusInTween();
		}



		override protected function $dragConfirmedTween():void {
			new TweenMax(_outBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.$dragConfirmedTween();
		}



		override protected function $releasedInsideTween():void {
			new TweenMax(_outBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.$releasedInsideTween();
		}



		override protected function $releasedOutsideTween():void {
			new TweenMax(_outBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_focusBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.$releasedOutsideTween();
		}
	}
}
