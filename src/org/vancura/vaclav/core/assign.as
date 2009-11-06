package org.vancura.vaclav.core {



	/*
	 *	Method: assign
	 *	
	 *	Assign properties from params to Object.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 *	Parameters:
	 *
	 *		obj		- Target Object
	 *		params	- Source Object
	 *		
	 *	Returns:
	 *			
	 *		Resulting Object
	 */
	public function assign(obj:Object, params:Object):Object {
		var out:Object = (obj);
		for(var i:String in params) out[i] = params[i];
		return out;
	}
}
