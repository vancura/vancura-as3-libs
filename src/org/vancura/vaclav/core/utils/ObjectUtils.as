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
	import flash.utils.ByteArray;
	import flash.utils.describeType;

	public class ObjectUtils {



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
