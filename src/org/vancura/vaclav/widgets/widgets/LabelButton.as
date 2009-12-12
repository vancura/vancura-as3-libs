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

	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.ILabelButton;
	import org.vancura.vaclav.widgets.interfaces.ILabelButtonSkin;

	public class LabelButton extends MorphSprite implements ILabelButton {


		protected var $skin:ILabelButtonSkin;
		protected var $button:ScaleButton;
		protected var $labelOut:Label;
		protected var $labelHover:Label;
		protected var $labelFocus:Label;

		private var _debugLevel:String;



		public function LabelButton(skin:ILabelButtonSkin, config:Object = null, text:String = '', parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {

			if(config == null) {
				config = new Object();
			}

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			$button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			$labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$button.debugColor = SkinManager.debugColor;
			$labelOut.debugColor = SkinManager.debugColor;
			$labelHover.debugColor = SkinManager.debugColor;
			$labelFocus.debugColor = SkinManager.debugColor;

			this.skin = skin;
			this.text = text;
			this.focusRect = false;
			this.tabEnabled = false;

			$button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, _onButtonHoverInTween, false, 0, true);
			$button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, _onButtonHoverOutTween, false, 0, true);
			$button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, _onButtonFocusInTween, false, 0, true);
			$button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, _onButtonDragConfirmedTween, false, 0, true);
			$button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, _onButtonReleasedInsideTween, false, 0, true);
			$button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, _onButtonReleasedOutsideTween, false, 0, true);

			if(config.width == undefined) {
				config.width = skin.buttonSkin.assetWidth;
			}

			if(config.height == undefined) {
				config.height = skin.buttonSkin.assetHeight;
			}

			if(skin != null) {
				super(config, parent);
			}
			else {
				throw new Error('No skin defined');
			}

			$skin = skin;
		}



		public function destroy():void {
			$button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, _onButtonHoverInTween);
			$button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, _onButtonHoverOutTween);
			$button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, _onButtonFocusInTween);
			$button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, _onButtonDragConfirmedTween);
			$button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, _onButtonReleasedInsideTween);
			$button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, _onButtonReleasedOutsideTween);

			removeChildren(this, $button, $labelOut, $labelHover, $labelFocus);

			$button.destroy();
			$labelOut.destroy();
			$labelHover.destroy();
			$labelFocus.destroy();
		}



		public function draw():void {
			$button.draw();
			$labelOut.draw();
			$labelHover.draw();
			$labelFocus.draw();
		}



		public function forceRelease():void {
			$button.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		public function get skin():ILabelButtonSkin {
			return $skin;
		}



		public function set skin(skin:ILabelButtonSkin):void {
			$skin = skin;

			$skin.labelOutSkin.hAlign = Align.CENTER;
			$skin.labelHoverSkin.hAlign = Align.CENTER;
			$skin.labelFocusSkin.hAlign = Align.CENTER;

			$button.skin = $skin.buttonSkin;
			$labelOut.skin = $skin.labelOutSkin;
			$labelHover.skin = $skin.labelHoverSkin;
			$labelFocus.skin = $skin.labelFocusSkin;

			draw();
		}



		override public function get width():Number {
			return $button.width;
		}



		override public function set width(value:Number):void {
			$button.width = value;
			$labelOut.width = value;
			$labelHover.width = value;
			$labelFocus.width = value;

			draw();
		}



		override public function get height():Number {
			return $button.height;
		}



		override public function set height(value:Number):void {
			$button.height = value;
			$labelOut.y = Math.round((value - $labelOut.height) / 2);
			$labelHover.y = Math.round((value - $labelHover.height) / 2);
			$labelFocus.y = Math.round((value - $labelFocus.height) / 2);

			draw();
		}



		public function set areEventsEnabled(value:Boolean):void {
			$button.areEventsEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;

			draw();
		}



		public function get areEventsEnabled():Boolean {
			return $button.areEventsEnabled;
		}



		public function get mouseStatus():String {
			return $button.mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			$button.mouseStatus = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;
			$button.debugLevel = value;
			$labelOut.debugLevel = value;
			$labelHover.debugLevel = value;
			$labelFocus.debugLevel = value;
		}



		public function get text():String {
			return $labelOut.text;
		}



		public function set text(value:String):void {
			$labelOut.text = value;
			$labelHover.text = value;
			$labelFocus.text = value;

			draw();
		}



		public function get label():ILabel {
			if($button.mouseStatus == MouseStatus.OUT) {
				return $labelOut;
			}
			if($button.mouseStatus == MouseStatus.HOVER) {
				return $labelHover;
			}
			if($button.mouseStatus == MouseStatus.FOCUS) {
				return $labelFocus;
			}

			return null;
		}



		public function get labelOut():ILabel {
			return $labelOut;
		}



		public function get labelHover():ILabel {
			return $labelHover;
		}



		public function get labelFocus():ILabel {
			return $labelFocus;
		}



		public function get button():IButton {
			return $button;
		}



		private function _onButtonHoverInTween(event:ButtonEvent):void {
			new TweenMax($labelOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonHoverOutTween(event:ButtonEvent):void {
			new TweenMax($labelOut, $skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelHover, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelFocus, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonFocusInTween(event:ButtonEvent):void {
			new TweenMax($labelOut, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelFocus, $skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}



		private function _onButtonDragConfirmedTween(event:ButtonEvent):void {
			new TweenMax($labelOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonReleasedInsideTween(event:ButtonEvent):void {
			new TweenMax($labelOut, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonReleasedOutsideTween(event:ButtonEvent):void {
			new TweenMax($labelOut, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelHover, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
