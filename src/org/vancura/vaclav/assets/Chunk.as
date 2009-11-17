package org.vancura.vaclav.assets {
	import flash.display.Bitmap;

	
	
	public class Chunk {

		
		
		public static const BITMAP:String = 'bitmap';
		
		private var _id:String;
		private var _uri:String;
		private var _type:String;
		private var _bitmap:Bitmap;
		private var _isAssigned:Boolean;

		
		
		public function Chunk(id:String, uri:String, type:String = BITMAP) {
			_id = id;
			_uri = uri;
			_type = type;
			_bitmap = new Bitmap();
		}
		
		
		
		public function get id():String {
			return _id;
		}
		
		
		
		public function get uri():String {
			return _uri;
		}
		
		
		
		public function get type():String {
			return _type;
		}

		
		
		public function set bitmap(value:Bitmap):void {
			_bitmap = value;
		}

		
		
		public function get bitmap():Bitmap {
			return _bitmap;
		}
		
		
		
		public function get isAssigned():Boolean {
			return _isAssigned;
		}
		
		
		
		public function set isAssigned(isAssigned:Boolean):void {
			_isAssigned = isAssigned;
		}
	}
}
