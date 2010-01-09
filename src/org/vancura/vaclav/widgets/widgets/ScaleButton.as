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
	import com.destroytoday.display.Scale9Bitmap;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	import org.vancura.vaclav.core.utils.DisplayUtils;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class ScaleButton extends ButtonCore implements IWidget, IButton {


		private var _outSBM:Scale9Bitmap;
		private var _hoverSBM:Scale9Bitmap;
		private var _focusSBM:Scale9Bitmap;



		public function ScaleButton(skin:IButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			super(skin, c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
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

			_outSBM = new Scale9Bitmap();
			_hoverSBM = new Scale9Bitmap();
			_focusSBM = new Scale9Bitmap();

			_hoverSBM.alpha = 0;
			_focusSBM.alpha = 0;

			_outSBM.mouseEnabled = false;
			_hoverSBM.mouseEnabled = false;
			_focusSBM.mouseEnabled = false;

			DisplayUtils.addChildren(_contentSpr, _outSBM, _hoverSBM, _focusSBM);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _outSBM, _hoverSBM, _focusSBM);
		}



		override public function draw():void {
			super.draw();

			if(_width != 0) {
				_outSBM.width = _width;
				_hoverSBM.width = _width;
				_focusSBM.width = _width;
			}
			if(_height != 0) {
				_outSBM.height = _height;
				_hoverSBM.height = _height;
				_focusSBM.height = _height;
			}

			_activeSpr.setSize(_width, _height);
		}



		override protected function _hoverInTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outSBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverSBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusSBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super._hoverInTween();
		}



		override protected function _hoverOutTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outSBM, _skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverSBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusSBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super._hoverOutTween();
		}



		override protected function _focusInTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outSBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverSBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusSBM, _skin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			super._focusInTween();
		}



		override protected function _dragConfirmedTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outSBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverSBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusSBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super._dragConfirmedTween();
		}



		override protected function _releasedInsideTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outSBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverSBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusSBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super._releasedInsideTween();
		}



		override protected function _releasedOutsideTween():void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_outSBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_hoverSBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_focusSBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super._releasedOutsideTween();
		}



		override public function set skin(skin:IButtonSkin):void {
			super.skin = skin;

			var rect:Rectangle = _skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false);

			_outSBM.setup(_skin.outBD, rect);
			_hoverSBM.setup(_skin.hoverBD, rect);
			_focusSBM.setup(_skin.focusBD, rect);

			draw();
		}
	}
}
