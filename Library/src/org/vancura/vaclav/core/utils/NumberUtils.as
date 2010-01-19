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
	import org.vancura.vaclav.core.types.Percent;

	public class NumberUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function NumberUtils() {
			throw new Error('The NumberUtils class cannot be instantiated.');
		}



		/**
		 Determines if the two values are equal, with the option to define the precision.
		 CASA
		 @param val1: A value to compare.
		 @param val2: A value to compare.
		 @param precision: The maximum amount the two values can differ and still be considered equal.
		 @return Returns <code>true</code> the values are equal; otherwise <code>false</code>.
		 @example
		 <code>
		 trace(NumberUtils.isEqual(3.042, 3, 0)); // Traces false
		 trace(NumberUtils.isEqual(3.042, 3, 0.5)); // Traces true
		 </code>
		 */
		public static function isEqual(val1:Number, val2:Number, precision:Number = 0):Boolean {
			return Math.abs(val1 - val2) <= Math.abs(precision);
		}



		/**
		 Evaluates <code>val1</code> and <code>val2</code> and returns the smaller value. Unlike <code>Math.min</code> this method will return the defined value if the other value is <code>null</code> or not a number.
		 CASA
		 @param val1: A value to compare.
		 @param val2: A value to compare.
		 @return Returns the smallest value, or the value out of the two that is defined and valid.
		 @example
		 <code>
		 trace(NumberUtils.min(5, null)); // Traces 5
		 trace(NumberUtils.min(5, "CASA")); // Traces 5
		 trace(NumberUtils.min(5, 13)); // Traces 5
		 </code>
		 */
		public static function min(val1:*, val2:*):Number {
			if(isNaN(val1) && isNaN(val2) || val1 == null && val2 == null)
				return NaN;

			if(val1 == null || val2 == null)
				return (val2 == null) ? val1 : val2;

			if(isNaN(val1) || isNaN(val2))
				return isNaN(val2) ? val1 : val2;

			return Math.min(val1, val2);
		}



		/**
		 Evaluates <code>val1</code> and <code>val2</code> and returns the larger value. Unlike <code>Math.max</code> this method will return the defined value if the other value is <code>null</code> or not a number.
		 CASA
		 @param val1: A value to compare.
		 @param val2: A value to compare.
		 @return Returns the largest value, or the value out of the two that is defined and valid.
		 @example
		 <code>
		 trace(NumberUtils.max(-5, null)); // Traces -5
		 trace(NumberUtils.max(-5, "CASA")); // Traces -5
		 trace(NumberUtils.max(-5, -13)); // Traces -5
		 </code>
		 */
		public static function max(val1:*, val2:*):Number {
			if(isNaN(val1) && isNaN(val2) || val1 == null && val2 == null)
				return NaN;

			if(val1 == null || val2 == null)
				return (val2 == null) ? val1 : val2;

			if(isNaN(val1) || isNaN(val2))
				return (isNaN(val2)) ? val1 : val2;

			return Math.max(val1, val2);
		}



		/**
		 Determines if the number is even.
		 CASA
		 @param value: A number to determine if it is divisible by <code>2</code>.
		 @return Returns <code>true</code> if the number is even; otherwise <code>false</code>.
		 @example
		 <code>
		 trace(NumberUtils.isEven(7)); // Traces false
		 trace(NumberUtils.isEven(12)); // Traces true
		 </code>
		 */
		public static function isEven(value:Number):Boolean {
			return (value & 1) == 0;
		}



		/**
		 Determines if the number is odd.
		 CASA
		 @param value: A number to determine if it is not divisible by <code>2</code>.
		 @return Returns <code>true</code> if the number is odd; otherwise <code>false</code>.
		 @example
		 <code>
		 trace(NumberUtils.isOdd(7)); // Traces true
		 trace(NumberUtils.isOdd(12)); // Traces false
		 </code>
		 */
		public static function isOdd(value:Number):Boolean {
			return !isEven(value);
		}



		/**
		 Determines if the number is an integer.
		 CASA
		 @param value: A number to determine if it contains no decimal values.
		 @return Returns <code>true</code> if the number is an integer; otherwise <code>false</code>.
		 @example
		 <code>
		 trace(NumberUtils.isInteger(13)); // Traces true
		 trace(NumberUtils.isInteger(1.2345)); // Traces false
		 </code>
		 */
		public static function isInteger(value:Number):Boolean {
			return (value % 1) == 0;
		}



		/**
		 Determines if the number is prime.
		 CASA
		 @param value: A number to determine if it is only divisible by <code>1</code> and itself.
		 @return Returns <code>true</code> if the number is prime; otherwise <code>false</code>.
		 @example
		 <code>
		 trace(NumberUtils.isPrime(13)); // Traces true
		 trace(NumberUtils.isPrime(4)); // Traces false
		 </code>
		 */
		public static function isPrime(value:Number):Boolean {
			if(value == 1 || value == 2)
				return true;

			if(isEven(value))
				return false;

			var s:Number = Math.sqrt(value);
			for(var i:Number = 3; i <= s; i++)
				if(value % i == 0)
					return false;

			return true;
		}



		/**
		 Rounds a number's decimal value to a specific place.
		 CASA
		 @param value: The number to round.
		 @param place: The decimal place to round.
		 @return Returns the value rounded to the defined place.
		 @example
		 <code>
		 trace(NumberUtils.roundToPlace(3.14159, 2)); // Traces 3.14
		 trace(NumberUtils.roundToPlace(3.14159, 3)); // Traces 3.142
		 </code>
		 */
		public static function roundDecimalToPlace(value:Number, place:uint):Number {
			var p:Number = Math.pow(10, place);

			return Math.round(value * p) / p;
		}



		/**
		 Determines if index is included within the collection length otherwise the index loops to the beginning or end of the range and continues.
		 CASA
		 @param index: Index to loop if needed.
		 @param length: The total elements in the collection.
		 @return A valid zero-based index.
		 @example
		 <code>
		 var colors:Array = new Array("Red", "Green", "Blue");

		 trace(colors[NumberUtils.loopIndex(2, colors.length)]); // Traces Blue
		 trace(colors[NumberUtils.loopIndex(4, colors.length)]); // Traces Green
		 trace(colors[NumberUtils.loopIndex(-6, colors.length)]); // Traces Red
		 </code>
		 */
		public static function loopIndex(index:int, length:uint):uint {
			if(index < 0)
				index = length + index % length;

			if(index >= length)
				return index % length;

			return index;
		}



		/**
		 Determines if the value is included within a range.

		 @param value: Number to determine if it is included in the range.
		 @param firstValue: First value of the range.
		 @param secondValue: Second value of the range.
		 @return Returns <code>true</code> if the number falls within the range; otherwise <code>false</code>.
		 @usageNote The range values do not need to be in order.
		 @example
		 <code>
		 trace(NumberUtils.isBetween(3, 0, 5)); // Traces true
		 trace(NumberUtils.isBetween(7, 0, 5)); // Traces false
		 </code>
		 */
		public static function isBetween(value:Number, firstValue:Number, secondValue:Number):Boolean {
			return !(value < Math.min(firstValue, secondValue) || value > Math.max(firstValue, secondValue));
		}



		/**
		 Determines if value falls within a range; if not it is snapped to the nearest range value.

		 @param value: Number to determine if it is included in the range.
		 @param firstValue: First value of the range.
		 @param secondValue: Second value of the range.
		 @return Returns either the number as passed, or its value once snapped to nearest range value.
		 @usageNote The constraint values do not need to be in order.
		 @example
		 <code>
		 trace(NumberUtils.constrain(3, 0, 5)); // Traces 3
		 trace(NumberUtils.constrain(7, 0, 5)); // Traces 5
		 </code>
		 */


		/**
		 * Resticts the <code>value</code> to the <code>min</code> and <code>max</code>
		 * @param value the number to restrict
		 * @param min the minimum number for <code>value</code> to be
		 * @param max the maximmum number for <code>value</code> to be
		 * @return
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function confine(value:Number, min:Number, max:Number):Number {
			return value < min ? min : (value > max ? max : value);
		}



		/**
		 * Pads the <code>value</code> with the set number of digits before and after the point.
		 * If the number of digits in the integer of <code>value</code> is less than <code>beforePoint</code>, the remaining digits are filled with zeros.
		 * If the number of digits in the decimal of <code>value</code> is less than <code>afterPoint</code>, the remaning digits are filled with zeros.
		 * @param value the number to pad
		 * @param beforePoint the number of digits to pad before the point
		 * @param afterPoint the number of digits to pad after the point
		 * @return <code>value</code> padded as a <code>String</code>
		 * @example
		 * <listing version="3.0">
		 * NumberUtils.pad(.824, 0, 5); // returns ".82400"
		 * NumberUtils.pad(9, 3, 2); // returns "009.00"
		 * NumberUtils.pad(2835.3, 4, 2); // returns "2835.30"
		 * </listing>
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function pad(value:Number, beforePoint:uint, afterPoint:uint = 0):String {
			// separate the integer from the decimal
			var valueArray:Array = String(value).split(".");

			var integer:String = valueArray[0];

			// determine the sign of the value
			var negative:Boolean = integer.substr(0, 1) == "-";

			// remove the "-" if it exists
			if(negative) integer = integer.substr(1);

			// treat zeros as empty, so integer.length doesn't return 1 when integer is 0
			if(integer == "0") {
				integer = "";
			}

			var len:int = integer.length;

			// determine how many times "0" needs to be prepended
			var zeros:int = Math.max(0, beforePoint - len);

			// prepend "0" until zeros == 0
			while(zeros--) integer = "0" + integer;

			var decimal:String;

			// if a point didn't exist or the decimal is 0, empty the decimal
			if(valueArray.length == 1 || valueArray[1] == "0") {
				decimal = "";
			}
			else {
				decimal = valueArray[1];
			}

			len = decimal.length;

			// determine how many times "0" needs to be appended
			zeros = Math.max(0, afterPoint - len);

			// append "0" until zeros == 0
			while(zeros--) decimal += "0";

			// set sign if negative
			var sign:String = negative ? "-" : "";

			// set point if a decimal exists (or afterPoint > 0, determined earlier)
			var point:String = decimal ? "." : "";

			return sign + integer + point + decimal;
		}



		/**
		 * Rounds a number to the nearest nth, where <code>digits</code> is n / 10.
		 * @param value the number to round
		 * @param digits the number of digits to show after the point
		 * @return
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function round(value:Number, digits:int):Number {
			digits = Math.pow(10, digits);

			return Math.round(value * digits) / digits;
		}



		/**
		 * Inserts commas every three digits in the integer of <code>value</code>
		 * @param value the number to insert commas into
		 * @return <code>value</code> as a <code>String</code> formatted with commas
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function insertCommas(value:Number):String {
			// convert the value to a string
			var valueString:String = String(value);

			// determine the location of the point
			var commaIndex:int = valueString.indexOf(".");

			// if a point doesn't exist, consider it to be at the end of the value
			if(commaIndex == -1) commaIndex = valueString.length;

			do {
				// move to the left three digits
				commaIndex -= 3;

				// if index is beyond the beginning of the value, end the loop
				if(commaIndex <= 0) break;

				// insert the comma
				valueString = valueString.substring(0, commaIndex) + "," + valueString.substr(commaIndex);
			}
			while(true);

			// remove "0" if value is a decimal
			if(valueString.substr(0, 2) == "0.") valueString = valueString.substr(1);

			return valueString;
		}



		/**
		 Creates evenly spaced numerical increments between two numbers.
		 CASA
		 @param begin: The starting value.
		 @param end: The ending value.
		 @param steps: The number of increments between the starting and ending values.
		 @return Returns an Array composed of the increments between the two values.
		 @example
		 <code>
		 trace(NumberUtils.createStepsBetween(0, 5, 4)); // Traces 1,2,3,4
		 trace(NumberUtils.createStepsBetween(1, 3, 3)); // Traces 1.5,2,2.5
		 </code>
		 */
		public static function createStepsBetween(begin:Number, end:Number, steps:Number):Array {
			steps++;

			var i:uint = 0;
			var stepsBetween:Array = new Array();
			var increment:Number = (end - begin) / steps;

			while(++i < steps)
				stepsBetween.push((i * increment) + begin);

			return stepsBetween;
		}



		/**
		 Determines a value between two specified values.
		 CASA
		 @param amount: The level of interpolation between the two values. If <code>0%</code>, <code>begin</code> value is returned; if <code>100%</code>, <code>end</code> value is returned.
		 @param minimum: The lower value.
		 @param maximum: The upper value.
		 @example
		 <code>
		 trace(NumberUtils.interpolate(new Percent(0.5), 0, 10)); // Traces 5
		 </code>
		 */
		public static function interpolate(amount:Percent, minimum:Number, maximum:Number):Number {
			return minimum + (maximum - minimum) * amount.decimalPercentage;
		}



		/**
		 Determines a percentage of a value in a given range.
		 CASA
		 @param value: The value to be converted.
		 @param minimum: The lower value of the range.
		 @param maximum: The upper value of the range.
		 @example
		 <code>
		 trace(NumberUtils.normalize(8, 4, 20).decimalPercentage); // Traces 0.25
		 </code>
		 */
		public static function normalize(value:Number, minimum:Number, maximum:Number):Percent {
			return new Percent((value - minimum) / (maximum - minimum));
		}



		/**
		 Maps a value from one coordinate space to another.
		 CASA
		 @param value: Value from the input coordinate space to map to the output coordinate space.
		 @param min1: Starting value of the input coordinate space.
		 @param max1: Ending value of the input coordinate space.
		 @param min2: Starting value of the output coordinate space.
		 @param max2: Ending value of the output coordinate space.
		 @example
		 <code>
		 trace(NumberUtils.map(0.75, 0, 1, 0, 100)); // Traces 75
		 </code>
		 */
		public static function map(value:Number, min1:Number, max1:Number, min2:Number, max2:Number):Number {
			return min2 + (max2 - min2) * ((value - min1) / (max1 - min1));
		}



		/**
		 Low pass filter alogrithm for easing a value toward a destination value. Works best for tweening values when no definite time duration exists and when the destination value changes.
		 CASA
		 If <code>(0.5 < n < 1)</code>, then the resulting values will overshoot (ping-pong) until they reach the destination value. When <code>n</code> is greater than 1, as its value increases, the time it takes to reach the destination also increases. A pleasing value for <code>n</code> is 5.

		 @param value: The current value.
		 @param dest: The destination value.
		 @param n: The slowdown factor.
		 @return The weighted average.
		 */
		public static function getWeightedAverage(value:Number, dest:Number, n:Number):Number {
			return value + (dest - value) / n;
		}



		/**
		 Formats a number.
		 CASA
		 @param value: The number you wish to format.
		 @param minLength: The minimum length of the number.
		 @param thouDelim: The character used to seperate thousands.
		 @param fillChar: The leading character used to make the number the minimum length.
		 @return Returns the formated number as a String.
		 @example
		 <code>
		 trace(NumberUtils.format(1234567, 8, ",")); // Traces 01,234,567
		 </code>
		 */
		public static function format(value:Number, minLength:uint, thouDelim:String = null, fillChar:String = null):String {
			var num:String = value.toString();
			var len:uint = num.length;

			if(thouDelim != null) {
				var numSplit:Array = num.split('');
				var counter:uint = 3;
				var i:uint = numSplit.length;

				while(--i > 0) {
					counter--;
					if(counter == 0) {
						counter = 3;
						numSplit.splice(i, 0, thouDelim);
					}
				}

				num = numSplit.join('');
			}

			if(minLength != 0) {
				if(len < minLength) {
					minLength -= len;

					var addChar:String = (fillChar == null) ? '0' : fillChar;

					while(minLength--)
						num = addChar + num;
				}
			}

			return num;
		}



		/**
		 Finds the English ordinal suffix for the number given.
		 CASA
		 @param value: Number to find the ordinal suffix of.
		 @return Returns the suffix for the number, 2 characters.
		 @example
		 <code>
		 trace(32 + NumberUtils.getOrdinalSuffix(32)); // Traces 32nd
		 </code>
		 */
		public static function getOrdinalSuffix(value:int):String {
			if(value >= 10 && value <= 20)
				return 'th';

			switch(value % 10) {
				case 0 :
				case 4 :
				case 5 :
				case 6 :
				case 7 :
				case 8 :
				case 9 :
					return 'th';
				case 3 :
					return 'rd';
				case 2 :
					return 'nd';
				case 1 :
					return 'st';
				default :
					return '';
			}
		}



		/**
		 Adds a leading zero for numbers less than ten.
		 CASA
		 @param value: Number to add leading zero.
		 @return Number as a String; if the number was less than ten the number will have a leading zero.
		 @example
		 <code>
		 trace(NumberUtils.addLeadingZero(7)); // Traces 07
		 trace(NumberUtils.addLeadingZero(11)); // Traces 11
		 </code>
		 */
		public static function addLeadingZero(value:Number):String {
			return (value < 10) ? '0' + value : value.toString();
		}



		/**
		 * Determines whether or not the supplied number is positive
		 * Nemo
		 * @param _num     The number to evaluate
		 * @return Whether or not the supplied number is positive
		 */
		public static function isPositive(_num:Number):Boolean {
			return(_num >= 0) as Boolean;
		}



		/**
		 * Determines whether or not the supplied number is negative
		 * Nemo
		 * @param _num     The number to evaluate
		 * @return Whether or not the supplied number is negative
		 */
		public static function isNegative(_num:Number):Boolean {
			return !isPositive(_num);
		}



		/**
		 * Determines whether or not the supplied number is a decimal
		 * Nemo
		 * @param _num    The number to be evaluated
		 * @return         True if _num is a decimal
		 * @example
		 * <code>
		 * trace(MathUtils.isDecimalNumber(1.1)); // true
		 * trace(MathUtils.isDecimalNumber(0.3)); // true
		 * trace(MathUtils.isDecimalNumber(5)); // false
		 * </code>
		 */
		public static function isDecimalNumber(_num:Number):Boolean {
			return !isInteger(_num);
		}



		/**
		 * Returns an {@code Array} of even numbers within the supplied range
		 * Nemo
		 * @param _min    The minimum range, if a decimal is passed the floor is used
		 * @param _max    The maximum range, if a decimal is passed the floor is used
		 * @return         {@code Array} of even numbers within the supplied range
		 */
		public static function getEvenNumbersWithinRange(_min:int, _max:int):Array {
			var _int:int = 0;
			if(isEven(_min)) _int = 1;
			var _evens:Array = new Array();
			for(var i:int = _min; i <= _max; i++) {
				//if(isEven(i)) _evens.push(i);        // this works but whats being used is faster as it requires no division
				if(_int == 1) _evens.push(i);
				_int = _abs(_int - 1);
			}
			return _evens;
		}



		/**
		 * Returns an {@code Array} of odd numbers within the supplied range
		 * Nemo
		 * @param _min    The minimum range, if a decimal is passed the floor is used
		 * @param _max    The maximum range, if a decimal is passed the floor is used
		 * @return         {@code Array} of odd numbers within the supplied range
		 */
		public static function getOddNumbersWithinRange(_min:int, _max:int):Array {

			var _int:int = 0;
			if(isOdd(_min)) _int = 1;
			var _odds:Array = new Array();
			for(var i:int = _min; i <= _max; i++) {
				//if(isOdd(i)) _odds.push(i);    // this works but whats being used is faster as it requires no division
				if(_int == 1) _odds.push(i);
				_int = _abs(_int - 1);
			}
			return _odds;
		}



		/**
		 * Returns an {@code Array} of prime numbers within the supplied range
		 * Nemo
		 * @param _min    The minimum range, if a decimal is passed the floor is used
		 * @param _max    The maximum range, if a decimal is passed the floor is used
		 * @return         {@code Array} of primes within the supplied range
		 */
		public static function getPrimeNumbersWithinRange(_min:int, _max:int):Array {
			var _primes:Array = new Array();
			for(var i:int = _min; i <= _max; i++) {
				if(isPrime(i)) _primes.push(i);
			}
			return _primes;
		}



		private static function _random(n:Number):Number {
			return (Math.random() * n);
		}



		private static function _round(n:Number):int {
			return(Math.round(n));
		}



		private static function _abs(n:Number):Number {
			if(n < 0) return -n;
			return n;
		}
	}
}
