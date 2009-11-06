package org.vancura.vaclav.far.events {
	import org.vancura.vaclav.far.FarHelperItem;

	import flash.display.DisplayObject;
	import flash.events.Event;

	
	
	public class FarHelperAssignEvent extends Event {

		
		
		public static const ITEM_READY:String = 'item_ready';
		
		public var helperItem:FarHelperItem;
		public var displayObject:DisplayObject;

		
		
		public function FarHelperAssignEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, helperItem:FarHelperItem = null, displayObject:DisplayObject = null) {
			this.helperItem = helperItem;
			this.displayObject = displayObject;
			
			super(type, bubbles, cancelable);
		}

		
		
		public override function clone():Event {
			return new FarHelperAssignEvent(type, bubbles, cancelable, helperItem, displayObject);
		}

		
		
		public override function toString():String {
			return formatToString('FarHelperAssignEvent', 'type', 'bubbles', 'cancelable', 'helperItem', 'displayObject');
		}
	}
}
