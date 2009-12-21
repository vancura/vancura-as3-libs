/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura (http://vaclav.vancura.org)
 **********************************************************************************************************************/

package org.vancura.vaclav.assets.events {
	import flash.events.Event;

	import org.vancura.vaclav.assets.Asset;

	/**
	 * AssetManager event, usually means an Item was loaded.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class ProviderEvent extends Event {


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
		public function ProviderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, asset:Asset = null) {
			super(type, bubbles, cancelable);

			this.asset = asset;
		}



		/**
		 * Clone Event.
		 *
		 * @return Cloned Event
		 */
		public override function clone():Event {
			return new ProviderItemEvent(type, bubbles, cancelable, asset);
		}



		/**
		 * Generate Event description.
		 *
		 * @return Event description
		 */
		public override function toString():String {
			return formatToString('ProviderItemEvent', 'type', 'bubbles', 'cancelable', 'asset');
		}
	}
}
