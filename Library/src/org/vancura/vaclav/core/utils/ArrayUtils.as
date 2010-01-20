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
	public class ArrayUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function ArrayUtils() {
			throw new Error('The ArrayUtils class cannot be instantiated.');
		}



		/**
		 * Returns the first element that matches <code>match</code> for the property <code>key</code>.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to search for an element with a <code>key</code> that matches <code>match</code>.
		 * @param key Name of the property to match.
		 * @param match Value to match against.
		 * @return Returns matched <code>Object</code>; otherwise <code>null</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getItemByKey(inArray:Array, key:String, match:*):* {
			for each (var item:* in inArray)
				if(item[key] == match)
					return item;

			return null;
		}



		/**
		 * Returns every element that matches <code>match</code> for the property <code>key</code>.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to search for object with <code>key</code> that matches <code>match</code>.
		 * @param key Name of the property to match.
		 * @param match Value to match against.
		 * @return Returns all the matched elements.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getItemsByKey(inArray:Array, key:String, match:*):Array {
			var t:Array = new Array();

			for each (var item:* in inArray)
				if(item[key] == match)
					t.push(item);

			return t;
		}



		/**
		 * Returns the first element that is compatible with a specific data type, class, or interface.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to search for an element of a specific type.
		 * @param type The type to compare the elements to.
		 * @return Returns all the matched elements.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getItemByType(inArray:Array, type:Class):* {
			for each (var item:* in inArray)
				if(item is type)
					return item;

			return null;
		}



		/**
		 * Returns every element that is compatible with a specific data type, class, or interface.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to search for elements of a specific type.
		 * @param type The type to compare the elements to.
		 * @return Returns all the matched elements.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getItemsByType(inArray:Array, type:Class):Array {
			var t:Array = new Array();

			for each (var item:* in inArray)
				if(item is type)
					t.push(item);

			return t;
		}



		/**
		 * Determines if two Arrays contain the same objects at the same index.
		 * Original taken from Casalib (http://casalib.org)
		 * @param first First Array to compare to the <code>second</code>.
		 * @param second Second Array to compare to the <code>first</code>.
		 * @return Returns <code>true</code> if Arrays are the same; otherwise <code>false</code>.
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function equals(first:Array, second:Array):Boolean {
			var i:uint = first.length;
			if(i != second.length)
				return false;

			while(i--)
				if(first[i] != second[i])
					return false;

			return true;
		}



		/**
		 * Modifies original Array by adding all the elements from another Array at a specified position.
		 * Original taken from Casalib (http://casalib.org)
		 * @param tarArray Array to add elements to.
		 * @param items Array of elements to add.
		 * @param index Position where the elements should be added.
		 * @return Returns <code>true</code> if the Array was changed as a result of the call; otherwise <code>false</code>.
		 * @example
		 * <code>
		 * var alphabet:Array = new Array("a", "d", "e");
		 * var parts:Array    = new Array("b", "c");
		 * ArrayUtils.addItemsAt(alphabet, parts, 1);
		 * trace(alphabet);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function addItemsAt(tarArray:Array, items:Array, index:int = 0x7FFFFFFF):Boolean {
			if(items.length == 0)
				return false;

			var args:Array = items.concat();
			args.splice(0, 0, index, 0);

			tarArray.splice.apply(null, args);

			return true;
		}



		/**
		 * Creates new Array composed of only the non-identical elements of passed Array.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to remove equivalent items.
		 * @return A new Array composed of only unique elements.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 4, 4, 4, 4, 5);
		 * trace(ArrayUtils.removeDuplicates(numberArray));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function removeDuplicates(inArray:Array):Array {
			return inArray.filter(_removeDuplicatesFilter);
		}



		protected static function _removeDuplicatesFilter(e:*, i:int, inArray:Array):Boolean {
			return (i == 0) ? true : inArray.lastIndexOf(e, i - 1) == -1;
		}



		/**
		 * Modifies original Array by removing all items that are identical to the specified item.
		 * Original taken from Casalib (http://casalib.org)
		 * @param tarArray Array to remove passed <code>item</code>.
		 * @param item Element to remove.
		 * @return The amount of removed elements that matched <code>item</code>, if none found returns <code>0</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 7, 7, 7, 4, 5);
		 * trace("Removed " + ArrayUtils.removeItem(numberArray, 7) + " items.");
		 * trace(numberArray);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function removeItem(tarArray:Array, item:*):uint {
			var i:int = tarArray.indexOf(item);
			var f:uint = 0;

			while(i != -1) {
				tarArray.splice(i, 1);

				i = tarArray.indexOf(item, i);

				f++;
			}

			return f;
		}



		/**
		 * Removes only the specified items in an Array.
		 * Original taken from Casalib (http://casalib.org)
		 * @param tarArray Array to remove specified items from.
		 * @param items Array of elements to remove.
		 * @return Returns <code>true</code> if the Array was changed as a result of the call; otherwise <code>false</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 7, 7, 7, 4, 5);
		 * ArrayUtils.removeItems(numberArray, new Array(1, 3, 7, 5));
		 * trace(numberArray);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function removeItems(tarArray:Array, items:Array):Boolean {
			var removed:Boolean = false;
			var l:uint = tarArray.length;

			while(l--) {
				if(items.indexOf(tarArray[l]) > -1) {
					tarArray.splice(l, 1);
					removed = true;
				}
			}

			return removed;
		}



		/**
		 Retains only the specified items in an Array.
		 * Original taken from Casalib (http://casalib.org)
		 * @param tarArray Array to remove non specified items from.
		 * @param items Array of elements to keep.
		 * @return Returns <code>true</code> if the Array was changed as a result of the call; otherwise <code>false</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 7, 7, 7, 4, 5);
		 * ArrayUtils.retainItems(numberArray, new Array(2, 4));
		 * trace(numberArray);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function retainItems(tarArray:Array, items:Array):Boolean {
			var removed:Boolean = false;
			var l:uint = tarArray.length;

			while(l--) {
				if(items.indexOf(tarArray[l]) == -1) {
					tarArray.splice(l, 1);
					removed = true;
				}
			}

			return removed;
		}



		/**
		 * Finds out how many instances of <code>item</code> Array contains.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to search for <code>item</code> in.
		 * @param item Object to find.
		 * @return The amount of <code>item</code>'s found; if none were found returns <code>0</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 7, 7, 7, 4, 5);
		 * trace("numberArray contains " + ArrayUtils.contains(numberArray, 7) + " 7's.");
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function contains(inArray:Array, item:*):uint {
			var i:int = inArray.indexOf(item, 0);
			var t:uint = 0;

			while(i != -1) {
				i = inArray.indexOf(item, i + 1);
				t++;
			}

			return t;
		}



		/**
		 * Determines if Array contains all items.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to search for <code>items</code> in.
		 * @param items Array of elements to search for.
		 * @return Returns <code>true</code> if <code>inArray</code> contains all elements of <code>items</code>; otherwise <code>false</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 4, 5);
		 * trace(ArrayUtils.containsAll(numberArray, new Array(1, 3, 5)));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function containsAll(inArray:Array, items:Array):Boolean {
			var l:uint = items.length;

			while(l--)
				if(inArray.indexOf(items[l]) == -1)
					return false;

			return true;
		}



		/**
		 * Determines if Array <code>inArray</code> contains any element of Array <code>items</code>.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to search for <code>items</code> in.
		 * @param items Array of elements to search for.
		 * @return Returns <code>true</code> if <code>inArray</code> contains any element of <code>items</code>; otherwise <code>false</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 4, 5);
		 * trace(ArrayUtils.containsAny(numberArray, new Array(9, 3, 6)));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function containsAny(inArray:Array, items:Array):Boolean {
			var l:uint = items.length;

			while(l--)
				if(inArray.indexOf(items[l]) > -1)
					return true;

			return false;
		}



		/**
		 * Compares two Arrays and finds the first index where they differ.
		 * Original taken from Casalib (http://casalib.org)
		 * @param first First Array to compare to the <code>second</code>.
		 * @param second Second Array to compare to the <code>first</code>.
		 * @param fromIndex The location in the Arrays from which to start searching for a difference.
		 * @return The first position/index where the Arrays differ; if Arrays are identical returns <code>-1</code>.
		 * @example
		 * <code>
		 * var color:Array     = new Array("Red", "Blue", "Green", "Indigo", "Violet");
		 * var colorsAlt:Array = new Array("Red", "Blue", "Green", "Violet");
		 * trace(ArrayUtils.getIndexOfDifference(color, colorsAlt)); // Traces 3
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getIndexOfDifference(first:Array, second:Array, fromIndex:uint = 0):int {
			var i:int = fromIndex - 1;

			while(++i < first.length)
				if(first[i] != second[i])
					return i;

			return -1;
		}



		/**
		 * Creates new Array composed of passed Array's items in a random order.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array to create copy of, and randomize.
		 * @return A new Array composed of passed Array's items in a random order.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
		 * trace(ArrayUtils.randomize(numberArray));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function randomize(inArray:Array):Array {
			var t:Array = new Array();
			var r:Array = inArray.sort(_sortRandom, Array.RETURNINDEXEDARRAY);
			var i:int = -1;

			while(++i < inArray.length)
				t.push(inArray[r[i]]);

			return t;
		}



		protected static function _sortRandom(a:*, b:*):int {
			return RandomUtils.integer(0, 1) ? 1 : -1;
		}



		/**
		 * Adds all items in <code>inArray</code> and returns the value.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array composed only of numbers.
		 * @return The total of all numbers in <code>inArray</code> added.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(2, 3);
		 * trace("Total is: " + ArrayUtils.sum(numberArray));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function sum(inArray:Array):Number {
			var t:Number = 0;
			var l:uint = inArray.length;

			while(l--)
				t += inArray[l];

			return t;
		}



		/**
		 * Averages the values in <code>inArray</code>.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array composed only of numbers.
		 * @return The average of all numbers in the <code>inArray</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(2, 3, 8, 3);
		 * trace("Average is: " + ArrayUtils.average(numberArray));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function average(inArray:Array):Number {
			if(inArray.length == 0)
				return 0;

			return sum(inArray) / inArray.length;
		}



		/**
		 * Finds the lowest value in <code>inArray</code>.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array composed only of numbers.
		 * @return The lowest value in <code>inArray</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(2, 1, 5, 4, 3);
		 * trace("The lowest value is: " + ArrayUtils.getLowestValue(numberArray));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getLowestValue(inArray:Array):Number {
			return inArray[inArray.sort(16 | 8)[0]];
		}



		/**
		 * Finds the highest value in <code>inArray</code>.
		 * Original taken from Casalib (http://casalib.org)
		 * @param inArray Array composed only of numbers.
		 * @return The highest value in <code>inArray</code>.
		 * @example
		 * <code>
		 * var numberArray:Array = new Array(2, 1, 5, 4, 3);
		 * trace("The highest value is: " + ArrayUtils.getHighestValue(numberArray));
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function getHighestValue(inArray:Array):Number {
			return inArray[inArray.sort(16 | 8)[inArray.length - 1]];
		}
	}
}