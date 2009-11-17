// TODO: Other than bitmap types



package org.vancura.vaclav.assets {
	import br.com.stimuli.string.printf;

	
	
	public class Asset {
		
		
		
		private var _id:String;
		private var _config:Object;
		private var _chunksList:Array = new Array();

		
		
		public function Asset(id:String, config:Object) {
			_id = id;
			_config = config;
		}
		
		
		
		public function addChunk(chunk:Chunk):void {
			for each(var c:Chunk in _chunksList) {
				if(c.uri == chunk.uri) {
					throw new Error(printf('Chunk with URI %s already added', chunk.uri));
				}
			}
			
			_chunksList.push(chunk);
		}
		
		
		
		public function getChunkByURI(uri:String):Chunk {
			for each(var c:Chunk in _chunksList) {
				if(c.uri == uri) {
					return c;
				}
			}
			
			return null;
		}
		
		
		
		public function get chunksList():Array {
			return _chunksList;
		}
		
		
		
		public function set chunksList(value:Array):void {
			_chunksList = value;
		}

		
		
		public function get id():String {
			return _id;
		}
		
		
		
		public function get config():Object {
			return _config;
		}
		
		
		
		public function toString():String {
			return printf('Asset id="%s"', _id);
		}
	}
}
