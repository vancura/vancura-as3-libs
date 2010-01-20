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
 * * Attribution � You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver � Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights � In no way are any of the following rights affected by the license:
 *	         - Your fair dealing or fair use rights � All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 *	         - The author's moral rights � In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 *	         - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. � Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice � For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;

	import org.vancura.vaclav.core.display.QSprite;
	import org.vancura.vaclav.core.utils.DisplayUtils;
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



		override protected function _addChildren():void {
			super._addChildren();

			_activeSpr = new QSprite({alpha:0}, _contentSpr);

			_activeSpr.addEventListener(MouseEvent.MOUSE_OVER, _onOver, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_OUT, _onOut, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, _onFocus, false, 0, true);
			_activeSpr.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
			_activeSpr.addEventListener(FocusEvent.FOCUS_IN, _onFocusIn, false, 0, true);
			_activeSpr.addEventListener(FocusEvent.FOCUS_OUT, _onFocusOut, false, 0, true);

			_activeSpr.tabEnabled = true;
			_activeSpr.focusRect = false;

			DisplayUtils.drawRect(_activeSpr);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			_activeSpr.removeEventListener(MouseEvent.MOUSE_OVER, _onOver);
			_activeSpr.removeEventListener(MouseEvent.MOUSE_OUT, _onOut);
			_activeSpr.removeEventListener(MouseEvent.MOUSE_DOWN, _onFocus);
			_activeSpr.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);
			_activeSpr.removeEventListener(FocusEvent.FOCUS_IN, _onFocusIn);
			_activeSpr.removeEventListener(FocusEvent.FOCUS_OUT, _onFocusOut);

			DisplayUtils.removeChildren(_contentSpr, _activeSpr);
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



		override public function get tabEnabled():Boolean {
			return _activeSpr.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			_activeSpr.tabEnabled = enabled;
		}



		override public function set tabIndex(index:int):void {
			_activeSpr.tabIndex = index;
		}



		override public function get tabIndex():int {
			return _activeSpr.tabIndex;
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
					throw new Error('Unknown mouse status (' + value + ')');
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



		private function _onFocusIn(event:FocusEvent):void {
			_onOver();
		}



		private function _onFocusOut(event:FocusEvent):void {
			_onOut();
		}
	}
}
