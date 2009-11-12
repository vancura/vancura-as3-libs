package org.vancura.vaclav.core {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	
	
	/*
	 *	Class: QSprite
	 *	
	 *	Quick creation of Sprite with initial data.
	 *	
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class QSprite extends Sprite {

		
		
		private var _embeddedSpr:Sprite;

		
		
		/*
		 * Constructor: QSprite
		 * 
		 * Create new QSprite instance.
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
		public function QSprite(	c:Object = null,
									parent:DisplayObjectContainer = null) {
										
			// if config is not defined, prepare it
			if(c == null) c = new Object();

			super();

			// Sprite overrides and custom config
			if(c.embed) {
				if(!(c.embed is Sprite)) throw new TypeError('Invalid embed object');
				_embeddedSpr = c.embed;
				addChild(_embeddedSpr);
			}
			
			// assign parameters
			assign(this, c);
			
			// add child if requested
			if(parent != null) parent.addChild(this);
		}

		
		
		/*
		 * Method: embeddedSpr
		 * 
		 * Get embedded Sprite.
		 * 
		 * Returns:
		 * 		Embedded Sprite
		 */
		public function get embeddedSpr():Sprite {
			return _embeddedSpr;
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
