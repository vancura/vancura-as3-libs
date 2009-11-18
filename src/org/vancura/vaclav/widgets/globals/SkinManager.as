// TODO: Caching
// TODO: Mergin with settings from FlashVar etc.
// TODO: Theming
// TODO: Better error handling



package org.vancura.vaclav.widgets.globals {
	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.skin.BarSkin;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.CheckButtonSkin;
	import org.vancura.vaclav.widgets.skin.ImageSkin;
	import org.vancura.vaclav.widgets.skin.InputBarSkin;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.LabelSkin;

	
	
	public class SkinManager {
		
		
		
		private static var _debugLevel:String = DebugLevel.NONE;
		private static var _debugColor:uint = 0xFF0000;

		
		
		public static function assetToSkin(asset:Asset):* {
			if(asset.config.widget != null) {
				var skin:*;
				var isSupported:Boolean = true;
				var config:Object = asset.config.widget;
				
				switch(config.type) {
					case SkinType.BAR:
						skin = new BarSkin();
						
						with(skin as BarSkin) {
							getAssetsFromAtlas(asset.getChunkByURI(config.backgroundImage).bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
					case SkinType.IMAGE:
						skin = new ImageSkin();
						
						with(skin as ImageSkin) {
//							getAssetsFromAtlas(asset.bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
					case SkinType.BUTTON:
						skin = new ButtonSkin();
						
						with(skin as ButtonSkin) {
							getAssetsFromAtlas(asset.getChunkByURI(config.backgroundImage).bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
					case SkinType.LABEL:
						skin = new LabelSkin();
						
						with(skin as LabelSkin) {
							parseConfig(config);
						}
						
						break;
						
					case SkinType.LABEL_BUTTON:
						skin = new LabelButtonSkin();
						
						with(skin as LabelButtonSkin) {
							buttonSkin.getAssetsFromAtlas(asset.getChunkByURI(config.button.backgroundImage).bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
					case SkinType.CHECK_BUTTON:
						skin = new CheckButtonSkin();
						
						with(skin as CheckButtonSkin) {
//							buttonOffSkin.getAssetsFromAtlas(asset.bitmap.bitmapData);
//							buttonOnSkin.getAssetsFromAtlas(asset.bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
					case SkinType.INPUT_BAR:
						skin = new InputBarSkin();
						
						with(skin as InputBarSkin) {
//							barSkin.getAssetsFromAtlas(asset.bitmap.bitmapData);
							parseConfig(config);
						}
						
						break;
						
					default:
						isSupported = false;
				}
			}
			
			if(isSupported) {
				return skin;
			}
			
			return null;
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
