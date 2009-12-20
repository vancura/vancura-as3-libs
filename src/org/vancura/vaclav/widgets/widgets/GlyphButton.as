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
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IGlyphButton;
	import org.vancura.vaclav.widgets.interfaces.IGlyphButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IImage;

	public class GlyphButton extends MorphSprite implements IGlyphButton {


		protected var _skin:IGlyphButtonSkin;
		protected var _button:ScaleButton;
		protected var _glyphOut:Image;
		protected var _glyphHover:Image;
		protected var _glyphFocus:Image;

		private var _debugLevel:String;


		//noinspection FunctionTooLongJS
		public function GlyphButton(skin:IGlyphButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object;

			if(config === null) c = new Object();
			else c = config;

			var dl:String = (debugLevel === null) ? SkinManager.debugLevel : debugLevel;

			_button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			_glyphOut = new Image(skin.glyphsSkin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dl);
			_glyphHover = new Image(skin.glyphsSkin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			_glyphFocus = new Image(skin.glyphsSkin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			_button.debugColor = SkinManager.debugColor;
			_glyphOut.debugColor = SkinManager.debugColor;
			_glyphHover.debugColor = SkinManager.debugColor;
			_glyphFocus.debugColor = SkinManager.debugColor;

			this.skin = skin;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;

			_button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, _onButtonHoverInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, _onButtonHoverOutTween, false, 0, true);
			_button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, _onButtonFocusInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, _onButtonDragConfirmedTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, _onButtonReleasedInsideTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, _onButtonReleasedOutsideTween, false, 0, true);

			if(c.width === undefined) c.width = skin.buttonSkin.assetWidth;
			if(c.height === undefined) c.height = skin.buttonSkin.assetHeight;

			if(skin !== null) super(c, parent);
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

			removeChildren(this, _button, _glyphOut, _glyphHover, _glyphFocus);

			_button.destroy();
			_glyphOut.destroy();
			_glyphHover.destroy();
			_glyphFocus.destroy();
		}



		public function draw():void {
			_button.draw();
			_glyphOut.draw();
			_glyphHover.draw();
			_glyphFocus.draw();
		}



		public function forceRelease():void {
			_button.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		public function get skin():IGlyphButtonSkin {
			return _skin;
		}



		public function set skin(skin:IGlyphButtonSkin):void {
			_skin = skin;

			_button.skin = _skin.buttonSkin;
			_glyphOut.skin = _skin.glyphsSkin.glyphOutSkin;
			_glyphHover.skin = _skin.glyphsSkin.glyphHoverSkin;
			_glyphFocus.skin = _skin.glyphsSkin.glyphFocusSkin;

			draw();
		}



		override public function get width():Number {
			return _button.width;
		}



		override public function set width(value:Number):void {
			_button.width = value;
			_glyphOut.x = Math.round((value - _glyphOut.width) / 2);
			_glyphHover.x = Math.round((value - _glyphHover.width) / 2);
			_glyphFocus.x = Math.round((value - _glyphFocus.width) / 2);

			draw();
		}



		override public function get height():Number {
			return _button.height;
		}



		override public function set height(value:Number):void {
			_button.height = value;
			_glyphOut.y = Math.round((value - _glyphOut.height) / 2);
			_glyphHover.y = Math.round((value - _glyphHover.height) / 2);
			_glyphFocus.y = Math.round((value - _glyphFocus.height) / 2);

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
			_glyphOut.debugLevel = value;
			_glyphHover.debugLevel = value;
			_glyphFocus.debugLevel = value;
		}



		public function get glyph():IImage {
			var out:IImage;

			if(_button.mouseStatus === MouseStatus.OUT) out = _glyphOut;
			if(_button.mouseStatus === MouseStatus.HOVER) out = _glyphHover;
			if(_button.mouseStatus === MouseStatus.FOCUS) out = _glyphFocus;

			return out;
		}



		public function get glyphOut():IImage {
			return _glyphOut;
		}



		public function get glyphHover():IImage {
			return _glyphHover;
		}



		public function get glyphFocus():IImage {
			return _glyphFocus;
		}



		public function get button():IButton {
			return _button;
		}



		private function _onButtonHoverInTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonHoverOutTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphOut, _skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphHover, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphFocus, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonFocusInTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphOut, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphHover, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphFocus, _skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}



		private function _onButtonDragConfirmedTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonReleasedInsideTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphOut, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphHover, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		private function _onButtonReleasedOutsideTween(event:ButtonEvent):void {
			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphOut, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphHover, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			//noinspection ObjectAllocationIgnored
			new TweenMax(_glyphFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
