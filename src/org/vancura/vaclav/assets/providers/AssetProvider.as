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

