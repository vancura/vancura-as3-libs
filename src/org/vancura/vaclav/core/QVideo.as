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
		 * Create a new QVideo instance.
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
			if(c == null) {
				c = new Object();
			}

			try {
				super(c.width, c.height);
			}
			catch(err:Error) {
				if(c.width == undefined) {
					throw new Error('Video width undefined');
				}
				
				if(c.height == undefined) {
					throw new Error('Video height undefined');
				}
			}

			// Video overrides and custom config
			this.deblocking = (c.deblocking != undefined) ? c.deblocking : 5;
			this.smoothing = (c.smoothing != undefined) ? c.smoothing : true;

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
