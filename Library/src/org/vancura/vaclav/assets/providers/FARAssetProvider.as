/***********************************************************************************************************************
 * Some methods Copyrighted by their authors, specified in ASDocs.
 * If not specified elsewhere: Copyright (c) 2010 Vaclav Vancura.
 *
 * Contact me at vaclav@vancura.org, @vancura or at my homepage at http://vaclav.vancura.org.
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Licensed under Attribution 3.0 Czech Republic (http://creativecommons.org/licenses/by/3.0/cz/deed.en_GB).
 *
 * That means you are free:
 * * to copy, distribute, display, and perform the work
 * * to make derivative works
 *
 * Under the following conditions::
 * * Attribution Ñ You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver Ñ Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights Ñ In no way are any of the following rights affected by the license:
 * 	        - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/


package org.vancura.vaclav.assets.providers {
	import com.adobe.serialization.json.JSON;

	import flash.events.Event;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.Chunk;
	import org.vancura.vaclav.assets.events.ProviderErrorEvent;
	import org.vancura.vaclav.assets.events.ProviderItemEvent;
	import org.vancura.vaclav.assets.interfaces.IAssetProvider;
	import org.vancura.vaclav.far.FarHelper;
	import org.vancura.vaclav.far.FarHelperItem;
	import org.vancura.vaclav.far.events.FarHelperAssignEvent;
	import org.vancura.vaclav.far.events.FarHelperEvent;
	import org.vancura.vaclav.far.events.FarHelperProgressEvent;

	/**
	 * FAR Asset provider.
	 * Based on the FAR loader by Edwin van Rijkom (http://code.google.com/p/vanrijkom-flashlibs)
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 *
	 * TODO: When loading a FAR and some (or no) index not found, everything silently fails. This is critical!
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
		private var _streamProgress:Number;
		private var _assetsConfigIndex:String;



		/**
		 * FAR Asset provider constructor.
		 *
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
			_isActive = true;
			_assetsConfigIndex = assetsConfigIndex;

			// create a new FarHelper
			_farHelper = new FarHelper();

			// add event listeners
			_farHelper.addEventListener(FarHelperEvent.STREAM_IO_ERROR, _onFarIOError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.STREAM_SECURITY_ERROR, _onFarSecurityError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_NOT_FOUND, _onItemNotFound, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadFailed, false, 0, true);
			_farHelper.addEventListener(FarHelperProgressEvent.STREAM_LOAD_PROGRESS, _onStreamLoadProgress, false, 0, true);

			// load FAR and config item
			_farHelper.load(_contentURL);
			_farHelper.loadItem(_assetsConfigIndex);
		}



		/**
		 * FAR Asset provider destructor.
		 */
		override public function destroy():void {
			if(_isActive) {
				// remove event listeners
				_farHelper.removeEventListener(FarHelperEvent.STREAM_IO_ERROR, _onFarIOError);
				_farHelper.removeEventListener(FarHelperEvent.STREAM_SECURITY_ERROR, _onFarSecurityError);
				_farHelper.removeEventListener(FarHelperProgressEvent.STREAM_LOAD_PROGRESS, _onStreamLoadProgress);
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
		 * Get an Asset from the provider.
		 *
		 * @param id Asset ID
		 * @return Asset
		 * @see Asset (if found, null if not)
		 */
		override public function getAsset(id:String):Asset {
			var asset:Asset = super.getAsset(id);

			if(asset != null) {
				// dispatch en event that the item was loaded
				var e:ProviderItemEvent = new ProviderItemEvent(ProviderItemEvent.ITEM_LOADED, false, false, asset);
				dispatchEvent(e);
			}

			return asset;
		}



		// Event listeners
		// ---------------

		private function _onFarSecurityError(event:FarHelperEvent):void {
			_isError = true;
			_isLoaded = false;

			var d:String = 'Security error loading asset library: ' + event.text;
			var e:ProviderErrorEvent = new ProviderErrorEvent(ProviderErrorEvent.PROVIDER_ERROR, false, false, d);
			dispatchEvent(e);
		}



		private function _onFarIOError(event:FarHelperEvent):void {
			_isError = true;
			_isLoaded = false;

			var d:String = 'IO error loading asset library: ' + event.text;
			var e:ProviderErrorEvent = new ProviderErrorEvent(ProviderErrorEvent.PROVIDER_ERROR, false, false, d);
			dispatchEvent(e);
		}



		private function _onItemNotFound(event:FarHelperEvent):void {
			var d:String = 'Asset item "' + event.helperItem.index + '" not found in the asset library';
			var e:ProviderErrorEvent = new ProviderErrorEvent(ProviderErrorEvent.ITEM_NOT_FOUND, false, false, d);
			dispatchEvent(e);
		}



		private function _onItemLoadFailed(event:FarHelperEvent):void {
			var d:String = 'Asset item "' + event.helperItem.index + '" load failed';
			var e:ProviderErrorEvent = new ProviderErrorEvent(ProviderErrorEvent.ITEM_LOAD_FAILED, false, false, d);
			dispatchEvent(e);
		}



		//noinspection FunctionWithMultipleReturnPointsJS
		private function _onItemLoadComplete(event:FarHelperEvent):void {
			var itemHelper:FarHelperItem = event.helperItem as FarHelperItem;

			if(itemHelper.index == _assetsConfigIndex) {
				// assets library config found

				var c:String = itemHelper.farItem.data.toString();
				try {
					_assetsConfig = JSON.decode(c);
				}
				catch(err:Error) {
					var m:String = 'Error parsing config JSON (' + err.message + ')';
					var e:ProviderErrorEvent = new ProviderErrorEvent(ProviderErrorEvent.CONFIG_PARSING_ERROR, false, false, m);
					dispatchEvent(e);
					return;
				}

				// find all assets specified in the config
				for each(var assetConfig:Object in _assetsConfig) {

					// create new asset
					// find all URLs referenced by the asset
					// add it to the list for future reference
					var newAsset:Asset = new Asset(assetConfig.id, assetConfig);
					_findURLs(newAsset, assetConfig);
					_assetsList.push(newAsset);
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



		private function _onStreamLoadProgress(event:FarHelperProgressEvent):void {
			_streamProgress = event.progress;

			var e:Event = event.clone();
			dispatchEvent(e);
		}



		//noinspection OverlyComplexFunctionJS
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
							// ok, so it's a new asset

							// create a new list of assets if not created before
							if(_indexList[index] == null) _indexList[index] = new Array();

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
			--_chunkLoadCounter;
			if(_chunkLoadCounter == 0) {
				// all is done
				_isLoaded = true;

				var e:Event = new Event(Event.COMPLETE);
				dispatchEvent(e);
			}
		}
	}
}
