package org.vancura.vaclav.widgets.globals {
	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.skin.BarSkin;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.Skin;

	
	
	public class SkinManager {
		
		
		
		// TODO: Caching
		// TODO: Mergin with settings from FlashVar
		// TODO: Theming

		
		
		private static var _debugLevel:String = DebugLevel.NONE;
		private static var _debugColor:uint = 0xFF0000;

		
		
		public static function assetToSkin(asset:Asset):* {
			if(asset.isValid && asset.config.widget != null) {
				var skin:*;
				var isSupported:Boolean = true;
				var config:Object = asset.config.widget;
				
				switch(config.type) {
					case Skin.TYPE_BAR:
						skin = new BarSkin();
						
						with(skin as BarSkin) {
							getAssetsFromAtlas(asset.bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
//					case Skin.TYPE_IMAGE:
//						skin = new ImageSkin(i.id);
//						$applyAsset(skin, ImageSkin, i);
//						(skin as ImageSkin).parseConfig($mergeConfig(i));
//						break;
						
					case Skin.TYPE_BUTTON:
						skin = new ButtonSkin();
						
						with(skin as ButtonSkin) {
							getAssetsFromAtlas(asset.bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
//					case Skin.TYPE_LABEL:
//						skin = new LabelSkin(i.id);
//						(skin as LabelSkin).parseConfig($mergeConfig(i));
//						break;
//						
//					case Skin.TYPE_LABEL_BUTTON:
//						skin = new LabelButtonSkin(i.id);
//						$applyAsset((skin as LabelButtonSkin).buttonSkin, ButtonSkin, i.button);
//						(skin as LabelButtonSkin).parseConfig($mergeConfig(i));
//						break;
//						
//					case Skin.TYPE_CHECK_BUTTON:
//						skin = new CheckButtonSkin(i.id);
//						$applyAsset((skin as CheckButtonSkin).buttonOffSkin, ButtonSkin, i.buttonOff);
//						$applyAsset((skin as CheckButtonSkin).buttonOnSkin, ButtonSkin, i.buttonOn);
//						(skin as CheckButtonSkin).parseConfig($mergeConfig(i));
//						break;
//						
//					case Skin.TYPE_INPUT_BAR:
//						skin = new InputBarSkin(i.id);
//						$applyAsset((skin as InputBarSkin).barSkin, BarSkin, i.bar);
//						(skin as InputBarSkin).parseConfig($mergeConfig(i));
//						break;
						
					default:
						isSupported = false;
				}
			}
			
			if(isSupported) {
				return skin;
			}
			else {
				return null;
			}
		}

		
		
		public static function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public static function set debugLevel(debugLevel:String):void {
			_debugLevel = debugLevel;
		}
		
		
		
		public static function get debugColor():uint {
			return _debugColor;
		}
		
		
		
		public static function set debugColor(debugColor:uint):void {
			_debugColor = debugColor;
		}
	}
}
