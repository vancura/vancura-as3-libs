package org.vancura.vaclav.widgets.widgets.events {
	import flash.events.Event;

	
	
	public class ButtonEvent extends Event {

		
		
		public static const DRAGGED_OVER:String = 'dragged_over';
		public static const DRAGGED_OUT:String = 'dragged_out';
		public static const DRAG_CONFIRM:String = 'drag_confirm';
		public static const HOVERED_IN:String = 'hovered_in';
		public static const HOVERED_OUT:String = 'hovered_out';
		public static const PRESSED_IN:String = 'pressed_in';
		public static const RELEASED_INSIDE:String = 'released_inside';
		public static const RELEASED_OUTSIDE:String = 'released_outside';

		
		
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		
		
		public override function clone():Event {
			return new ButtonEvent(type, bubbles, cancelable);
		}

		
		
		public override function toString():String {
			return formatToString('ButtonEvent', 'type', 'bubbles', 'cancelable');
		}
	}
}
