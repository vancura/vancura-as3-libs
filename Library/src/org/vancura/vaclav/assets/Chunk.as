/***********************************************************************************************************************
 * Some methods Copyrighted by their authors, specified in ASDocs.
 * If not specified elsewhere: Copyright (c) 2010 Vaclav Vancura.
 *
 * Contact me at vaclav@vancura.org, @vancura or at my homepage at http://vaclav.vancura.org.
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Licensed under Attribution 3.0 Czech Republic (http://creativecommons.org/licenses/by/3.0/cz/deed.en_GB).
 *
 * That means you are free:
 * * to copy, distribute, display, and perform the work
 * * to make derivative works
 *
 * Under the following conditions::
 * * Attribution Ñ You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver Ñ Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights Ñ In no way are any of the following rights affected by the license:
 * 	        - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
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
