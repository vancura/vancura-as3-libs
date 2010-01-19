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
 *	         - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 *	         - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 *	         - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.core.utils {
	import flash.geom.ColorTransform;

	import org.vancura.vaclav.core.types.Percent;

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
		 * box.transform.colorTransform = ColorUtils.interpolateColor(new ColorTransform(), myColor, new Percent(0.5));
		 * this.addChild(box);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function interpolateColor(begin:ColorTransform, end:ColorTransform, amount:Percent):ColorTransform {
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
		}



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
		 * var hexColor : String = ColorUtils.getHexStringFromARGB(128, 255, 0, 255);
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
		 * var myRGB:Object = ColorUtils.getARGB(0xCCFF00FF);
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
		 * var myRGB:Object = ColorUtils.getRGB(0xFF00FF);
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
		 * var hexColor : String = ColorUtils.getHexStringFromARGB(128, 255, 0, 255);
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
		 * var hexColor : String = ColorUtils.getHexStringFromRGB(255, 0, 255);
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



		/**
		 * Original taken from Five3D (http://five3d.mathieu-badimon.com)
		 * @param colortransform
		 * @param value
		 */
		static public function setBrightness(colortransform:ColorTransform, value:Number):void {
			if(value > 1) value = 1; else if(value < -1) value = -1;
			var percent:Number = 1 - Math.abs(value);
			var offset:Number = 0;
			if(value > 0) offset = value * 255;
			colortransform.redMultiplier = colortransform.greenMultiplier = colortransform.blueMultiplier = percent;
			colortransform.redOffset = colortransform.greenOffset = colortransform.blueOffset = offset;
		}
	}
}
