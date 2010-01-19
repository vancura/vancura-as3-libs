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
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GeomUtils {



		/** The pre-calcuated value of Math.PI */
		public static var PI:Number = 3.141592653589793;
		/** The pre-calcuated value of (Math.PI/180) */
		public static var PI_OVER_180:Number = 0.017453292519943295;



		/**
		 * Constructor.
		 */
		public function GeomUtils() {
		}



		/**
		 Rotates a Point around another Point by the specified angle.
		 CASA
		 @param point: The Point to rotate.
		 @param centerPoint: The Point to rotate this Point around.
		 @param angle: The angle (in degrees) to rotate this point.
		 */
		public static function rotatePoint(point:Point, centerPoint:Point, angle:Number):void {
			var radians:Number = ConversionUtils.degreesToRadians(angle);
			var baseX:Number = point.x - centerPoint.x;
			var baseY:Number = point.y - centerPoint.y;

			point.x = (Math.cos(radians) * baseX) - (Math.sin(radians) * baseY) + centerPoint.x;
			point.y = (Math.sin(radians) * baseX) + (Math.cos(radians) * baseY) + centerPoint.y;
		}



		/**
		 Determines the angle/degree between the first and second point.
		 CASA
		 @param first: The first Point.
		 @param second: The second Point.
		 @return The degree between the two points.
		 */
		public static function angle(first:Point, second:Point):Number {
			return Math.atan2(second.y - first.y, second.x - first.x) / (Math.PI / 180);
		}



		/**
		 Calculates the perimeter of a rectangle.
		 CASA
		 @param rect: Rectangle to determine the perimeter of.
		 */
		public static function getRectanglePerimeter(rect:Rectangle):Number {
			return rect.width * 2 + rect.height * 2;
		}



		/**
		 * Converts the supplied degrees to radians
		 * Nemo
		 * @param _degrees    The degrees to be converted to radians
		 * @return             The supplied degrees converted to radians
		 */
		public static function degreesToRadians(_degrees:Number):Number {
			return _degrees * PI_OVER_180;
		}



		/**
		 * Converts the supplied radians represented as degrees
		 * Nemo
		 * @param _radians    The radians to be converted to degrees
		 * @return             The radians converted to degrees
		 */
		public static function radiansToDegrees(_radians:Number):Number {
			return _radians / PI_OVER_180;
		}



		/**
		 * Simplifys the supplied angle to its simpliest representation
		 * Nemo
		 * @param _angle    The angle to simplify
		 * @return         The supplied angle simplified
		 * @example
		 * <code>
		 * var _simpAngle:Number = MathUtils.simplifyAngle(725); // returns 5
		 * var _simpAngle2:Number = MathUtils.simplifyAngle(-725); // returns -5
		 * </code>
		 */
		public static function simplifyAngle(_angle:Number):Number {
			var _rotations:Number = Math.floor(_angle / 360);
			return (_angle >= 0) ? _angle - (360 * _rotations) : _angle + (360 * _rotations);
		}


	}
}
