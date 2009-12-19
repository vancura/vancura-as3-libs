package org.vancura.vaclav.core.global {
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/*
	 Function: getDisplayObjectClass

	 Get the Class of a DisplayObject.

	 Parameters:
	    obj - Object to get the Class of

	 Returns:
	 The Class of the given Object or null if the class cannot be determined.

	 Author: Jackson Dunstan <http://jacksondunstan.com/articles/512>
	 */
	public function getDisplayObjectClass(obj:Object):Class {
		if(obj == null) {
			return null;
		}
		try {
			var className:String = getQualifiedClassName(obj);
			var ret:Class = Class(getDefinitionByName(className));
			if(ret == null && obj is DisplayObject) {
				ret = getDisplayObjectClass(DisplayObject(obj));
			}
			return ret;
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
