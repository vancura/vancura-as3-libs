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
		public function QBitmap(	c:Object = null,
									parent:DisplayObjectContainer = null) {
										
			// if config is not defined, prepare it
			if(c == null) {
				c = new Object();
			}

			super();

			// Bitmap overrides and custom config
			if(c.embed) {
				if(c.embed is Bitmap) this.bitmapData = c.embed.bitmapData;
				else if(c.embed is BitmapData) this.bitmapData = c.embed;
				else throw new TypeError('Invalid embed object');
			}

			// assign parameters
			assign(this, c);
			
			// add child if requested
			if(parent != null) {
				parent.addChild(this);
			}
		}
		
		
		
		/*
		 * Method: setPosition
		 * 
		 * Moves to the specified position.
		 * 
		 * Parameters:
		 * 		x	- New x position
		 * 		y	- New y position
		 */
		public function setPosition(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}

		
		
		/*
		 * Method: setSize
		 * 
		 * Sets the size.
		 * 
		 * Parameters:
		 * 		width	- New width
		 * 		height	- New height
		 */
		public function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
	}
}
