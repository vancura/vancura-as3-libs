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

/**
 * TODO: Caching
 * TODO: Mergin with settings from FlashVar etc.
 * TODO: Theming
 * TODO: Better error handling
 */

package org.vancura.vaclav.widgets.globals {
	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.skin.BarSkin;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.CheckButtonSkin;
	import org.vancura.vaclav.widgets.skin.GlyphButtonSkin;
	import org.vancura.vaclav.widgets.skin.GlyphLabelButtonSkin;
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
							getAssetsFromAtlas(asset.getChunkByURL(config.backgroundImage).bitmap.bitmapData);
							parseConfig(config);
						}

						break;

					case SkinType.IMAGE:
						skin = new ImageSkin();

						with(skin as ImageSkin) {
							getAssetsFromAtlas(asset.getChunkByURL(config.image).bitmap.bitmapData);
							parseConfig(config);
						}

						break;

					case SkinType.BUTTON:
						skin = new ButtonSkin();

						with(skin as ButtonSkin) {
							getAssetsFromAtlas(asset.getChunkByURL(config.backgroundImage).bitmap.bitmapData);
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
							buttonSkin.getAssetsFromAtlas(asset.getChunkByURL(config.button.backgroundImage).bitmap.bitmapData);
							parseConfig(config);
						}

						break;

					case SkinType.GLYPH_BUTTON:
						skin = new GlyphButtonSkin();

						with(skin as GlyphButtonSkin) {
							buttonSkin.getAssetsFromAtlas(asset.getChunkByURL(config.button.backgroundImage).bitmap.bitmapData);
							glyphsSkin.getAssetsFromAtlas(asset.getChunkByURL(config.glyph.image).bitmap.bitmapData);
							parseConfig(config);
						}

						break;

					case SkinType.GLYPH_LABEL_BUTTON:
						skin = new GlyphLabelButtonSkin();

						with(skin as GlyphLabelButtonSkin) {
							buttonSkin.getAssetsFromAtlas(asset.getChunkByURL(config.button.backgroundImage).bitmap.bitmapData);
							glyphsSkin.getAssetsFromAtlas(asset.getChunkByURL(config.glyph.image).bitmap.bitmapData);
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
