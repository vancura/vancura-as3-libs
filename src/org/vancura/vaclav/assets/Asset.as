// TODO: Other than bitmap types



package org.vancura.vaclav.assets {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.assets.constants.AssetType;

	import flash.display.Bitmap;

	
	
	public class Asset {
		
		
		
		private var _type:String;
		private var _id:String;
		private var _config:Object;
		private var _bitmap:Bitmap;

		
		
		public function Asset(type:String, id:String) {
			if(type != AssetType.BITMAP) {
				throw new TypeError('Invalid asset type');
			}
			
			_type = type;
			_id = id;
			
			if(_type == AssetType.BITMAP) {
				_bitmap = new Bitmap();
			}
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
		
		
		
		public function set config(value:Object):void {
			_config = value;
		}
		
		
		
		public function get config():Object {
			return _config;
		}
		
		
		
		public function set bitmap(value:Bitmap):void {
			if(type != AssetType.BITMAP) {
				throw new TypeError('Invalid asset type');
			}
			
			_bitmap = value;
		}
		
		
		
		public function get bitmap():Bitmap {
			if(type != AssetType.BITMAP) {
				throw new TypeError('Invalid asset type');
			}
			
			return _bitmap;
		}
		
		
		
		public function get isValid():Boolean {
			return _type != '' && _type != null && _id != '' && _id != null;
		}
	}
}
