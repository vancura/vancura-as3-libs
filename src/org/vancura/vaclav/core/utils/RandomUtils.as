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
	public class RandomUtils {



		/**
		 * Constructor.
		 */
		public function RandomUtils() {
		}



		// random(); // returns a number between 0-1 exclusive.
		/**
		 * Grant Skinner
		 * @return
		 */
		public static function random():Number {
			return Math.random();
		}



		// float(50); // returns a number between 0-50 exclusive
		// float(20,50); // returns a number between 20-50 exclusive
		/**
		 * Grant Skinner
		 * @param min
		 * @param max
		 * @return
		 */
		public static function float(min:Number, max:Number = NaN):Number {
			if(isNaN(max)) {
				max = min;
				min = 0;
			}
			return random() * (max - min) + min;
		}



		// boolean(); // returns true or false (50% chance of true)
		// boolean(0.8); // returns true or false (80% chance of true)
		/**
		 * Grant Skinner
		 * @param chance
		 * @return
		 */
		public static function boolean(chance:Number = 0.5):Boolean {
			return (random() < chance);
		}



		// sign(); // returns 1 or -1 (50% chance of 1)
		// sign(0.8); // returns 1 or -1 (80% chance of 1)
		/**
		 * Grant Skinner
		 * @param chance
		 * @return
		 */
		public static function sign(chance:Number = 0.5):int {
			return (random() < chance) ? 1 : -1;
		}



		// bit(); // returns 1 or 0 (50% chance of 1)
		// bit(0.8); // returns 1 or 0 (80% chance of 1)
		/**
		 * Grant Skinner
		 * @param chance
		 * @return
		 */
		public static function bit(chance:Number = 0.5):int {
			return (random() < chance) ? 1 : 0;
		}



		// integer(50); // returns an integer between 0-49 inclusive
		// integer(20,50); // returns an integer between 20-49 inclusive
		/**
		 * Grant Skinner
		 * @param min
		 * @param max
		 * @return
		 */
		public static function integer(min:Number, max:Number = NaN):int {
			if(isNaN(max)) {
				max = min;
				min = 0;
			}
			// Need to use floor instead of bit shift to work properly with negative values:
			return Math.floor(float(min, max));
		}
	}
}
