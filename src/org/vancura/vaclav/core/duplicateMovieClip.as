package org.vancura.vaclav.core {
	import flash.display.MovieClip;	
	
	
	
	/*
	 *	Method: duplicateMovieClip
	 *	
	 *	Duplicate a MovieClip
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 *	Parameters:
	 *
	 *		source	- Source MovieClip
	 *		
	 *	Returns:
	 *			
	 *		Duplicated MovieClip
	 */
	public function duplicateMovieClip(source:MovieClip):MovieClip {
		var targetClass:Class = Object(source).constructor as Class;
		
		return(new targetClass() as MovieClip);
	}
}
