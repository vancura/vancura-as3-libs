package org.vancura.vaclav.core {
	import flash.display.DisplayObject;
	


	/*
	 *	Function: addChildren
	 *	
	 *	Basically an addChild() for more children at one time.
	 *	Just saves few lines of code, nothing special.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 *	Parameters:
	 *
	 *		obj			- Target DisplayObject
	 *		children	- Children to be added
	 */
	public function addChildren(obj:*, ... children:Array):void {
		for each(var i:DisplayObject in children) {
			obj.addChild(i);
		}
	}
}
