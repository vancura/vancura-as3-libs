/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the “Software”), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.assets.globals {
	import br.com.stimuli.string.printf;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.events.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.interfaces.IAssetProvider;

	/**
	 * Class: AssetManager
	 *
	 * Asset manager. Singleton.
	 *
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class AssetManager extends EventDispatcher {


		private static var _instance:AssetManager;
		private var _provider:IAssetProvider;



		/**
		 * Get an AssetManager instance (AssetManager is singleton)
		 * @return AssetManager instance
		 */
		public static function getInstance():AssetManager {
			return _instance || (_instance = new AssetManager());
		}



		/**
		 * Attach a provider.
		 * @param provider Provider to be attached
		 * @see IAssetProvider
		 */
		public function attachProvider(provider:IAssetProvider):void {
			if(_provider != null) throw new Error('Asset provider already attached');

			else {
				// attaching a new asset provider
				_provider = provider;

				// add event listeners
				_provider.addEventListener(Event.COMPLETE, _onProviderComplete, false, 0, true);
				_provider.addEventListener(AssetManagerErrorEvent.PROVIDER_ERROR, _onProviderError, false, 0, true);
				_provider.addEventListener(AssetManagerErrorEvent.ITEM_LOAD_FAILED, _onItemLoadFailed, false, 0, true);
				_provider.addEventListener(AssetManagerErrorEvent.ITEM_NOT_FOUND, _onItemNotFound, false, 0, true);
			}
		}



		/**
		 * Get an Asset.
		 * @param id Asset ID
		 * @return Asset (if defined, null if not)
		 */
		public function getAsset(id:String):* {
			if(_provider == null) throw new Error('Asset provider not attached');

			else {
				// try to find the asset
				for each(var item:Asset in _provider.assetsList) {
					if(item.id == id) return item;
				}
			}

			return null;
		}



		/**
		 * Generate AssetManager description.
		 * @return AssetManager description
		 */
		override public function toString():String {
			if(_provider == null) {
				return printf('AssetManager info:\n  provider not attached');
			}
			else {
				// create list of assets
				var list:String = '';
				for each(var i:Asset in _provider.assetsList) {
					list += printf('%s, ', i.id);
				}

				// strip trailing ', '
				list = list.substr(0, list.length - 2);

				return printf('AssetManager info:\n  provider=%s\n  registered assets: %s', _provider.toString(), list);
			}
		}



		// Getters & setters
		// -----------------


		/**
		 * Get list of assets.
		 * @return List of assets as Array
		 */
		public function get assetsList():Array {
			if(_provider == null) throw new Error('Asset provider not attached');

			else {
				// return asset list
				return _provider.assetsList;
			}
		}



		/**
		 * Get pointer to asset provider
		 * @return Asset provider (if attached, null if not)
		 * @see IAssetProvider
		 */
		public function get provider():IAssetProvider {
			return _provider;
		}



		/**
		 * Has an error happened?
		 * @return Error happened flag
		 */
		public function get isError():Boolean {
			return (_provider != null) ? _provider.isError : false;
		}



		/**
		 * Is AssetManager active?
		 * @return AssetManager active flag
		 */
		public function get isActive():Boolean {
			return (_provider != null) ? _provider.isActive : false;
		}



		/**
		 * Is everything loaded?
		 * @return Loaded flag
		 */
		public function get isLoaded():Boolean {
			return (_provider != null) ? _provider.isLoaded : false;
		}



		// Private stuff
		// -------------


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
