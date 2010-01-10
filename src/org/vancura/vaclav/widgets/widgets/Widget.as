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

/**
 * TODO: Width & height not applied in the constructor
 * TODO: Check for children and remove them on destroy()
 */


package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.vancura.vaclav.core.display.MorphSprite;
	import org.vancura.vaclav.core.display.QSprite;
	import org.vancura.vaclav.core.utils.DisplayUtils;
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
			_contentSpr = new QSprite({mouseEnabled:false}, this);
			_debugSpr = new QSprite({mouseEnabled:false, mouseChildren:false}, this);
		}



		protected function _removeChildren():void {
			this.removeEventListener(MouseEvent.ROLL_OVER, _onDebugOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, _onDebugOut);

			_allWidgets[_allIdx] = null;

			DisplayUtils.removeChildren(this, _contentSpr, _debugSpr);
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

					DisplayUtils.drawRect(_debugSpr, 0, 0, _width, _height, _debugColor, 0.15);
					DisplayUtils.strokeBounds(_debugSpr, 0, 0, _width, _height, 5, _debugColor);
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



		override public function addChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.addChild(child);
			else out = _contentSpr.addChild(child);

			return out;
		}



		override public function removeChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.removeChild(child);
			else out = _contentSpr.removeChild(child);

			return out;
		}



		override public function contains(child:DisplayObject):Boolean {
			var out:Boolean;

			if(_contentSpr == null) out = super.contains(child);
			else out = _contentSpr.contains(child);

			return out;
		}



		override public function swapChildrenAt(index1:int, index2:int):void {
			if(_contentSpr == null) super.swapChildrenAt(index1, index2);
			else _contentSpr.swapChildrenAt(index1, index2);
		}



		override public function getChildByName(name:String):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.getChildByName(name);
			else out = _contentSpr.getChildByName(name);

			return out;
		}



		override public function removeChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.removeChildAt(index);
			else out = _contentSpr.removeChildAt(index);

			return out;
		}



		override public function getChildIndex(child:DisplayObject):int {
			var out:int;

			if(_contentSpr == null) out = super.getChildIndex(child);
			else out = _contentSpr.getChildIndex(child);

			return out;
		}



		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.addChildAt(child, index);
			else out = _contentSpr.addChildAt(child, index);

			return out;
		}



		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if(_contentSpr == null) super.swapChildren(child1, child2);
			else _contentSpr.swapChildren(child1, child2);
		}



		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.getChildAt(index);
			else _contentSpr.getChildAt(index);

			return out;
		}



		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(_contentSpr == null) super.setChildIndex(child, index);
			else _contentSpr.setChildIndex(child, index);
		}
	}
}
