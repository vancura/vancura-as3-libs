package org.vancura.vaclav.core {
	import flash.display.DisplayObjectContainer;
	import flash.media.Video;

	
	
	/*
	 *	Class: QVideo
	 *	
	 *	Quick creation of Video with initial data.
	 *	
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class QVideo extends Video {

		
		
		/*
		 * Constructor: QVideo
		 * 
		 * Create new QVideo instance.
		 * 
		 * Parameters:
		 * 
		 * 		c		- Config object
		 * 		parent	- Parent DisplayObjectContainer 
		 * 		
		 * Every sane parameter of Video and DisplayObject is supported, that means:
		 * 
		 * Video parameters: deblocking, smoothing
		 * 
		 * DisplayObject parameters: accessibilityProperties, alpha, blendMode, cacheAsBitmap,
		 * filters, height, mask, name, opaqueBackground, rotation, scale9Grid, scaleX, scaleY,
		 * scrollRect, transform, visible, width, x, y
		 * 
		 * Additionally these parameters are set to new values if not specified:
		 * 
		 * 		deblocking	- set to 5 if not specified
		 * 		smoothing	- set to true if not specified
		 * 		
		 * Throws a Error if width and height are not specified.
		 * 
		 * Example code:
		 * 
		 * (start code)
		 * 
		 * 		import org.vancura.graphics.QVideo;
		 * 		
		 * 		var myVideo:QVideo = new QVideo({
		 * 			x: 100,
		 * 			y: 50,
		 * 			width: 512,
		 * 			height: 384
		 * 		});
		 * 		addChild(myVideo);
		 * 
		 * (end)
		 *  	
		 * Another example:
		 *  	
		 * (start code)
		 * 
		 * 		import org.vancura.graphics.QVideo;
		 * 		
		 * 		var myVideo:QVideo = new QVideo(null, this);
		 * 
		 * (end) 	
		 */
		public function QVideo(	c:Object = null,
								parent:DisplayObjectContainer = null) {
									
			// if config is not defined, prepare it
			if(c == null) c = new Object();

			try {
				super(c.width, c.height);
			}
			catch(err:Error) {
				if(c.width == undefined) throw new Error('Video width undefined');
				if(c.height == undefined) throw new Error('Video height undefined');
			}

			// Video overrides and custom config
			this.deblocking = (c.deblocking != undefined) ? c.deblocking : 5;
			this.smoothing = (c.smoothing != undefined) ? c.smoothing : true;

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
