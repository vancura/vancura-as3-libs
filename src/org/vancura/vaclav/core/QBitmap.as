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

package org.vancura.vaclav.core {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;

	/*
	 *	Class: QBitmap
	 *
	 *	Quick creation of Bitmap with initial data.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class QBitmap extends Bitmap {



		/*
		 * Constructor: QBitmap
		 *
		 * Create a new QBitmap instance.
		 *
		 * Parameters:
		 *
		 * 		c		- Config object
		 * 		parent	- Parent DisplayObjectContainer
		 *
		 * Every sane parameter of Bitmap and DisplayObject is supported, that means:
		 *
		 * Bitmap parameters: bitmapData, pixelSnapping, smoothing
		 *
		 * DisplayObject parameters: accessibilityProperties, alpha, blendMode, cacheAsBitmap,
		 * filters, height, mask, name, opaqueBackground, rotation, scale9Grid, scaleX, scaleY,
		 * scrollRect, transform, visible, width, x, y
		 *
		 * Additionally these parameters are added:
		 *
		 * 		embed	- Bitmap or BitmapData object to be used as Bitmap source (throws
		 * 					a TypeError if the embed object is not Bitmap nor BitmapData)
		 *
		 * Example code:
		 *
		 * (start code)
		 *
		 * 		import org.vancura.graphics.QBitmap;
		 *
		 * 		[Embed(source='bitmap-test.png')] private static var _bitmapTest:Class;
		 *
		 * 		var myBitmap:QBitmap = new QBitmap({
		 * 			embed: new _bitmapTest(),
		 * 			x: 100,
		 * 			y: 50,
		 * 			alpha: .5
		 * 		});
		 * 		addChild(myBitmap);
		 *
		 * (end)
		 *
		 * Another example:
		 *
		 * (start code)
		 *
		 * 		import org.vancura.graphics.QSprite;
		 *
		 * 		var myBitmap:QBitmap = new QBitmap({embed: new _bitmapTest()}, this);
		 *
		 * (end)
		 */
		public function QBitmap(config:Object = null, parent:DisplayObjectContainer = null) {
			// if config is not defined, prepare it
			if(config == null) {
				config = new Object();
			}

			super();

			// Bitmap overrides and custom config
			if(config.embed) {
				if(config.embed is Bitmap) {
					this.bitmapData = config.embed.bitmapData;
				} else if(config.embed is BitmapData) {
					this.bitmapData = config.embed;
				}
				else {
					throw new TypeError('Invalid embed object');
				}
			}

			// assign parameters
			assign(this, config);

			// add child if requested
			if(parent != null) {
				parent.addChild(this);
			}
		}



		// Getters & setters
		// -----------------


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
