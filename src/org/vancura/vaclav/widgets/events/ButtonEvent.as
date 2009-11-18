package org.vancura.vaclav.widgets.events {
	import flash.events.Event;

	
	
	public class ButtonEvent extends Event {

		
		
		public static const DRAG_OVER:String = 'drag_over';
		public static const DRAG_OUT:String = 'drag_out';
		public static const DRAG_CONFIRM:String = 'drag_confirm';
		public static const HOVER_IN:String = 'hover_in';
		public static const HOVER_OUT:String = 'hover_out';
		public static const FOCUS_IN:String = 'focus_in';
		public static const RELEASE_INSIDE:String = 'release_inside';
		public static const RELEASE_OUTSIDE:String = 'release_outside';
		public static const HOVER_IN_TWEEN:String = 'hover_in_tween';
		public static const HOVER_OUT_TWEEN:String = 'hover_out_tween';
		public static const FOCUS_IN_TWEEN:String = 'focus_in_tween';
		public static const DRAG_CONFIRMED_TWEEN:String = 'drag_confirmed_tween';
		public static const RELEASED_INSIDE_TWEEN:String = 'released_inside_tween';
		public static const RELEASED_OUTSIDE_TWEEN:String = 'released_outside_tween';

		
		
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
