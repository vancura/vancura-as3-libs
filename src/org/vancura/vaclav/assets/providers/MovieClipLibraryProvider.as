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
 * TODO: Finalize MovieClipLibraryProvider
 */

package org.vancura.vaclav.assets.providers {
	import br.com.stimuli.string.printf;

	import flash.display.LoaderInfo;
	import flash.display.MovieClip;

	public class MovieClipLibraryProvider extends AssetProvider {


		private var _skinMC:MovieClip;
		private var _loaderInfo:LoaderInfo;



		/**
		 * MovieClipLibrary provider constructor.
		 *
		 * @param mc MovieClip with the library to be loaded.
		 */
		public function MovieClipLibraryProvider(mc:MovieClip):void {
			// initialize super
			// super(themeElements, themeConfig, isVerbose);

			// initial setting
			_skinMC = mc;

			// get skin loaderInfo.
			// used to get assets from skin asset library.
			if(_skinMC.loaderInfo === null) throw new Error('Could not get skin loaderInfo (skin asset library)');
			else _loaderInfo = _skinMC.loaderInfo;

			// get config
			var skinConfig:Object;
			try {
				skinConfig = _skinMC.getSkinConfig();
			}
			catch(err:Error) {
				var message:String = printf('Could not get skin config. Usually it means there was a compile error while publishing skin SWF. Go check it out into Compiler Errors panel in Flash.', err);
				throw new Error(message);
			}

			// get skins from the $skinConfig
			// $getSkins(skinConfig);

			// send COMPLETE event
			// dispatchEvent(new Event(Event.COMPLETE, true));
		}



		//		override protected function $getAsset(name:String):MovieClip {
		//			try {
		//				return new(_loaderInfo.applicationDomain.getDefinition(name) as Class) as MovieClip;
		//			}
		//			catch(err:ReferenceError) {
		//			}
		//
		//			return null;
		//		}


		//		override protected function $applyAsset(skin:ISkinnable, cls:Class, i:Object):Boolean {
		//			var asset:MovieClip = $getAsset(i.symbol);
		//
		//			if(i.symbol != undefined) {
		//				try {
		//					with(skin as cls) {
		//						if(asset != null) {
		//							getAssetsFromMovieClip(asset, $themeElements);
		//							parseConfig($mergeConfig(i));
		//							return true;
		//						}
		//						else {
		//							if(_isVerbose) {
		//								trace(printf('MovieClipLibraryProvider: "%s" skin requires symbol "%s", but it was not found in the library', i.id, i.symbol));
		//							}
		//							return false;
		//						}
		//					}
		//				}
		//				catch(err:Error) {
		//					throw new Error(printf('Could not apply asset (%s)', err.message));
		//				}
		//			}
		//			else {
		//				if($isVerbose) {
		//					trace(printf('MovieClipLibraryProvider: "%s" skin requires symbol field', i.id));
		//				}
		//				return false;
		//			}
		//
		//			return false;
		//		}
	}
}
