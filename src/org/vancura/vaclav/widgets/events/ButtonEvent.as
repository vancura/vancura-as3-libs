/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

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
