/***********************************************************************************************************************
 * Some methods Copyrighted by their authors, specified in ASDocs.
 * If not specified elsewhere: Copyright (c) 2010 Vaclav Vancura.
 *
 * Contact me at vaclav@vancura.org, @vancura or at my homepage at http://vaclav.vancura.org.
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Licensed under Attribution 3.0 Czech Republic (http://creativecommons.org/licenses/by/3.0/cz/deed.en_GB).
 *
 * That means you are free:
 * * to copy, distribute, display, and perform the work
 * * to make derivative works
 *
 * Under the following conditions::
 * * Attribution Ñ You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver Ñ Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights Ñ In no way are any of the following rights affected by the license:
 * 	        - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
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
