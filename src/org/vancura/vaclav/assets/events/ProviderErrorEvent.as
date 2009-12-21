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

package org.vancura.vaclav.assets.events {
	import flash.events.ErrorEvent;
	import flash.events.Event;

	/**
	 * Provider ErrorEvent. Something bad happened.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class ProviderErrorEvent extends ErrorEvent {


		/** Provider error */
		public static const PROVIDER_ERROR:String = 'provider_error';

		/** Item not found */
		public static const ITEM_NOT_FOUND:String = 'item_not_found';

		/** Item load failed */
		public static const ITEM_LOAD_FAILED:String = 'item_load_failed';

		/** Config parsing error */
		public static const CONFIG_PARSING_ERROR:String = 'config_parsing_error';



		/**
		 * Event constructor.
		 *
		 * @param type Event type (see Event constants)
		 * @param bubbles Bubbles enabled
		 * @param cancelable Cancel enabled
		 * @param text Error description
		 */
		public function ProviderErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = '') {
			super(type, bubbles, cancelable, text);
		}



		/**
		 * Clone Event.
		 *
		 * @return Cloned Event
		 */
		public override function clone():Event {
			return new ProviderErrorEvent(type, bubbles, cancelable, text);
		}



		/**
		 * Generate Event description.
		 *
		 * @return Event description
		 */
		public override function toString():String {
			return formatToString('ProviderErrorEvent', 'type', 'bubbles', 'cancelable', 'text');
		}
	}
}
