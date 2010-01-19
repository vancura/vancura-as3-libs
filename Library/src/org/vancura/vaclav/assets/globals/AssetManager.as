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

package org.vancura.vaclav.assets.globals {
	import flash.events.EventDispatcher;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.interfaces.IAssetProvider;

	/**
	 * Asset manager. Singleton.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class AssetManager extends EventDispatcher {


		private static var _provider:IAssetProvider;



		/**
		 * Attach a provider.
		 *
		 * @param provider Provider to be attached
		 * @see IAssetProvider
		 */
		public static function attachProvider(provider:IAssetProvider):void {
			if(_provider == null) {
				// attaching a new asset provider
				_provider = provider;
			}

			else throw new Error('Asset provider already attached');
		}



		/**
		 * Get an Asset.
		 *
		 * @param id Asset ID
		 * @return Asset (if defined, null if not)
		 */
		public static function getAsset(id:String):* {
			var out:Asset;

			if(_provider == null) throw new Error('Asset provider not attached');

			else {
				// try to find the asset
				for each(var item:Asset in _provider.assetsList) {
					if(item.id == id) out = item;
				}
			}

			return out;
		}



		/**
		 * Generate AssetManager description.
		 *
		 * @return AssetManager description
		 */
		public static function toString():String {
			var out:String;

			if(_provider == null) out = 'AssetManager info:\n  provider not attached';

			else {
				// create list of assets
				var list:String = '';
				for each(var i:Asset in _provider.assetsList) {
					list += i.id + ', ';
				}

				// strip trailing ', '
				list = list.substr(0, list.length - 2);

				var ps:String = _provider.toString();
				out = 'AssetManager info:\n  provider=' + ps + '\n  registered assets: ' + list;
			}

			return out;
		}



		// Getters & setters
		// -----------------


		/**
		 * Get list of assets.
		 *
		 * @return List of assets as Array
		 */
		public static function get assetsList():Array {
			if(_provider == null) throw new Error('Asset provider not attached');

			else {
				// return asset list
				return _provider.assetsList;
			}
		}



		/**
		 * Get pointer to asset provider.
		 *
		 * @return Asset provider (if attached, null if not)
		 * @see IAssetProvider
		 */
		public static function get provider():IAssetProvider {
			return _provider;
		}



		/**
		 * Has an error happened?
		 *
		 * @return Error happened flag
		 */
		public static function get isError():Boolean {
			var out:Boolean;

			if(_provider == null) out = false;
			else out = _provider.isError;

			return out;
		}



		/**
		 * Is AssetManager active?
		 *
		 * @return AssetManager active flag
		 */
		public static function get isActive():Boolean {
			var out:Boolean;

			if(_provider == null) out = false;
			else out = _provider.isActive;

			return out;
		}



		/**
		 * Is everything loaded?
		 *
		 * @return Loaded flag
		 */
		public static function get isLoaded():Boolean {
			var out:Boolean;

			if(_provider == null) out = false;
			else out = _provider.isLoaded;

			return out;
		}
	}
}
