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
	import org.vancura.vaclav.core.types.Percent;

	public class LoadUtils {



		/**
		 * Constructor.
		 */
		public function LoadUtils() {
		}



		/**
		 Calculates the load speed in bytes per second (Bps).
CASA
		 @param bytesLoaded: Number of bytes that have loaded between <code>startTime</code> and <code>elapsedTime</code>.
		 @param startTime: Time in milliseconds when the load started.
		 @param elapsedTime: Time in milliseconds since the load started or time when load completed.
		 @return Bytes per second.
		 @usageNote This method returns BYTES per second, not bits per second.
		 */
		public static function calculateBps(bytesLoaded:uint, startTime:uint, elapsedTime:uint):int {
			return Math.max(0, (bytesLoaded / ConversionUtils.millisecondsToSeconds(elapsedTime - startTime)));
		}



		/**
		 Calculates the load speed in kilobytes per second (kBps).
		 CASA
		 @param bytesLoaded: Number of bytes that have loaded between <code>startTime</code> and <code>elapsedTime</code>.
		 @param startTime: Time in milliseconds when the load started.
		 @param elapsedTime: Time in milliseconds since the load started or time when load completed.
		 @return Kilobytes per second.
		 @usageNote This method returns kiloBYTES per second, not kilobits per second.
		 */
		public static function calculateKBps(bytesLoaded:uint, startTime:uint, elapsedTime:uint):Number {
			return ConversionUtils.bytesToKilobytes(calculateBps(bytesLoaded, startTime, elapsedTime));
		}



		/**
		 Calculates the percent the video has buffered.
		 CASA
		 @param bytesLoaded: Number of bytes that have loaded between <code>startTime</code> and <code>elapsedTime</code>.
		 @param bytesTotal: Number of bytes total to be loaded.
		 @param startTime: Time in milliseconds when the load started.
		 @param elapsedTime: The current time in milliseconds or time when load completed.
		 @param lengthInMilliseconds: The total duration/length of the video in milliseconds.
		 @return The percent buffered.
		 */
		public static function calculateBufferPercent(bytesLoaded:uint, bytesTotal:uint, startTime:uint, elapsedTime:uint,
		                                              lengthInMilliseconds:uint):Percent {
			var totalWait:Number = bytesTotal / (bytesLoaded / (elapsedTime - startTime)) - lengthInMilliseconds;
			var millisecondsRemaining:uint = calculateMillisecondsUntilBuffered(bytesLoaded, bytesTotal, startTime, elapsedTime, lengthInMilliseconds);

			return (totalWait == Number.POSITIVE_INFINITY) ? new Percent(0) : new Percent(NumberUtils.confine(1 - millisecondsRemaining / totalWait, 0, 1));
		}



		/**
		 Calculates the remaining time until the video is buffered.
		 CASA
		 @param bytesLoaded: Number of bytes that have loaded between <code>startTime</code> and <code>elapsedTime</code>.
		 @param bytesTotal: Number of bytes total to be loaded.
		 @param startTime: Time in milliseconds when the load started.
		 @param elapsedTime: The current time in milliseconds or time when load completed.
		 @param lengthInMilliseconds: The total duration/length of the video in milliseconds.
		 @return The amount millisecond that remain before the video is buffered.
		 */
		public static function calculateMillisecondsUntilBuffered(bytesLoaded:uint, bytesTotal:uint, startTime:uint,
		                                                          elapsedTime:uint, lengthInMilliseconds:uint):uint {
			return Math.max(Math.ceil((bytesTotal - bytesLoaded) / (bytesLoaded / (elapsedTime - startTime))) - lengthInMilliseconds, 0);
		}
	}
}
