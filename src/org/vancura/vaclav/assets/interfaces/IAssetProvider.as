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

package org.vancura.vaclav.assets.interfaces {
	import flash.events.IEventDispatcher;

	import org.vancura.vaclav.assets.Asset;

	/**
	 * Interface: IAssetProvider
	 *
	 * AssetProvider interface.
	 *
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public interface IAssetProvider extends IEventDispatcher {


		/**
		 * AssetProvider destructor.
		 */
		function destroy():void;



		/**
		 * Get an Asset from the provider.
		 * @param id Asset ID
		 * @return Asset (if found, null if not)
		 * @see Asset
		 */
		function getAsset(id:String):Asset;



		/**
		 * Generate AssetProvider description.
		 * @return AssetProvider description
		 */
		function toString():String;



		/**
		 * Get list of assets as Array
		 * @return List of assets
		 */
		function get assetsList():Array;



		/**
		 * Is AssetProvider active?
		 * @return AssetProvider active flag
		 */
		function get isActive():Boolean;



		/**
		 * Is AssetProvider fully loaded?
		 * @return AssetProvider loaded flag
		 */
		function get isLoaded():Boolean;



		/**
		 * Has an error happened?
		 * @return Error flag
		 */
		function get isError():Boolean;

	}
}
