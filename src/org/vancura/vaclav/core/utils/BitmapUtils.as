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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * A class covering few bitmap methods I can't put anywhere else.
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public final class BitmapUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function BitmapUtils() {
			throw new Error('The BitmapUtils class cannot be instantiated.');
		}



		/**
		 * Get BitmapData from the source.
		 * If the source is Bitmap, it's converted, if it is already BitmapData, the reference is returned.
		 * Serves as a quick filter for Bitmap and BitmapData.
		 * @param source Source Bitmap or BitmapData
		 * @return Source converted to BitmapData
		 * @throws TypeError if the source is not Bitmap nor BitmapData
		 */
		public static function embed2BD(source:*):BitmapData {
			var o:BitmapData;

			if(source is Bitmap) o = source.bitmapData; else if(source is BitmapData) o = source;
			else throw new TypeError('Bitmap or BitmapData needed');

			return o;
		}



		/**
		 * Crop the BitmapData source and return a new BitmapData.
		 * @param source Source BitmapData
		 * @param x Left margin of crop area
		 * @param y Top margin of crop area
		 * @param width Width of crop area
		 * @param height Height of crop area
		 * @return Cropped source as BitmapData
		 */
		public static function crop(source:BitmapData, x:uint, y:uint, width:uint, height:uint):BitmapData {
			var o:BitmapData = new BitmapData(width, height);
			var rectangle:Rectangle = new Rectangle(x, y, width, height);
			var point:Point = new Point(0, 0);

			o.copyPixels(source, rectangle, point);

			return o;
		}
	}
}
