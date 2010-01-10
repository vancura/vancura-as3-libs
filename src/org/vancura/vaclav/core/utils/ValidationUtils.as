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
	public class ValidationUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function ValidationUtils() {
			throw new Error('The ValidationUtils class cannot be instantiated.');
		}



		/**
		 Determines if String is a valid email address.
		 * Original taken from Casalib (http://casalib.org)
		 @param email: String to verify as email.
		 @return Returns <code>true</code> if String is a valid email; otherwise <code>false</code>.
		 @see <a href="http://www.regular-expressions.info/email.html">Read more about the regular expression used by this method.</a>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function isEmail(email:String):Boolean {
			var pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
			return email.match(pattern) != null;
		}



		/**
		 Determines if String is a valid USA state abbreviation.
		 * Original taken from Casalib (http://casalib.org)
		 @param state: String to verify as two letter state abbreviation (includes DC).
		 @return Returns <code>true</code> if String is a state abbreviation; otherwise <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function isUsaStateAbbreviation(state:String):Boolean {
			var states:Array = new Array('ak', 'al', 'ar', 'az', 'ca', 'co', 'ct', 'dc', 'de', 'fl', 'ga', 'hi', 'ia', 'id', 'il', 'in', 'ks', 'ky', 'la', 'ma', 'md', 'me', 'mi', 'mn', 'mo', 'ms', 'mt', 'nb', 'nc', 'nd', 'nh', 'nj', 'nm', 'nv', 'ny', 'oh', 'ok', 'or', 'pa', 'ri', 'sc', 'sd', 'tn', 'tx', 'ut', 'va', 'vt', 'wa', 'wi', 'wv', 'wy');
			return ArrayUtils.contains(states, state.toLowerCase()) == 1;
		}



		/**
		 Determines if credit card is valid using the Luhn formula.
		 * Original taken from Casalib (http://casalib.org)
		 @param cardNumber: The credit card number.
		 @return Returns <code>true</code> if String is a valid credit card number; otherwise <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function isCreditCard(cardNumber:String):Boolean {
			if(cardNumber.length < 7 || cardNumber.length > 19 || Number(cardNumber) < 1000000)
				return false;

			var pre:Number;
			var sum:Number = 0;
			var alt:Boolean = true;

			var i:Number = cardNumber.length;
			while(--i > -1) {
				if(alt)
					sum += Number(cardNumber.substr(i, 1));
				else {
					pre = Number(cardNumber.substr(i, 1)) * 2;
					sum += (pre > 8) ? pre -= 9 : pre;
				}

				alt = !alt;
			}

			return sum % 10 == 0;
		}



		/**
		 Determines credit card provider by card number.
		 * Original taken from Casalib (http://casalib.org)
		 @param cardNumber: The credit card number.
		 @return Returns name of the provider; values can be <code>"visa"</code>, <code>"mastercard"</code>, <code>"discover"</code>, <code>"amex"</code>, <code>"diners"</code>, <code>"other"</code> or <code>"invalid"</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getCreditCardProvider(cardNumber:String):String {
			if(!isCreditCard(cardNumber))
				return 'invalid';

			if(cardNumber.length == 13 || cardNumber.length == 16 && cardNumber.indexOf('4') == 0) {
				return 'visa';
			} else if(cardNumber.indexOf('51') == 0 || cardNumber.indexOf('52') == 0 || cardNumber.indexOf('53') == 0 || cardNumber.indexOf('54') == 0 || cardNumber.indexOf('55') == 0 && cardNumber.length == 16) {
				return 'mastercard';
			} else if(cardNumber.length == 16 && cardNumber.indexOf('6011') == 0) {
				return 'discover';
			} else if(cardNumber.indexOf('34') == 0 || cardNumber.indexOf('37') == 0 && cardNumber.length == 15) {
				return 'amex';
			} else if(cardNumber.indexOf('300') == 0 || cardNumber.indexOf('301') == 0 || cardNumber.indexOf('302') == 0 || cardNumber.indexOf('303') == 0 || cardNumber.indexOf('304') == 0 || cardNumber.indexOf('305') == 0 || cardNumber.indexOf('36') == 0 || cardNumber.indexOf('38') == 0 && cardNumber.length == 14) {
				return 'diners';
			}
			else return 'other';
		}
	}
}
