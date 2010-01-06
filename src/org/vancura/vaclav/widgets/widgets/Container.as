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
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.display.GraphicsUtil;
	import org.vancura.vaclav.core.display.QSprite;
	import org.vancura.vaclav.core.global.addChildren;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IContainer;
	import org.vancura.vaclav.widgets.interfaces.IContainerSkin;

	/**
	 * Class: Container
	 *
	 * Container is a.. Container. You can place other DisplayObjects inside and let them automatically align via
	 * paddingLeft, paddingRight, paddingTop and paddingBottom properties specified in the skin or altered via skin
	 * property. You can set alignment too (left, right, top, bottom, center vertically and/or horizontally). If you
	 * need to override inner sprite size, specify it via innerWidth and innerHeight setters (with corresponding
	 * getters of course).
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class Container extends Widget implements IContainer {


		protected var _skin:IContainerSkin;

		private var _innerSpr:QSprite;
		private var _innerWidth:Number = 0;
		private var _innerHeight:Number = 0;



		/**
		 * Constructor.
		 *
		 * @param skin Skin
		 * @param config (Optional) Config Object
		 * @param parent (Optional) parent to addChild() to
		 * @param debugLevel (Optional) DebugLevel
		 * @see QSprite
		 * @see ContainerSkin
		 * @see DebugLevel
		 */
		public function Container(skin:IContainerSkin, config:Object = null, parent:DisplayObjectContainer = null,
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
		}



		override protected function _init():void {
			super._init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function _addChildren():void {
			super._addChildren();

			_innerSpr = new QSprite({});

			addChildren(_contentSpr, _innerSpr);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			removeChildren(_contentSpr, _innerSpr);
		}



		/**
		 * Redraw stuff.
		 */
		override public function draw():void {
			super.draw();

			if(_skin != null) {
				var l:Number = _skin.paddingLeft;
				var t:Number = _skin.paddingTop;
				var w:Number = _width - _skin.paddingLeft - _skin.paddingRight;
				var h:Number = _height - _skin.paddingTop - _skin.paddingBottom;

				// check for inner width & height override
				if(_innerWidth == 0) _innerWidth = _innerSpr.width;
				if(_innerHeight == 0) _innerHeight = _innerSpr.height;

				// draw debug rectangle
				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(_width != 0 && _height != 0) {
						GraphicsUtil.strokeBounds(_debugSpr, l, t, w, h, 5, _debugColor);
					}
				}

				// align inner sprite horizontally
				if(_skin.hAlign == Align.RIGHT) {
					// right
					_innerSpr.x = _width - _skin.paddingRight - _innerWidth;
				} else if(_skin.hAlign == Align.CENTER) {
					// center
					_innerSpr.x = l + Math.round((w - _innerWidth) / 2);
				}
				else {
					// left
					_innerSpr.x = l;
				}

				// align inner sprite vertically
				if(_skin.vAlign == Align.BOTTOM) {
					// bottom
					_innerSpr.y = _height - _skin.paddingBottom - _innerHeight;
				} else if(_skin.vAlign == Align.CENTER) {
					// center
					_innerSpr.y = t + Math.round((h - _innerHeight) / 2);
				}
				else {
					// top
					_innerSpr.y = t;
				}
			}
		}



		override public function addChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.addChild(child);
			else out = _innerSpr.addChild(child);

			return out;
		}



		override public function removeChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.removeChild(child);
			else out = _innerSpr.removeChild(child);

			return out;
		}



		override public function contains(child:DisplayObject):Boolean {
			var out:Boolean;

			if(_innerSpr == null) out = super.contains(child);
			else out = _innerSpr.contains(child);

			return out;
		}



		override public function swapChildrenAt(index1:int, index2:int):void {
			if(_innerSpr == null) super.swapChildrenAt(index1, index2);
			else _innerSpr.swapChildrenAt(index1, index2);
		}



		override public function getChildByName(name:String):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.getChildByName(name);
			else out = _innerSpr.getChildByName(name);

			return out;
		}



		override public function removeChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.removeChildAt(index);
			else out = _innerSpr.removeChildAt(index);

			return out;
		}



		override public function getChildIndex(child:DisplayObject):int {
			var out:int;

			if(_innerSpr == null) out = super.getChildIndex(child);
			else out = _innerSpr.getChildIndex(child);

			return out;
		}



		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.addChildAt(child, index);
			else out = _innerSpr.addChildAt(child, index);

			return out;
		}



		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if(_innerSpr == null) super.swapChildren(child1, child2);
			else _innerSpr.swapChildren(child1, child2);
		}



		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_innerSpr == null) out = super.getChildAt(index);
			else out = _innerSpr.getChildAt(index);

			return out;
		}



		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(_innerSpr == null) super.setChildIndex(child, index);
			else _innerSpr.setChildIndex(child, index);
		}



		public function get skin():IContainerSkin {
			return _skin;
		}



		public function set skin(skin:IContainerSkin):void {
			_skin = skin;

			if(_width == 0) _width = _skin.assetWidth;
			if(_height == 0) _height = _skin.assetHeight;

			draw();
		}



		// Getters & setters
		// -----------------


		override public function get width():Number {
			return _width + _skin.paddingLeft + _skin.paddingRight;
		}



		override public function get height():Number {
			return _height + _skin.paddingTop + _skin.paddingBottom;
		}



		public function get innerWidth():Number {
			return _innerWidth;
		}



		public function set innerWidth(value:Number):void {
			_innerWidth = value;
		}



		public function get innerHeight():Number {
			return _innerWidth;
		}



		public function set innerHeight(value:Number):void {
			_innerHeight = value;
		}
	}
}
