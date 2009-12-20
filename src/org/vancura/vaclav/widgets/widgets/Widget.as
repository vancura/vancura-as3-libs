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

/**
 * TODO: Width & height not applied in the constructor
 */


package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.vancura.vaclav.core.display.GraphicsUtil;
	import org.vancura.vaclav.core.display.MorphSprite;
	import org.vancura.vaclav.core.display.QSprite;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class Widget extends MorphSprite {


		public static const DRAW:String = 'draw';

		public static var initialDebugLevel:String;

		protected static const _DEBUG_PADDING:Number = 4;

		protected static var _allWidgets:Array;

		protected var _allIdx:uint;
		protected var _config:Object;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _debugLevel:String;
		protected var _debugColor:uint;
		protected var _debugSpr:QSprite;
		protected var _contentSpr:QSprite;


		//noinspection FunctionWithMoreThanThreeNegationsJS
		public function Widget(config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null):void {
			if(config == null) _config = new Object();
			else _config = config;

			_debugColor = SkinManager.debugColor;

			super(_config);

			if(_config.x != undefined) this.x = _config.x;
			if(_config.y != undefined) this.y = _config.y;
			if(_config.width != undefined) this.width = _config.width;
			if(_config.height != undefined) this.height = _config.height;

			if(parent != null) parent.addChild(this);

			if(_allWidgets == null) _allWidgets = new Array();

			_allWidgets.push(this);

			_allIdx = _allWidgets.length - 1;

			_init();

			if(debugLevel == null) {
				if(initialDebugLevel != null) {
					this.debugLevel = initialDebugLevel;
				}
			}
			else this.debugLevel = debugLevel;
		}



		public function destroy():void {
			_removeChildren();
		}



		protected function _init():void {
			_addChildren();
			_invalidate();
		}



		protected function _addChildren():void {
			_contentSpr = new QSprite({}, this);
			_debugSpr = new QSprite({mouseEnabled:false}, this);
		}



		protected function _removeChildren():void {
			this.removeEventListener(MouseEvent.ROLL_OVER, _onDebugOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, _onDebugOut);

			_allWidgets[_allIdx] = null;

			removeChildren(this, _contentSpr, _debugSpr);
		}



		protected function _invalidate():void {
			addEventListener(Event.ENTER_FRAME, _onInvalidate, false, 0, true);
		}



		public static function initStage(stage:Stage):void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}



		override public function setSize(width:Number, height:Number):void {
			_width = width;
			_height = height;

			_invalidate();
		}



		public function draw():void {
			if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
				if(_width != 0 && _height != 0) {
					_debugSpr.graphics.clear();

					GraphicsUtil.drawRect(_debugSpr, 0, 0, _width, _height, _debugColor, 0.15);
					GraphicsUtil.strokeBounds(_debugSpr, 0, 0, _width, _height, 5, _debugColor);
				}
			}

			var e:Event = new Event(Widget.DRAW);
			dispatchEvent(e);
		}



		public static function set allDebugLevel(value:String):void {
			for each(var i:IWidget in _allWidgets) {
				if(i != null) i.debugLevel = value;
			}
		}



		override public function set width(w:Number):void {
			_width = Math.round(w);

			_invalidate();

			var e:Event = new Event(Event.RESIZE);
			dispatchEvent(e);
		}



		override public function get width():Number {
			return _width;
		}



		override public function set height(h:Number):void {
			_height = Math.round(h);

			_invalidate();

			var e:Event = new Event(Event.RESIZE);
			dispatchEvent(e);
		}



		override public function get height():Number {
			return _height;
		}



		override public function set x(value:Number):void {
			super.x = Math.round(value);
		}



		override public function set y(value:Number):void {
			super.y = Math.round(value);
		}



		public function get config():Object {
			return _config;
		}



		public function set debugLevel(value:String):void {
			if(value == DebugLevel.ALWAYS) {
				_debugSpr.visible = true;

				this.removeEventListener(MouseEvent.ROLL_OVER, _onDebugOver);
				this.removeEventListener(MouseEvent.ROLL_OUT, _onDebugOut);
			}
			else {
				_debugSpr.visible = false;

				this.addEventListener(MouseEvent.ROLL_OVER, _onDebugOver, false, 0, true);
				this.addEventListener(MouseEvent.ROLL_OUT, _onDebugOut, false, 0, true);
			}

			_debugLevel = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugColor(value:uint):void {
			_debugColor = value;
			draw();
		}



		public function get debugColor():uint {
			return _debugColor;
		}



		protected function _onDebugOver(event:MouseEvent):void {
			_debugSpr.visible = true;
		}



		protected function _onDebugOut(event:MouseEvent):void {
			_debugSpr.visible = false;
		}



		private function _onInvalidate(event:Event):void {
			removeEventListener(Event.ENTER_FRAME, _onInvalidate);

			draw();
		}
	}
}
