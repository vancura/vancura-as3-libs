package org.vancura.vaclav.widgets.globals {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.widgets.interfaces.ISkinnable;

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

	
	
	public class SWFLibraryProvider extends SkinProvider {

		
		
		private var _skinMC:MovieClip;
		private var _loaderInfo:LoaderInfo;
		private var _skinURLLoader:URLLoader;
		private var _skinSWFLoader:Loader;
		private var _isError:Boolean;

		
		
		/*
		 * Constructor: SWFLibraryProvider
		 * 
		 * Create a new SWFLibraryProvider.
		 * 
		 * Parameters:
		 * 		uri				- URI of the SWF containing the skin library
		 * 		themeElements	- Theming element names
		 * 		themeConfig		- Theming element config
		 * 		isVerbose		- Verbose flag
		 */
		public function SWFLibraryProvider(uri:String, themeElements:Array = null, themeConfig:Array = null, isVerbose:Boolean = false):void {
			// initialize super
			super(themeElements, themeConfig, isVerbose);
			
			_skinURLLoader = new URLLoader();
			_skinURLLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_skinURLLoader.addEventListener(Event.COMPLETE, _onURLLoaderComplete, false, 0, true);
			_skinURLLoader.addEventListener(IOErrorEvent.IO_ERROR, _onURLLoaderError, false, 0, true);
			_skinURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onURLLoaderError, false, 0, true);
				
			_skinSWFLoader = new Loader();
			_skinSWFLoader.contentLoaderInfo.addEventListener(Event.INIT, _onSWFLoaderInit, false, 0, true);
				
			_skinURLLoader.load(new URLRequest(uri));
		}

		
		
		override protected function $getAsset(name:String):MovieClip {
			try {
				return new(_loaderInfo.applicationDomain.getDefinition(name) as Class) as MovieClip;
			}
			catch(err:ReferenceError) {
			}
			
			return null;
		}
		
		
		
		override protected function $applyAsset(skin:ISkinnable, cls:Class, i:Object):Boolean {
			var asset:MovieClip = $getAsset(i.symbol);
			
			if(i.symbol != undefined) {
				try {
					with(skin as cls) {
						if(asset != null) {
							getAssetsFromMovieClip(asset, $themeElements);
							parseConfig($mergeConfig(i));
							return true;
						}
						else {
							if(_isVerbose) {
								trace(printf('SWFLibraryProvider: "%s" skin requires symbol "%s", but it was not found in the library', i.id, i.symbol));
							}
							return false;
						}
					}
				}
				catch(err:Error) {
					throw new Error(printf('Could not apply asset (%s)', err.message));
				}
			}
			else {
				if($isVerbose) {
					trace(printf('SWFLibraryProvider: "%s" skin requires symbol field', i.id));
				}
				return false;
			}
			
			return false;
		}
		
		
		
		private function _onURLLoaderComplete(event:Event):void {
			if(_isError) {
				return;
			}
			
			var lc:LoaderContext = new LoaderContext(false, null);
			
			// FIXME: allowLoadBytesCodeExecution may be broken one day
			// We have to find a way how to load content from another sandbox
			// More info: http://richardleggett.co.uk/blog/index.php/2009/04/02/loading-swfs-into-air-1-5-and-loaderinfo
			// As seen here, it even doesn't compile, I have to put the parameter using Array. Damn!
			// lc['allowLoadBytesCodeExecution'] = true;
			_skinSWFLoader.loadBytes(_skinURLLoader.data, lc);
		}

		
		
		private function _onURLLoaderError(event:ErrorEvent):void {
			_isError = true;
			
			trace('Skin could not be loaded. Is the URI correct?');
		}

		
		
		private function _onSWFLoaderInit(event:Event):void {
			if(_isError) return;
			
			_skinURLLoader.removeEventListener(Event.COMPLETE, _onURLLoaderComplete);
			_skinURLLoader.removeEventListener(IOErrorEvent.IO_ERROR, _onURLLoaderError);
			_skinURLLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onURLLoaderError);
			_skinSWFLoader.contentLoaderInfo.removeEventListener(Event.INIT, _onSWFLoaderInit);
			
			// initial setting
			_skinMC = _skinSWFLoader.contentLoaderInfo.content as MovieClip;
			
			// get skin loaderInfo.
			// used to get assets from skin asset library.
			if(_skinMC.loaderInfo == null) {
				throw new Error('Could not get skin loaderInfo (skin asset library)');
			}
			else {
				_loaderInfo = _skinMC.loaderInfo;
			}
			
			// get config
			var skinConfig:Object;
			try {
				skinConfig = _skinMC.getSkinConfig();
			}
			catch(err:Error) {
				throw new Error('Could not get skin config. Usually it means there was a compile error while publishing skin SWF. Go check it out into Compiler Errors panel in Flash.');
			}
			
			// get skins from the $skinConfig
			$getSkins(skinConfig);
			
			// send COMPLETE event
			dispatchEvent(new Event(Event.COMPLETE, true));
		}
	}
}
