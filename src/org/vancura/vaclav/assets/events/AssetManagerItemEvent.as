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
	import flash.events.Event;

	import org.vancura.vaclav.assets.Asset;

	/**
	 * AssetManager item Event, usually means an Item was loaded.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class AssetManagerItemEvent extends Event {


		/** Item was successfully loaded */
		public static const ITEM_LOADED:String = 'item_loaded';

		private var asset:Asset;



		/**
		 * Event constructor.
		 *
		 * @param type Event type (see Event constants)
		 * @param bubbles Bubbles enabled
		 * @param cancelable Cancel enabled
		 * @param asset Asset
		 * @see Asset
		 */
		public function AssetManagerItemEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, asset:Asset = null) {
			super(type, bubbles, cancelable);

			this.asset = asset;
		}



		/**
		 * Clone Event.
		 *
		 * @return Cloned Event
		 */
		public override function clone():Event {
			return new AssetManagerItemEvent(type, bubbles, cancelable, asset);
		}



		/**
		 * Generate Event description.
		 *
		 * @return Event description
		 */
		public override function toString():String {
			return formatToString('AssetManagerItemEvent', 'type', 'bubbles', 'cancelable', 'asset');
		}
	}
}
