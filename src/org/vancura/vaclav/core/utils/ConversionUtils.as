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
	public class ConversionUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function ConversionUtils() {
			throw new Error('The ConversionUtils class cannot be instantiated.');
		}



		/**
		 Converts bits to bytes.
		 * Original taken from Casalib (http://casalib.org)
		 @param bits: The number of bits.
		 @return Returns the number of bytes.
		 */
		public static function bitsToBytes(bits:Number):Number {
			return bits / 8;
		}



		/**
		 Converts bits to kilobits.
		 * Original taken from Casalib (http://casalib.org)

		 @param bits: The number of bits.
		 @return Returns the number of kilobits.
		 */
		public static function bitsToKilobits(bits:Number):Number {
			return bits / 1024;
		}



		/**
		 Converts bits to kilobytes.
		 * Original taken from Casalib (http://casalib.org)

		 @param bits: The number of bits.
		 @return Returns the number of kilobits.
		 */
		public static function bitsToKilobytes(bits:Number):Number {
			return bits / 8192;
		}



		/**
		 Converts bytes to bits.
		 * Original taken from Casalib (http://casalib.org)

		 @param bytes: The number of bytes.
		 @return Returns the number of bits.
		 */
		public static function bytesToBits(bytes:Number):Number {
			return bytes * 8;
		}



		/**
		 Converts bytes to kilobits.
		 * Original taken from Casalib (http://casalib.org)

		 @param bytes: The number of bytes.
		 @return Returns the number of kilobits.
		 */
		public static function bytesToKilobits(bytes:Number):Number {
			return bytes / 128;
		}



		/**
		 Converts bytes to kilobytes.
		 * Original taken from Casalib (http://casalib.org)

		 @param bytes: The number of bytes.
		 @return Returns the number of kilobytes.
		 */
		public static function bytesToKilobytes(bytes:Number):Number {
			return bytes / 1024;
		}



		/**
		 Converts kilobits to bits.
		 * Original taken from Casalib (http://casalib.org)

		 @param kilobits: The number of kilobits.
		 @return Returns the number of bits.
		 */
		public static function kilobitsToBits(kilobits:Number):Number {
			return kilobits * 1024;
		}



		/**
		 Converts kilobits to bytes.
		 * Original taken from Casalib (http://casalib.org)

		 @param kilobits: The number of kilobits.
		 @return Returns the number of bytes.
		 */
		public static function kilobitsToBytes(kilobits:Number):Number {
			return kilobits * 128;
		}



		/**
		 Converts kilobits to kilobytes.
		 * Original taken from Casalib (http://casalib.org)

		 @param kilobytes: The number of kilobits.
		 @return Returns the number of kilobytes.
		 */
		public static function kilobitsToKilobytes(kilobits:Number):Number {
			return kilobits / 8;
		}



		/**
		 Converts kilobytes to bits.
		 * Original taken from Casalib (http://casalib.org)

		 @param kilobytes: The number of kilobytes.
		 @return Returns the number of bits.
		 */
		public static function kilobytesToBits(kilobytes:Number):Number {
			return kilobytes * 8192;
		}



		/**
		 Converts kilobytes to bytes.
		 * Original taken from Casalib (http://casalib.org)

		 @param kilobytes: The number of kilobytes.
		 @return Returns the number of bytes.
		 */
		public static function kilobytesToBytes(kilobytes:Number):Number {
			return kilobytes * 1024;
		}



		/**
		 Converts kilobytes to kilobits.
		 * Original taken from Casalib (http://casalib.org)

		 @param kilobytes: The number of kilobytes.
		 @return Returns the number of kilobits.
		 */
		public static function kilobytesToKilobits(kilobytes:Number):Number {
			return kilobytes * 8;
		}



		/**
		 Converts milliseconds to seconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param milliseconds: The number of milliseconds.
		 @return Returns the number of seconds.
		 */
		public static function millisecondsToSeconds(milliseconds:Number):Number {
			return milliseconds / 1000;
		}



		/**
		 Converts milliseconds to minutes.
		 * Original taken from Casalib (http://casalib.org)

		 @param milliseconds: The number of milliseconds.
		 @return Returns the number of minutes.
		 */
		public static function millisecondsToMinutes(milliseconds:Number):Number {
			return secondsToMinutes(millisecondsToSeconds(milliseconds));
		}



		/**
		 Converts milliseconds to hours.
		 * Original taken from Casalib (http://casalib.org)

		 @param milliseconds: The number of milliseconds.
		 @return Returns the number of hours.
		 */
		public static function millisecondsToHours(milliseconds:Number):Number {
			return minutesToHours(millisecondsToMinutes(milliseconds));
		}



		/**
		 Converts milliseconds to days.
		 * Original taken from Casalib (http://casalib.org)

		 @param milliseconds: The number of milliseconds.
		 @return Returns the number of days.
		 */
		public static function millisecondsToDays(milliseconds:Number):Number {
			return hoursToDays(millisecondsToHours(milliseconds));
		}



		/**
		 Converts seconds to milliseconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param seconds: The number of seconds.
		 @return Returns the number of milliseconds.
		 */
		public static function secondsToMilliseconds(seconds:Number):Number {
			return seconds * 1000;
		}



		/**
		 Converts seconds to minutes.
		 * Original taken from Casalib (http://casalib.org)

		 @param seconds: The number of seconds.
		 @return Returns the number of minutes.
		 */
		public static function secondsToMinutes(seconds:Number):Number {
			return seconds / 60;
		}



		/**
		 Converts seconds to hours.
		 * Original taken from Casalib (http://casalib.org)

		 @param seconds: The number of seconds.
		 @return Returns the number of hours.
		 */
		public static function secondsToHours(seconds:Number):Number {
			return minutesToHours(secondsToMinutes(seconds));
		}



		/**
		 Converts seconds to days.
		 * Original taken from Casalib (http://casalib.org)

		 @param seconds: The number of seconds.
		 @return Returns the number of days.
		 */
		public static function secondsToDays(seconds:Number):Number {
			return hoursToDays(secondsToHours(seconds));
		}



		/**
		 Converts minutes to milliseconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param minutes: The number of minutes.
		 @return Returns the number of milliseconds.
		 */
		public static function minutesToMilliseconds(minutes:Number):Number {
			return secondsToMilliseconds(minutesToSeconds(minutes));
		}



		/**
		 Converts minutes to seconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param minutes: The number of minutes.
		 @return Returns the number of seconds.
		 */
		public static function minutesToSeconds(minutes:Number):Number {
			return minutes * 60;
		}



		/**
		 Converts minutes to hours.
		 * Original taken from Casalib (http://casalib.org)

		 @param minutes: The number of minutes.
		 @return Returns the number of hours.
		 */
		public static function minutesToHours(minutes:Number):Number {
			return minutes / 60;
		}



		/**
		 Converts minutes to days.
		 * Original taken from Casalib (http://casalib.org)

		 @param minutes: The number of minutes.
		 @return Returns the number of days.
		 */
		public static function minutesToDays(minutes:Number):Number {
			return hoursToDays(minutesToHours(minutes));
		}



		/**
		 Converts hours to milliseconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param hours: The number of hours.
		 @return Returns the number of milliseconds.
		 */
		public static function hoursToMilliseconds(hours:Number):Number {
			return secondsToMilliseconds(hoursToSeconds(hours));
		}



		/**
		 Converts hours to seconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param hours: The number of hours.
		 @return Returns the number of seconds.
		 */
		public static function hoursToSeconds(hours:Number):Number {
			return minutesToSeconds(hoursToMinutes(hours));
		}



		/**
		 Converts hours to minutes.
		 * Original taken from Casalib (http://casalib.org)

		 @param hours: The number of hours.
		 @return Returns the number of minutes.
		 */
		public static function hoursToMinutes(hours:Number):Number {
			return hours * 60;
		}



		/**
		 Converts hours to days.
		 * Original taken from Casalib (http://casalib.org)

		 @param hours: The number of hours.
		 @return Returns the number of days.
		 */
		public static function hoursToDays(hours:Number):Number {
			return hours / 24;
		}



		/**
		 Converts days to milliseconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param days: The number of days.
		 @return Returns the number of milliseconds.
		 */
		public static function daysToMilliseconds(days:Number):Number {
			return secondsToMilliseconds(daysToSeconds(days));
		}



		/**
		 Converts days to seconds.
		 * Original taken from Casalib (http://casalib.org)

		 @param days: The number of days.
		 @return Returns the number of seconds.
		 */
		public static function daysToSeconds(days:Number):Number {
			return minutesToSeconds(daysToMinutes(days));
		}



		/**
		 Converts days to minutes.
		 * Original taken from Casalib (http://casalib.org)

		 @param days: The number of days.
		 @return Returns the number of minutes.
		 */
		public static function daysToMinutes(days:Number):Number {
			return hoursToMinutes(daysToHours(days));
		}



		/**
		 Converts days to hours.
		 * Original taken from Casalib (http://casalib.org)

		 @param days: The number of days.
		 @return Returns the number of hours.
		 */
		public static function daysToHours(days:Number):Number {
			return days * 24;
		}



		/**
		 Converts degrees to radians.
		 * Original taken from Casalib (http://casalib.org)

		 @param degrees: The number of degrees.
		 @return Returns the number of radians.
		 */
		public static function degreesToRadians(degrees:Number):Number {
			return degrees * (Math.PI / 180);
		}



		/**
		 Converts radians to degrees.
		 * Original taken from Casalib (http://casalib.org)

		 @param radians: The number of radians.
		 @return Returns the number of degrees.
		 */
		public static function radiansToDegrees(radians:Number):Number {
			return radians * (180 / Math.PI);
		}
	}
}
