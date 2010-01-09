/***********************************************************************************************************************
 * Copyright (c) 2010 Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.assets {
	import flash.display.Bitmap;

	/**
	 * Am Asset chunk.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class Chunk {


		/** Bitmap Chunk type */
		public static const BITMAP:String = 'bitmap';

		private var _url:String;
		private var _type:String;
		private var _bitmap:Bitmap;



		/**
		 * Chunk constructor.
		 *
		 * @param url Chunk URL
		 * @param type Chunk type (Chunk.BITMAP by default)
		 */
		public function Chunk(url:String, type:String = Chunk.BITMAP) {
			_url = url;
			_type = type;
			_bitmap = new Bitmap();
		}



		// Getters & setters
		// -----------------


		/**
		 * Get Chunk URL.
		 *
		 * @return Chunk URL
		 */
		public function get url():String {
			return _url;
		}



		/**
		 * Get Chunk type.
		 *
		 * @return Chunk type
		 */
		public function get type():String {
			return _type;
		}



		/**
		 * Set Chunk Bitmap.
		 *
		 * @param value Chunk Bitmap
		 */
		public function set bitmap(value:Bitmap):void {
			_bitmap = value;
		}



		/**
		 * Get Chunk Bitmap.
		 *
		 * @return Chunk Bitmap
		 */
		public function get bitmap():Bitmap {
			return _bitmap;
		}
	}
}
