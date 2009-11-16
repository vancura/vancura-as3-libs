package org.vancura.vaclav.assets {
	import br.com.stimuli.string.printf;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	
	
	public class AssetManager extends EventDispatcher {

		
		
		private static var _instance:AssetManager;
		
		private var _provider:IAssetProvider;

		
		
		public static function getInstance():AssetManager {
			return _instance || (_instance = new AssetManager());
		}

		
		
		public function attachProvider(provider:IAssetProvider):void {
			if(_provider == null) {
				_provider = provider;
				
				_provider.addEventListener(Event.COMPLETE, _onProviderComplete, false, 0, true);
				_provider.addEventListener(AssetManagerErrorEvent.PROVIDER_ERROR, _onProviderError, false, 0, true);
				_provider.addEventListener(AssetManagerErrorEvent.ITEM_LOAD_FAILED, _onItemLoadFailed, false, 0, true);
				_provider.addEventListener(AssetManagerErrorEvent.ITEM_NOT_FOUND, _onItemNotFound, false, 0, true);				
			}
			else {
				throw new Error('Asset provider already attached');
			}
		}

		
		
		public function getAsset(id:String):* {
			for each(var item:Asset in assetsList) {
				if(item.id == id) {
					return item;
				}
			}
			
			return null;
		}

		
		
		override public function toString():String {
			if(_provider != null) {
				var list:String = '';
				
				for each(var i:Asset in assetsList) {
					list += printf('%s (%s), ', i.id, i.type);
				}
				list = list.substr(0, list.length - 2);
				
				return printf('AssetManager info:\n  provider=%s\n  registered assets: %s', _provider.toString(), list);
			}
			
			return printf('AssetManager info:\n  provider not attached');
		}

		
		
		public function get assetsList():Array {
			if(_provider != null) {
				return _provider.assetsList;
			}

			return null;
		}

		
		
		public function get provider():IAssetProvider {
			return _provider;
		}
		
		
		
		public function get isError():Boolean {
			return (_provider != null) ? _provider.isError : false;
		}
		
		
		
		public function get isActive():Boolean {
			return (_provider != null) ? _provider.isActive : false;
		}
		
		
		
		public function get isLoaded():Boolean {
			return (_provider != null) ? _provider.isLoaded : false;
		}
		
		
		
		private function _onItemNotFound(event:AssetManagerErrorEvent):void {
			dispatchEvent(event.clone());
		}

		
		
		private function _onItemLoadFailed(event:AssetManagerErrorEvent):void {
			dispatchEvent(event.clone());
		}

		
		
		private function _onProviderError(event:AssetManagerErrorEvent):void {
			dispatchEvent(event.clone());
		}

		
		
		private function _onProviderComplete(event:Event):void {
			dispatchEvent(event.clone());
		}
	}
}
