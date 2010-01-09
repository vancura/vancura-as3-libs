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
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class FunctionUtils {


		
		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function FunctionUtils() {
			throw new Error('The FunctionUtils class cannot be instantiated.');
		}



		/**
		 * Get a stack trace.
		 * Original article: http://jacksondunstan.com/articles/525
		 * @return A stack trace
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function getStackTrace():String {
			//noinspection ChainedFunctionCallJS
			return new Error().getStackTrace();
		}



		/**
		 * Get a class from the clip's library
		 * Original article: http://jacksondunstan.com/articles/525
		 * @param source Source DisplayObject
		 * @param className Name of the class to get
		 * @return The class with the given name or null if it cannot be found
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public function getClassFromLibrary(source:DisplayObject, className:String):Class {
			try {
				return Class(source.loaderInfo.applicationDomain.getDefinition(className));
			}
			catch(refErr:ReferenceError) {
				return null;
			}
			catch(typeErr:TypeError) {
				return null;
			}

			return null;
		}



		/**
		 * Get an instance of a clip from the clip's library
		 * Original article: http://jacksondunstan.com/articles/525
		 * @param source Source DisplayObject
		 * @param className Name of the clip's class (aka. linkage ID)
		 * @return An instance of the clip with the given name or null if the class cannot be found or the clip cannot be instantiated
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public function getClipFromLibrary(source:DisplayObject, className:String):MovieClip {
			var clazz:Class = getClassFromLibrary(source, className);

			if(!clazz) return null;

			try {
				return new clazz();
			}
			catch(err:ArgumentError) {
				return null;
			}

			return null;
		}



		/**
		 * Get an instance of a BitmapData from the clip's library
		 * Original article: http://jacksondunstan.com/articles/525
		 * @param source Source DisplayObject
		 * @param className Name of the BitmapData's class (aka. linkage ID)
		 * @return An instance of the BitmapData with the given name or null if the class cannot be found or the BitmapData cannot be instantiated
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public function getBitmapDataFromLibrary(source:DisplayObject, className:String):BitmapData {
			var clazz:Class = getClassFromLibrary(source, className);

			if(!clazz) return null;

			try {
				// Need to pass a width and height, but they are ignored
				return new clazz(0, 0);
			}
			catch(err:ArgumentError) {
				return null;
			}

			return null;
		}
	}
}
