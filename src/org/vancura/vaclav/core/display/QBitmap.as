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

package org.vancura.vaclav.core.display {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.utils.ObjectUtils;

	/**
	 * Quick creation of Bitmap with initial data.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
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
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			super();

			// Bitmap overrides and custom config
			if(c.embed) {
				if(c.embed is Bitmap) this.bitmapData = c.embed.bitmapData; else if(c.embed is BitmapData) this.bitmapData = c.embed;
				else throw new TypeError('Invalid embed object');
			}

			// assign parameters
			ObjectUtils.assign(this, c);

			// add child if requested
			if(parent != null) parent.addChild(this);
		}



		// Getters & setters
		// -----------------


		/**
		 * Moves to the specified position.
		 *
		 * @param x New X position
		 * @param y New Y position
		 */
		public function setPosition(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}



		/**
		 * Rescales to new size.
		 *
		 * @param width New width
		 * @param height New height
		 */
		public function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
	}
}
