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
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.display.MorphSprite;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.ICheckButton;
	import org.vancura.vaclav.widgets.interfaces.ICheckButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class CheckButton extends MorphSprite implements IWidget, ICheckButton {


		protected var _skin:ICheckButtonSkin;
		protected var _buttonOff:StaticButton;
		protected var _buttonOn:StaticButton;

		private var _debugLevel:String;
		private var _isChecked:Boolean;



		public function CheckButton(skin:ICheckButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object;

			if(config === null) c = new Object();
			else c = config;

			var dl:String = (debugLevel === null) ? SkinManager.debugLevel : debugLevel;

			_buttonOff = new StaticButton(skin.buttonOffSkin, {}, this, dl);
			_buttonOn = new StaticButton(skin.buttonOnSkin, {visible:false}, this, dl);

			_buttonOff.debugColor = SkinManager.debugColor;
			_buttonOn.debugColor = SkinManager.debugColor;

			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
			this.isMorphHeightEnabled = false;
			this.isMorphWidthEnabled = false;

			_buttonOff.addEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle, false, 0, true);
			_buttonOn.addEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle, false, 0, true);

			if(c.width === undefined) c.width = skin.buttonOffSkin.assetWidth;
			if(c.height === undefined) c.height = skin.buttonOffSkin.assetHeight;

			if(skin === null) throw new Error('No skin defined');
			else super(c, parent);

			_skin = skin;
		}



		public function destroy():void {
			_buttonOff.removeEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle);

			removeChildren(this, _buttonOff, _buttonOn);

			_buttonOff.destroy();
			_buttonOn.destroy();
		}



		public function draw():void {
			_buttonOff.draw();
			_buttonOn.draw();

			_buttonOff.visible = !_isChecked;
			_buttonOn.visible = _isChecked;
		}



		public function forceRelease():void {
			_buttonOff.forceRelease();
			_buttonOn.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		override public function get width():Number {
			return _buttonOff.width;
		}



		override public function set width(value:Number):void {
		}



		override public function get height():Number {
			return _buttonOff.height;
		}



		override public function set height(value:Number):void {
		}



		public function set areEventsEnabled(value:Boolean):void {
			_buttonOff.areEventsEnabled = value;
			_buttonOn.areEventsEnabled = value;

			this.buttonMode = value;
			this.useHandCursor = value;

			draw();
		}



		public function get areEventsEnabled():Boolean {
			return _buttonOff.areEventsEnabled;
		}



		public function get mouseStatus():String {
			return button.mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			button.mouseStatus = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			_buttonOff.debugLevel = value;
			_buttonOn.debugLevel = value;
		}



		public function get isChecked():Boolean {
			return _isChecked;
		}



		public function set isChecked(value:Boolean):void {
			_isChecked = value;
			draw();
		}



		public function get skin():ICheckButtonSkin {
			return _skin;
		}



		public function set skin(skin:ICheckButtonSkin):void {
			_skin = skin;

			_buttonOff.skin = skin.buttonOffSkin;
			_buttonOn.skin = skin.buttonOnSkin;

			draw();
		}



		public function get button():IButton {
			return (_isChecked) ? _buttonOn : _buttonOff;
		}



		public function get buttonOff():IButton {
			return _buttonOff;
		}



		public function get buttonOn():IButton {
			return _buttonOn;
		}



		private function _onToggle(event:ButtonEvent):void {
			isChecked = !isChecked;
		}
	}
}
