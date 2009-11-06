package org.vancura.vaclav.far.events {
	import org.vancura.vaclav.far.FarHelperItem;

	import flash.events.Event;

	
	
	public class FarHelperEvent extends Event {

		
		
		public static const STREAM_DOWNLOAD_DONE:String = 'stream_download_done';
		public static const STREAM_SECURITY_ERROR:String = 'stream_security_error';
		public static const STREAM_IO_ERROR:String = 'stream_io_error';
		public static const ITEM_NOT_FOUND:String = 'item_not_found';
		public static const ITEM_LOAD_FAILED:String = 'item_load_failed';
		public static const ITEM_LOAD_COMPLETE:String = 'item_load_complete';
		
		public var helperItem:FarHelperItem;
		public var text:String;

		
		
		public function FarHelperEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, helperItem:FarHelperItem = null, text:String = null) {
			this.helperItem = helperItem;
			this.text = text;
			
			super(type, bubbles, cancelable);
		}

		
		
		public override function clone():Event {
			return new FarHelperEvent(type, bubbles, cancelable, helperItem, text);
		}

		
		
		public override function toString():String {
			return formatToString('FarHelperEvent', 'type', 'bubbles', 'cancelable', 'helperItem', 'text');
		}
	}
}
