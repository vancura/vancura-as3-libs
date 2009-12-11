/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the “Software”), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.core {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/*
	 * Class: BitmapUtil
	 *
	 * A class covering few bitmap methods I can't put anywhere else.
	 *
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public final class BitmapUtil {



		/*
		 * Function: embed2BD
		 *
		 * Get BitmapData from the source.
		 * If the source is Bitmap, it's converted, if it is already BitmapData, the reference is returned.
		 * Serves as a quick filter for Bitmap and BitmapData.
		 * Throws a TypeError if the source is not Bitmap nor BitmapData.
		 *
		 * Parameters:
		 *
		 * 		source	- Source Bitmap or BitmapData
		 *
		 * Returns:
		 *
		 * 		Source converted to BitmapData
		 */
		public static function embed2BD(source:*):BitmapData {
			if(source is Bitmap) {
				return source.bitmapData;
			}

			else if(source is BitmapData) {
				return source;
			}

			else {
				throw new TypeError('Bitmap or BitmapData needed');
			}
		}



		/*
		 * Function: crop
		 *
		 * Crop the BitmapData source and return a new BitmapData.
		 *
		 * Parameters:
		 *
		 * 		source	- Source BitmapData
		 * 		x		- Left margin of crop area
		 * 		y		- Top margin of crop area
		 * 		width	- Width of crop area
		 * 		height	- Height of crop area
		 *
		 * Returns:
		 *
		 * 		Cropped source as BitmapData
		 */
		public static function crop(source:BitmapData, x:uint, y:uint, width:uint, height:uint):BitmapData {
			var o:BitmapData = new BitmapData(width, height);

			o.copyPixels(source, new Rectangle(x, y, width, height), new Point(0, 0));

			return o;
		}
	}
}
