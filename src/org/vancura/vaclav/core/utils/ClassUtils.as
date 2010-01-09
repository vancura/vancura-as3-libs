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
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ClassUtils {



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function ClassUtils() {
			throw new Error('The ClassUtils class cannot be instantiated.');
		}



		/**
		 * Get the Class of an Object.
		 * Original article: http://jacksondunstan.com/articles/512
		 * @param obj DisplayObject to get the Class of
		 * @return The Class of the given DisplayObject or null if the class cannot be determined.
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		//noinspection FunctionWithMultipleReturnPointsJS
		public static function getClass(obj:Object):Class {
			//noinspection UnusedCatchParameterJS
			try {
				var cn:String = getQualifiedClassName(obj);
				var gd:* = obj.loaderInfo.applicationDomain.getDefinition(cn);
				return Class(gd);
			}
			catch(refError:ReferenceError) {
				return null;
			}
			catch(typeError:TypeError) {
				return null;
			}

			//noinspection UnreachableCodeJS
			return null;
		}



		/**
		 * Get a Class by its fully-qualified name.
		 * Original article: http://jacksondunstan.com/articles/512
		 * @param className Fully-qualified name of the class
		 * @return The Class with the given name or null if none exists.
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		//noinspection FunctionWithMultipleReturnPointsJS
		public static function getClassByName(className:String):Class {
			//noinspection UnusedCatchParameterJS
			try {
				var dn:Object = getDefinitionByName(className);
				return Class(dn);
			}
			catch(refError:ReferenceError) {
				return null;
			}
			catch(typeError:TypeError) {
				return null;
			}

			//noinspection UnreachableCodeJS
			return null;
		}



		/**
		 * Get the Class of a DisplayObject.
		 * Original article: http://jacksondunstan.com/articles/512
		 * @param obj Object to get the Class of
		 * @return The Class of the given Object or null if the class cannot be determined.
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		//noinspection FunctionWithMultipleReturnPointsJS
		public static function getDisplayObjectClass(obj:Object):Class {
			if(obj == null) return null;

			//noinspection UnusedCatchParameterJS
			try {
				var cn:String = getQualifiedClassName(obj);
				var dn:Object = getDefinitionByName(cn);
				var ret:Class = Class(dn);

				if(ret == null && obj is DisplayObject) {
					var dj:DisplayObject = DisplayObject(obj);
					ret = getDisplayObjectClass(dj);
				}

				return ret;
			}
			catch(refError:ReferenceError) {
				return null;
			}
			catch(typeError:TypeError) {
				return null;
			}

			//noinspection UnreachableCodeJS
			return null;
		}



		/**
		 * Dynamically constructs a Class.
		 * Original taken from Casalib (http://casalib.org)
		 * @param type The Class to create.
		 * @param arguments Up to ten arguments to the constructor.
		 * @return Returns the dynamically created instance of the Class specified by <code>type</code> parameter.
		 * @example
		 * <code>
		 * var bData:* = ClassUtil.construct(BitmapData, 200, 200);
		 * trace(bData is BitmapData, bData.width);
		 * </code>
		 * @author Aaron Clinger (http://casalib.org)
		 * @author Jon Adams (http://casalib.org)
		 */
		public static function construct(type:Class, ...arguments):* {
			if(arguments.length > 10) throw new Error('You have passed more arguments than this method excepts (Ten or less).');

			switch(arguments.length) {
				case 0 :
					return new type();
				case 1 :
					return new type(arguments[0]);
				case 2 :
					return new type(arguments[0], arguments[1]);
				case 3 :
					return new type(arguments[0], arguments[1], arguments[2]);
				case 4 :
					return new type(arguments[0], arguments[1], arguments[2], arguments[3]);
				case 5 :
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]);
				case 6 :
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]);
				case 7 :
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]);
				case 8 :
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]);
				case 9 :
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8]);
				case 10 :
					return new type(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8], arguments[9]);
			}
		}
	}
}
