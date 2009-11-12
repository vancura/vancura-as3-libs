package org.vancura.vaclav.core {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	
	
	/*
	 * Class: BitmapUtil
	 * 
	 * Container for a few bitmap methods I can't put anywhere else.
	 * 
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public final class BitmapUtil {

		
		
		/*
		 * Function: embed2BD
		 *
		 * Get BitmapData from the source. If the source is Bitmap, it's converted, if it is already BitmapData, the reference is returned.
		 * Serves as a quick filter for Bitmap and BitmapData.
		 * Throws a TypeError if the source is not Bitmap nor BitmapData.
		 * 
		 * Parameters:
		 * 
		 * 		source	- Source Bitmap or BitmapData
		 * 		
		 * Returns:
		 * 
		 * 		Source converted to BitmapData
		 */
		public static function embed2BD(source:*):BitmapData {
			if(source is Bitmap) return source.bitmapData;
			else if(source is BitmapData) return source;
			else throw new TypeError('Bitmap or BitmapData needed');
		}

		
		
		/*
		 * Function: crop
		 * 
		 * Crop the BitmapData source and return a new BitmapData.
		 * 
		 * Parameters:
		 * 
		 * 		source	- Source BitmapData
		 * 		x		- Left margin of crop area
		 * 		y		- Top margin of crop area
		 * 		width	- Width of crop area
		 * 		height	- Height of crop area
		 * 		
		 * Returns:
		 * 
		 * 		Cropped source as BitmapData
		 */
		public static function crop(source:BitmapData, x:uint, y:uint, width:uint, height:uint):BitmapData {
			var o:BitmapData = new BitmapData(width, height);
			o.copyPixels(source, new Rectangle(x, y, width, height), new Point(0, 0));
			return o;
		}
	}
}
