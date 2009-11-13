package org.vancura.vaclav.widgets.globals {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.widgets.interfaces.ISkinnable;

	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;

	
	
	public class MovieClipLibraryProvider extends SkinProvider {

		
		
		private var _skinMC:MovieClip;
		private var _loaderInfo:LoaderInfo;

		
		
		/*
		 * Constructor: MovieClipLibraryProvider
		 * 
		 * Create a new MovieClipLibraryProvider.
		 * 
		 * Parameters:
		 * 		mc				- MovieClip containing the skin library
		 * 		themeElements	- Theming element names
		 * 		themeConfig		- Theming element config
		 * 		isVerbose		- Verbose flag
		 */
		public function MovieClipLibraryProvider(mc:MovieClip, themeElements:Array = null, themeConfig:Array = null, isVerbose:Boolean = false):void {
			// initialize super
			super(themeElements, themeConfig, isVerbose);
			
			// initial setting
			_skinMC = mc;
			
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
								trace(printf('MovieClipLibraryProvider: "%s" skin requires symbol "%s", but it was not found in the library', i.id, i.symbol));
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
					trace(printf('MovieClipLibraryProvider: "%s" skin requires symbol field', i.id));
				}
				return false;
			}
			
			return false;
		}
	}
}
