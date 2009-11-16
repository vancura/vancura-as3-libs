package org.vancura.vaclav.assets.providers {
	import br.com.stimuli.string.printf;

	import com.adobe.serialization.json.JSON;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.Chunk;
	import org.vancura.vaclav.assets.events.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.events.AssetManagerItemEvent;
	import org.vancura.vaclav.assets.interfaces.IAssetProvider;
	import org.vancura.vaclav.far.FarHelper;
	import org.vancura.vaclav.far.FarHelperItem;
	import org.vancura.vaclav.far.events.FarHelperAssignEvent;
	import org.vancura.vaclav.far.events.FarHelperEvent;

	import flash.events.Event;

	
	
	public class FARAssetProvider extends AssetProvider implements IAssetProvider {

		
		
		private static const _ASSETS_CONFIG_INDEX:String = 'assets_config.json';
		
		private var _contentURI:String;
		private var _farHelper:FarHelper;
		private var _chunkLoadCounter:uint = 0;

		
		
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
				
				var config:Array = JSON.decode(itemHelper.farItem.data.toString());
				
				for each(var assetConfig:Object in config) {
					var newAsset:Asset = new Asset(assetConfig.id, assetConfig);
					
					if(assetConfig.chunks != null) {
						for each(var chunkConfig:Object in assetConfig.chunks) {
							var c:Chunk = new Chunk(chunkConfig.id, chunkConfig.index, chunkConfig.type);
							
							newAsset.addChunk(c);
							
							_chunkLoadCounter++;
							
							_farHelper.loadItem(chunkConfig.index);
						}
					}
					
					$assetsList.push(newAsset);
				}
			}
			else {
				// standard asset
				
				for each(var oldAsset:Asset in $assetsList) {
					for each(var chunk:Chunk in oldAsset.chunksList) {
						if(chunk.uri == itemHelper.index) {
							itemHelper.addEventListener(FarHelperAssignEvent.ITEM_READY, _onItemReady, false, 0, true);
							itemHelper.assignBitmap(chunk.bitmap);
						}
					}
				}
			}
		}
		
		
		
		private function _onItemReady(event:FarHelperAssignEvent):void {
			var itemHelper:FarHelperItem = event.helperItem as FarHelperItem;
			
			itemHelper.removeEventListener(FarHelperAssignEvent.ITEM_READY, _onItemReady);
			
			_chunkLoadCounter--;
			
			// check if all items are loaded
			if(_chunkLoadCounter == 0) {
				$isLoaded = true;
			
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}
