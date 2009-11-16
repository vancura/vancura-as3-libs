package org.vancura.vaclav.assets {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.far.FarHelper;
	import org.vancura.vaclav.far.FarHelperItem;
	import org.vancura.vaclav.far.events.FarHelperEvent;

	import flash.events.Event;

	
	
	public class FARAssetProvider extends AssetProvider implements IAssetProvider {

		
		
		private static const _ASSETS_CONFIG_INDEX:String = 'assets_config';
		
		private var _contentURI:String;
		private var _farHelper:FarHelper;
		private var _assetLoadCounter:Number = 0;

		
		
		public function FARAssetProvider(contentURI:String, assetsConfigIndex:String = _ASSETS_CONFIG_INDEX) {
			super();
			
			_contentURI = contentURI;
			
			_farHelper = new FarHelper();
			
			_farHelper.addEventListener(FarHelperEvent.STREAM_IO_ERROR, _onFarIOError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.STREAM_SECURITY_ERROR, _onFarSecurityError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_NOT_FOUND, _onItemNotFound, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadFailed, false, 0, true);
			
			_farHelper.load(_contentURI);
			_farHelper.loadItem(assetsConfigIndex);
			
			$isActive = true;
		}

		
		
		override public function destroy():void {
			if(!$isActive) {
				return;
			}
			
			_farHelper.removeEventListener(FarHelperEvent.STREAM_IO_ERROR, _onFarIOError);
			_farHelper.removeEventListener(FarHelperEvent.STREAM_SECURITY_ERROR, _onFarSecurityError);
			_farHelper.removeEventListener(FarHelperEvent.ITEM_NOT_FOUND, _onItemNotFound);
			_farHelper.removeEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete);
			_farHelper.removeEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadFailed);
			
			_farHelper.destroy();
			
			super.destroy();
		}
		
		
		
		override public function getAsset(id:String):Asset {
			var asset:Asset = super.getAsset(id);
			
			dispatchEvent(new AssetManagerItemEvent(AssetManagerItemEvent.ITEM_LOADED, false, false, asset));
			
			return asset;
		}
		
		
		
		private function _onFarSecurityError(event:FarHelperEvent):void {
			$isError = true;
			$isLoaded = false;
			
			dispatchEvent(new AssetManagerErrorEvent(AssetManagerErrorEvent.PROVIDER_ERROR, false, false, printf('Security error loading asset library: %s', event.text)));
		}

		
		
		private function _onFarIOError(event:FarHelperEvent):void {
			$isError = true;
			$isLoaded = false;
			
			dispatchEvent(new AssetManagerErrorEvent(AssetManagerErrorEvent.PROVIDER_ERROR, false, false, printf('IO error loading asset library: %s', event.text)));
		}

		
		
		private function _onItemNotFound(event:FarHelperEvent):void {
			dispatchEvent(new AssetManagerErrorEvent(AssetManagerErrorEvent.ITEM_NOT_FOUND, false, false, printf('Asset item "%s" not found in the asset library', event.helperItem.index)));
		}

		
		
		private function _onItemLoadFailed(event:FarHelperEvent):void {
			dispatchEvent(new AssetManagerErrorEvent(AssetManagerErrorEvent.ITEM_LOAD_FAILED, false, false, printf('Asset item "%s" load failed', event.helperItem.index)));
		}

		
		
		private function _onItemLoadComplete(event:FarHelperEvent):void {
			var itemHelper:FarHelperItem = event.helperItem as FarHelperItem;
			
			if(itemHelper.index == _ASSETS_CONFIG_INDEX) {
				// assets library config found
				
				var config:XML = new XML(itemHelper.farItem.data);
				
				for each(var assetConfig:XML in config.asset) {
					var asset1:Asset = new Asset(assetConfig.@type, assetConfig.@id);
					
					asset1.config = assetConfig;
					
					$assetsList.push(asset1);
					
					_farHelper.loadItem(assetConfig.@id);
				}
			}
			else {
				// standard asset
				
				for each(var asset2:Asset in $assetsList) {
					if(itemHelper.index == asset2.id) {
						asset2.data = itemHelper.farItem.data;
						_assetLoadCounter++;
					}
				}
			}
			
			// check if all items are loaded
			if(_assetLoadCounter == $assetsList.length) {
				$isLoaded = true;
			
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}
