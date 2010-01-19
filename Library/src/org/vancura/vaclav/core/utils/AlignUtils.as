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

package org.vancura.vaclav.core.utils {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	public class AlignUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function AlignUtils() {
			throw new Error('The AlignUtils class cannot be instantiated.');
		}



		/**
		 * Aligns a DisplayObject to the left side of the bounding Rectangle.
		 * Original taken from Casalib (http://casalib.org)
		 * @param displayObject The DisplayObject to align.
		 * @param bounds The area in which to align the DisplayObject.
		 * @param snapToPixel Force the position to whole pixels <code>true</code>, or to let the DisplayObject be positioned on sub-pixels <code>false</code>.
		 * @param outside Align the DisplayObject to the outside of the bounds <code>true</code>, or the inside <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function alignLeft(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true,
		                                 outside:Boolean = false):void {
			var x:Number = outside ? bounds.left - displayObject.width : bounds.left;
			displayObject.x = snapToPixel ? Math.round(x) : x;
		}



		/**
		 * Aligns a DisplayObject to the right side of the bounding Rectangle.
		 * Original taken from Casalib (http://casalib.org)
		 * @param displayObject The DisplayObject to align.
		 * @param bounds The area in which to align the DisplayObject.
		 * @param snapToPixel Force the position to whole pixels <code>true</code>, or to let the DisplayObject be positioned on sub-pixels <code>false</code>.
		 * @param outside Align the DisplayObject to the outside of the bounds <code>true</code>, or the inside <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function alignRight(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true,
		                                  outside:Boolean = false):void {
			var x:Number = outside ? bounds.right : bounds.right - displayObject.width;
			displayObject.x = snapToPixel ? Math.round(x) : x;
		}



		/**
		 * Aligns a DisplayObject to the top of the bounding Rectangle.
		 * Original taken from Casalib (http://casalib.org)
		 * @param displayObject The DisplayObject to align.
		 * @param bounds The area in which to align the DisplayObject.
		 * @param snapToPixel Force the position to whole pixels <code>true</code>, or to let the DisplayObject be positioned on sub-pixels <code>false</code>.
		 * @param outside Align the DisplayObject to the outside of the bounds <code>true</code>, or the inside <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function alignTop(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true,
		                                outside:Boolean = false):void {
			var y:Number = outside ? bounds.top - displayObject.height : bounds.top;
			displayObject.y = snapToPixel ? Math.round(y) : y;
		}



		/**
		 * Aligns a DisplayObject to the bottom of the bounding Rectangle.
		 * Original taken from Casalib (http://casalib.org)
		 * @param displayObject The DisplayObject to align.
		 * @param bounds The area in which to align the DisplayObject.
		 * @param snapToPixel Force the position to whole pixels <code>true</code>, or to let the DisplayObject be positioned on sub-pixels <code>false</code>.
		 * @param outside Align the DisplayObject to the outside of the bounds <code>true</code>, or the inside <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function alignBottom(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true,
		                                   outside:Boolean = false):void {
			var y:Number = outside ? bounds.bottom : bounds.bottom - displayObject.height;
			displayObject.y = snapToPixel ? Math.round(y) : y;
		}



		/**
		 * Aligns a DisplayObject to the horizontal center of the bounding Rectangle.
		 * Original taken from Casalib (http://casalib.org)
		 * @param displayObject The DisplayObject to align.
		 * @param bounds The area in which to align the DisplayObject.
		 * @param snapToPixel Force the position to whole pixels <code>true</code>, or to let the DisplayObject be positioned on sub-pixels <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function alignCenter(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true):void {
			var centerX:Number = bounds.width * 0.5 - displayObject.width * 0.5 + bounds.x;
			displayObject.x = snapToPixel ? Math.round(centerX) : centerX;
		}



		/**
		 * Aligns a DisplayObject to the vertical middle of the bounding Rectangle.
		 * Original taken from Casalib (http://casalib.org)
		 * @param displayObject The DisplayObject to align.
		 * @param bounds The area in which to align the DisplayObject.
		 * @param snapToPixel Force the position to whole pixels <code>true</code>, or to let the DisplayObject be positioned on sub-pixels <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function alignMiddle(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true):void {
			var centerY:Number = bounds.height * 0.5 - displayObject.height * 0.5 + bounds.y;
			displayObject.y = snapToPixel ? Math.round(centerY) : centerY;
		}



		/**
		 * Aligns a DisplayObject to the horizontal center and vertical middle of the bounding Rectangle.
		 * Original taken from Casalib (http://casalib.org)
		 * @param displayObject The DisplayObject to align.
		 * @param bounds The area in which to align the DisplayObject.
		 * @param snapToPixel Force the position to whole pixels <code>true</code>, or to let the DisplayObject be positioned on sub-pixels <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function alignCenterMiddle(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Boolean = true):void {
			AlignUtils.alignCenter(displayObject, bounds, snapToPixel);
			AlignUtils.alignMiddle(displayObject, bounds, snapToPixel);
		}
	}
}
