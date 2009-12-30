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
 * TODO: Caching
 * TODO: Mergin with settings from FlashVar etc.
 * TODO: Theming
 * TODO: Better error handling
 */

package org.vancura.vaclav.widgets.globals {
	import flash.display.BitmapData;

	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.skin.BarSkin;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.CheckButtonSkin;
	import org.vancura.vaclav.widgets.skin.ContainerSkin;
	import org.vancura.vaclav.widgets.skin.GlyphButtonSkin;
	import org.vancura.vaclav.widgets.skin.GlyphLabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.ImageSkin;
	import org.vancura.vaclav.widgets.skin.InputBarSkin;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.LabelSkin;

	public class SkinManager {


		private static var _debugLevel:String = DebugLevel.NONE;
		private static var _debugColor:uint = 0xFF0000;


		//noinspection FunctionTooLongJS,FunctionWithMultipleReturnPointsJS,OverlyComplexFunctionJS
		public static function assetToSkin(asset:Asset):* {
			if(asset.config.widget == null) {
				throw new Error('Asset is null');
			}
			
			else {
				var skin:*;
				var isSupported:Boolean = true;
				var config:Object = asset.config.widget;

				switch(config.type) {
					case SkinType.CONTAINER:
						skin = new ContainerSkin();

						var containerSkin:ContainerSkin = skin as ContainerSkin;

						containerSkin.parseConfig(config);

						break;

					case SkinType.BAR:
						skin = new BarSkin();

						var barSkin:BarSkin = skin as BarSkin;
						var barSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

						barSkin.getAssetsFromAtlas(barSkinBD);
						barSkin.parseConfig(config);

						break;

					case SkinType.IMAGE:
						skin = new ImageSkin();

						var imageSkin:ImageSkin = skin as ImageSkin;
						var imageSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

						imageSkin.getAssetsFromAtlas(imageSkinBD);
						imageSkin.parseConfig(config);

						break;

					case SkinType.BUTTON:
						skin = new ButtonSkin();

						var buttonSkin:ButtonSkin = skin as ButtonSkin;
						var buttonSkinBD:BitmapData = asset.getChunkByURL(config.image).bitmap.bitmapData;

						buttonSkin.getAssetsFromAtlas(buttonSkinBD);
						buttonSkin.parseConfig(config);

						break;

					case SkinType.LABEL:
						skin = new LabelSkin();

						var labelSkin:LabelSkin = skin as LabelSkin;

						labelSkin.parseConfig(config);

						break;

					case SkinType.LABEL_BUTTON:
						skin = new LabelButtonSkin();

						var labelButtonSkin:LabelButtonSkin = skin as LabelButtonSkin;
						var labelButtonSkinBD:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;

						labelButtonSkin.buttonSkin.getAssetsFromAtlas(labelButtonSkinBD);
						labelButtonSkin.parseConfig(config);

						break;

					case SkinType.GLYPH_BUTTON:
						skin = new GlyphButtonSkin();

						var glyphButtonSkin:GlyphButtonSkin = skin as GlyphButtonSkin;
						var glyphButtonSkinBD1:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;
						var glyphButtonSkinBD2:BitmapData = asset.getChunkByURL(config.glyph.image).bitmap.bitmapData;

						glyphButtonSkin.buttonSkin.getAssetsFromAtlas(glyphButtonSkinBD1);
						glyphButtonSkin.glyphsSkin.getAssetsFromAtlas(glyphButtonSkinBD2);
						glyphButtonSkin.parseConfig(config);

						break;

					case SkinType.GLYPH_LABEL_BUTTON:
						skin = new GlyphLabelButtonSkin();

						var glyphLabelButtonSkin:GlyphLabelButtonSkin = skin as GlyphLabelButtonSkin;
						var glyphLabelButtonSkinBD1:BitmapData = asset.getChunkByURL(config.button.image).bitmap.bitmapData;
						var glyphLabelButtonSkinBD2:BitmapData = asset.getChunkByURL(config.glyph.image).bitmap.bitmapData;

						glyphLabelButtonSkin.buttonSkin.getAssetsFromAtlas(glyphLabelButtonSkinBD1);
						glyphLabelButtonSkin.glyphsSkin.getAssetsFromAtlas(glyphLabelButtonSkinBD2);
						glyphLabelButtonSkin.parseConfig(config);

						break;

					case SkinType.CHECK_BUTTON:
						skin = new CheckButtonSkin();

						var checkButtonSkin:CheckButtonSkin = skin as CheckButtonSkin;

						// buttonOffSkin.getAssetsFromAtlas(asset.bitmap.bitmapData);
						// buttonOnSkin.getAssetsFromAtlas(asset.bitmap.bitmapData);

						checkButtonSkin.parseConfig(config);

						break;

					case SkinType.INPUT_BAR:
						skin = new InputBarSkin();

						var inputBarSkin:InputBarSkin = skin as InputBarSkin;
						var inputBarSkinBD:BitmapData = asset.getChunkByURL(config.bar.image).bitmap.bitmapData;

						inputBarSkin.barSkin.getAssetsFromAtlas(inputBarSkinBD);
						inputBarSkin.parseConfig(config);

						break;

					default:
						//noinspection ReuseOfLocalVariableJS
						isSupported = false;
				}
			}

			if(isSupported) return skin;
			else return null;
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
