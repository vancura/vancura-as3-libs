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

			// Sprite overrides
			if(c.buttonMode != undefined) this.buttonMode = c.buttonMode;
			if(c.hitArea != undefined) this.hitArea = c.hitArea;
			if(c.soundTransform != undefined) this.soundTransform = c.soundTransform;
			if(c.useHandCursor != undefined) this.useHandCursor = c.useHandCursor;

			// DisplayObjectContainer overrides
			if(c.mouseChildren != undefined) this.mouseChildren = c.mouseChildren;
			if(c.tabChildren != undefined) this.tabChildren = c.tabChildren;

			// InteractiveObject overrides
			if(c.contextMenu != undefined) this.contextMenu = c.contextMenu;
			if(c.doubleClickEnabled != undefined) this.doubleClickEnabled = c.doubleClickEnabled;
			if(c.focusRect != undefined) this.focusRect = c.focusRect;
			if(c.mouseEnabled != undefined) this.mouseEnabled = c.mouseEnabled;
			if(c.tabEnabled != undefined) this.tabEnabled = c.tabEnabled;
			if(c.tabIndex != undefined) this.tabIndex = c.tabIndex;

			// DisplayObject overrides
			if(c.accessibilityProperties != undefined) this.accessibilityProperties = c.accessibilityProperties;
			if(c.alpha != undefined) this.alpha = c.alpha;
			if(c.blendMode != undefined) this.blendMode = c.blendMode;
			if(c.cacheAsBitmap != undefined) this.cacheAsBitmap = c.cacheAsBitmap;
			if(c.filters != undefined) this.filters = c.filters;
			if(c.height != undefined) this.height = c.height;
			if(c.mask != undefined) this.mask = c.mask;
			if(c.name != undefined) this.name = c.name;
			if(c.opaqueBackground != undefined) this.opaqueBackground = c.opaqueBackground;
			if(c.rotation != undefined) this.rotation = c.rotation;
			if(c.scale9Grid != undefined) this.scale9Grid = c.scale9Grid;
			if(c.scaleX != undefined) this.scaleX = c.scaleX;
			if(c.scaleY != undefined) this.scaleY = c.scaleY;
			if(c.scrollRect != undefined) this.scrollRect = c.scrollRect;
			if(c.transform != undefined) this.transform = c.transform;
			if(c.visible != undefined) this.visible = c.visible;
			if(c.width != undefined) this.width = c.width;
			if(c.x != undefined) this.x = c.x;
			if(c.y != undefined) this.y = c.y;
			
			// add child if requested
			if(parent != null) parent.addChild(this);
		}

		
		
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
