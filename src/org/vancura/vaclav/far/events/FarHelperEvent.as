/***********************************************************************************************************************
 * Copyright (c) 2010. Vaclav Vancura.
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

	public class FarHelperEvent extends Event {


		public static const STREAM_DOWNLOAD_DONE:String = 'stream_download_done';
		public static const STREAM_SECURITY_ERROR:String = 'stream_security_error';
		public static const STREAM_IO_ERROR:String = 'stream_io_error';
		public static const ITEM_NOT_FOUND:String = 'item_not_found';
		public static const ITEM_LOAD_FAILED:String = 'item_load_failed';
		public static const ITEM_LOAD_COMPLETE:String = 'item_load_complete';

		public var helperItem:FarHelperItem;
		public var text:String;



		public function FarHelperEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, helperItem:FarHelperItem = null,
		                               text:String = null) {
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
