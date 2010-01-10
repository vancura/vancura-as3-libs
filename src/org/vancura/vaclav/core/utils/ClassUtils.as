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
		 * var bData:* = ClassUtils.construct(BitmapData, 200, 200);
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
