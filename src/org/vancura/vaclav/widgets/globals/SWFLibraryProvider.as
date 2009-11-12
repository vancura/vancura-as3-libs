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
			
			// get skins
			if($skinConfig.skins != null && $skinConfig.skins.length > 0) {
				for each(var i:Object in $skinConfig.skins) {
					if(i.id != undefined && i.type != undefined) {
						
						var skin:ISkinnable;
						var isSupported:Boolean = true;
						var isOK:Boolean = true;
						
						switch(i.type) {
							case Skin.TYPE_BAR:
								skin = new BarSkin(i.id);
								_applyAsset(skin, BarSkin, i);
								(skin as BarSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_IMAGE:
								skin = new ImageSkin(i.id);
								_applyAsset(skin, ImageSkin, i);
								(skin as ImageSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_BUTTON:
								skin = new ButtonSkin(i.id);
								_applyAsset(skin, ButtonSkin, i);
								(skin as ButtonSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_LABEL:
								skin = new LabelSkin(i.id);
								(skin as LabelSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_LABEL_BUTTON:
								skin = new LabelButtonSkin(i.id);
								_applyAsset((skin as LabelButtonSkin).buttonSkin, ButtonSkin, i.button);
								(skin as LabelButtonSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_CHECK_BUTTON:
								skin = new CheckButtonSkin(i.id);
								_applyAsset((skin as CheckButtonSkin).buttonOffSkin, ButtonSkin, i.buttonOff);
								_applyAsset((skin as CheckButtonSkin).buttonOnSkin, ButtonSkin, i.buttonOn);
								(skin as CheckButtonSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_INPUT_BAR:
								skin = new InputBarSkin(i.id);
								_applyAsset((skin as InputBarSkin).barSkin, BarSkin, i.bar);
								(skin as InputBarSkin).parseConfig($mergeConfig(i));
								break;
								
							default:
								isSupported = false;
						}
						
						if(isOK && isSupported) {
							if($isVerbose) {
								trace(printf('SkinManager: Adding "%s" skin "%s"', i.type, i.id));
							}
							$skinList.push(skin);
						}
						else if(isOK) {
							if($isVerbose) {
								trace(printf('SkinManager: "%s" skin is unsupported (type "%s")', i.id, i.type));
							}
						}
						 
					}
					else {
						if($isVerbose) {
							trace('SkinManager: Found skin without id or type fields defined');
						}
					}
				}
			}
			else {
				if($isVerbose) {
					trace('SkinManager: No skins defined');
				}
			}
		}

		
		
		private function _getAsset(name:String):MovieClip {
			try {
				return new(_loaderInfo.applicationDomain.getDefinition(name) as Class) as MovieClip;
			}
			catch(err:ReferenceError) {
			}
			
			return null;
		}
		
		
		
		private function _applyAsset(skin:ISkinnable, cls:Class, i:Object):Boolean {
			var asset:MovieClip = _getAsset(i.symbol);
			
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
