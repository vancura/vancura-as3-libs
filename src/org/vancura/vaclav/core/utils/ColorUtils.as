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
	import flash.geom.ColorTransform;

	public class ColorUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function ColorUtils() {
			throw new Error('The ColorUtils class cannot be instantiated.');
		}



		/**
		 * Interpolates (tints) between two colors.
		 * Original taken from Casalib (http://casalib.org)
		 * @param begin The start color.
		 * @param end The finish color.
		 * @param amount The level of interpolation between the two colors.
		 * @return The new interpolated color.
		 * @usage
		 * <code>
		 * var myColor:ColorTransform = new ColorTransform();
		 * myColor.color              = 0xFF0000;
		 * var box:Sprite = new Sprite();
		 * box.graphics.beginFill(0x0000FF);
		 * box.graphics.drawRect(10, 10, 250, 250);
		 * box.graphics.endFill();
		 * box.transform.colorTransform = ColorUtil.interpolateColor(new ColorTransform(), myColor, new Percent(0.5));
		 * this.addChild(box);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 * TODO: Finish
		 */
/*		public static function interpolateColor(begin:ColorTransform, end:ColorTransform, amount:Percent):ColorTransform {
			var interpolation:ColorTransform = new ColorTransform();

			interpolation.redMultiplier = NumberUtils.interpolate(amount, begin.redMultiplier, end.redMultiplier);
			interpolation.greenMultiplier = NumberUtils.interpolate(amount, begin.greenMultiplier, end.greenMultiplier);
			interpolation.blueMultiplier = NumberUtils.interpolate(amount, begin.blueMultiplier, end.blueMultiplier);
			interpolation.alphaMultiplier = NumberUtils.interpolate(amount, begin.alphaMultiplier, end.alphaMultiplier);
			interpolation.redOffset = NumberUtils.interpolate(amount, begin.redOffset, end.redOffset);
			interpolation.greenOffset = NumberUtils.interpolate(amount, begin.greenOffset, end.greenOffset);
			interpolation.blueOffset = NumberUtils.interpolate(amount, begin.blueOffset, end.blueOffset);
			interpolation.alphaOffset = NumberUtils.interpolate(amount, begin.alphaOffset, end.alphaOffset);

			return interpolation;
		} */



		/**
		 * Converts a series of individual RGB(A) values to a 32-bit ARGB color value.
		 * Original taken from Casalib (http://casalib.org)
		 * @param r A uint from 0 to 255 representing the red color value.
		 * @param g A uint from 0 to 255 representing the green color value.
		 * @param b A uint from 0 to 255 representing the blue color value.
		 * @param a A uint from 0 to 255 representing the alpha value. Default is <code>255</code>.
		 * @return Returns a hexidecimal color as a String.
		 * @example
		 * <code>
		 * var hexColor : String = ColorUtil.getHexStringFromARGB(128, 255, 0, 255);
		 * trace(hexColor); // Traces 80FF00FF
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getColor(r:uint, g:uint, b:uint, a:uint = 255):uint {
			return (a << 24) | (r << 16) | (g << 8) | b;
		}



		/**
		 * Converts a 32-bit ARGB color value into an ARGB object.
		 * Original taken from Casalib (http://casalib.org)
		 * @param color The 32-bit ARGB color value.
		 * @return Returns an object with the properties a, r, g, and b defined.
		 * @example
		 * <code>
		 * var myRGB:Object = ColorUtil.getARGB(0xCCFF00FF);
		 * trace("Alpha = " + myRGB.a);
		 * trace("Red = " + myRGB.r);
		 * trace("Green = " + myRGB.g);
		 * trace("Blue = " + myRGB.b);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getARGB(color:uint):Object {
			var c:Object = {};
			c.a = color >> 24 & 0xFF;
			c.r = color >> 16 & 0xFF;
			c.g = color >> 8 & 0xFF;
			c.b = color & 0xFF;
			return c;
		}



		/**
		 * Converts a 24-bit RGB color value into an RGB object.
		 * Original taken from Casalib (http://casalib.org)
		 * @param color The 24-bit RGB color value.
		 * @return Returns an object with the properties r, g, and b defined.
		 * @example
		 * <code>
		 * var myRGB:Object = ColorUtil.getRGB(0xFF00FF);
		 * trace("Red = " + myRGB.r);
		 * trace("Green = " + myRGB.g);
		 * trace("Blue = " + myRGB.b);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getRGB(color:uint):Object {
			var c:Object = {};
			c.r = color >> 16 & 0xFF;
			c.g = color >> 8 & 0xFF;
			c.b = color & 0xFF;
			return c;
		}



		/**
		 * Converts a 32-bit ARGB color value into a hexidecimal String representation.
		 * Original taken from Casalib (http://casalib.org)
		 * @param a A uint from 0 to 255 representing the alpha value.
		 * @param r A uint from 0 to 255 representing the red color value.
		 * @param g A uint from 0 to 255 representing the green color value.
		 * @param b A uint from 0 to 255 representing the blue color value.
		 * @return Returns a hexidecimal color as a String.
		 * @example
		 * <code>
		 * var hexColor : String = ColorUtil.getHexStringFromARGB(128, 255, 0, 255);
		 * trace(hexColor); // Traces 80FF00FF
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getHexStringFromARGB(a:uint, r:uint, g:uint, b:uint):String {
			var aa:String = a.toString(16);
			var rr:String = r.toString(16);
			var gg:String = g.toString(16);
			var bb:String = b.toString(16);
			aa = (aa.length == 1) ? '0' + aa : aa;
			rr = (rr.length == 1) ? '0' + rr : rr;
			gg = (gg.length == 1) ? '0' + gg : gg;
			bb = (bb.length == 1) ? '0' + bb : bb;
			return (aa + rr + gg + bb).toUpperCase();
		}



		/**
		 * Converts an RGB color value into a hexidecimal String representation.
		 * Original taken from Casalib (http://casalib.org)
		 * @param r A uint from 0 to 255 representing the red color value.
		 * @param g A uint from 0 to 255 representing the green color value.
		 * @param b A uint from 0 to 255 representing the blue color value.
		 * @return Returns a hexidecimal color as a String.
		 * @example
		 * <code>
		 * var hexColor : String = ColorUtil.getHexStringFromRGB(255, 0, 255);
		 * trace(hexColor); // Traces FF00FF
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getHexStringFromRGB(r:uint, g:uint, b:uint):String {
			var rr:String = r.toString(16);
			var gg:String = g.toString(16);
			var bb:String = b.toString(16);
			rr = (rr.length == 1) ? '0' + rr : rr;
			gg = (gg.length == 1) ? '0' + gg : gg;
			bb = (bb.length == 1) ? '0' + bb : bb;
			return (rr + gg + bb).toUpperCase();
		}
	}
}
