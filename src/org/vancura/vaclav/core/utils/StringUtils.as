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
	public class StringUtils {


		public static const REGEX_UNSAFE_CHARS:String = "\\-^[]";

		protected static const TRIM_RIGHT_REGEX:RegExp = /[\s]+$/g;



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function StringUtils() {
			throw new Error('The StringUtils class cannot be instantiated.');
		}



		/**
		 * Generate random String.
		 * @param length String length (default 10)
		 * @param chars Chars used (default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')
		 * @return Random String
		 * @author Vaclav Vancura (http://vaclav.vancura.org)
		 */
		public static function randomString(length:uint = 10, chars:String = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):String {
			var alphabet:Array = chars.split('');
			var alphabetLength:int = alphabet.length;
			var randomLetters:String = '';

			for(var j:uint = 0; j < length; j++) {
				var r:Number = Math.random() * alphabetLength;
				var s:int = Math.floor(r);
				randomLetters += alphabet[s];
			}

			return randomLetters;
		}



		/**
		 * Returns the truncated string with an appended ellipsis (...) if the length of <code>str</code> is greater than <code>len</code>.
		 * If the length of <code>str</code> is less than or equal to <code>len</code>, the method returns <code>str</code> unaltered.
		 * @param str the string to truncate
		 * @param len the length to limit the string to
		 * @return
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function truncate(str:String, len:int):String {
			// return the string if str is null, empty, or the length of str is less than or equal to len
			if(!str || str.length <= len) return str;

			// short str to len
			str = str.substr(0, len);

			// trim the right side of whitespace
			str = str.replace(TRIM_RIGHT_REGEX, "");

			// append the ellipsis
			return str + "...";
		}



		/**
		 * @private
		 * @param chars
		 * @return
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		protected static function slashUnsafeChars(chars:String):String {
			var unsafeChar:String;
			var m:uint = REGEX_UNSAFE_CHARS.length;

			for(var i:uint = 0; i < m; ++i) {
				unsafeChar = REGEX_UNSAFE_CHARS.substr(i, 1);

				if(chars.indexOf(unsafeChar) != -1) chars = chars.replace(unsafeChar, "\\" + unsafeChar);
			}

			return chars;
		}



		/**
		 * Returns the string with slashes prepended to all characters specified in the <code>chars</code> parameter
		 * @param str the string to return slashed
		 * @param chars the string of chars to slash
		 * @return
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function addSlashes(str:String, chars:String = "\""):String {
			// return the unaltered string if str or chars are null or empty
			if(!str || !chars) return str;

			// slash unsafe characters
			chars = slashUnsafeChars(chars);

			// build the regular expression that handles the slashing
			var regex:RegExp = new RegExp("([" + chars + "])", "g");

			// add the slashes to the specified characters
			return str.replace(regex, "\\$1");
		}



		/**
		 * Returns the string with slashes removed from all characters specified in the <code>chars</code> parameter
		 * @param str the string to return stripped of slashes
		 * @param chars the string of chars to remove slashes from
		 * @return
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function stripSlashes(str:String, chars:String = "\""):String {
			// return the unaltered string if str or chars are null or empty
			if(!str || !chars) return str;

			// slash unsafe characters
			chars = slashUnsafeChars(chars);

			// build the regular expression that removes the slashes
			var regex:RegExp = new RegExp("\\\\([" + chars + "])", "g");

			// strip the slashes from the specified characters
			return str.replace(regex, "$1");
		}
	}
}
