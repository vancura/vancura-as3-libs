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

/**
 * TODO: Add non bitmap types, vectors needed!
 */


package org.vancura.vaclav.assets {
	import br.com.stimuli.string.printf;

	/**
	 * Asset template.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class Asset {


		private var _id:String;
		private var _config:Object;
		private var _chunksList:Array = new Array();



		/**
		 * Create a new Asset.
		 *
		 * @param id Asset ID
		 * @param config Config data
		 */
		public function Asset(id:String, config:Object) {
			_id = id;
			_config = config;
		}



		/**
		 * Add a chunk.
		 *
		 * @param chunk Chunk
		 * @see Chunk
		 */
		public function addChunk(chunk:Chunk):void {
			for each(var c:Chunk in _chunksList) {
				if(c.url == chunk.url) {
					var t:String = printf('Chunk with URL %s already added', chunk.url);
					throw new Error(t);
				}
			}

			_chunksList.push(chunk);
		}



		/**
		 * Get chunk by its URL.
		 *
		 * @param url Chunk URL
		 * @return Chunk if found, null if not
		 * @see Chunk
		 */
		public function getChunkByURL(url:String):Chunk {
			var o:Chunk;

			// try to find it in the _chunksList
			for each(var c:Chunk in _chunksList) {
				if(c.url == url) {
					o = c;
				}
			}

			if(o == null) {
				throw new Error(printf('Chunk with URL "%s" not found in Asset "%s"', url, _id));
			}

			return o;
		}



		/**
		 * Get list of chunks.
		 *
		 * @return List of chunks as an Array
		 * @see Chunk
		 */
		public function get chunksList():Array {
			return _chunksList;
		}



		/**
		 * Set list of chunks.
		 *
		 * @param value List of chunks as Array
		 * @see Chunk
		 */
		public function set chunksList(value:Array):void {
			_chunksList = value;
		}



		/**
		 * Get Asset ID.
		 *
		 * @return Asset ID
		 */
		public function get id():String {
			return _id;
		}



		/**
		 * Get Asset config.
		 *
		 * @return Asset config
		 */
		public function get config():Object {
			return _config;
		}



		/**
		 * Generate Asset description.
		 *
		 * @return Asset Description
		 */
		public function toString():String {
			return printf('Asset id="%s"', _id);
		}
	}
}
