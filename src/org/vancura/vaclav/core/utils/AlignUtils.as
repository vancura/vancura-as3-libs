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
