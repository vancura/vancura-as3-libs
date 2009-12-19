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

package org.vancura.vaclav.core.display {
	import flash.display.DisplayObjectContainer;
	import flash.media.Video;

	import org.vancura.vaclav.core.global.assign;

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
		public function QVideo(config:Object = null, parent:DisplayObjectContainer = null) {
			// if config is not defined, prepare it
			if(config == null) {
				config = new Object();
			}

			try {
				super(config.width, config.height);
			}
			catch(err:Error) {
				if(config.width == undefined) {
					throw new Error('Video width undefined');
				}

				if(config.height == undefined) {
					throw new Error('Video height undefined');
				}
			}

			// Video overrides and custom config
			this.deblocking = (config.deblocking == undefined) ? 5 : config.deblocking;
			this.smoothing = (config.smoothing == undefined) ? true : config.smoothing;

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
