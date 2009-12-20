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
 * TODO: Add MovieClipLibrary provider
 * TODO: Add SWFLibrary provider
 * TODO: Add folder provider
 */


package org.vancura.vaclav.assets.providers {
	import flash.events.EventDispatcher;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.interfaces.IAssetProvider;

	/**
	 * AssetProvider template.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class AssetProvider extends EventDispatcher implements IAssetProvider {


		/** Assets list */
		protected var _assetsList:Array;

		/** Error flag */
		protected var _isError:Boolean;

		/** Active flag */
		protected var _isActive:Boolean;

		/** Loaded flag */
		protected var _isLoaded:Boolean;



		/**
		 * AssetProvider constructor
		 */
		public function AssetProvider() {
			_assetsList = new Array();
		}



		/**
		 * AssetProvider destructor.
		 */
		public function destroy():void {
			if(_isActive) {
				_isActive = false;
				_isLoaded = false;
			}
		}



		/**
		 * Get an Asset from the provider.
		 *
		 * @param id Asset ID
		 * @return Asset (if found, null if not)
		 * @see Asset
		 */
		public function getAsset(id:String):Asset {
			var out:Asset;

			// try to find the asset in the asset list
			for each(var asset:Asset in _assetsList) {
				if(asset.id == id) out = asset;
			}

			return out;
		}



		// Getters & Setters
		// -----------------


		/**
		 * Get list of assets as Array.
		 *
		 * @return List of assets
		 */
		public function get assetsList():Array {
			return _assetsList;
		}



		/**
		 * Has an error happened?
		 *
		 * @return Error flag
		 */
		public function get isError():Boolean {
			return _isError;
		}



		/**
		 * Is AssetProvider active?
		 *
		 * @return AssetProvider active flag
		 */
		public function get isActive():Boolean {
			return _isActive;
		}



		/**
		 * Is AssetProvider fully loaded?
		 *
		 * @return AssetProvider loaded flag
		 */
		public function get isLoaded():Boolean {
			return _isLoaded;
		}
	}
}

