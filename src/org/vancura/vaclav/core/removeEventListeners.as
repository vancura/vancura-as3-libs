package org.vancura.vaclav.core {
	import flash.events.EventDispatcher;
	
	
	
	/*
	 *	Method: removeEventListeners
	 *	
	 *	Basically an removeEventListener() for more events at once.
	 *	Just saves few lines of code, nothing special.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 *	Parameters:
	 *
	 *		obj		- Target EventDispatcher
	 *		params	- Multiple Objects with pairs {event: ..., method: ...}
	 */
	public function removeEventListeners(obj:EventDispatcher, ... params):void {
		for each(var i:Object in params) {
			if(i.event == undefined) {
				throw new Error('Event undefined');
			}
			
			if(i.method == undefined) {
				throw new Error('Method undefined');
			}
			
			obj.removeEventListener(i.event, i.method);
		}
	}
}
