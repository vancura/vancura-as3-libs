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
