package org.vancura.vaclav.core.global {
	import flash.utils.getDefinitionByName;

	/*
	 Function: getClassByName

	 Get a Class by its fully-qualified name.

	 Parameters:
	 className - Fully-qualified name of the class

	 Returns:
	 The Class with the given name or null if none exists.

	 Author: Jackson Dunstan <http://jacksondunstan.com/articles/512>
	 */
	public function getClassByName(className:String):Class {
		try {
			return Class(getDefinitionByName(className));
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
