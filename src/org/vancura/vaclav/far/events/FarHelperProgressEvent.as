package org.vancura.vaclav.far.events {
	import org.vancura.vaclav.far.FarHelperItem;

	import flash.events.Event;

	
	
	public class FarHelperProgressEvent extends Event {

		
		
		public static const ITEM_LOAD_PROGRESS:String = 'item_load_progress';
		
		public var helperItem:FarHelperItem;
		public var progress:Number;

		
		
		public function FarHelperProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, helperItem:FarHelperItem = null, progress:Number = 0) {
			this.helperItem = helperItem;
			this.progress = progress;
			
			super(type, bubbles, cancelable);
		}

		
		
		public override function clone():Event {
			return new FarHelperProgressEvent(type, bubbles, cancelable, helperItem, progress);
		}

		
		
		public override function toString():String {
			return formatToString('FarHelperProgressEvent', 'type', 'bubbles', 'cancelable', 'helperItem', 'progress');
		}
	}
}
