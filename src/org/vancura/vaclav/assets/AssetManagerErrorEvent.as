package org.vancura.vaclav.assets {
	import flash.events.ErrorEvent;
	import flash.events.Event;

	
	
	public class AssetManagerErrorEvent extends ErrorEvent {

		
		
		public static const PROVIDER_ERROR:String = 'provider_error';
		public static const ITEM_NOT_FOUND:String = 'item_not_found';
		public static const ITEM_LOAD_FAILED:String = 'item_load_failed';

		
		
		public function AssetManagerErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = '') {
			super(type, bubbles, cancelable, text);
		}

		
		
		public override function clone():Event {
			return new AssetManagerErrorEvent(type, bubbles, cancelable, text);
		}

		
		
		public override function toString():String {
			return formatToString('AssetManagerErrorEvent', 'type', 'bubbles', 'cancelable', 'text');
		}
	}
}
