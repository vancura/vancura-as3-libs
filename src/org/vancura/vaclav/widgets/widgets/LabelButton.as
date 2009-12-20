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

	import org.vancura.vaclav.core.display.MorphSprite;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.ILabelButton;
	import org.vancura.vaclav.widgets.interfaces.ILabelButtonSkin;

	public class LabelButton extends MorphSprite implements ILabelButton {


		protected var _skin:ILabelButtonSkin;
		protected var _button:ScaleButton;
		protected var _labelOut:Label;
		protected var _labelHover:Label;
		protected var _labelFocus:Label;

		private var _debugLevel:String;


		//noinspection FunctionTooLongJS
		public function LabelButton(skin:ILabelButtonSkin, config:Object = null, text:String = '', parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			c = config;

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			_labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, '', this, dl);
			_labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, '', this, dl);
			_labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, '', this, dl);
			_button.debugColor = SkinManager.debugColor;
			_labelOut.debugColor = SkinManager.debugColor;
			_labelHover.debugColor = SkinManager.debugColor;
			_labelFocus.debugColor = SkinManager.debugColor;

			this.skin = skin;
			this.text = text;
			this.focusRect = false;
			this.tabEnabled = false;

			_button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, _onButtonHoverInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, _onButtonHoverOutTween, false, 0, true);
			_button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, _onButtonFocusInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, _onButtonDragConfirmedTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, _onButtonReleasedInsideTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, _onButtonReleasedOutsideTween, false, 0, true);

			if(c.width == undefined) c.width = skin.buttonSkin.assetWidth;
			if(c.height == undefined) c.height = skin.buttonSkin.assetHeight;

			if(skin != null) super(c, parent);
			else throw new Error('No skin defined');

			_skin = skin;
		}



		public function destroy():void {
			_button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, _onButtonHoverInTween);
			_button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, _onButtonHoverOutTween);
			_button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, _onButtonFocusInTween);
			_button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, _onButtonDragConfirmedTween);
			_button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, _onButtonReleasedInsideTween);
			_button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, _onButtonReleasedOutsideTween);

			removeChildren(this, _button, _labelOut, _labelHover, _labelFocus);

			_button.destroy();
			_labelOut.destroy();
			_labelHover.destroy();
			_labelFocus.destroy();
		}



		public function draw():void {
			_button.draw();
			_labelOut.draw();
			_labelHover.draw();
			_labelFocus.draw();
		}



		public function forceRelease():void {
			_button.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		public function get skin():ILabelButtonSkin {
			return _skin;
		}



		public function set skin(skin:ILabelButtonSkin):void {
			_skin = skin;

			_skin.labelOutSkin.hAlign = Align.CENTER;
			_skin.labelHoverSkin.hAlign = Align.CENTER;
			_skin.labelFocusSkin.hAlign = Align.CENTER;

			_button.skin = _skin.buttonSkin;
			_labelOut.skin = _skin.labelOutSkin;
			_labelHover.skin = _skin.labelHoverSkin;
			_labelFocus.skin = _skin.labelFocusSkin;

			draw();
		}



		override public function get width():Number {
			return _button.width;
		}



		override public function set width(value:Number):void {
			_button.width = value;
			_labelOut.width = value;
			_labelHover.width = value;
			_labelFocus.width = value;

			draw();
		}



		override public function get height():Number {
			return _button.height;
		}



		override public function set height(value:Number):void {
			_button.height = value;
			_labelOut.y = Math.round((value - _labelOut.height) / 2);
			_labelHover.y = Math.round((value - _labelHover.height) / 2);
			_labelFocus.y = Math.round((value - _labelFocus.height) / 2);

			draw();
		}



		public function set areEventsEnabled(value:Boolean):void {
			_button.areEventsEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;

			draw();
		}



		public function get areEventsEnabled():Boolean {
			return _button.areEventsEnabled;
		}



		public function get mouseStatus():String {
			return _button.mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			_button.mouseStatus = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;
			_button.debugLevel = value;
			_labelOut.debugLevel = value;
			_labelHover.debugLevel = value;
			_labelFocus.debugLevel = value;
		}



		public function get text():String {
			return _labelOut.text;
		}



		public function set text(value:String):void {
			_labelOut.text = value;
			_labelHover.text = value;
			_labelFocus.text = value;

			draw();
		}



		public function get label():ILabel {
			var out:ILabel;

			if(_button.mouseStatus == MouseStatus.OUT) out = _labelOut;
			if(_button.mouseStatus == MouseStatus.HOVER) out = _labelHover;
			if(_button.mouseStatus == MouseStatus.FOCUS) out = _labelFocus;

			return out;
		}



		public function get labelOut():ILabel {
			return _labelOut;
		}



		public function get labelHover():ILabel {
			return _labelHover;
		}



		public function get labelFocus():ILabel {
			return _labelFocus;
		}



		public function get button():IButton {
			return _button;
		}



		private function _onButtonHoverInTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonHoverOutTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelOut, _skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelHover, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelFocus, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonFocusInTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelOut, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelHover, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelFocus, _skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}



		private function _onButtonDragConfirmedTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonReleasedInsideTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelOut, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelHover, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonReleasedOutsideTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelOut, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelHover, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_labelFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
