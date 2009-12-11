/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the ÒSoftwareÓ), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED ÒAS ISÓ, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.widgets {
	import br.com.stimuli.string.printf;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	import org.vancura.vaclav.core.QSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;

	public class ButtonCore extends Widget implements IWidget, IButton {


		private static var _currentDrag:ButtonCore;

		protected var $skin:IButtonSkin;
		protected var $activeSpr:QSprite;

		private var _mouseStatus:String;
		private var _areEventsEnabled:Boolean = true;



		public function ButtonCore(skin:IButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                           debugLevel:String = null) {

			if(config == null) {
				config = new Object();
			}

			if(config.width == undefined) {
				config.width = skin.assetWidth;
			}

			if(config.height == undefined) {
				config.height = skin.assetHeight;
			}

			if(skin != null) {
				super(config, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			}
			else {
				throw new Error('No skin defined');
			}

			this.skin = skin;

			_mouseStatus = MouseStatus.OUT;
		}



		override protected function $init():void {
			super.$init();

			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
		}



		override protected function $addChildren():void {
			super.$addChildren();

			$activeSpr = new QSprite({alpha:0}, $contentSpr);

			$activeSpr.addEventListener(MouseEvent.MOUSE_OVER, _onOver, false, 0, true);
			$activeSpr.addEventListener(MouseEvent.MOUSE_OUT, _onOut, false, 0, true);
			$activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, _onFocus, false, 0, true);
			$activeSpr.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
		}



		override protected function $removeChildren():void {
			super.$removeChildren();

			removeChildren($contentSpr, $activeSpr);
		}



		public function forceRelease():void {
			if(_mouseStatus == MouseStatus.FOCUS) {
				_currentDrag = null;
				_mouseStatus = MouseStatus.OUT;

				$releasedOutsideTween();

				dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true));
			}
		}



		public static function releaseAll():void {
			for each(var b:IWidget in $allWidgets) {
				if(b is ButtonCore) {
					(b as ButtonCore).forceRelease();
				}
			}
		}



		public function get skin():IButtonSkin {
			return $skin;
		}



		public function set skin(skin:IButtonSkin):void {
			$skin = skin as ButtonSkin;

			if($width == 0) {
				$width = $skin.assetWidth;
			}

			if($height == 0) {
				$height = $skin.assetHeight;
			}

			if($skin.assetWidth != 0 && $skin.assetHeight != 0) {
				setSize($skin.assetWidth, $skin.assetHeight);
			}

			draw();
		}



		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;

			$activeSpr.mouseEnabled = value;
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
					throw new Error(printf('Unknown mouse status (%s)', value));
			}
		}



		protected function $hoverInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN_TWEEN, true));

			// duration: $skin.hoverInDuration
			// out -> hidden, sineIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function $hoverOutTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT_TWEEN, true));

			// duration: $skin.hoverOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		protected function $focusInTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN_TWEEN, true));

			// duration: $skin.focusInDuration
			// out -> hidden, easeIn
			// hover -> hidden, easeIn
			// focus -> visible, easeOut
		}



		protected function $dragConfirmedTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRMED_TWEEN, true));

			// duration: $skin.hoverInDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function $releasedInsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_INSIDE_TWEEN, true));

			// duration: $skin.focusOutDuration
			// out -> hidden, easeIn
			// hover -> visible, easeOut
			// focus -> hidden, easeIn
		}



		protected function $releasedOutsideTween():void {
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASED_OUTSIDE_TWEEN, true));

			// duration: $skin.focusOutDuration
			// out -> visible, easeOut
			// hover -> hidden, easeIn
			// focus -> hidden, easeIn
		}



		private function _onOver(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag over
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OVER, true));
				}
				else {
					// roll over
					_mouseStatus = MouseStatus.HOVER;

					$hoverInTween();

					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN, true));
				}
			}
		}



		private function _onOut(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				if(event != null && event.buttonDown) {
					// drag out
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OUT, true));
				}
				else {
					// roll out
					_mouseStatus = MouseStatus.OUT;

					$hoverOutTween();

					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT, true));
				}
			}
		}



		private function _onFocus(event:MouseEvent = null):void {
			if(_areEventsEnabled) {
				_mouseStatus = MouseStatus.FOCUS;
				_currentDrag = this;

				$focusInTween();

				if(stage != null) {
					stage.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
				}

				dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN, true));
			}
		}



		private function _onRelease(event:MouseEvent = null):void {
			if(stage != null) {
				stage.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);
			}

			if(_areEventsEnabled && _mouseStatus == MouseStatus.FOCUS) {
				if(event != null && event.currentTarget == stage) {
					// release outside
					forceRelease();
				}

				else if(_currentDrag != this) {
					// drag confirm
					$dragConfirmedTween();

					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRM, true));
				}

				else {
					// release inside
					_currentDrag = null;

					$releasedInsideTween();

					dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
				}

				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
			}
		}
	}
}
