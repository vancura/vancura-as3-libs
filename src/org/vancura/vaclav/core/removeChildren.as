package org.vancura.vaclav.core {
	import flash.display.DisplayObject;
	
	
	
	/*
	 *	Function: removeChildren
	 *	
	 *	Basically an addChild() for more children at once.
	 *	Just saves few lines of code, nothing special.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 *	Parameters:
	 *
	 *		obj			- Target DisplayObject
	 *		children	- Children to be removed
	 */
	public function removeChildren(obj:*, ... children:Array):void {
		for each(var i:DisplayObject in children) {
			obj.removeChild(i);
		}
	}
}
