/***********************************************************************************************************************
 * Copyright (c) 2010. Vaclav Vancura.
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
	import br.com.stimuli.string.printf;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	import org.vancura.vaclav.core.display.GraphicsUtil;
	import org.vancura.vaclav.core.display.QSprite;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;

	public class ButtonCore extends Widget implements IWidget, IButton {


		private static var _currentDrag:ButtonCore;

		protected var _skin:IButtonSkin;
		protected var _activeSpr:QSprite;

		private var _mouseStatus:String;
		private var _areEventsEnabled:Boolean = true;



		public function ButtonCore(skin:IButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			if(c.width == undefined) c.width = skin.assetWidth;
			if(c.height == undefined) c.height = skin.assetHeight;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error('No skin defined');

			this.skin = skin;

			_mouseStatus = MouseStatus.OUT;
		}



		override protected function _init():void {
			super._init();

			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
		}



		override protected function _addChildren():void {
			super._addChildren();

			_activeSpr = new QSprite({alpha:0}, _contentSpr);

			_activeSpr.addEventListener(MouseEvent.MOUSE_OVER, _onOver, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_OUT, _onOut, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, _onFocus, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);

			GraphicsUtil.drawRect(_activeSpr);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			removeChildren(_contentSpr, _activeSpr);
		}



		public function forceRelease():void {
			if(_mouseStatus == MouseStatus.FOCUS) {
				_currentDrag = null;
				_mouseStatus = MouseStatus.OUT;

				_releasedOutsideTween();

				var e:ButtonEvent = new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true);
				dispatchEvent(e);
			}
		}



		public static function releaseAll():void {
			for each(var b:IWidget in _allWidgets) {
				if(b is ButtonCore) {
					(b as ButtonCore).forceRelease();
				}
			}
		}



		public function get skin():IButtonSkin {
			return _skin;
		}



		public function set skin(skin:IButtonSkin):void {
			_skin = skin as ButtonSkin;

			if(_width == 0) _width = _skin.assetWidth;
			if(_height == 0) _height = _skin.assetHeight;

			if(_skin.assetWidth != 0 && _skin.assetHeight != 0) {
				setSize(_skin.assetWidth, _skin.assetHeight);
			}
		}



		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;

			_activeSpr.mouseEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;

			if(!value) {
				forceRelease();
			}
		}



		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}



		public function get mouseStatus():String {
			return _mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			switch(value) {
				case MouseStatus.OUT:
					_onOut();
					break;

				case MouseStatus.HOVER:
					_onOver();
					break;

				case MouseStatus.FOCUS:
					_onFocus();
					break;

				default:
					var message:String = printf('Unknown mouse status (%s)', value);
					throw new Error(message);
			}
		}



		protected function _hoverInTween():void {
			var e:ButtonEvent = new ButtonEvent(ButtonEvent.HOVER_IN_TWEEN, true);
			dispatchEvent(e);

			// duration: _skin.hoverInDuration
			// out -> hidden, sineIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function _hoverOutTween():void {
			var e:ButtonEvent = new ButtonEvent(ButtonEvent.HOVER_OUT_TWEEN, true);
			dispatchEvent(e);

			// duration: _skin.hoverOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		protected function _focusInTween():void {
			var e:ButtonEvent = new ButtonEvent(ButtonEvent.FOCUS_IN_TWEEN, true);
			dispatchEvent(e);

			// duration: _skin.focusInDuration
			// out -> hidden, easeIn
			// hover -> hidden, easeIn
			// focus -> visible, easeOut
		}



		protected function _dragConfirmedTween():void {
			var e:ButtonEvent = new ButtonEvent(ButtonEvent.DRAG_CONFIRMED_TWEEN, true);
			dispatchEvent(e);

			// duration: _skin.hoverInDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function _releasedInsideTween():void {
			var e:ButtonEvent = new ButtonEvent(ButtonEvent.RELEASED_INSIDE_TWEEN, true);
			dispatchEvent(e);

			// duration: _skin.focusOutDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function _releasedOutsideTween():void {
			var e:ButtonEvent = new ButtonEvent(ButtonEvent.RELEASED_OUTSIDE_TWEEN, true);
			dispatchEvent(e);

			// duration: _skin.focusOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		private function _onOver(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag over
					var e1:ButtonEvent = new ButtonEvent(ButtonEvent.DRAG_OVER, true);
					dispatchEvent(e1);
				}
				else {
					// roll over
					_mouseStatus = MouseStatus.HOVER;

					_hoverInTween();

					var e2:ButtonEvent = new ButtonEvent(ButtonEvent.HOVER_IN, true);
					dispatchEvent(e2);
				}
			}
		}



		private function _onOut(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag out
					var e1:ButtonEvent = new ButtonEvent(ButtonEvent.DRAG_OUT, true);
					dispatchEvent(e1);
				}
				else {
					// roll out
					_mouseStatus = MouseStatus.OUT;

					_hoverOutTween();

					var e2:ButtonEvent = new ButtonEvent(ButtonEvent.HOVER_OUT, true);
					dispatchEvent(e2);
				}
			}
		}



		private function _onFocus(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				_mouseStatus = MouseStatus.FOCUS;
				_currentDrag = this;

				_focusInTween();

				if(stage != null) stage.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);

				var e:ButtonEvent = new ButtonEvent(ButtonEvent.FOCUS_IN, true);
				dispatchEvent(e);
			}
		}



		private function _onRelease(event:MouseEvent = null):void {
			if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);

			if(_areEventsEnabled && _mouseStatus == MouseStatus.FOCUS) {
				if(event != null && event.currentTarget == stage) {
					// release outside
					forceRelease();
				}

				else if(_currentDrag != this) {
					// drag confirm
					_dragConfirmedTween();

					var e1:ButtonEvent = new ButtonEvent(ButtonEvent.DRAG_CONFIRM, true);
					dispatchEvent(e1);
				}

				else {
					// release inside
					_currentDrag = null;

					_releasedInsideTween();

					var e2:ButtonEvent = new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true);
					dispatchEvent(e2);
				}

				var e3:MouseEvent = new MouseEvent(MouseEvent.MOUSE_UP, true);
				dispatchEvent(e3);
			}
		}
	}
}
