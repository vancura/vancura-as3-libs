package org.vancura.vaclav.core.global {
	import flash.utils.getQualifiedClassName;

	/*
	 Function: getClass

	 Get the Class of an Object.

	 Parameters:
	 obj - DisplayObject to get the Class of

	 Returns:
	 The Class of the given DisplayObject or null if the class cannot be determined.

	 Author: Jackson Dunstan <http://jacksondunstan.com/articles/512>
	 */
	public function getClass(obj:Object):Class {
		try {
			return Class(obj.loaderInfo.applicationDomain.getDefinition(getQualifiedClassName(obj)));
		}
		catch(refErr:ReferenceError) {
			return null;
		}
		catch(typeErr:TypeError) {
			return null;
		}

		return null;
	}
}
