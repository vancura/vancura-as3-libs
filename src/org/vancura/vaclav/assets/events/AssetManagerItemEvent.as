package org.vancura.vaclav.assets.events {
	import org.vancura.vaclav.assets.Asset;
	import flash.events.Event;

	
	
	public class AssetManagerItemEvent extends Event {

		
		
		public static const ITEM_LOADED:String = 'item_loaded';
		
		private var asset:Asset;

		
		
		public function AssetManagerItemEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, asset:Asset = null) {
			super(type, bubbles, cancelable);
			
			this.asset = asset;
		}

		
		
		public override function clone():Event {
			return new AssetManagerItemEvent(type, bubbles, cancelable, asset);
		}

		
		
		public override function toString():String {
			return formatToString('AssetManagerItemEvent', 'type', 'bubbles', 'cancelable', 'asset');
		}
	}
}
