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

package org.vancura.vaclav.widgets.widgets {
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.display.QBitmap;
	import org.vancura.vaclav.core.utils.DisplayUtils;
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
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			super(skin, c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
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

			_outBM = new QBitmap({}, _contentSpr);
			_hoverBM = new QBitmap({alpha:0}, _contentSpr);
			_focusBM = new QBitmap({alpha:0}, _contentSpr);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _outBM, _hoverBM, _focusBM);
		}



		override public function draw():void {
			super.draw();

			_activeSpr.setSize(_width, _height);
		}



		override protected function _hoverInTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super._hoverInTween();
		}



		override protected function _hoverOutTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outBM, _skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super._hoverOutTween();
		}



		override protected function _focusInTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusBM, _skin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			super._focusInTween();
		}



		override protected function _dragConfirmedTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super._dragConfirmedTween();
		}



		override protected function _releasedInsideTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super._releasedInsideTween();
		}



		override protected function _releasedOutsideTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super._releasedOutsideTween();
		}



		override public function set skin(skin:IButtonSkin):void {
			super.skin = skin;

			_outBM.bitmapData = _skin.outBD;
			_hoverBM.bitmapData = _skin.hoverBD;
			_focusBM.bitmapData = _skin.focusBD;

			draw();
		}
	}
}
