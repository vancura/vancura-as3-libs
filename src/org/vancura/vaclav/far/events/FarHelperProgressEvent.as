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

package org.vancura.vaclav.far.events {
	import flash.events.Event;

	import org.vancura.vaclav.far.FarHelperItem;

	public class FarHelperProgressEvent extends Event {


		public static const ITEM_LOAD_PROGRESS:String = 'item_load_progress';

		public var helperItem:FarHelperItem;
		public var progress:Number;



		public function FarHelperProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
		                                       helperItem:FarHelperItem = null, progress:Number = 0) {
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
