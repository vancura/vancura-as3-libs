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
 * TODO: Finalize SWFLibraryProvider
 */

package org.vancura.vaclav.assets.providers {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class SWFLibraryProvider extends AssetProvider {


		private var _skinMC:MovieClip;
		private var _loaderInfo:LoaderInfo;
		private var _urlLoader:URLLoader;
		private var _swfLoader:Loader;
		private var _url:String;



		/**
		 * SWFLibrary Asset provider constructor.
		 *
		 * @param url SWF URL
		 */
		public function SWFLibraryProvider(url:String):void {
			// initialize super
			// super(themeElements, themeConfig, isVerbose);

			// store parameters
			_url = url;

			// create url loader
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE, _onURLLoaderComplete, false, 0, true);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _onURLLoaderError, false, 0, true);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onURLLoaderError, false, 0, true);

			// create swf loader
			_swfLoader = new Loader();
			_swfLoader.contentLoaderInfo.addEventListener(Event.INIT, _onSWFLoaderInit, false, 0, true);

			// load
			var ur:URLRequest = new URLRequest(url);
			_urlLoader.load(ur);
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
		//								trace(printf('SWFLibraryProvider: "%s" skin requires symbol "%s", but it was not found in the library', i.id, i.symbol));
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
		//					trace(printf('SWFLibraryProvider: "%s" skin requires symbol field', i.id));
		//				}
		//				return false;
		//			}
		//
		//			return false;
		//		}


		public function get url():String {
			return _url;
		}



		// Event listeners
		// ---------------


		//noinspection FunctionWithMultipleReturnPointsJS
		private function _onURLLoaderComplete(event:Event):void {
			if(_isError) return;

			var lc:LoaderContext = new LoaderContext(false, null);

			// TODO: allowLoadBytesCodeExecution may be broken one day
			// We have to find a way how to load content from another sandbox
			// More info: http://richardleggett.co.uk/blog/index.php/2009/04/02/loading-swfs-into-air-1-5-and-loaderinfo
			// As seen here, it even doesn't compile, I have to put the parameter using Array. Damn!
			// lc['allowLoadBytesCodeExecution'] = true;
			_swfLoader.loadBytes(_urlLoader.data, lc);
		}



		private function _onURLLoaderError(event:ErrorEvent):void {
			_isError = true;

			// dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, true, false, printf('Skin could not be loaded. Is the URL "%s" correct?', _uri)));
		}



		//noinspection FunctionWithMultipleReturnPointsJS
		private function _onSWFLoaderInit(event:Event):void {
			if(_isError) return;

			// remove event listeners
			_urlLoader.removeEventListener(Event.COMPLETE, _onURLLoaderComplete);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, _onURLLoaderError);
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onURLLoaderError);
			_swfLoader.contentLoaderInfo.removeEventListener(Event.INIT, _onSWFLoaderInit);

			// initial setting
			_skinMC = _swfLoader.contentLoaderInfo.content as MovieClip;

			// get skin loaderInfo.
			// used to get assets from skin asset library.
			if(_skinMC.loaderInfo == null) throw new Error('Could not get skin loaderInfo (skin asset library)');
			else _loaderInfo = _skinMC.loaderInfo;

			// get config
			var skinConfig:Object;
			try {
				skinConfig = _skinMC.getSkinConfig();
			}
			catch(err:Error) {
				throw new Error('Could not get skin config. Usually it means there was a compile error while publishing skin SWF. Go check it out into Compiler Errors panel in Flash. (' + err.message + ')');
			}

			// get skins from the $skinConfig
			//			$getSkins(skinConfig);

			// send COMPLETE event
			//			dispatchEvent(new Event(Event.COMPLETE, true));
		}
	}
}
