/***********************************************************************************************************************
 * Copyright (c) 2010 Vaclav Vancura.
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

package org.vancura.vaclav.core.display {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	import org.vancura.vaclav.core.utils.ObjectUtils;

	/**
	 * Quick creation of Sprite with initial data.
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class QSprite extends Sprite {


		private var _embeddedSpr:Sprite;


		/*
		 * Constructor: QSprite
		 *
		 * Create a new QSprite instance.
		 *
		 * Parameters:
		 *
		 * 		c		- Config object
		 * 		parent	- Parent DisplayObjectContainer
		 *
		 * Every sane parameter of Sprite, DisplayObjectContainer, InteractiveObject and
		 * DisplayObject is supported, that means:
		 *
		 * Sprite parameters: buttonMode, hitArea, soundTransform, useHandCursor
		 *
		 * DisplayObjectContainer parameters: mouseChildren, tabChildren
		 *
		 * InteractiveObject parameters: contextMenu, doubleClickEnabled, focusRect,
		 * mouseEnabled, tabEnabled, tabIndex
		 *
		 * DisplayObject parameters: accessibilityProperties, alpha, blendMode, cacheAsBitmap,
		 * filters, height, mask, name, opaqueBackground, rotation, scale9Grid, scaleX, scaleY,
		 * scrollRect, transform, visible, width, x, y
		 *
		 * Additionally these parameters are added:
		 *
		 * 		embed	- Sprite object to be used as Sprite source (throws a TypeError if
		 * 					the embed object is not Sprite)
		 *
		 * Example code:
		 *
		 * (start code)
		 *
		 * 		import org.vancura.graphics.QSprite;
		 *
		 * 		var mySprite:QSprite = new QSprite({
		 * 			x: 100,
		 * 			y: 50,
		 * 			alpha: .5,
		 * 			rotation: 10
		 * 		});
		 * 		addChild(mySprite);
		 *
		 * (end)
		 *
		 * Another example:
		 *
		 * (start code)
		 *
		 * 		import org.vancura.graphics.QSprite;
		 *
		 * 		var mySprite:QSprite = new QSprite(null, this);
		 *
		 * (end)
		 */
		public function QSprite(config:Object = null, parent:DisplayObjectContainer = null) {
			// if config is not defined, prepare it
			var c:Object;
			if(config == null) c = new Object();
			else c = config;

			super();

			// Sprite overrides and custom config
			if(c.embed) {
				if(!(c.embed is Sprite)) throw new TypeError('Invalid embed object');

				_embeddedSpr = c.embed;
				addChild(_embeddedSpr);
			}

			// assign parameters
			ObjectUtils.assign(this, c);

			// add child if requested
			if(parent != null) parent.addChild(this);
		}



		// Getters & setters
		// -----------------


		/**
		 * Get embedded Sprite (nested).
		 * @return Embedded Sprite
		 */
		public function get embeddedSpr():Sprite {
			return _embeddedSpr;
		}



		/**
		 * Moves to the specified position.
		 * @param x New X position
		 * @param y New Y position
		 */
		public function setPosition(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}



		/**
		 * Rescales to new size.
		 * @param width New width
		 * @param height New height
		 */
		public function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
	}
}
