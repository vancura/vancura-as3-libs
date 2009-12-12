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

/**
 * TODO: When asset needs an image which is not bundled in the far, it silently fails.
 */


package org.vancura.vaclav.assets.providers {
	import br.com.stimuli.string.printf;

	import com.adobe.serialization.json.JSON;

	import flash.events.Event;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.Chunk;
	import org.vancura.vaclav.assets.events.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.events.AssetManagerItemEvent;
	import org.vancura.vaclav.assets.interfaces.IAssetProvider;
	import org.vancura.vaclav.far.FarHelper;
	import org.vancura.vaclav.far.FarHelperItem;
	import org.vancura.vaclav.far.events.FarHelperAssignEvent;
	import org.vancura.vaclav.far.events.FarHelperEvent;

	/**
	 * Class: FARAssetProvider
	 *
	 * FAR Asset provider.
	 * Based on the FAR loader by Edwin van Rijkom (<http://code.google.com/p/vanrijkom-flashlibs>)
	 *
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class FARAssetProvider extends AssetProvider implements IAssetProvider {


		private static const _ASSETS_CONFIG_INDEX:String = 'config.json';
		private static const _INDEX_URL_PREFIX:String = 'index:';

		private var _contentURL:String;
		private var _farHelper:FarHelper;
		private var _chunkLoadCounter:uint;
		private var _chunksList:Array;
		private var _assetsConfig:Object;
		private var _indexList:Array;



		/**
		 * FAR Asset provider constructor.
		 * @param contentURL FAR URL
		 * @param assetsConfigIndex Item name of the config, "config.json" by default
		 */
		public function FARAssetProvider(contentURL:String, assetsConfigIndex:String = _ASSETS_CONFIG_INDEX) {
			super();

			// store varialbes
			_contentURL = contentURL;
			_chunksList = new Array();
			_chunkLoadCounter = 0;
			_indexList = new Array();
			$isActive = true;

			// create a new FarHelper
			_farHelper = new FarHelper();

			// add event listeners
			_farHelper.addEventListener(FarHelperEvent.STREAM_IO_ERROR, _onFarIOError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.STREAM_SECURITY_ERROR, _onFarSecurityError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_NOT_FOUND, _onItemNotFound, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadFailed, false, 0, true);

			// load FAR and config item
			_farHelper.load(_contentURL);
			_farHelper.loadItem(assetsConfigIndex);
		}



		/**
		 * FAR Asset provider destructor.
		 */
		override public function destroy():void {
			if($isActive) {
				// remove event listeners
				_farHelper.removeEventListener(FarHelperEvent.STREAM_IO_ERROR, _onFarIOError);
				_farHelper.removeEventListener(FarHelperEvent.STREAM_SECURITY_ERROR, _onFarSecurityError);
				_farHelper.removeEventListener(FarHelperEvent.ITEM_NOT_FOUND, _onItemNotFound);
				_farHelper.removeEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete);
				_farHelper.removeEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadFailed);

				// destroy FarHelper
				_farHelper.destroy();

				// destroy super
				super.destroy();
			}
		}



		/**
		 * Get an Asset from the provider
		 * @param id Asset ID
		 * @return Asset
		 * @see Asset (if found, null if not)
		 */
		override public function getAsset(id:String):Asset {
			var asset:Asset = super.getAsset(id);

			if(asset != null) {
				// dispatch en event that the item was loaded
				dispatchEvent(new AssetManagerItemEvent(AssetManagerItemEvent.ITEM_LOADED, false, false, asset));
			}

			return asset;
		}



		// Event listeners
		// ---------------

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
					// find all URLs referenced by the asset
					// add it to the list for future reference
					var newAsset:Asset = new Asset(assetConfig.id, assetConfig);
					_findURLs(newAsset, assetConfig);
					$assetsList.push(newAsset);
				}
			}
			else {
				// standard asset

				// find all chunks previously found by the _findURLs() method
				for each(var chunk:Chunk in _chunksList) {
					if(chunk.url.substr(_INDEX_URL_PREFIX.length) == itemHelper.index) {
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



		private function _findURLs(asset:Asset, branch:Object):void {
			// browse all items in the list
			for each(var leaf:Object in branch) {
				// test for the leaf, if it's string, then it *may* contain an URL reference

				if(leaf is String) {
					// ok, it's a String

					var leafAsString:String = leaf as String;

					if(leafAsString.indexOf(_INDEX_URL_PREFIX) == 0) {
						// strip the trailing this

						var isNewChunk:Boolean = true;
						var isNewIndex:Boolean = true;
						var index:String = leafAsString.substr(_INDEX_URL_PREFIX.length);

						// browse all stored chunks and test if the chunk is already there
						for each(var testedChunk:Chunk in _chunksList) {
							if(testedChunk.url == leafAsString) {
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
					_findURLs(asset, leaf);
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
						if(ch.url.substr(_INDEX_URL_PREFIX.length) == itemHelper.index) {
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
