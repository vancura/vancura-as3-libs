package org.vancura.vaclav.widgets.globals {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.widgets.interfaces.ISkinnable;
	import org.vancura.vaclav.widgets.skin.BarSkin;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.CheckButtonSkin;
	import org.vancura.vaclav.widgets.skin.ImageSkin;
	import org.vancura.vaclav.widgets.skin.InputBarSkin;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.LabelSkin;
	import org.vancura.vaclav.widgets.skin.Skin;

	import flash.display.LoaderInfo;
	import flash.display.MovieClip;

	
	
	public class SWFLibraryProvider extends SkinProvider {

		
		
		private var _skinMC:MovieClip;
		private var _loaderInfo:LoaderInfo;

		
		
		public function SWFLibraryProvider(mc:MovieClip, themeElements:Array = null, themeConfig:Array = null, isVerbose:Boolean = false):void {
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
			try {
				$skinConfig = _skinMC.getSkinConfig();
			}
			catch(err:Error) {
				throw new Error('Could not get skin config. Usually it means there was a compile error while publishing skin SWF. Go check it out into Compiler Errors panel in Flash.');
			}
			
			$getSkins();
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
				with(skin as cls) {
					if(asset != null) {
						getAssetsFromMovieClip(asset, $themeElements);
						parseConfig($mergeConfig(i));
						return true;
					}
					else {
						if(_isVerbose) {
							trace(printf('SkinManager: "%s" skin requires symbol "%s", but it was not found in the library', i.id, i.symbol));
						}
						return false;
					}
				}
			}
			else {
				if($isVerbose) {
					trace(printf('SkinManager: "%s" skin requires symbol field', i.id));
				}
				return false;
			}
		}
	}
}
