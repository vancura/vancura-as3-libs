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
	import flash.utils.ByteArray;
	import flash.utils.describeType;

	public class ObjectUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function ObjectUtils() {
			throw new Error('The ObjectUtils class cannot be instantiated.');
		}



		/**
		 * Count the properties in an object.
		 * Original article: http://jacksondunstan.com/articles/509
		 * @param obj Object to count the properties of
		 * @return The number of properties in the specified object. If the specified object is null, this is 0
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function numProperties(obj:Object):int {
			var count:int = 0;
			for each(var prop:Object in obj) count++;
			return count;
		}



		/**
		 * Check if an object has any properties.
		 * Original article: http://jacksondunstan.com/articles/509
		 * @param obj Object to check for properties
		 * @return If the specified object has any properties. If the specified object is null, this is false.
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function hasProperties(obj:Object):Boolean {
			for each(var prop:Object in obj) return true;
			return false;
		}



		/**
		 * Check if the properties of an object are all the same.
		 * Original article: http://jacksondunstan.com/articles/509
		 * @param obj Object whose properties should be checked
		 * @param type Type to check the object's properties against
		 * @return If all of the properties of the specified object are of the specified type
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function isUniformPropertyType(obj:Object, type:Class):Boolean {
			for each(var prop:Object in obj) {
				if(!(prop is type)) return false;
			}
			return true;
		}



		/**
		 * Assign properties from params to an Object.
		 * @param obj Target Object
		 * @param params Source Object
		 * @return Resulting Object
		 */
		public static function assign(obj:Object, params:Object):Object {
			var out:Object = (obj);

			for(var i:String in params) {
				//noinspection EmptyCatchBlockJS,UnusedCatchParameterJS
				try {
					out[i] = params[i];
				}
				catch(err:Error) {
				}
			}

			return out;
		}



		/**
		 * Clone an Object.
		 * @param source Source Object
		 * @return Cloned Object
		 */
		public static function clone(source:*):Object {
			var copier:ByteArray = new ByteArray();

			copier.writeObject(source as Object);
			copier.position = 0;

			return copier.readObject();
		}



		/**
		 * Scan an Object.
		 * Original article: http://jacksondunstan.com/articles/509
		 * @param obj Object to be scanned
		 * @param depth Depth of scanning
		 * @return Scan result
		 * @author whitered
		 */
		public static function inspect(obj:Object, depth:int = 2):String {
			return scan(obj, depth, '');
		}



		/**
		 * Copy an object.
		 * Original article: http://jacksondunstan.com/articles/509
		 * @param obj Object to copy
		 * @param into (optional) Object to copy into. If null, a new object is created.
		 * @return A one-level deep copy of the object or null if the argument is null
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function copy(obj:Object, into:Object = null):Object {
			if(into == null) into = {};
			if(obj != null) {
				for(var o:* in obj) into[o] = obj[o];
			}
			return into;
		}



		/**
		 * Convert the object to an array. Note that the order of the array is undefined.
		 * Original article: http://jacksondunstan.com/articles/509
		 * @param obj Object to convert
		 * @return An array with all of the properties of the given object or null if the given object is null
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function toArray(obj:Object):Array {
			if(obj == null) return null;
			else {
				var ret:Array = [];
				for each (var prop:Object in obj) ret.push(prop);
				return ret;
			}
		}



		/**
		 * Convert the object to a string of form: PROP: VAL&PROP: VAL where:
		 *   - PROP is a property
		 *   - VAL is its corresponding value
		 *   - & is the specified optional delimiter
		 * Original article: http://jacksondunstan.com/articles/509
		 * @param obj Object to convert
		 * @param delimiter (optional) Delimiter of property/value pairs
		 * @return An string of all property/value pairs delimited by the given string or null if the input object or delimiter is null.
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function toString(obj:Object = null, delimiter:String = '\n'):String {
			if(obj == null || delimiter == null) return '';
			else {
				var ret:Array = [];
				for(var s:Object in obj) ret.push(s + ': ' + obj[s]);
				return ret.join(delimiter);
			}
		}



		/**
		 Searches the first level properties of an object for a another object.
		 CASA
		 @param obj: Object to search in.
		 @param member: Object to search for.
		 @return Returns <code>true</code> if object was found; otherwise <code>false</code>.
		 */
		public static function contains(obj:Object, member:Object):Boolean {
			for(var prop:String in obj)
				if(obj[prop] == member)
					return true;

			return false;
		}



		/**
		 Uses the strict equality operator to determine if object is <code>undefined</code>.
		 CASA
		 @param obj: Object to determine if <code>undefined</code>.
		 @return Returns <code>true</code> if object is <code>undefined</code>; otherwise <code>false</code>.
		 */
		public static function isUndefined(obj:Object):Boolean {
			return obj is undefined;
		}



		/**
		 Uses the strict equality operator to determine if object is <code>null</code>.
		 CASA
		 @param obj: Object to determine if <code>null</code>.
		 @return Returns <code>true</code> if object is <code>null</code>; otherwise <code>false</code>.
		 */
		public static function isNull(obj:Object):Boolean {
			return obj === null;
		}



		/**
		 Determines if object contains no value(s).
		 CASA
		 @param obj: Object to derimine if empty.
		 @return Returns <code>true</code> if object is empty; otherwise <code>false</code>.
		 @example
		 <code>
		 var testNumber:Number;
		 var testArray:Array   = new Array();
		 var testString:String = "";
		 var testObject:Object = new Object();

		 trace(ObjectUtils.isEmpty(testNumber)); // traces "true"
		 trace(ObjectUtils.isEmpty(testArray));  // traces "true"
		 trace(ObjectUtils.isEmpty(testString)); // traces "true"
		 trace(ObjectUtils.isEmpty(testObject)); // traces "true"
		 </code>
		 */
		public static function isEmpty(obj:*):Boolean {
			if(obj == undefined)
				return true;

			if(obj is Number)
				return isNaN(obj);

			if(obj is Array || obj is String)
				return obj.length == 0;

			if(obj is Object) {
				for(var prop:String in obj)
					return false;

				return true;
			}

			return false;
		}



		// Private methods


		private static function scan(obj:Object, depth:int, prefix:String):String {
			if(depth < 1) return String(obj);

			const classDef:XML = describeType(obj);

			var str:String = '';
			for each(var variable:XML in classDef.variable) {
				str += prefix + variable.@name + ' : ' + scan(obj[variable.@name], depth - 1, prefix + '\t') + '\n';
			}

			for(var s:* in obj) {
				str += prefix + s + ' = ' + scan(obj[s], depth - 1, prefix + '\t') + '\n';
			}
			return str != '' ? ('[' + classDef.@name + '] {\n' + str + prefix + '}\n') : ((obj != null) ? obj + '' : 'null');
		}
	}
}
