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
	import flash.geom.Rectangle;

	import org.vancura.vaclav.core.types.Percent;

	public class RatioUtils {



		/**
		 * Constructor.
		 */
		public function RatioUtils() {
		}



		/**
		 Determines the ratio of width to height.
		 * Original taken from Casalib (http://casalib.org)
		 @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function widthToHeight(size:Rectangle):Number {
			return size.width / size.height;
		}



		/**
		 Determines the ratio of height to width.

		 @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 */
		public static function heightToWidth(size:Rectangle):Number {
			return size.height / size.width;
		}



		/**
		 Scales an area's width and height while preserving aspect ratio.

		 @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 @param amount: The amount you wish to scale by.
		 @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
		 */
		public static function scale(size:Rectangle, amount:Percent, snapToPixel:Boolean = true):Rectangle {
			return _defineRect(size, size.width * amount.decimalPercentage, size.height * amount.decimalPercentage, snapToPixel);
		}



		/**
		 Scales the width of an area while preserving aspect ratio.

		 @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 @param height: The new height of the area.
		 @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
		 */
		public static function scaleWidth(size:Rectangle, height:Number, snapToPixel:Boolean = true):Rectangle {
			return _defineRect(size, height * widthToHeight(size), height, snapToPixel);
		}



		/**
		 Scales the height of an area while preserving aspect ratio.

		 @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 @param width: The new width of the area.
		 @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
		 */
		public static function scaleHeight(size:Rectangle, width:Number, snapToPixel:Boolean = true):Rectangle {
			return _defineRect(size, width, width * heightToWidth(size), snapToPixel);
		}



		/**
		 Resizes an area to fill the bounding area while preserving aspect ratio.

		 @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 @param bounds: The area to fill. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
		 */
		public static function scaleToFill(size:Rectangle, bounds:Rectangle, snapToPixel:Boolean = true):Rectangle {
			var scaled:Rectangle = scaleHeight(size, bounds.width, snapToPixel);

			if(scaled.height < bounds.height)
				scaled = scaleWidth(size, bounds.height, snapToPixel);

			return scaled;
		}



		/**
		 Resizes an area to the maximum size of a bounding area without exceeding while preserving aspect ratio.

		 @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 @param bounds: The area the rectangle needs to fit within. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
		 @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
		 */
		public static function scaleToFit(size:Rectangle, bounds:Rectangle, snapToPixel:Boolean = true):Rectangle {
			var scaled:Rectangle = scaleHeight(size, bounds.width, snapToPixel);

			if(scaled.height > bounds.height)
				scaled = scaleWidth(size, bounds.height, snapToPixel);

			return scaled;
		}



		protected static function _defineRect(size:Rectangle, width:Number, height:Number, snapToPixel:Boolean):Rectangle {
			var scaled:Rectangle = size.clone();
			scaled.width = snapToPixel ? Math.round(width) : width;
			scaled.height = snapToPixel ? Math.round(height) : height;

			return scaled;
		}
	}
}
