package org.vancura.vaclav.core {



	/*
	 *	Method: assign
	 *	
	 *	Assign properties from params to an Object.
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
		
		for(var i:String in params) {
			try {
				out[i] = params[i];
			}
			catch(err:Error) {
			}
		}
		
		return out;
	}
}
