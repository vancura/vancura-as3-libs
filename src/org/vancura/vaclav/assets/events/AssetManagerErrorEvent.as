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
	 * Class: AssetManagerErrorEvent
	 *
	 * AssetManager ErrorEvent. Something bad happened.
	 *
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class AssetManagerErrorEvent extends ErrorEvent {


		/**
		 * Constants: Events
		 *      PROVIDER_ERROR - Provider error
		 *      ITEM_NOT_FOUND - Item not found
		 *      ITEM_LOAD_FAILED - Item load failed
		 */
		public static const PROVIDER_ERROR:String = 'provider_error';
		public static const ITEM_NOT_FOUND:String = 'item_not_found';
		public static const ITEM_LOAD_FAILED:String = 'item_load_failed';



		/**
		 * Event constructor.
		 * @param type Event type (see Event constants)
		 * @param bubbles Bubbles enabled
		 * @param cancelable Cancel enabled
		 * @param text Error description
		 */
		public function AssetManagerErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = '') {
			super(type, bubbles, cancelable, text);
		}



		/**
		 * Clone Event.
		 * @return Cloned Event
		 */
		public override function clone():Event {
			return new AssetManagerErrorEvent(type, bubbles, cancelable, text);
		}



		/**
		 * Generate Event description.
		 * @return Event description
		 */
		public override function toString():String {
			return formatToString('AssetManagerErrorEvent', 'type', 'bubbles', 'cancelable', 'text');
		}
	}
}
