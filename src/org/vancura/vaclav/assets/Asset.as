package org.vancura.vaclav.assets {
	import br.com.stimuli.string.printf;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	
	
	public class Asset {
		
		
		
		private var _type:String;
		private var _id:String;
		private var _data:ByteArray;
		private var _config:XML;

		
		
		public function Asset(type:String, id:String) {
			_type = type;
			_id = id;
		}
		
		
		
		public function toString():String {
			return printf('Asset id="%s", type="%s"', _id, _type);
		}
		
		
		
		public function get type():String {
			return _type;
		}
		
		
		
		public function get id():String {
			return _id;
		}
		
		
		
		public function set byteArray(value:ByteArray):void {
			_data = value;
		}
		
		
		
		public function get byteArray():ByteArray {
			return _data;
		}
		
		
		
		public function set xml(value:XML):void {
			_config = value;
		}
		
		
		
		public function get xml():XML {
			return _config;
		}
		
		
		
		public function get bitmapData():BitmapData {
			return null;
		}
		
		
		
		public function get isValid():Boolean {
			return _type != '' && _type != null && _id != '' && _id != null;
		}
	}
}
