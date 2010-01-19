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

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.display.QSprite;
	import org.vancura.vaclav.core.utils.DisplayUtils;
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

			DisplayUtils.addChildren(_contentSpr, _innerSpr);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _innerSpr);
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
						DisplayUtils.strokeBounds(_debugSpr, l, t, w, h, 5, _debugColor);
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
