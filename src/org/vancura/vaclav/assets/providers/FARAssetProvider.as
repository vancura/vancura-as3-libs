// FIXME: When asset needs an image which is not bundled in the far, it silently fails



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

		
		
		private static const _ASSETS_CONFIG_INDEX:String = 'config.json';
		private static const _INDEX_URI_PREFIX:String = 'index:';
		
		private var _contentURI:String;
		private var _farHelper:FarHelper;
		private var _chunkLoadCounter:uint;
		private var _chunksList:Array;
		private var _assetsConfig:Object;
		private var _indexList:Array;

		
		
		public function FARAssetProvider(contentURI:String, assetsConfigIndex:String = _ASSETS_CONFIG_INDEX) {
			super();
			
			_contentURI = contentURI;
			_chunksList = new Array();
			_chunkLoadCounter = 0;
			_indexList = new Array();
			
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
				
				_assetsConfig = JSON.decode(itemHelper.farItem.data.toString());
				
				// find all assets specified in the config
				for each(var assetConfig:Object in _assetsConfig) {
					
					// create new asset
					// find all URIs referenced by the asset
					// add it to the list for future reference
					var newAsset:Asset = new Asset(assetConfig.id, assetConfig);
					_findURIs(newAsset, assetConfig);
					$assetsList.push(newAsset);
				}
			}
			else {
				// standard asset

				// find all chunks previously found by the _findURIs() method
				for each(var chunk:Chunk in _chunksList) {
					if(chunk.uri.substr(_INDEX_URI_PREFIX.length) == itemHelper.index) {
						// chunk index contains even the prefix (like this:),
						// but itemHelper.index contains just index
						// hence we need to strip it this way
						
						// add event listener to check for bitmap assignment afterwards
						itemHelper.addEventListener(FarHelperAssignEvent.ITEM_READY, _onItemReady, false, 0, true);
						
						// and assign a bitmap to the chunk
						itemHelper.assignBitmap(chunk.bitmap);
					}
				}
			}
		}
		
		
		
		private function _findURIs(asset:Asset, branch:Object):void {
			// browse all items in the list
			for each(var leaf:Object in branch) {
				// test for the leaf, if it's string, then it *may* contain an URI reference
				
				if(leaf is String) {
					// ok, it's a String
					
					var leafAsString:String = leaf as String;
					
					if(leafAsString.indexOf(_INDEX_URI_PREFIX) == 0) {
						// strip the trailing this
						
						var isNewChunk:Boolean = true;
						var isNewIndex:Boolean = true;
						var index:String = leafAsString.substr(_INDEX_URI_PREFIX.length);
						
						// browse all stored chunks and test if the chunk is already there
						for each(var testedChunk:Chunk in _chunksList) {
							if(testedChunk.uri == leafAsString) {
								// it's there, so ignore it, preventing dupes
								isNewChunk = false;
							}
						}
						
						// browse all stored assets and test if the asset is already there
						for each(var ix:Asset in _indexList[index]) {
							if(ix == asset) {
								// it's there, so ignore it, preventing dupes
								isNewIndex = true;
							}
						}
						
						if(isNewChunk) {
							// ok, so it's a new chunk
							
							var newChunk:Chunk = new Chunk(leafAsString, Chunk.BITMAP);
								
							// increase counter to test for the last loaded chunk
							_chunkLoadCounter++;
							
							// load item
							// _onItemLoadComplete() is a handler called on successful load
							_farHelper.loadItem(index);
							
							// add to the list
							_chunksList.push(newChunk);
						}
						
						if(isNewIndex) {
							// ok, so it's a ne asset
							
							// create a new list of assets if not created before
							if(_indexList[index] == null) {
								_indexList[index] = new Array();
							}
							
							// add it to the list of assets
							_indexList[index].push(asset);
						}
					}
				} // if(leaf is String)
				
				else if(leaf is Object) {
					// no, it's an Object, so go deeper
					_findURIs(asset, leaf);
				}
			}
		}
		
		
		
		private function _onItemReady(event:FarHelperAssignEvent):void {
			var itemHelper:FarHelperItem = event.helperItem as FarHelperItem;
			
			// remove all event listeners
			itemHelper.removeEventListener(FarHelperAssignEvent.ITEM_READY, _onItemReady);
			
			// check for all assets where the item is used
			for(var i:String in _indexList) {
				// _indexList[] contains a list of all assets
				
				if(i == itemHelper.index) {
					// now we got an asset list just for this particular farItem
					
					var chunk:Chunk;
					
					// find all chunks
					for each(var ch:Chunk in _chunksList) {
						if(ch.uri.substr(_INDEX_URI_PREFIX.length) == itemHelper.index) {
							chunk = ch;
						}
					}
					
					// add this chunk to the asset
					for each(var asset:Asset in _indexList[i]) {
						asset.addChunk(chunk);
					}
				}
			}
			
			// check if all items are loaded
			if(--_chunkLoadCounter == 0) {
				// all is done
				
				$isLoaded = true;
			
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}
