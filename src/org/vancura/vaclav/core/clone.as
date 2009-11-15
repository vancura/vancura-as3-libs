package org.vancura.vaclav.core {
	import flash.utils.ByteArray;



	/*
	 *	Method: clone
	 *	
	 *	Clone an Object.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 *	Parameters:
	 *
	 *		source		- Source Object
	 *		
	 *	Returns:
	 *			
	 *		Cloned Object
	 */
	public function clone(source:*):Object {
		var copier:ByteArray = new ByteArray();
		
		copier.writeObject(source as Object);
		copier.position = 0;
		
		return copier.readObject();
	}
}
