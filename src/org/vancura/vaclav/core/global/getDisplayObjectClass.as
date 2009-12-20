/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
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

package org.vancura.vaclav.core.global {
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * Get the Class of a DisplayObject.
	 *
	 * @param obj Object to get the Class of
	 * @return The Class of the given Object or null if the class cannot be determined.
	 * @author Jackson Dunstan (http://jacksondunstan.com/articles/512)
	 */
	public function getDisplayObjectClass(obj:Object):Class {
		if(obj === null) return null;

		//noinspection UnusedCatchParameterJS
		try {
			var cn:String = getQualifiedClassName(obj);
			var dn:Object = getDefinitionByName(cn);
			var ret:Class = Class(dn);

			if(ret === null && obj is DisplayObject) {
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
}
